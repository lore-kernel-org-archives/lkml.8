Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2811C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9B920663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCSMGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:06:31 -0400
Received: from foss.arm.com ([217.140.110.172]:34076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSMGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:06:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C895D31B;
        Thu, 19 Mar 2020 05:06:30 -0700 (PDT)
Received: from e113632-lin (unknown [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ABC63F305;
        Thu, 19 Mar 2020 05:06:29 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-5-valentin.schneider@arm.com> <a4a87ce6-9770-dc58-c2b6-e001b8050a8e@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 4/9] sched/topology: Kill SD_LOAD_BALANCE
In-reply-to: <a4a87ce6-9770-dc58-c2b6-e001b8050a8e@arm.com>
Date:   Thu, 19 Mar 2020 12:06:07 +0000
Message-ID: <jhjtv2ko8gg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 19 2020, Dietmar Eggemann wrote:
> On 11.03.20 19:15, Valentin Schneider wrote:
>> That flag is set unconditionally in sd_init(), and no one checks for it
>> anymore. Remove it.
>
> Why not merge 3/9 and 4/9 ?
>
> [...]
>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index f341163fedc9..8de2f9744569 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -11,21 +11,20 @@
>>   */
>>  #ifdef CONFIG_SMP
>>
>> -#define SD_LOAD_BALANCE		0x0001	/* Do load balancing on this domain. */
>> -#define SD_BALANCE_NEWIDLE	0x0002	/* Balance when about to become idle */
>
> [...]
>
>> -#define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
>> -#define SD_NUMA			0x4000	/* cross-node balancing */
>> +#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
>
> IMHO, changing the values of the remaining SD flags will break lots of
> userspace scripts.
>

True, and that includes some of my own scripts. That's also part of why
I have this 3/9 and 4/9 split: 4/9 is the externally visible part. If
deemed necessary, we could keep the definition of SD_LOAD_BALANCE but
kill all of its uses.

Alternatively, I was thinking that we could leverage [1] to make
/proc/sys/kernel/sched_domain/cpu*/domain*/flags print
e.g. comma-separated flag names rather than flag values. That way the
userland scripts would no longer have to contain some
{flag_value : flag_name} translation.

[1]: https://lkml.kernel.org/r/20200311183320.19186-1-valentin.schneider@arm.com

> [...]
