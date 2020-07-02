Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95339C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777F9207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGBS3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:29:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgGBS3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B714A1FB;
        Thu,  2 Jul 2020 11:29:07 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9BD33F71E;
        Thu,  2 Jul 2020 11:29:06 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] sched/topology: Add more flags to the SD
 degeneration mask
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-6-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3406fe6b-405b-d542-6459-732f4ae890f6@arm.com>
Date:   Thu, 2 Jul 2020 20:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701190656.10126-6-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 21:06, Valentin Schneider wrote:
> I don't think it is going to change much in practice, but we were missing
> those:
> 
> o SD_BALANCE_WAKE: Used just like the other SD_BALANCE_* flags, so also
>   needs > 1 group.
> o SD_ASYM_PACKING: Hinges on load balancing (periodic / wakeup), thus needs
>   > 1 group to happen
> o SD_OVERLAP: Describes domains with overlapping groups; can't have
>   overlaps with a single group.
> 
> SD_PREFER_SIBLING is as always the odd one out: we currently consider it
> in sd_parent_degenerate() but not in sd_degenerate(). It too hinges on load
> balancing, and thus won't have any effect when set on a domain with a
> single group. Add it to the sd_degenerate() groups mask.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/topology.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6047d491abe9..fe393b295444 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -161,11 +161,15 @@ static int sd_degenerate(struct sched_domain *sd)
>  
>  	/* Following flags need at least 2 groups */
>  	if (sd->flags & (SD_BALANCE_NEWIDLE |
> +			 SD_BALANCE_WAKE |
>  			 SD_BALANCE_FORK |
>  			 SD_BALANCE_EXEC |
> +			 SD_ASYM_PACKING |
>  			 SD_SHARE_CPUCAPACITY |
>  			 SD_ASYM_CPUCAPACITY |
> -			 SD_SHARE_PKG_RESOURCES)) {
> +			 SD_SHARE_PKG_RESOURCES |
> +			 SD_OVERLAP |
> +			 SD_PREFER_SIBLING)) {

Why do you add SD_PREFER_SIBLING here? It doesn't have SDF_NEEDS_GROUPS
set in [PATCH v3 6/7].

$ cat ./include/linux/sched/sd_flags.h | grep ^SD_FLAG
SD_FLAG(SD_BALANCE_NEWIDLE,     0, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_BALANCE_EXEC,        1, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_BALANCE_FORK,        2, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_BALANCE_WAKE,        3, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_WAKE_AFFINE,         4, SDF_SHARED_CHILD)
SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_SERIALIZE,           8, SDF_SHARED_PARENT)
SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
SD_FLAG(SD_PREFER_SIBLING,      10, 0)                           <-- !!!
SD_FLAG(SD_OVERLAP,             11, SDF_SHARED_PARENT |SDF_NEEDS_GROUPS)
SD_FLAG(SD_NUMA,                12, SDF_SHARED_PARENT)
