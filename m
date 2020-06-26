Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4AEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46AE207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFZUXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFZUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:23:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD89DC03E979;
        Fri, 26 Jun 2020 13:23:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 33C4A2A5F0E
Subject: Re: next/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     Sudeep Holla <sudeep.holla@arm.com>, kernelci-results@groups.io,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <5ef64849.1c69fb81.2d891.248a@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <9b77d663-311e-37ba-c33f-31dd0a77723c@collabora.com>
Date:   Fri, 26 Jun 2020 21:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ef64849.1c69fb81.2d891.248a@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 20:11, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15
> 
> Summary:
>   Start:      36e3135df4d4 Add linux-next specific files for 20200626
>   Plain log:  https://storage.kernelci.org/next/master/next-20200626/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20200626/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.html
>   Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into motherboard node
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     qemu_arm-vexpress-a15
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     vexpress_defconfig
>   Test case:  baseline.dmesg.crit

The critical error message allegedly caused by this commit is:

<2>GIC CPU mask not found - kernel will fail to boot.

The report needs to be improved to show it automatically, sorry
if this wasn't clear.

Guillaume


> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 38ac46002d1df5707566a73486452851341028d2
> Author: Andre Przywara <andre.przywara@arm.com>
> Date:   Wed Jun 3 17:22:37 2020 +0100
> 
>     arm: dts: vexpress: Move mcc node back into motherboard node
>     
>     Commit d9258898ad49 ("arm64: dts: arm: vexpress: Move fixed devices
>     out of bus node") moved the "mcc" DT node into the root node, because
>     it does not have any children using "reg" properties, so does violate
>     some dtc checks about "simple-bus" nodes.
>     
>     However this broke the vexpress config-bus code, which walks up the
>     device tree to find the first node with an "arm,vexpress,site" property.
>     This gave the wrong result (matching the root node instead of the
>     motherboard node), so broke the clocks and some other devices for
>     VExpress boards.
>     
>     Move the whole node back into its original position. This re-introduces
>     the dtc warning, but is conceptually the right thing to do. The dtc
>     warning seems to be overzealous here, there are discussions on fixing or
>     relaxing this check instead.
>     
>     Link: https://lore.kernel.org/r/20200603162237.16319-1-andre.przywara@arm.com
>     Fixes: d9258898ad49 ("arm64: dts: vexpress: Move fixed devices out of bus node")
>     Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>     Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index e6308fb76183..a88ee5294d35 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -100,79 +100,6 @@
>  		};
>  	};
>  
> -	mcc {
> -		compatible = "arm,vexpress,config-bus";
> -		arm,vexpress,config-bridge = <&v2m_sysreg>;
> -
> -		oscclk0 {
> -			/* MCC static memory clock */
> -			compatible = "arm,vexpress-osc";
> -			arm,vexpress-sysreg,func = <1 0>;
> -			freq-range = <25000000 60000000>;
> -			#clock-cells = <0>;
> -			clock-output-names = "v2m:oscclk0";
> -		};
> -
> -		v2m_oscclk1: oscclk1 {
> -			/* CLCD clock */
> -			compatible = "arm,vexpress-osc";
> -			arm,vexpress-sysreg,func = <1 1>;
> -			freq-range = <23750000 65000000>;
> -			#clock-cells = <0>;
> -			clock-output-names = "v2m:oscclk1";
> -		};
> -
> -		v2m_oscclk2: oscclk2 {
> -			/* IO FPGA peripheral clock */
> -			compatible = "arm,vexpress-osc";
> -			arm,vexpress-sysreg,func = <1 2>;
> -			freq-range = <24000000 24000000>;
> -			#clock-cells = <0>;
> -			clock-output-names = "v2m:oscclk2";
> -		};
> -
> -		volt-vio {
> -			/* Logic level voltage */
> -			compatible = "arm,vexpress-volt";
> -			arm,vexpress-sysreg,func = <2 0>;
> -			regulator-name = "VIO";
> -			regulator-always-on;
> -			label = "VIO";
> -		};
> -
> -		temp-mcc {
> -			/* MCC internal operating temperature */
> -			compatible = "arm,vexpress-temp";
> -			arm,vexpress-sysreg,func = <4 0>;
> -			label = "MCC";
> -		};
> -
> -		reset {
> -			compatible = "arm,vexpress-reset";
> -			arm,vexpress-sysreg,func = <5 0>;
> -		};
> -
> -		muxfpga {
> -			compatible = "arm,vexpress-muxfpga";
> -			arm,vexpress-sysreg,func = <7 0>;
> -		};
> -
> -		shutdown {
> -			compatible = "arm,vexpress-shutdown";
> -			arm,vexpress-sysreg,func = <8 0>;
> -		};
> -
> -		reboot {
> -			compatible = "arm,vexpress-reboot";
> -			arm,vexpress-sysreg,func = <9 0>;
> -		};
> -
> -		dvimode {
> -			compatible = "arm,vexpress-dvimode";
> -			arm,vexpress-sysreg,func = <11 0>;
> -		};
> -	};
> -
>  	bus@8000000 {
>  		motherboard-bus {
>  			model = "V2M-P1";
> @@ -435,6 +362,79 @@
>  						};
>  					};
>  				};
> +
> +				mcc {
> +					compatible = "arm,vexpress,config-bus";
> +					arm,vexpress,config-bridge = <&v2m_sysreg>;
> +
> +					oscclk0 {
> +						/* MCC static memory clock */
> +						compatible = "arm,vexpress-osc";
> +						arm,vexpress-sysreg,func = <1 0>;
> +						freq-range = <25000000 60000000>;
> +						#clock-cells = <0>;
> +						clock-output-names = "v2m:oscclk0";
> +					};
> +
> +					v2m_oscclk1: oscclk1 {
> +						/* CLCD clock */
> +						compatible = "arm,vexpress-osc";
> +						arm,vexpress-sysreg,func = <1 1>;
> +						freq-range = <23750000 65000000>;
> +						#clock-cells = <0>;
> +						clock-output-names = "v2m:oscclk1";
> +					};
> +
> +					v2m_oscclk2: oscclk2 {
> +						/* IO FPGA peripheral clock */
> +						compatible = "arm,vexpress-osc";
> +						arm,vexpress-sysreg,func = <1 2>;
> +						freq-range = <24000000 24000000>;
> +						#clock-cells = <0>;
> +						clock-output-names = "v2m:oscclk2";
> +					};
> +
> +					volt-vio {
> +						/* Logic level voltage */
> +						compatible = "arm,vexpress-volt";
> +						arm,vexpress-sysreg,func = <2 0>;
> +						regulator-name = "VIO";
> +						regulator-always-on;
> +						label = "VIO";
> +					};
> +
> +					temp-mcc {
> +						/* MCC internal operating temperature */
> +						compatible = "arm,vexpress-temp";
> +						arm,vexpress-sysreg,func = <4 0>;
> +						label = "MCC";
> +					};
> +
> +					reset {
> +						compatible = "arm,vexpress-reset";
> +						arm,vexpress-sysreg,func = <5 0>;
> +					};
> +
> +					muxfpga {
> +						compatible = "arm,vexpress-muxfpga";
> +						arm,vexpress-sysreg,func = <7 0>;
> +					};
> +
> +					shutdown {
> +						compatible = "arm,vexpress-shutdown";
> +						arm,vexpress-sysreg,func = <8 0>;
> +					};
> +
> +					reboot {
> +						compatible = "arm,vexpress-reboot";
> +						arm,vexpress-sysreg,func = <9 0>;
> +					};
> +
> +					dvimode {
> +						compatible = "arm,vexpress-dvimode";
> +						arm,vexpress-sysreg,func = <11 0>;
> +					};
> +				};
>  			};
>  		};
>  	};
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [52366a107bf0600cf366f5ff3ea1f147b285e41f] Merge tag 'fsnotify_for_v5.8-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> git bisect good 52366a107bf0600cf366f5ff3ea1f147b285e41f
> # bad: [36e3135df4d426612fc77db26a312c2531108603] Add linux-next specific files for 20200626
> git bisect bad 36e3135df4d426612fc77db26a312c2531108603
> # bad: [11fdea666694c5c8c8a52cb75b2f0e70a2c2c201] Merge remote-tracking branch 'drm/drm-next'
> git bisect bad 11fdea666694c5c8c8a52cb75b2f0e70a2c2c201
> # bad: [39ac1a242d0940dabd9192d99113c2b082ba45bc] Merge remote-tracking branch 'printk/for-next'
> git bisect bad 39ac1a242d0940dabd9192d99113c2b082ba45bc
> # good: [4a750150d9fe543e2163998501b3ad947d6dff74] Merge remote-tracking branch 'at91/at91-next'
> git bisect good 4a750150d9fe543e2163998501b3ad947d6dff74
> # bad: [d7645ac1101c5160a05e2dced672a8d63c2a7ec0] Merge remote-tracking branch 'scmi/for-linux-next'
> git bisect bad d7645ac1101c5160a05e2dced672a8d63c2a7ec0
> # good: [2408a915a05c109169ab689dc91ce31315406513] Merge branches 'arm64-defconfig-for-5.9', 'arm64-for-5.9', 'drivers-for-5.9' and 'dts-for-5.9' into for-next
> git bisect good 2408a915a05c109169ab689dc91ce31315406513
> # good: [1679681fb8b2d169ac9d98660d7390620990bf77] Merge remote-tracking branch 'raspberrypi/for-next'
> git bisect good 1679681fb8b2d169ac9d98660d7390620990bf77
> # good: [137233bdcd265762a251dfa24e82ebc5468e0ec2] Merge remote-tracking branch 'reset/reset/next'
> git bisect good 137233bdcd265762a251dfa24e82ebc5468e0ec2
> # good: [99bcf38dd05b76b41f8564b53d9be6b44613fa92] Merge branch 'v5.9-clk/next' into for-next
> git bisect good 99bcf38dd05b76b41f8564b53d9be6b44613fa92
> # good: [dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe] Merge branch 'next/dt' into for-next
> git bisect good dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe
> # good: [d6fe116541b73a56110310c39a270c99766cd909] Merge branch 'next/soc' into for-next
> git bisect good d6fe116541b73a56110310c39a270c99766cd909
> # bad: [24077bf8f9e69a3a6a2c714634e6c813566a152f] Merge tag 'juno-fix-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next
> git bisect bad 24077bf8f9e69a3a6a2c714634e6c813566a152f
> # bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
> git bisect bad 38ac46002d1df5707566a73486452851341028d2
> # first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
> -------------------------------------------------------------------------------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

