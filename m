Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F631C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963462054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qh4dDJPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgEMUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgEMUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:54:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E904C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=dMTtYFDXqUdlmzWoL5eR1c/r+iW79rtsYdnr93KcRJA=; b=qh4dDJPOeMSykQV0ryuh0iRpxQ
        a2LC4lSg3POAP5J5Spgh+PaMzfefovUjqOu4ubqcl+/GyxIzkYts176/t5BoH0N0w068WT/IvHxK3
        fvJ73GeE0ecbuveu2+jZqZbICpUu1pmVOzaEZo53pcmvwfvZbh2SqowM0heR0I+OftggHI5usutcy
        6220g9YkPmq4uG7ciZMherKR3C3pGSskAVCbgtQ+hnrMhoZuPktOlOXN9+0cOo24CXKgXoaqLznuP
        Tz9RpDicEgBKDHb9dYEeAe0jeGmxwRFK0049wffYg/hbCkmu4ahTlY4TudkWMi7RMQ8yhdwsECVaZ
        l3P5P7qw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYyOP-0001k3-MH; Wed, 13 May 2020 20:54:17 +0000
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Brendan Higgins <brendanhiggins@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <CAFd5g46npUaVOu9+xvLqw=DhCccuzOLpFLn1+8Qc8Un0AALThg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca1db965-e3aa-7c86-27b2-92fb4707ddb5@infradead.org>
Date:   Wed, 13 May 2020 13:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46npUaVOu9+xvLqw=DhCccuzOLpFLn1+8Qc8Un0AALThg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 1:18 PM, Brendan Higgins wrote:
> On Wed, May 13, 2020 at 8:18 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
>>
>> In the function kobject_cleanup(), kobject_del(kobj) is
>> called before the kobj->release(). That makes it possible to
>> release the parent of the kobject before the kobject itself.
>>
>> To fix that, adding function __kboject_del() that does
>> everything that kobject_del() does except release the parent
>> reference. kobject_cleanup() then calls __kobject_del()
>> instead of kobject_del(), and separately decrements the
>> reference count of the parent kobject after kobj->release()
>> has been called.
> 
> I was starting to wonder if anything else needed to happen with this. :-)
> 
> Thanks for taking care of this!
> 
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Didn't I and someone else test this?
> 
> Either way, I will test this out in a little bit.
> 
> Thanks!
> 

Yes, I tested the earlier patch and acked it.
(using lib/test_printf.ko)

-- 
~Randy

