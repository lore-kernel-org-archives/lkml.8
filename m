Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FEBC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215A20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgCWNmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:42:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgCWNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3796F1FB;
        Mon, 23 Mar 2020 06:42:38 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385FA3F52E;
        Mon, 23 Mar 2020 06:42:37 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:42:34 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/3] sched/topology: Split out SD_* flags declaration
 to its own file
Message-ID: <20200323134234.GD6103@e123083-lin>
References: <20200311183320.19186-1-valentin.schneider@arm.com>
 <20200311183320.19186-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311183320.19186-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:33:18PM +0000, Valentin Schneider wrote:
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> new file mode 100644
> index 000000000000..685bbe736945
> --- /dev/null
> +++ b/include/linux/sched/sd_flags.h
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sched-domains (multiprocessor balancing) flag declarations.
> + */
> +
> +/* Balance when about to become idle */
> +SD_FLAG(SD_BALANCE_NEWIDLE,     0)
> +/* Balance on exec */
> +SD_FLAG(SD_BALANCE_EXEC,        1)
> +/* Balance on fork, clone */
> +SD_FLAG(SD_BALANCE_FORK,        2)
> +/* Balance on wakeup */
> +SD_FLAG(SD_BALANCE_WAKE,        3)
> +/* Wake task to waking CPU */
> +SD_FLAG(SD_WAKE_AFFINE,         4)

Isn't it more like: "Consider waking task on waking CPU"?

IIRC, with this flag set the wake-up can happen either near prev_cpu or
this_cpu.

> +/* Domain members have different CPU capacities */
> +SD_FLAG(SD_ASYM_CPUCAPACITY,    5)
> +/* Domain members share CPU capacity */
> +SD_FLAG(SD_SHARE_CPUCAPACITY,   6)

Perhaps add +" (SMT)" to the comment to help the uninitiated
understanding it a bit easier?

> +/* Domain members share power domain */
> +SD_FLAG(SD_SHARE_POWERDOMAIN,   7)

This flag is set only by 32-bit arm and has never had any effect. I
think it was the beginning of something years ago that hasn't
progressed. Perhaps we can remove it now?

> +/* Domain members share CPU pkg resources */
> +SD_FLAG(SD_SHARE_PKG_RESOURCES, 8)

+" (e.g. caches)" ?

> +/* Only a single load balancing instance */
> +SD_FLAG(SD_SERIALIZE,           9)
> +/* Place busy groups earlier in the domain */
> +SD_FLAG(SD_ASYM_PACKING,        10)

Place busy _tasks_ earlier in the domain?

It is a bit unclear what 'earlier' means here but since the packing
ordering can actually be defined by the architecture, we can't be much
more specific I guess.

Morten
