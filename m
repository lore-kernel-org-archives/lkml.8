Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B44C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3620704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HdNZ2xzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbgAXLas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:30:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60220 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404266AbgAXLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:30:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00OBUXrG093347;
        Fri, 24 Jan 2020 05:30:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579865433;
        bh=TNVGZncj/emO7ZwPs/tDLiyy7EhUXZDgUQHos95Xw2g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HdNZ2xzlLG2ZNKD6hs0FQrdQDdrcseAZXh6kSYPbXceVuL7TwNRzaFXe7bIcRrCI0
         yNQfBhSqdmzkWrJHEo/ZGBoHvTYumV4RTHJOsHdyo/BjK9r1ECU7B4DQveL2I8jeO3
         AIUq+64yJcX/6KGC11vpzB90JADudPCM2horL+lc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00OBUX7L051608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 05:30:33 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 05:30:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 05:30:32 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OBUUUE088149;
        Fri, 24 Jan 2020 05:30:31 -0600
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <f.fainelli@gmail.com>, <linux-rpi-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200124111700.29910-1-nsaenzjulienne@suse.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <adf69613-518f-db01-c1c1-8d3fda4b5182@ti.com>
Date:   Fri, 24 Jan 2020 13:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124111700.29910-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 24/01/2020 13.17, Nicolas Saenz Julienne wrote:
> With the introduction of 738987a1d6f1 ("mmc: bcm2835: Use
> dma_request_chan() instead dma_request_slave_channel()") sdhost-bcm2835
> now waits for its DMA channel to be available when defined in the
> device-tree (it would previously default to PIO). Albeit the right
> behaviour, the MMC host is needed for booting. So this makes sure the
> DMA channel shows up in time.
> 
> Fixes: 738987a1d6f1 ("mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()")

it is not a bug, it is a feature ;)

Yes, if a driver have DMA binding and it is needed during boot then the
DMA driver also needs to be built in.
I believe it is desired to use DMA instead of PIO in any case for MMC
and in the past bcm2835 did not used DMA if DMA was module and the MMC
was built in.

Sorry for the inconvenience this change has caused to bcm2835!

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4631a1190719..905109f6814f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -683,7 +683,7 @@ CONFIG_RTC_DRV_SNVS=m
>  CONFIG_RTC_DRV_IMX_SC=m
>  CONFIG_RTC_DRV_XGENE=y
>  CONFIG_DMADEVICES=y
> -CONFIG_DMA_BCM2835=m
> +CONFIG_DMA_BCM2835=y
>  CONFIG_DMA_SUN6I=m
>  CONFIG_FSL_EDMA=y
>  CONFIG_IMX_SDMA=y
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
