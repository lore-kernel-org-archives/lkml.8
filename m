Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C192074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598487797;
	bh=0ia8O++lCCY7OuZgn4cvxRRO38bVLc9aTzbYf7rmHGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VWQbLAMDhrf999MkiMsOtaQks7os32RTk/VcCX6fgFcTTOGJxN3FS8Iy+Kifjok2M
	 nYTBVu//FLO22fvoMqC4d36DYc9uyXoRQs1s+/SRiFs0PZKWH26D2rR4F5Gk8C1l0b
	 h/lwoAb6CQztjLdF8jotXSN6IBzF0U1j6I36XjN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0AXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgH0AXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:23:14 -0400
Received: from ogun.localdomain (unknown [47.185.225.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EF52074A;
        Thu, 27 Aug 2020 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598487794;
        bh=0ia8O++lCCY7OuZgn4cvxRRO38bVLc9aTzbYf7rmHGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7LLW/OCbc7aEijrvZ64yshOtWYqEgSTEizsGiYVP8xvdPYwMNVAPCM0q56ClkItZ
         cNAgHACjM6BK+O8dRlrztFeqZz8tRBp30rgQzwgvr3B3rZR0AGAUmNltSX9au22s+6
         QN8vkBiwv6iCYap5DHMpjLl/BcsWLvycJ3rtjEW8=
Date:   Wed, 26 Aug 2020 19:23:18 -0500
From:   Nishanth Menon <nmenon@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: ti: Add bindings for J7200 SoC
Message-ID: <20200827002318.fumzb3w7ekciffua@ogun.localdomain>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
 <20200723084628.19241-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723084628.19241-2-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:16-20200723, Lokesh Vutla wrote:
> The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
> It is targeted for automotive gateway, vehicle compute systems,
> Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
> The SoC aims to meet the complex processing needs of modern embedded
> products.
> 
> Some highlights of this SoC are:
> * Dual Cortex-A72s in a single cluster, two clusters of lockstep
>   capable dual Cortex-R5F MCUs and a Centralized Device Management and
>   Security Controller (DMSC).
> * Configurable L3 Cache and IO-coherent architecture with high data
>   throughput capable distributed DMA architecture under NAVSS.
> * Integrated Ethernet switch supporting up to a total of 4 external ports
>   in addition to legacy Ethernet switch of up to 2 ports.
> * Upto 1 PCIe-GEN3 controller, 1 USB3.0 Dual-role device subsystems,
>   20 MCANs, 3 McASP, eMMC and SD, OSPI/HyperBus memory controller, I3C and
>   I2C, eCAP/eQEP, eHRPWM among other peripherals.
> * One hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>   management.
> 
> See J7200 Technical Reference Manual (SPRUIU1, June 2020)
> for further details: https://www.ti.com/lit/pdf/spruiu1
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
> index 333e7256126a..33419cce0afa 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.txt
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
> @@ -16,6 +16,9 @@ architecture it uses, using one of the following compatible values:
>  - J721E
>    compatible = "ti,j721e";
>  
> +- J7200
> +  compatible = "ti,j7200";
> +
>  Boards
>  ------

Lets convert the k3.txt to k3.yaml before we do anything more here.
Looking at the full series, I see that there are pending comments from
Grygorii as well which needs to be looked at. I have'nt seen a follow up
version since this version.

[1] https://lore.kernel.org/linux-arm-kernel/20200723084628.19241-1-lokeshvutla@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
