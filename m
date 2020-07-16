Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85155C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AC82071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594892512;
	bh=tFMjaTObTGfQzsxUT7iWfGij3LNoOn67jvCe37qigkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NyXZizgdmhry9OLmdi/SBr3seGsy8AYR7usgYfteKHrDDN9D/Izg8XXuo0iWOudfc
	 NHrWrYuRO0hqrGprjtB72CueEJzD12hjbwtQV1qabKAZig4devEsrJRcQSmVFYWV5e
	 JiQImz28XVPcX2Lx1qNPCPuiEjM2ss7rD4hQyZk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGPJlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgGPJlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:41:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58042065D;
        Thu, 16 Jul 2020 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594892510;
        bh=tFMjaTObTGfQzsxUT7iWfGij3LNoOn67jvCe37qigkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG4ewMb3Rq4brE9ktYGjoGPCThQEUtSA/M8Js/9Xe1iCHvrVmnM6jZGVFU/T2Ol55
         9Oy1DYmOYZ7uldE7+vuMd5vdtGnBIQRENZ28wA8VHQXJT0GGwL0iZoMP9rZMbZjkl8
         H6FV45HV9MNpsqedgLSyEHhvryUlRM8vuNWyhMxU=
Date:   Thu, 16 Jul 2020 10:41:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     john.garry@huawei.com, zhangshaokun@hisilicon.com,
        mark.rutland@arm.com, wang.wanghaifeng@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
Message-ID: <20200716094144.GC6771@willie-the-truck>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:19:25PM +0800, Qi Liu wrote:
> Kernel panic will also happen when users try to unbind PMU drivers with
> device. This unbind issue could be solved by another patch latter.
> 
>  drivers/perf/arm_smmuv3_pmu.c                 | 1 +
>  drivers/perf/fsl_imx8_ddr_perf.c              | 1 +
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 1 +
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 1 +
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 48e28ef..90caba56 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -742,6 +742,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, smmu_pmu);
> 
>  	smmu_pmu->pmu = (struct pmu) {
> +		.module		= THIS_MODULE,

I thought platform_driver_register() did this automatically?

Will
