Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4E0C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10B320663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCSOc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:32:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgCSOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:32:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F1130E;
        Thu, 19 Mar 2020 07:32:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274703F52E;
        Thu, 19 Mar 2020 07:32:56 -0700 (PDT)
Date:   Thu, 19 Mar 2020 14:32:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: dsu: Allow multiple devices share same IRQ.
Message-ID: <20200319143250.GA4876@lakrids.cambridge.arm.com>
References: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 05:26:15PM -0700, Tuan Phan wrote:
> Add IRQF_SHARED flag when register IRQ such that multiple dsu
> devices can share same IRQ.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>

I don't think that this makes sense; further I think that this
highlights that the current driver doesn't support such a configuration
for other reasons.

A DSU instance can only be accessed from a CPU associated with it, since
it's accessed via sysregs. The IRQ handler must run on one of those
CPUs.

To handle that, the DSU PMU driver will need to gain an understanding of
which CPUs are associated with the instance. As it stands the driver
seems to assume that there's a single DSU instance, and that all CPUs
are affine to that same instance.

So NAK to this patch, given the above.

Thanks,
Mark.

> ---
>  drivers/perf/arm_dsu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 70968c8..2622900 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -700,7 +700,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
>  	if (!name)
>  		return -ENOMEM;
>  	rc = devm_request_irq(&pdev->dev, irq, dsu_pmu_handle_irq,
> -			      IRQF_NOBALANCING, name, dsu_pmu);
> +			      IRQF_NOBALANCING | IRQF_SHARED, name, dsu_pmu);
>  	if (rc) {
>  		dev_warn(&pdev->dev, "Failed to request IRQ %d\n", irq);
>  		return rc;
> -- 
> 2.7.4
> 
