Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B8C20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597155359;
	bh=zWMlmJB1HlVKW8Wg0QY20hOxqwzcNWsUp85/HFNWzd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c5o672xt70y8gl0uCAlM+aLPtQiIxzxdnYEPbJujQeaMnxOL1LlV6gG76XLPIdfNG
	 B9KIb3SsUHVry6chDvbk/eLh0b37lw0Fzk0k34stDQGDJ1RWWvQ5oM9LPXdlwVb6aP
	 m/V871bgatKrFvCf0P5aQm3ZJ8sz3sOVRafEbIzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHKOP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgHKOP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:15:57 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9DA206C3;
        Tue, 11 Aug 2020 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597155356;
        bh=zWMlmJB1HlVKW8Wg0QY20hOxqwzcNWsUp85/HFNWzd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJ0FUbDiSmfTBvKOQnICMqMcaH97rzRamK5ZTeyJlQjAg0Nnn/NajT4Y/0+GOntVD
         YmYhKN3/swgNlGd6EhfmDWSNqaUlYGE69dNOV/aSV3RTygkBkqYdJUBg9C7NIpnAB/
         tWAaQ+sNQeAeXJVzE/1XII16Hw6fuuC7/OWfQ5oA=
Date:   Tue, 11 Aug 2020 16:15:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH v3 11/11] misc: hisi_hikey_usb: Driver to support
 usb functionality of Hikey960
Message-ID: <20200811161141.431007e8@coco.lan>
In-Reply-To: <20200811142106.3dba2f9f@coco.lan>
References: <20191016033340.1288-1-john.stultz@linaro.org>
        <20191016033340.1288-12-john.stultz@linaro.org>
        <20200810183503.3e8bae80@coco.lan>
        <CALAqxLUu76m=Q_tDht4DmtgXYmL7Ma1zVJZzvhcsHn2hMAgpLA@mail.gmail.com>
        <20200811142106.3dba2f9f@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Aug 2020 14:21:06 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> I was able to drop it, but I had to add this at dwc3 settings:
> 
> 	regulator-on-in-suspend;
> 
> As otherwise the device seems to stop a few seconds after the dwc3
> driver gets started.
> 
> I suspect it could be related to those calls at the dwg3 driver:
> 
> 	pm_runtime_use_autosuspend(dev);
> 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
> 
> As this seems to be the only difference between what the dwc3 core
> does and the dwc3-hisi doesn't do.

Found the issue.

It is due to a quirk that was renamed:

	-                       snps,dis-split-quirk;
	+                       snps,dis_enblslpm_quirk;

I'm now using just those drivers:

	- hikey 970 phy (pulled from OOT);
	- upstream dwc3;
	- upstream rt1711 driver;
	- drivers/misc/hisi_hikey_usb.c (with my changes).

Now, the problem is that the USB devices are getting one reset per 
second (which starts about 10 seconds after dwc3 driver is loaded):

[   14.080666] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
[   14.752689] usb 1-1.2: reset low-speed USB device number 4 using xhci-hcd
[   15.712646] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
[   16.480683] usb 1-1.2: reset low-speed USB device number 4 using xhci-hcd
[   17.472651] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
[   18.208675] usb 1-1.2: reset low-speed USB device number 4 using xhci-hcd

It sounds like an autosuspend thing, but disabling it (using powertop) 
doesn't affect it. Any ideas?

PS.: I'm enclosing the relevant DT data.

Thanks,
Mauro

		i2c1: i2c@ffd72000 {
			compatible = "snps,designware-i2c";
			reg = <0x0 0xffd72000 0x0 0x1000>;
			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
			#address-cells = <1>;
			#size-cells = <0>;
			clock-frequency = <400000>;
			clocks = <&iomcu HI3670_CLK_GATE_I2C1>;
			resets = <&iomcu_rst 0x20 4>;
			pinctrl-names = "default";
			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;

			rt1711h: rt1711h@4e {
				compatible = "richtek,rt1711h";
				reg = <0x4e>;
				status = "ok";
				interrupt-parent = <&gpio27>;
				interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
				pinctrl-names = "default";
				pinctrl-0 = <&pd_cfg_func>;

				usb_con: connector {
					compatible = "usb-c-connector";
					label = "USB-C";
					data-role = "dual";
					power-role = "dual";
					try-power-role = "sink";
					source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
					sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
						     PDO_VAR(5000, 5000, 1000)>;
					op-sink-microwatt = <10000000>;

					ports {
						#address-cells = <1>;
						#size-cells = <0>;
						port@1 {
							reg = <1>;
							usb_con_ss: endpoint {
								remote-endpoint = <&dwc3_ss>;
							};
						};
					};
				};
				port {
					#address-cells = <1>;
					#size-cells = <0>;

					rt1711h_ep: endpoint@0 {
						reg = <0>;
						remote-endpoint = <&hikey_usb_ep1>;
					};
				};
			};
		};

		hikey_usbhub: hikey_usbhub {
			compatible = "hisilicon,kirin970_hikey_usbhub";

			typec-vbus-gpios = <&gpio26 1 0>;
			otg-switch-gpios = <&gpio4 2 0>;
			hub_reset_en_gpio = <&gpio0 3 0>;
			hub-vdd-supply = <&ldo17>;
			usb-role-switch;

			port {
				#address-cells = <1>;
				#size-cells = <0>;

				hikey_usb_ep0: endpoint@0 {
					reg = <0>;
					remote-endpoint = <&dwc3_role_switch>;
				};
				hikey_usb_ep1: endpoint@1 {
					reg = <1>;
					remote-endpoint = <&rt1711h_ep>;
				};
			};
		};

		usb31_misc: usb31_misc@ff200000 {
			compatible = "syscon";
			reg = <0x0 0xff200000 0x0 0x1000>;
		};

		usb31_misc_rst: usb31_misc_rst_controller {
			compatible = "hisilicon,hi3660-reset";
			#reset-cells = <2>;
			hisi,rst-syscon = <&usb31_misc>;
		};

		usb_phy: usbphy {
			compatible = "hisilicon,hi3670-usb-phy";
			#phy-cells = <0>;
			hisilicon,pericrg-syscon = <&crg_ctrl>;
			hisilicon,pctrl-syscon = <&pctrl>;
			hisilicon,sctrl-syscon = <&sctrl>;
			hisilicon,usb31-misc-syscon = <&usb31_misc>;
			eye-diagram-param = <0xFDFEE4>;
			usb3-phy-tx-vboost-lvl = <0x5>;
		};
		dwc3: dwc3@ff100000 {
			compatible = "snps,dwc3";
			reg = <0x0 0xff100000 0x0 0x100000>;
			interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
				    <0 161 IRQ_TYPE_LEVEL_HIGH>;

			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
				    <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
				    <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
				    <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
			clock-names = "clk_gate_abb_usb",
				      "hclk_gate_usb3otg",
				      "clk_gate_usb3otg_ref",
				      "aclk_gate_usb3dvfs";

			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
			assigned-clock-rates = <238000000>;
			resets = <&crg_rst 0x90 6>,
				 <&crg_rst 0x90 7>,
				 <&usb31_misc_rst 0xA0 8>,
				 <&usb31_misc_rst 0xA0 9>;

			phys = <&usb_phy>;
			phy-names = "usb3-phy";
			dr_mode = "otg";
			maximum-speed = "super-speed";
			phy_type = "utmi";
			snps,dis-del-phy-power-chg-quirk;
			snps,lfps_filter_quirk;
			snps,dis_u2_susphy_quirk;
			snps,dis_u3_susphy_quirk;
			snps,tx_de_emphasis_quirk;
			snps,tx_de_emphasis = <1>;
			snps,dis_enblslpm_quirk;
			snps,gctl-reset-quirk;
			usb-role-switch;
			role-switch-default-mode = "host";
			port {
				#address-cells = <1>;
				#size-cells = <0>;
				dwc3_role_switch: endpoint@0 {
					reg = <0>;
					remote-endpoint = <&hikey_usb_ep0>;
				};

				dwc3_ss: endpoint@1 {
					reg = <1>;
					remote-endpoint = <&usb_con_ss>;
				};
			};
		};


