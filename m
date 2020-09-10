Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA7E20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BUBQ6UHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:39:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgIJHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:39:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08A7csho073221;
        Thu, 10 Sep 2020 02:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599723534;
        bh=6UgPk8O5Y8/6fKP4sAV7kdg8zCK2Ptevy054z4nrWwo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BUBQ6UHXr9dJ/wNBq4WKGzThUSVOGuv2JlQgbRoxMOCctcblg0zm+Jmhwb/o2pDsM
         kZ7IYaXCw2IpdumeVqhKgtZd+vOBkCCpwvNOvkUPEgb/QAqPHo6APGWHDXfEFK/l08
         QdZuk+64ACSQ3+8cTTDIQA5U0X6QdTBpHpJmnnMY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08A7cslp063132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 02:38:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 02:38:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 02:38:53 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7cnQF068803;
        Thu, 10 Sep 2020 02:38:51 -0500
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200908165942.32368-1-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a6eb8995-f06f-2af4-2618-01b681f771b1@ti.com>
Date:   Thu, 10 Sep 2020 13:08:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908165942.32368-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/20 10:29 pm, Grygorii Strashko wrote:
> Hi All,
> 
> arm64: dts: ti: k3-j7200: add dma and mcu cpsw nodes
> 
> This series adds DT nodes for TI J7200 SoC
> - INTR/INTA, Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
>   with J721E Soc, to enable DMA support
> - MCU CPSW2g DT nodes to enable networking

https://pastebin.ubuntu.com/p/FPVggcdQ6T/

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon

> 
> This series depends on:
>  - [PATCH v2 0/4] arm64: Initial support for Texas Instrument's J7200 Platform [1]
>    from: Lokesh Vutla <lokeshvutla@ti.com>
>  - [PATCH] soc: ti: k3-socinfo: Add entry for J7200 [2]
>    from: Peter Ujfalusi <peter.ujfalusi@ti.com>
>  - [PATCH] dmaengine: ti: k3-udma: Use soc_device_match() for SoC dependent parameters [3]
>    from: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200827065144.17683-1-lokeshvutla@ti.com/T/#m141ae4d0dd818518c00c81806d689983d6e832e6
> [2] https://lore.kernel.org/patchwork/patch/1283230/
> [3] https://lore.kernel.org/lkml/20200904120009.30941-1-peter.ujfalusi@ti.com/
> 
> Changes in v2:
>  - fixed DT build warnings (Nishanth Menon)
> 
> v1: https://lore.kernel.org/patchwork/cover/1301067/
> 
> Grygorii Strashko (3):
>   arm64: dts: ti: k3-j7200-main: add main navss cpts node
>   arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
>   arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
>     and phy defs
> 
> Peter Ujfalusi (1):
>   arm64: dts: ti: k3-j7200: add DMA support
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  73 +++++++++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
>  3 files changed, 236 insertions(+)
> 
