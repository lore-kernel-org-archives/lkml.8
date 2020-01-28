Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C2FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C042E24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgA1Sg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:36:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgA1Sg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:36:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082E3328;
        Tue, 28 Jan 2020 10:36:27 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2538C3F52E;
        Tue, 28 Jan 2020 10:36:25 -0800 (PST)
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the AMU
 extension
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
 <b63b6f10-22c8-79be-cc97-08484874bd62@arm.com>
 <20200128165325.GA16417@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <487a8af1-a1b8-5a16-6487-968049bfc12f@arm.com>
Date:   Tue, 28 Jan 2020 18:36:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128165325.GA16417@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 16:53, Ionela Voinescu wrote:
> Or you won't be able to access them at all. Lacking firmware support
> accesses to AMU registers could be trapped in EL3. If access for EL1 and
> EL2 is enabled from EL3, it's still possible that the counters
> themselves are not enabled - that means they are not enabled to count
> the events they are designed to be counting. That's why in this case the
> event counter register could read 0.
> 
> But if we read 0, it does not necessarily mean that the counter is
> disabled. It could also mean that the events is meant to count did not
> happen yet.
> 

Right, which (as we discussed offline) is quite likely to happen if/when
we get stuff like SVE counters and we try to read them at boot time. Might
be worth adding a small note about that (0 != disabled).

>> I haven't seen something that would try to catch this on the kernel side.
>> Can we try to detect that (e.g. at least one counter returns > 0) in
>> cpu_amu_enable() and thus not write to the CPU-local 'amu_feat'?
>>
> 
> I'm reluctant to do this especially given that platforms might choose to
> keep some counters disabled while enabling some counters that might not
> have counted any events by the time we reach cpu_enable. We would end up
> mistakenly disabling the feature. I would rather leave the validation of
> the counters to be done at the location and for the purpose of their
> use: see patch 6/6 - the use of counters for frequency invariance.
> 

Hmph, I'm a bit torn on that one. It would be really nice to provide *some*
amount of sanity checking at core level - e.g. by checking that at least
one of the four architected counters reads non-zero. But as you say these
could be disabled, while some other arch/aux counter is enabled, and we
could then mistakenly disable the feature. So we can't really do much
unless we handle *each* individual counter. Oh well :/

>> While we're on the topic of detecting broken stuff, what if some CPUs
>> implement some auxiliary counters that some others don't?
>>
> 
> I think it should be up to the user of that counter to decide if the
> usecase is at CPU level or system level. My intention of this base
> support was to keep it simple and allow users of some counters to
> decide on their own how to validate and make use of either architected
> or auxiliary counters.
> 
> For example, in the case of frequency invariance, given a platform that
> does not support cpufreq based invariance, I would validate all CPUs for
> the use of AMU core and constant counters. If it happens that some CPUs
> do not support those counters or they are not enabled, we'd have to
> disable frequency invariance at system level.
> 
> For some other scenarios only partial support is needed - only a subset
> of CPUs need to support the counters for their use to be feasible.
> 
> But I believe only the user of the counters can decide, whether this is
> happening in architecture code, driver code, generic code.
> 

Right, the FIE support is actually a good example of that, I think.
