Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B751206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LSVZ4rdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgIAOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:52:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44796 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgIAOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:52:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081Eq5D5072509;
        Tue, 1 Sep 2020 09:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598971925;
        bh=7WwUQEK0QlMirnCVFFz8/M6oa2rEBJ2EnkKCl/BwZCc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LSVZ4rdr493g0Ssd0nJePMxsdxf4bXNDeb70IFYneuvqdPF8TTGXJ8314hLsjyRCo
         vic3j4z/oWykXE8M/p69HfxT/D3zXkfCitXrV7ojzEPuVVyAbO/mCXoIGIUE+gESFd
         eo5yOCPsdz2cUtGSrebq1j/USp+UHfo2i20nZ8rQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081Eq5jo110207;
        Tue, 1 Sep 2020 09:52:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 09:52:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 09:52:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081Eq4Hv125864;
        Tue, 1 Sep 2020 09:52:04 -0500
Date:   Tue, 1 Sep 2020 09:52:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe
 device tree nodes
Message-ID: <20200901145204.ayybrzqjcfhiqnfq@akan>
References: <20200901140628.8800-1-kishon@ti.com>
 <20200901140628.8800-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200901140628.8800-2-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:36-20200901, Kishon Vijay Abraham I wrote:
> Add PCIe device tree node (both RC and EP) for the four
> PCIe instances here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 218 ++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
>  2 files changed, 222 insertions(+), 1 deletion(-)


Did you look at the diff of the dtbs_check before and after this
series? I see: https://pastebin.ubuntu.com/p/9fyfrTjx9M/

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 00a36a14efe7..a36909d8b8c3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -28,6 +28,26 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x00100000 0x1c000>;
>  
> +		pcie0_ctrl: pcie-ctrl@4070 {
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf
Section 2.2.2: why not use syscon@4070 and so on?

> +			compatible = "syscon";
> +			reg = <0x00004070 0x4>;
> +		};
> +
> +		pcie1_ctrl: pcie-ctrl@4074 {
> +			compatible = "syscon";
> +			reg = <0x00004074 0x4>;
> +		};
> +
> +		pcie2_ctrl: pcie-ctrl@4078 {
> +			compatible = "syscon";
> +			reg = <0x00004078 0x4>;
> +		};
> +
> +		pcie3_ctrl: pcie-ctrl@407c {
> +			compatible = "syscon";
> +			reg = <0x0000407c 0x4>;
> +		};
> +
>  		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
>  			compatible = "mmio-mux";
>  			reg = <0x00004080 0x50>;
> @@ -576,6 +596,204 @@
>  		};
>  	};
>  
> +	pcie0_rc: pcie@2900000 {
> +		compatible = "ti,j721e-pcie-host";
> +		reg = <0x00 0x02900000 0x00 0x1000>,
> +		      <0x00 0x02907000 0x00 0x400>,
> +		      <0x00 0x0d000000 0x00 0x00800000>,
> +		      <0x00 0x10000000 0x00 0x00001000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> +		interrupt-names = "link_state";
> +		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
> +		device_type = "pci";
> +		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +		max-link-speed = <3>;
> +		num-lanes = <2>;
> +		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 239 1>;
> +		clock-names = "fck";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xf>;
> +		vendor-id = <0x104c>;
> +		device-id = <0xb00d>;
> +		msi-map = <0x0 &gic_its 0x0 0x10000>;
> +		dma-coherent;
> +		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
> +			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
> +		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> +	};
> +
> +	pcie0_ep: pcie-ep@2900000 {
Not related to this patch, but just a suggestion: pcie-ep -> do we
need to add that to the Generic names in DT spec?

[...]
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index f787aa73aaae..eeb02115b966 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -132,9 +132,12 @@
>  			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
>  			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
>  			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
> -			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
> +			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* PCIe Core*/
> +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* PCIe Core*/
>  			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
										^^
									should be PCIe1?
Just because you are introducing PCIe2,3 in this patch, the net result
does'nt look consistent? Also might want to cover this change in the
$commit_message.
[...]
>  			 <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71 */
> +			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT */
> +			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT */
>  			 <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
>  			 <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>, /* C66_1 */
>  			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
