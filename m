Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700A72053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmxJ9Utv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbgEMXPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732136AbgEMXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:14:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92684C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=1u6OWA9P/4XPQPpiocvHMbun/hKoPpnrqvp3gSVmyQ8=; b=lmxJ9UtvvRhaPMiY5oI60od3Il
        agMkxNGSf/0e7YDbWjFlHRdz//eqTQ2atagWoatRcj+52mH0229nIqqHqPILt6qyZdswC+MQ+UKuT
        UxXz7Bs50+yERbPRG2eC7wwbRvdYdKafnvR3Sph6cKsHMSywWA7UBxw68AhhgDcqOGBQzkjXSMFRt
        PtZGare2LMM97J+IWdx/BxrBpYGGc1x9Us5pmeBndpqiQIKKrGBQbyRDdPYPIzoJ0flzzOmXOp2nv
        +1niObXYaSQgmQGc857lEeadXRnFtDAszd2i04yJJVLe6Uts58k/JVgAApexu5u69o5vsZTVzbRET
        +stzlDnw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ0aT-0002V0-6v; Wed, 13 May 2020 23:14:53 +0000
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
 <CAFd5g44d+VCSimjboPkf-NF1eCdbq6Uy+pabNftB8p5Lj2yc1A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e51d4ce4-42ba-8c89-21b4-082c7158a9a9@infradead.org>
Date:   Wed, 13 May 2020 16:14:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44d+VCSimjboPkf-NF1eCdbq6Uy+pabNftB8p5Lj2yc1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 2:30 PM, Brendan Higgins wrote:
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
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
