Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A45C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A22078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598068963;
	bh=YGZkhca07krEP+4IV4VOl3lqC5GOkhsPpelNi0so0aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SoFgc+lGlebYc6wpfiurEnY0LJsucsj0wdUFD0YaZQEH7Q3rVGAXdCBUPYDGfRZJN
	 bBatLktXEWtxbeI5nHZk4A34WtJ+50uiUBhItQw2ZCqeE1wxG0XuwW9PMn3C0Zr9JO
	 5GI5iqjGS+aam6rZB6ldCCVT74NS1ZclQNVtHjGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgHVECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHVECl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:02:41 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9777A20732;
        Sat, 22 Aug 2020 04:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598068961;
        bh=YGZkhca07krEP+4IV4VOl3lqC5GOkhsPpelNi0so0aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDVDl75fUUNARBhzkj+IADwTQZ+5asmINBBM78lB1darERLgqTMT5vFkkp4H4QZU+
         yMlY/CC8GVLuM4rRBiKQ+05U3ce7U3LWsElHlhutiCATbl3Z/ZBAAaOwr+VUFEKOuM
         r5c+gmBCoKHBo75uCJsGkDl8vvDS3KaBHvCWFKic=
Date:   Sat, 22 Aug 2020 12:02:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: ls1021a: fix QuadSPI-memory reg range
Message-ID: <20200822040224.GC27575@dragon>
References: <20200728105006.7952-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728105006.7952-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:50:06PM +0200, Matthias Schiffer wrote:
> According to the Reference Manual, the correct size is 512 MiB.
> 
> Without this fix, probing the QSPI fails:
> 
>     fsl-quadspi 1550000.spi: ioremap failed for resource
>         [mem 0x40000000-0x7fffffff]
>     fsl-quadspi 1550000.spi: Freescale QuadSPI probe failed
>     fsl-quadspi: probe of 1550000.spi failed with error -12
> 
> Fixes: 85f8ee78ab72 ("ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Idiomatically we use 'ARM: ...' for arm32 DTS patch prefix.

I fixed it up and applied the patch.

Shawn

> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index b2ff27af090e..9435ce527e85 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -181,7 +181,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x1550000 0x0 0x10000>,
> -			      <0x0 0x40000000 0x0 0x40000000>;
> +			      <0x0 0x40000000 0x0 0x20000000>;
>  			reg-names = "QuadSPI", "QuadSPI-memory";
>  			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "qspi_en", "qspi";
> -- 
> 2.17.1
> 
