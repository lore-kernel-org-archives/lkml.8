Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44571206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFJKDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:03:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:03:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538981FB;
        Wed, 10 Jun 2020 03:03:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8573F73D;
        Wed, 10 Jun 2020 03:03:20 -0700 (PDT)
References: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: correct SD_flags returned by tl->sd_flags()
In-reply-to: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
Date:   Wed, 10 Jun 2020 11:03:14 +0100
Message-ID: <jhjv9jz2q71.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/06/20 16:09, Peng Liu wrote:
> During sched domain init, we check whether non-topological SD_flags are
> returned by tl->sd_flags(), if found, fire a waning and correct the
                                               ^^^^^^
                                            s/waning/warning/

> violation, but the code failed to correct the violation. Correct this.
>
> Fixes: 143e1e28cb40 ("sched: Rework sched_domain topology definition")
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ba81187bb7af..9079d865a935 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1328,7 +1328,7 @@ sd_init(struct sched_domain_topology_level *tl,
>               sd_flags = (*tl->sd_flags)();
>       if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
>                       "wrong sd_flags in topology description\n"))
> -		sd_flags &= ~TOPOLOGY_SD_FLAGS;
> +		sd_flags &= TOPOLOGY_SD_FLAGS;
>
>       /* Apply detected topology flags */
>       sd_flags |= dflags;
