Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A4C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D710220715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGMs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:48:29 -0500
Received: from foss.arm.com ([217.140.110.172]:39922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGMs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:48:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35630328;
        Fri,  7 Feb 2020 04:48:28 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA02F3F6CF;
        Fri,  7 Feb 2020 04:48:26 -0800 (PST)
Subject: Re: [PATCH v4 4/4] sched/fair: Kill wake_cap()
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-5-valentin.schneider@arm.com>
 <20200207111904.GC239598@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <bc4cecd2-81ea-b6e4-68df-b021d4fa128b@arm.com>
Date:   Fri, 7 Feb 2020 12:48:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207111904.GC239598@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2020 11:19, Quentin Perret wrote:
> On Thursday 06 Feb 2020 at 19:19:57 (+0000), Valentin Schneider wrote:
>> From: Morten Rasmussen <morten.rasmussen@arm.com>
>>
>> Capacity-awareness in the wake-up path previously involved disabling
>> wake_affine in certain scenarios. We have just made select_idle_sibling()
>> capacity-aware, so this isn't needed anymore.
>>
>> Remove wake_cap() entirely.
>>
>> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
>> [Changelog tweaks]
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> 
> I wanted to suggest removing the CA code from update_sg_wakeup_stats()
> which is now called only on fork/exec, but I suppose we still want it
> for util_clamp, so n/m.
> 

Good point, I hadn't thought about this. As you say we probably want to
keep it since we can fork/exec into a cgroup that has uclamp values already
set up, and that would drive task_fits_capacity().

> Thanks for the series,

Thanks for the review!

> Quentin
> 
