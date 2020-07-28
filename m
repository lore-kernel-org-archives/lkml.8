Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBBC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09656207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JKJPFnn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgG1TTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:19:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41448 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbgG1TTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:19:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SJJjiW048344;
        Tue, 28 Jul 2020 14:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595963985;
        bh=t6blnstb7bXBVCv5Ji+4XyRD3JuIXeeM7NotCIPjKE4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JKJPFnn5mvsFJT1Cq3Ki1eoZa4jVHaKDOVwZSCogT3y5ox1ZJusWgnmiLhNWuXFBe
         1aQkcKWbjbNSGm0qa3xOqjQoowGmXw8EAmnIPsrCzBYmDxgRU2CkCPv0qjrNNKz5rU
         t0+gpxLsLoWXHJtQ6rge9JJOIfe90BNphNyxLTb0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SJJjCX033200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 14:19:45 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 14:19:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 14:19:45 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SJJgp9080041;
        Tue, 28 Jul 2020 14:19:42 -0500
Subject: Re: [PATCH 0/4] arm64: Initial support for Texas Instrument's J7200
 Platform
To:     Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Suman Anna <s-anna@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <17a6e608-7ffc-a612-9caf-bad7315f5e60@ti.com>
Date:   Tue, 28 Jul 2020 22:19:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200723084628.19241-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/2020 11:46, Lokesh Vutla wrote:
> This series adds initial support for latest new SoC, J7200, from Texas Instruments.
> 
> The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
> It is targeted for for automotive gateway, vehicle compute systems,
> Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
> The SoC aims to meet the complex processing needs of modern embedded products.
> 
> See J7200 Technical Reference Manual (SPRUIU1, June 2020)
> for further details: https://www.ti.com/lit/pdf/spruiu1
> 
> Testing:
> - Boot log: https://pastebin.ubuntu.com/p/FvpzWjf7tw/
> - ./scripts/checkpatch --strict
> 	- Few warningns about Line length exceeding 100 columns.
> 	  But these are corresponding to comments
> - v8make dtbs_check
> - DT_SCHEMA_FLAGS="-u"
>    DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/ti/k3.yaml"
>    v8make dtbs_check
> - DT_SCHEMA_FLAGS="-u"
>    DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/ti/k3.yaml"
>    v8make dt_binding_check
> 
> Lokesh Vutla (4):
>    dt-bindings: arm: ti: Add bindings for J7200 SoC
>    dt-bindings: arm: ti: Convert K3 board/soc bindings to DT schema
>    arm64: dts: ti: Add support for J7200 SoC
>    arm64: dts: ti: Add support for J7200 Common Processor Board
> 
>   .../devicetree/bindings/arm/ti/k3.txt         |  26 ---
>   .../devicetree/bindings/arm/ti/k3.yaml        |  28 +++
>   MAINTAINERS                                   |   2 +-
>   arch/arm64/boot/dts/ti/Makefile               |   3 +-
>   .../dts/ti/k3-j7200-common-proc-board.dts     |  64 ++++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 199 ++++++++++++++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  84 ++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  29 +++
>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          | 165 +++++++++++++++
>   9 files changed, 572 insertions(+), 28 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.yaml
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi
> 

I have networking enabled on top of this series here.

ssh://git@bitbucket.itg.ti.com/~x1045550/ti-priv-linux-kernel.git ti-linux-5.4.y-for-next-pull

But DMA failed for Main domain.
     0.781005] ti-udma 31150000.dma-controller: NAVSS ti,sci-dev-id read failure -22
[    0.788684] ti-udma: probe of 31150000.dma-controller failed with error -22

http://lcpdresults.itg.ti.com/launcher/results/8013

Is there anything (except my comment for patch 3) which prevents this from been merged?

-- 
Best regards,
grygorii
