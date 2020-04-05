Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F5C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F96020719
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="TIzjQu4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDELvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:51:41 -0400
Received: from vps.xff.cz ([195.181.215.36]:37732 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDELvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1586087498; bh=NNWPYQmKXiUs070rAcv05Neys9flJOHGWA3PVq5buKk=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=TIzjQu4Ta7udL+i4zYgBcZYi7l/NQ0qQ4myiGz3hM1O6UU7MbzPLt7FatSSdJPiGs
         IGsydDYXAlgZz2pu8uHJLRT9mL4xXBrDzDIOltqhpCkZJoaIoap7bU209SMa0DJMvP
         PBuGJwwbgJU//n3AJVKnNEIOQ2RnpsdmSXWV6Vc4=
Date:   Sun, 5 Apr 2020 13:51:38 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200405115138.vrrvv7spnv6ifm6x@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clément,

On Sun, Apr 05, 2020 at 12:49:06PM +0200, Clément Péron wrote:
> Hi Sunxi maintainers and members,
> 
> Now that required drivers are merged we can contibute on DVFS support for
> Allwinner H6.
> 
> This serie is based on Yangtao Li serie[0] and Megous works[1].
> 
> Most of the OPP tables are taken from original vendor kernel[2].
> Plus there is a new CPU frequency @1.8GHz.
> 
> I wrote a simple script to randomly set a frequency during a random time[3].
> With this script and using stress-ng during a day I didn't see any issue.
> Moreover I have tested specifically the 1.8GHz on my Beelink GS1, max thermal
> 80°C is reached after ~10min and then the SoC oscillates quickly between 1.5
> and 1.8GHz.

Thank you for working on this. :) I wonder what SoC bin you tested this on.

I have a patch to print it here:

  https://megous.com/git/linux/commit/?h=ths-5.7&id=c5ddd2a45c7e04dcec31619b58de7c798ad6594c

> I also test that that offlining CPU0 and doing DVFS on other CPUs works.
> As CPU regulator is only set for CPU0.
> 
> But maybe it doesn't cost much to set the regulator for all the CPUs?
> 
> Jernej test the GPU devfreq on several H6 board particulary the Tanix TX6 which
> doesn't have a proper dedicated PMIC and doesn't had any trouble with it.
> 
> Do you think I can enable GPU OPP for all H6 Boards?
> 
> Also Yangtao Li enable DVFS for OrangePi and Pine64, as I can't test them I
> didn't reenable these boards. Please, let me know if you want me to add these
> boards in this serie.

Feel free to add these OPPs also to OrangePi 3 dts, I've been running mine with
this OPP table for at least a year already (I have the worst SoC bin).

Though I'll run a bit more comprehensive test for more frequencies, like you
did, just to be sure.

One thing I wonder about is if there should not be some small ramp delay on the
CPU regulator node, because voltage change probably takes some small time to
apply, compared to changing the PLL frequency. And I have no idea if the CPU
is not running for some very small time out of spec during transitions.

I didn't find timing information in the PMIC datasheet, but I suppose based
on the DCDCA frequency of 3MHz that it will adapt to the new voltage in the
range of 1s-10s of microseconds.

In datasheet of the similar PMIC (AXP813) there is this note:

  DVM (Dynamic Voltage scaling Management) ramp rate: 2.5mV/us at buck frequency 3MHz

I think it will be simiar with AXP805.

regards,
	o.

> Thanks,
> Clément
> 
> 0: https://patchwork.kernel.org/cover/10815117/
> 1: https://megous.com/git/linux/log/?h=ths-5.7
> 2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
> 3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e2
> 
> Clément Péron (4):
>   arm64: dts: allwinner: h6: set thermal polling time
>   arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
>   arm64: configs: Enable sun50i cpufreq nvmem
>   arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink
>     GS1
> 
> Ondrej Jirman (2):
>   arm64: dts: allwinner: h6: Add thermal trip points/cooling map
>   arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
> 
> Yangtao Li (1):
>   arm64: dts: allwinner: h6: Add clock to CPU cores
> 
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  10 +-
>  .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 103 ++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi |  74 +++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  44 +++++++-
>  arch/arm64/configs/defconfig                  |   1 +
>  5 files changed, 226 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> 
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200405104913.22806-1-peron.clem%40gmail.com.
