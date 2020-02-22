Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC6C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B471B206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9Zq3H3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgBVSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:50:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=h+38e26tqUDo/PqZ0G1mLmF456jZ+eqfKHNlYKIxDLw=; b=d9Zq3H3Zvey+RC4W+slt5QcLlu
        Jc/3mOfXE15cRanwLC9GJOZhHFq+N7etLJFMOMpfsaAGWwgQ9r3Wi27zWD/koCFhCsxnO9aNDhQQU
        P3FLdrE9N3jbERks4Mqo99nY+mFSzLunX2LLG3OsIeMM9mRwrv34jGJAugM062TziYnNLNQ1cQy1g
        9Z68ZpGKPLYiChMpa7QCvc9kbNXPf3zt+kn43DrtJpDpRKGESsuhRLL/arlf0sYkqZE+1NRpvFGPv
        rT1q28kOrR3MU92kjqLQ3LYR6W2xPZV5owrAplTK8EAlyh9T25ecJzRbMb8yM4N4Bj0vDFG59aejN
        QpcwfpsQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ZrB-0004RH-Ey; Sat, 22 Feb 2020 18:50:29 +0000
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
 <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
 <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a3102cf8-bb77-fed4-ffc7-8ef74e9feb23@infradead.org>
Date:   Sat, 22 Feb 2020 10:50:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/20 10:27 AM, Thara Gopinath wrote:
> 
> 
> On 2/21/20 7:59 PM, Randy Dunlap wrote:
>> On 2/21/20 4:52 PM, Thara Gopinath wrote:
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 2a25c769eaaa..8d56902efa70 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -464,6 +464,10 @@ config HAVE_SCHED_AVG_IRQ
>>>       depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>>>       depends on SMP
>>>   +config HAVE_SCHED_THERMAL_PRESSURE
>>> +    bool "Enable periodic averaging of thermal pressure"
>>
>> This prompt string makes this symbol user-configurable, but
>> I don't think that's what you want here.
> 
> Hi Randy,
> Thank you for the review.
> Actually I thought being user-configurable is a good idea as it will allow users to easily enable it and see if the benefits their systems. (I used menuconfig while developing, to enable it).
> Do you see a reason why this should not be so?
> 
>>
>>> +    depends on SMP
>>> +
>>>   config BSD_PROCESS_ACCT
>>>       bool "BSD Process Accounting"
>>>       depends on MULTIUSER

Hi Thara,
Is there some other way that HAVE_SCHED_THERMAL_PRESSURE can become
set/enabled?  for example, is it selected by any other options?

The Kconfig symbols that begin with HAVE_ are usually something that
are platform-specific and are usually set (selected) by other options,
or they are "default y".

In init/Kconfig, I see 15 other HAVE_ Kconfig symbols,
and none of them have user prompt strings.  They are either selected
elsewhere or set inside their Kconfig block.

Maybe you just want to rename the Kconfig symbol so that it does not
being with HAVE_.


-- 
~Randy

