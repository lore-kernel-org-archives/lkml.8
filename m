Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3EED206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJmrpRIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgIHQgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:36:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51706 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbgIHQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:31:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Caq2l101881;
        Tue, 8 Sep 2020 07:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599568612;
        bh=yE6h/TCCI1nr5Hwk2p595EtwXTIH9VDdBsXkMKKTFWA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dJmrpRIv/Jw2G79AVUgGNzWeslazPxYqLvhWM6FOoBSjTVLxI4e7DjvFMhHGSteIZ
         bdut1T98FntyvxALagJ6MPiDXjpHufpg8kvWYKM9dupO3UC8BUzsIpShwb5xtg/Tso
         5Bp6hu0U+YNXMl8SNckYFa/VnfmKYWuvDKPfWCI8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088Caqj9102372;
        Tue, 8 Sep 2020 07:36:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 07:36:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 07:36:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088Caq0J126769;
        Tue, 8 Sep 2020 07:36:52 -0500
Date:   Tue, 8 Sep 2020 07:36:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: ti: k3-j7200-common-proc-board: Add
 USB support
Message-ID: <20200908123651.yg54ht2z2esqdg4e@akan>
References: <20200907145213.30788-1-rogerq@ti.com>
 <20200907145213.30788-7-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907145213.30788-7-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:52-20200907, Roger Quadros wrote:
> Enable USB0 port in high-speed (2.0) mode.


Am I right that this is a choice forced by serdes mux configuration
selection? Might be good to document it (default speed is super-speed).

> 
> The board uses lane 3 of SERDES for USB. Set the mux
> accordingly.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 0ecaba600704..5ce3fddbd617 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -42,6 +42,12 @@
>  			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
>  		>;
>  	};
> +
> +	main_usbss0_pins_default: main-usbss0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
> +		>;
> +	};
>  };
>  
>  &wkup_uart0 {
> @@ -145,3 +151,19 @@
>  	idle-states = <SERDES0_LANE0_PCIE1_LANE0>, <SERDES0_LANE1_PCIE1_LANE1>,
>  		      <SERDES0_LANE2_QSGMII_LANE1>, <SERDES0_LANE3_IP4_UNUSED>;
>  };
> +
> +&usb_serdes_mux {
> +	idle-states = <1>; /* USB0 to SERDES lane 3 */
> +};
> +
> +&usbss0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usbss0_pins_default>;
> +	ti,vbus-divider;
> +	ti,usb2-only;
> +};
> +
> +&usb0 {
> +	dr_mode = "otg";
> +	maximum-speed = "high-speed";
> +};
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
