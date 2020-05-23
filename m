Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D70C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C92207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6twRXzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEWPoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEWPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:44:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5EC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=U+IiB+papUoUppksQW3XAeJEGMtGqdvxwQ2rfkDXF6w=; b=l6twRXzpi1M+m6dRlqOPDGPpPs
        aO+BWJb/XO8CpcmwvLgN/2KjhJbwd2NaYlXSAbsWUb/598ynJyJ4417WQKiL6H3iMGo5JEqrb3QAe
        +8wpDEyRK2+dJ1Rv4cpdkk1KlZUwLVaTXqbQ3+sp8ka7XJUx+eRKeDhKZJkRukyovD41jcOngeptd
        C7eml3Iftujw7RwCn0OTmRqncOF2D9kRjSX9HrPGkhESICDG5GllHeVSe4DS2yjYX1wRcyNR/4nmA
        9OjKSJcL7o7uGv8CP1YhXWz1mskEtVWNxZAhtYh02cTeU18oCQ2byzoBWkp8zkIY9ckkTwnQ5WEuo
        jfjcORnQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcWJk-00077y-1i; Sat, 23 May 2020 15:44:08 +0000
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
Date:   Sat, 23 May 2020 08:44:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523153643.GA226270@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
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
>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>> Tested-by: Brendan Higgins <brendanhiggins@google.com>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  lib/kobject.c | 30 ++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> Stepping back, now that it turns out this patch causes more problems
> than it fixes, how is everyone reproducing the original crash here?

Just load lib/test_printf.ko and boom!


> Is it just the KUNIT_DRIVER_PE_TEST that is causing the issue?
> 
> In looking at 7589238a8cf3 ("Revert "software node: Simplify
> software_node_release() function""), the log messages there look
> correct.  sysfs can't create a duplicate file, and so when your test is
> written to try to create software nodes, you always have to check the
> return value.  If you run the test in parallel, or before another test
> has had a chance to clean up, the function will fail, correctly.
> 
> So what real-world thing is this test "failure" trying to show?


-- 
~Randy

