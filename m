Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6BBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0793820737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGCKvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:51:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGCKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:51:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CC492F;
        Fri,  3 Jul 2020 03:50:59 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 095923F68F;
        Fri,  3 Jul 2020 03:50:57 -0700 (PDT)
Subject: Re: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     "kernelci.org bot" <bot@kernelci.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kernelci-results@groups.io, gtucker@collabora.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <5efec450.1c69fb81.7626b.b08a@mx.google.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <85f43f7f-f423-fe84-81e4-ddefe16c1a53@arm.com>
Date:   Fri, 3 Jul 2020 11:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5efec450.1c69fb81.7626b.b08a@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 06:38, kernelci.org bot wrote:

Hi Guillaume,

is this report legit? The situation didn't change from Monday, I just
repeated the test with mainline compared to my patch reverted.

What is the actual failure here? You pointed to:
<2>GIC CPU mask not found - kernel will fail to boot.
but I don't see any explicit line stating that as the culprit anywhere
in the logs. Actually the last line says:
00:24:07.022224  Job finished correctly

And I see the GIC messages with and without this patch. As mentioned on
Monday, "-smp 2" should be added to the QEMU command line to fix that.

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
> mainline/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15
> 
> Summary:
>   Start:      7cc2a8ea1048 Merge tag 'block-5.8-2020-07-01' of git://git.kernel.dk/linux-block
>   Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc3-37-g7cc2a8ea1048/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc1.txt
>   HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc3-37-g7cc2a8ea1048/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc1.html
>   Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into motherboard node
> 
> Checks:
>   revert:     PASS
>   verify:     PASS

What does that mean? That reverting the patch made the test pass?
I did exactly that, and reverting made it worse, because poweroff
doesn't work (among other things).
So could this be a testing artifact? Because of the failing poweroff the
test timed out or something?

Many thanks,
Andre

> 
> Parameters:
>   Tree:       mainline
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     qemu_arm-vexpress-a15
>   CPU arch:   arm
>   Lab:        lab-cip
>   Compiler:   gcc-8
>   Config:     vexpress_defconfig
>   Test case:  baseline.dmesg.crit
> 
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
> # good: [719fdd32921fb7e3208db8832d32ae1c2d68900f] afs: Fix storage of cell names
> git bisect good 719fdd32921fb7e3208db8832d32ae1c2d68900f
> # bad: [7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf] Merge tag 'block-5.8-2020-07-01' of git://git.kernel.dk/linux-block
> git bisect bad 7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf
> # bad: [e44b59cd758acdd413512d4597a1fabdadfe3abf] Merge tag 'arm-fixes-5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad e44b59cd758acdd413512d4597a1fabdadfe3abf
> # good: [91a9a90d040e8b9ff63d48ea71468e0f4db764ff] Merge tag 'sched_urgent_for_5.8_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 91a9a90d040e8b9ff63d48ea71468e0f4db764ff
> # bad: [42d3f7e8da1bc55e3109f612c519c945f6587194] Merge tag 'imx-fixes-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
> git bisect bad 42d3f7e8da1bc55e3109f612c519c945f6587194
> # bad: [6d89c73ca5813768a2cc66f7420ac0cbddf4f37d] Merge tag 'arm-soc/for-5.8/soc-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
> git bisect bad 6d89c73ca5813768a2cc66f7420ac0cbddf4f37d
> # bad: [0f77ce26ebcf6ea384421d2dd47b924b83649692] Revert "ARM: sti: Implement dummy L2 cache's write_sec"
> git bisect bad 0f77ce26ebcf6ea384421d2dd47b924b83649692
> # bad: [d68ec1644dd546851d651787a638aead32a60a6f] Merge tag 'juno-fix-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
> git bisect bad d68ec1644dd546851d651787a638aead32a60a6f
> # bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
> git bisect bad 38ac46002d1df5707566a73486452851341028d2
> # first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
> -------------------------------------------------------------------------------
> 

