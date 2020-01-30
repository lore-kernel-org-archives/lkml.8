Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C911C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C55B20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgA3QMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:12:02 -0500
Received: from foss.arm.com ([217.140.110.172]:54930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgA3QMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:12:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F92931B;
        Thu, 30 Jan 2020 08:11:59 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B92C03F67D;
        Thu, 30 Jan 2020 08:11:57 -0800 (PST)
Subject: Re: [PATCH v2 6/6] arm64: use activity monitors for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-7-ionela.voinescu@arm.com>
 <96fdead6-9896-5695-6744-413300d424f5@arm.com>
 <3ed9af08-82ef-e30c-b1ec-3a1dac0d2091@arm.com>
 <20200130154923.GB5208@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ec71a41d-5274-c29c-a391-4ed92839d58f@arm.com>
Date:   Thu, 30 Jan 2020 16:11:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130154923.GB5208@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2020 15:49, Ionela Voinescu wrote:
> Okay, I'll add this as a separate patch to the series and put you as
> author. That is if you want me to tie this check to this usecase that
> proves its usefulness. Otherwise it can stand on its own as well if
> you want to submit it separately.
> 

It's pretty much standalone, but it does make sense to bundle it with this
series, I think. Feel free to grab ownership (I didn't test it) ;)

> In regards to the ratio computation for frequency invariance where this
> plays a role, I'll do a check and bail out if the ratio is 0, which I'm
> ashamed to not have added before :).

That does sound like something we very much want to have.

> 
> Thanks,
> Ionela.
> 
> 
>>> Long story short, we're probably fine, but it would nice to shove some of
>>> the above into comments (especially the SCHED_CAPACITY_SCALE² trick)
>>>
