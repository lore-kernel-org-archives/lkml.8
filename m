Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4096C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38A3206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NqLnKQQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgGAKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:18:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39666 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgGAKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:18:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061AISlU056677;
        Wed, 1 Jul 2020 05:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593598708;
        bh=zH7dkkXZTfeKS3biJUEQPEIz7m1XP2qGGeV5DgRW3gQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NqLnKQQSCNo+gpum1eCEC9s11nEwWeNsXEDB2V5Yn7odZOxNiFrpm+us15p2UHm4o
         wxwTaGlBWcyA920cVbFU6niNxhkzxGW52JHVygKuiIkghwSbvvyeBN8VadqShAnaRk
         ELKmO3/HGhY/XimPl9exY1c0ChhGAynoYdNEA438=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061AISfe075915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 05:18:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:18:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:18:27 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AIOgo060155;
        Wed, 1 Jul 2020 05:18:25 -0500
Subject: Re: [PATCH] arm64: arch_k3: enable chipid driver
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20200619162527.1226-1-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <4bbdfff6-8fba-0568-b243-5da9ee6e29b6@ti.com>
Date:   Wed, 1 Jul 2020 13:18:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619162527.1226-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi All,

On 19/06/2020 19:25, Grygorii Strashko wrote:
> Select TI chip id driver for TI's SoCs based on K3 architecture to provide
> this information to user space and Kernel as it is required by other
> drivers to determine SoC revision to function properly.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   arch/arm64/Kconfig.platforms | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 8dd05b2a925c..1d3710e3626a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -98,6 +98,7 @@ config ARCH_K3
>   	select TI_SCI_PROTOCOL
>   	select TI_SCI_INTR_IRQCHIP
>   	select TI_SCI_INTA_IRQCHIP
> +	select TI_K3_SOCINFO
>   	help
>   	  This enables support for Texas Instruments' K3 multicore SoC
>   	  architecture.
> 

Are there any comments?

The driver and dt changes were merged [1][2] and for adding new am654x SoC
revision SR2.0 we need this driver to be enabled always as other drivers are
going to use SOC Bus API intensively.

No dependencies.

[1] https://lore.kernel.org/lkml/20200512123449.16517-1-grygorii.strashko@ti.com/
[2] https://lore.kernel.org/lkml/20200613164346.28852-1-grygorii.strashko@ti.com/


-- 
Best regards,
grygorii
