Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A56C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94362072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgCIKwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:52:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCIKwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:52:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 244D81FB;
        Mon,  9 Mar 2020 03:52:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741AF3F6CF;
        Mon,  9 Mar 2020 03:52:22 -0700 (PDT)
Date:   Mon, 9 Mar 2020 10:52:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: remove unnecessary zero check
Message-ID: <20200309105219.GC25261@lakrids.cambridge.arm.com>
References: <1582691106-3432-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582691106-3432-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:25:06PM +0800, luanshi wrote:
> The "nr_pages" variable has been checked before, it can't be zero, so a check here would be useless.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>

As the commit message states, a  done:

| /* We need at least two pages for this to work. */
| if (nr_pages < 2)
|         return NULL;

... so this looks sensible to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_spe_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 4e4984a..b72c048 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -831,7 +831,7 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
>  	 * parts and give userspace a fighting chance of getting some
>  	 * useful data out of it.
>  	 */
> -	if (!nr_pages || (snapshot && (nr_pages & 1)))
> +	if (snapshot && (nr_pages & 1))
>  		return NULL;
>  
>  	if (cpu == -1)
> -- 
> 1.8.3.1
> 
