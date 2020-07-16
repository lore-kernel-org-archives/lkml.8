Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE63C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F820656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGPJhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:37:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43394 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:37:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 045122A5513
Subject: Re: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kernelci-results@groups.io,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <5efec450.1c69fb81.7626b.b08a@mx.google.com>
 <85f43f7f-f423-fe84-81e4-ddefe16c1a53@arm.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <1f8dbd49-7774-f761-73f4-d96e81acff7e@collabora.com>
Date:   Thu, 16 Jul 2020 10:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85f43f7f-f423-fe84-81e4-ddefe16c1a53@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

Sorry for the delay, I missed the thread on this issue.

On 03/07/2020 11:49, André Przywara wrote:
> On 03/07/2020 06:38, kernelci.org bot wrote:
> 
> Hi Guillaume,
> 
> is this report legit? The situation didn't change from Monday, I just
> repeated the test with mainline compared to my patch reverted.
> 
> What is the actual failure here? You pointed to:
> <2>GIC CPU mask not found - kernel will fail to boot.
> but I don't see any explicit line stating that as the culprit anywhere
> in the logs. Actually the last line says:
> 00:24:07.022224  Job finished correctly

The failure is a "crit" kernel error message.  The test job still
completes, but it has detected this new error and the bisection
reliably lands on the same commit mentioned below as the root
cause.  As you found out, the commit is not to blame so this is a
false positive.  However, it's a bit more complicated...

> And I see the GIC messages with and without this patch. As mentioned on
> Monday, "-smp 2" should be added to the QEMU command line to fix that.

All the test jobs involved in this bisection can be found here:

  https://lava.ciplatform.org/scheduler/alljobs?length=25&search=lava-bisection-2224#table

The bisection first ran the "good" and "bad" revisions and didn't
detect the kernel error message with the "good" one.  However,
taking a closer look at the logs, the error was actually there:

  https://lava.ciplatform.org/scheduler/job/27647#L454

and then there were some kernel warnings:

  https://lava.ciplatform.org/scheduler/job/27647#L561

which didn't occur with the "bad" revision:

  https://lava.ciplatform.org/scheduler/job/27648


For some reason probably related to the kernel warnings, when
testing the "good" revision the GIC kernel errors got silenced
and dmesg didn't print them.  This mislead the test into a false
positive.

Bisections are only run when a regression occurs, and it looks
like these GIC errors have been around for a long time.  What I
believe happened is that the errors got hidden at some
point (allegedly due to the kernel warnings) and then came back
later.  This was then wrongly detected as a regression.


So we have 2 problems to solve, the first one is to actually
remove these kernel errors and you've explained how to do that
with the QEMU command line.  I've resubmitted the test job with
it and it worked indeed:

  https://lava.collabora.co.uk/scheduler/job/2493885

and sent a fix for it:

  https://github.com/kernelci/kernelci-core/pull/442


The other problem is about avoiding such cases from occurring
again in the future on kernelci.org, by making kernel error
detection more robust.  But that's not a kernel problem.

Please bear with us, hopefully this false positive should not
come back.  Thanks for your help with investigating the GIC
errors in the first place.

Guillaume

>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> mainline/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15
>>
>> Summary:
>>   Start:      7cc2a8ea1048 Merge tag 'block-5.8-2020-07-01' of git://git.kernel.dk/linux-block
>>   Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc3-37-g7cc2a8ea1048/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc1.txt
>>   HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc3-37-g7cc2a8ea1048/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc1.html
>>   Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into motherboard node
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
> 
> What does that mean? That reverting the patch made the test pass?
> I did exactly that, and reverting made it worse, because poweroff
> doesn't work (among other things).
> So could this be a testing artifact? Because of the failing poweroff the
> test timed out or something?
> 
> Many thanks,
> Andre
> 
>>
>> Parameters:
>>   Tree:       mainline
>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>   Branch:     master
>>   Target:     qemu_arm-vexpress-a15
>>   CPU arch:   arm
>>   Lab:        lab-cip
>>   Compiler:   gcc-8
>>   Config:     vexpress_defconfig
>>   Test case:  baseline.dmesg.crit
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit 38ac46002d1df5707566a73486452851341028d2
>> Author: Andre Przywara <andre.przywara@arm.com>
>> Date:   Wed Jun 3 17:22:37 2020 +0100
>>
>>     arm: dts: vexpress: Move mcc node back into motherboard node
>>     
>>     Commit d9258898ad49 ("arm64: dts: arm: vexpress: Move fixed devices
>>     out of bus node") moved the "mcc" DT node into the root node, because
>>     it does not have any children using "reg" properties, so does violate
>>     some dtc checks about "simple-bus" nodes.
>>     
>>     However this broke the vexpress config-bus code, which walks up the
>>     device tree to find the first node with an "arm,vexpress,site" property.
>>     This gave the wrong result (matching the root node instead of the
>>     motherboard node), so broke the clocks and some other devices for
>>     VExpress boards.
>>     
>>     Move the whole node back into its original position. This re-introduces
>>     the dtc warning, but is conceptually the right thing to do. The dtc
>>     warning seems to be overzealous here, there are discussions on fixing or
>>     relaxing this check instead.
>>     
>>     Link: https://lore.kernel.org/r/20200603162237.16319-1-andre.przywara@arm.com
>>     Fixes: d9258898ad49 ("arm64: dts: vexpress: Move fixed devices out of bus node")
>>     Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
>>     Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>     Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> index e6308fb76183..a88ee5294d35 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> @@ -100,79 +100,6 @@
>>  		};
>>  	};
>>  
>> -	mcc {
>> -		compatible = "arm,vexpress,config-bus";
>> -		arm,vexpress,config-bridge = <&v2m_sysreg>;
>> -
>> -		oscclk0 {
>> -			/* MCC static memory clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 0>;
>> -			freq-range = <25000000 60000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk0";
>> -		};
>> -
>> -		v2m_oscclk1: oscclk1 {
>> -			/* CLCD clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 1>;
>> -			freq-range = <23750000 65000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk1";
>> -		};
>> -
>> -		v2m_oscclk2: oscclk2 {
>> -			/* IO FPGA peripheral clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 2>;
>> -			freq-range = <24000000 24000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk2";
>> -		};
>> -
>> -		volt-vio {
>> -			/* Logic level voltage */
>> -			compatible = "arm,vexpress-volt";
>> -			arm,vexpress-sysreg,func = <2 0>;
>> -			regulator-name = "VIO";
>> -			regulator-always-on;
>> -			label = "VIO";
>> -		};
>> -
>> -		temp-mcc {
>> -			/* MCC internal operating temperature */
>> -			compatible = "arm,vexpress-temp";
>> -			arm,vexpress-sysreg,func = <4 0>;
>> -			label = "MCC";
>> -		};
>> -
>> -		reset {
>> -			compatible = "arm,vexpress-reset";
>> -			arm,vexpress-sysreg,func = <5 0>;
>> -		};
>> -
>> -		muxfpga {
>> -			compatible = "arm,vexpress-muxfpga";
>> -			arm,vexpress-sysreg,func = <7 0>;
>> -		};
>> -
>> -		shutdown {
>> -			compatible = "arm,vexpress-shutdown";
>> -			arm,vexpress-sysreg,func = <8 0>;
>> -		};
>> -
>> -		reboot {
>> -			compatible = "arm,vexpress-reboot";
>> -			arm,vexpress-sysreg,func = <9 0>;
>> -		};
>> -
>> -		dvimode {
>> -			compatible = "arm,vexpress-dvimode";
>> -			arm,vexpress-sysreg,func = <11 0>;
>> -		};
>> -	};
>> -
>>  	bus@8000000 {
>>  		motherboard-bus {
>>  			model = "V2M-P1";
>> @@ -435,6 +362,79 @@
>>  						};
>>  					};
>>  				};
>> +
>> +				mcc {
>> +					compatible = "arm,vexpress,config-bus";
>> +					arm,vexpress,config-bridge = <&v2m_sysreg>;
>> +
>> +					oscclk0 {
>> +						/* MCC static memory clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 0>;
>> +						freq-range = <25000000 60000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk0";
>> +					};
>> +
>> +					v2m_oscclk1: oscclk1 {
>> +						/* CLCD clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 1>;
>> +						freq-range = <23750000 65000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk1";
>> +					};
>> +
>> +					v2m_oscclk2: oscclk2 {
>> +						/* IO FPGA peripheral clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 2>;
>> +						freq-range = <24000000 24000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk2";
>> +					};
>> +
>> +					volt-vio {
>> +						/* Logic level voltage */
>> +						compatible = "arm,vexpress-volt";
>> +						arm,vexpress-sysreg,func = <2 0>;
>> +						regulator-name = "VIO";
>> +						regulator-always-on;
>> +						label = "VIO";
>> +					};
>> +
>> +					temp-mcc {
>> +						/* MCC internal operating temperature */
>> +						compatible = "arm,vexpress-temp";
>> +						arm,vexpress-sysreg,func = <4 0>;
>> +						label = "MCC";
>> +					};
>> +
>> +					reset {
>> +						compatible = "arm,vexpress-reset";
>> +						arm,vexpress-sysreg,func = <5 0>;
>> +					};
>> +
>> +					muxfpga {
>> +						compatible = "arm,vexpress-muxfpga";
>> +						arm,vexpress-sysreg,func = <7 0>;
>> +					};
>> +
>> +					shutdown {
>> +						compatible = "arm,vexpress-shutdown";
>> +						arm,vexpress-sysreg,func = <8 0>;
>> +					};
>> +
>> +					reboot {
>> +						compatible = "arm,vexpress-reboot";
>> +						arm,vexpress-sysreg,func = <9 0>;
>> +					};
>> +
>> +					dvimode {
>> +						compatible = "arm,vexpress-dvimode";
>> +						arm,vexpress-sysreg,func = <11 0>;
>> +					};
>> +				};
>>  			};
>>  		};
>>  	};
>> -------------------------------------------------------------------------------
>>
>>
>> Git bisection log:
>>
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [719fdd32921fb7e3208db8832d32ae1c2d68900f] afs: Fix storage of cell names
>> git bisect good 719fdd32921fb7e3208db8832d32ae1c2d68900f
>> # bad: [7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf] Merge tag 'block-5.8-2020-07-01' of git://git.kernel.dk/linux-block
>> git bisect bad 7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf
>> # bad: [e44b59cd758acdd413512d4597a1fabdadfe3abf] Merge tag 'arm-fixes-5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> git bisect bad e44b59cd758acdd413512d4597a1fabdadfe3abf
>> # good: [91a9a90d040e8b9ff63d48ea71468e0f4db764ff] Merge tag 'sched_urgent_for_5.8_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good 91a9a90d040e8b9ff63d48ea71468e0f4db764ff
>> # bad: [42d3f7e8da1bc55e3109f612c519c945f6587194] Merge tag 'imx-fixes-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
>> git bisect bad 42d3f7e8da1bc55e3109f612c519c945f6587194
>> # bad: [6d89c73ca5813768a2cc66f7420ac0cbddf4f37d] Merge tag 'arm-soc/for-5.8/soc-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
>> git bisect bad 6d89c73ca5813768a2cc66f7420ac0cbddf4f37d
>> # bad: [0f77ce26ebcf6ea384421d2dd47b924b83649692] Revert "ARM: sti: Implement dummy L2 cache's write_sec"
>> git bisect bad 0f77ce26ebcf6ea384421d2dd47b924b83649692
>> # bad: [d68ec1644dd546851d651787a638aead32a60a6f] Merge tag 'juno-fix-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
>> git bisect bad d68ec1644dd546851d651787a638aead32a60a6f
>> # bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
>> git bisect bad 38ac46002d1df5707566a73486452851341028d2
>> # first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
>> -------------------------------------------------------------------------------
>>
> 

