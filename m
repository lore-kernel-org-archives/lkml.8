Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3881C54E7E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8EA218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcpIXoIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEJCUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 22:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726209AbgEJCUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:20:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC85C061A0C;
        Sat,  9 May 2020 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=r9eTuqNOLM0wMerku3W3sxrHIhIvztBWpcO4VqsnqgY=; b=TcpIXoIOShVYcpUz2H5O5KTucz
        zSEtYHLXAoMPgoTlRZJjr/1KOf9xYgg8EsQvVV8bPW5MELZ4x7NodyC7zQzykZE88WjEsjRMgZLe2
        9Wg2kjczXHBmW5krGAP8nf6lOHdwinwxWoOE7MGQD3KuKgcaGLCDCABU1ImOAkfsKC1ZjvgGtwBR8
        AwnnWJ0+i6huLYWIkUDb8KRe4yTwfPGuG9dMxgIiYu9xy2Z9f/gsmvGxBr5MoBCo1zPt/OSXbFZav
        PeYJuLnOXMdoZpBMrb94iJ+SSBeAaipo6NNdGbD5WON3zg2YIrTgjQ2TJ/dqSBc39DmAJmVklvDvY
        oVX9KOVg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXbZF-0007tH-Uw; Sun, 10 May 2020 02:19:50 +0000
Subject: Re: [PATCH 01/15] taint: add module firmware crash taint support
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Rafael Aquini <aquini@redhat.com>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, cai@lca.pw,
        dyoung@redhat.com, bhe@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, gpiccoli@canonical.com, pmladek@suse.com,
        tiwai@suse.de, schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200509043552.8745-1-mcgrof@kernel.org>
 <20200509043552.8745-2-mcgrof@kernel.org> <20200509151829.GB6704@x1-fbsd>
 <20200509164653.GK11244@42.do-not-panic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b48a2894-f67c-03d1-502a-9e7e7d4435ff@infradead.org>
Date:   Sat, 9 May 2020 19:19:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509164653.GK11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/20 9:46 AM, Luis Chamberlain wrote:
> On Sat, May 09, 2020 at 11:18:29AM -0400, Rafael Aquini wrote:
>> We are still missing the documentation bits for this
>> new flag, though.
> 
> Ah yeah sorry about that.
> 
>> How about having a blurb similar to:
>>
>> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>> index 71e9184a9079..5c6a9e2478b0 100644
>> --- a/Documentation/admin-guide/tainted-kernels.rst
>> +++ b/Documentation/admin-guide/tainted-kernels.rst
>> @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>>   15  _/K   32768  kernel has been live patched
>>   16  _/X   65536  auxiliary taint, defined for and used by distros
>>   17  _/T  131072  kernel was built with the struct randomization plugin
>> + 18  _/Q  262144  driver firmware crash annotation
>>  ===  ===  ======  ========================================================
>>
>>  Note: The character ``_`` is representing a blank in this table to make reading
>> @@ -162,3 +163,7 @@ More detailed explanation for tainting
>>       produce extremely unusual kernel structure layouts (even performance
>>       pathological ones), which is important to know when debugging. Set at
>>       build time.
>> +
>> + 18) ``Q`` Device drivers might annotate the kernel with this taint, in cases
>> +     their firmware might have crashed leaving the driver in a crippled and
>> +     potentially useless state.
> 
> Sure, I'll modify it a bit to add the use case to help with support
> issues, ie, to help rule out firmware issues.

Please also update tools/debugging/kernel-chktaint.

> I'm starting to think that to make this even more usesul later we may
> want to add a uevent to add_taint() so that userspace can decide to look
> into this, ignore it, or report something to the user, say on their
> desktop.

thanks.
-- 
~Randy

