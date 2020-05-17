Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE85C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA20420820
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589724620;
	bh=XT/syzd4Ji2A/NzOC4REpBE9YiXAEHBOciMXCiNEquk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ESRAyJ8mi1uKgW3q9mFx84wBdyM4DRXpGudPrOSKTAcIgQ5TxTWHyyKkNke1jH/0l
	 1cTE1jgmiyZAuOYjTSVoNkWRrkNWt44ABPwoGTIR9eiurtXNi/DNR/vZWrP+WFG5Lc
	 z4PXN6yHmoxLFa93iSdJKmkcbhje17DqtPseQYHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEQOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 10:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQOKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 10:10:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3448C207BB;
        Sun, 17 May 2020 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589724619;
        bh=XT/syzd4Ji2A/NzOC4REpBE9YiXAEHBOciMXCiNEquk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8vJ/DrZGKm0VjP5Yj3UfHVhf2C7sBi7wzYNkMryqQQNxTZXltxYC48Il4Gfl05GJ
         aed+6/wrf684RsVJ68FByBCnIut8zDptu+nzgBOQKZDd6fs/b0k4ugRd+CuCt0taBP
         ptFDpqYw0afnOVDLEyQHI0PBXg5I/raVvFnjmusk=
Date:   Sun, 17 May 2020 22:10:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch v2 1/2] ls1043ardb: add qe node to ls1043ardb
Message-ID: <20200517141011.GB25973@dragon>
References: <20200429082052.18519-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429082052.18519-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:20:51PM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> Add qe node to fsl-ls1043a.dtsi and fsl-ls1043a-rdb.dts
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Subject prefix should be like 'arm64: dts: ...'


> ---
> v2:
> - add commit msg and drop a new blank line
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 16 ++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 65 +++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index 4223a23..96e87ba 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -96,6 +96,22 @@
>  	};
>  };
>  
> +&uqe {

Keep labeling node sort alphabetically.

> +	ucc_hdlc: ucc@2000 {
> +		compatible = "fsl,ucc-hdlc";
> +		rx-clock-name = "clk8";
> +		tx-clock-name = "clk9";
> +		fsl,rx-sync-clock = "rsync_pin";
> +		fsl,tx-sync-clock = "tsync_pin";
> +		fsl,tx-timeslot-mask = <0xfffffffe>;
> +		fsl,rx-timeslot-mask = <0xfffffffe>;
> +		fsl,tdm-framer-type = "e1";
> +		fsl,tdm-id = <0>;
> +		fsl,siram-entry-id = <0>;
> +		fsl,tdm-interface;
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index c084c7a4..674e671 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -525,6 +525,71 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		uqe: uqe@2400000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "qe";

Is this really needed?  I can not find it in bindings doc qe.txt.

> +			compatible = "fsl,qe", "simple-bus";
> +			ranges = <0x0 0x0 0x2400000 0x40000>;
> +			reg = <0x0 0x2400000 0x0 0x480>;
> +			brg-frequency = <100000000>;
> +			bus-frequency = <200000000>;
> +			fsl,qe-num-riscs = <1>;
> +			fsl,qe-num-snums = <28>;
> +
> +			qeic: qeic@80 {
> +				compatible = "fsl,qe-ic";
> +				reg = <0x80 0x80>;
> +				#address-cells = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupts = <0 77 0x04 0 77 0x04>;

Two identical interrupts?  Also, please use GIC_SPI and
IRQ_TYPE_LEVEL_HIGH defines.

Shawn

> +			};
> +
> +			si1: si@700 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,ls1043-qe-si",
> +						"fsl,t1040-qe-si";
> +				reg = <0x700 0x80>;
> +			};
> +
> +			siram1: siram@1000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "fsl,ls1043-qe-siram",
> +						"fsl,t1040-qe-siram";
> +				reg = <0x1000 0x800>;
> +			};
> +
> +			ucc@2000 {
> +				cell-index = <1>;
> +				reg = <0x2000 0x200>;
> +				interrupts = <32>;
> +				interrupt-parent = <&qeic>;
> +			};
> +
> +			ucc@2200 {
> +				cell-index = <3>;
> +				reg = <0x2200 0x200>;
> +				interrupts = <34>;
> +				interrupt-parent = <&qeic>;
> +			};
> +
> +			muram@10000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "fsl,qe-muram", "fsl,cpm-muram";
> +				ranges = <0x0 0x10000 0x6000>;
> +
> +				data-only@0 {
> +					compatible = "fsl,qe-muram-data",
> +					"fsl,cpm-muram-data";
> +					reg = <0x0 0x6000>;
> +				};
> +			};
> +		};
> +
>  		lpuart0: serial@2950000 {
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2950000 0x0 0x1000>;
> -- 
> 2.9.5
> 
