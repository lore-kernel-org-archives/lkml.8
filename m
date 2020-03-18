Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBAC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64115208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565074;
	bh=rFLv1ZfRcV+svX8JTmV+UQxowcY75lz27dYs4kS6JTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12tad9a7s7o1EhHC8K0k99daWGByeILPmWalbijuYEd8ASkytN+3D4tZhR/YQpmss
	 m5oEY8xK+O74qS0DVSSwS6h/HooJDCsYC+NmXQKRpW/CcpnU6ggDjrtol9OzuXg/xi
	 voIvwZGJdmAkthIWH89BdetVWqof7vxmA5To8Dx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgCRU5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgCRU5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:57:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9674A208E0;
        Wed, 18 Mar 2020 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565029;
        bh=rFLv1ZfRcV+svX8JTmV+UQxowcY75lz27dYs4kS6JTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xljifAxNivUslQxB0dEZbzfkBmD+lKeG1i4Zu0f4ZRaU7QqI58Yeigqxo2i7lgJj3
         No8I85DDU9TleHICnvT+UQMBEoeHcB/Cf6mFuyFNGH386BIT46hb59dGhDR4MXSMk6
         IfsNELEx6AoL/oVqpy/sO2tX4ylZfDhlQ/aiJdiU=
Date:   Wed, 18 Mar 2020 20:57:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH 1/2] perf: dsu: Allow multiple devices share same IRQ.
Message-ID: <20200318205704.GC8094@willie-the-truck>
References: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Suzuki, since he wrote the driver]

On Tue, Mar 17, 2020 at 05:26:15PM -0700, Tuan Phan wrote:
> Add IRQF_SHARED flag when register IRQ such that multiple dsu
> devices can share same IRQ.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
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
