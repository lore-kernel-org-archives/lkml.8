Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RHS_DOB autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB6FC11D34
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DED21556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="FoSjuyUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgBXRjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:44 -0500
Received: from vps.xff.cz ([195.181.215.36]:60558 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXRjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582565980; bh=bssBG1gkye/nYahI0KI7q69HyEXw05nP1PGKKo8PTDc=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=FoSjuyUEQg2Zi08JDwJhfQKkeU+UWADJZHnAIBU7RY8JU1qByM7iZvFuW4x2nwBhW
         LQFABB99Nv08xlfT9LxVBgzfhtmJdwqdWhQL/3tmhYi4PipX5/Iz3/KcHZUkzBtI1T
         2QNNcU+zW2sm3ErVaf8txlY3VNGztiHLu/jjvP6E=
Date:   Mon, 24 Feb 2020 18:39:40 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
Message-ID: <20200224173940.huwpaqhrc5ngbmji@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200224165417.334617-1-megous@megous.com>
 <2e4213a6-2aaf-641c-f741-9503f3ffd5fe@linaro.org>
 <20200224172328.yauwfgov664ayrd6@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224172328.yauwfgov664ayrd6@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:23:28PM +0100, megous hlavni wrote:
> Hi, 
> 
> On Mon, Feb 24, 2020 at 06:06:20PM +0100, Daniel Lezcano wrote:
> > On 24/02/2020 17:54, Ondrej Jirman wrote:
> > > This enables passive cooling by down-regulating CPU voltage
> > >  			clocks = <&ccu CLK_C1CPUX>;
> > > @@ -1188,12 +1188,60 @@ cpu0_thermal: cpu0-thermal {
> > >  			polling-delay-passive = <0>;
> > >  			polling-delay = <0>;
> > >  			thermal-sensors = <&ths 0>;
> > > +
> > > +			trips {
> > > +				cpu0_hot: cpu-hot {
> > > +					temperature = <80000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > > +				};
> > > +
> > > +				cpu0_very_hot: cpu-very-hot {
> > > +					temperature = <100000>;
> > > +					hysteresis = <0>;
> > > +					type = "critical";
> > > +				};
> > > +			};
> > > +
> > > +			cooling-maps {
> > > +				cpu-hot-limit {
> > > +					trip = <&cpu0_hot>;
> > > +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +				};
> > > +			};
> > >  		};
> > >  
> > >  		cpu1_thermal: cpu1-thermal {
> > >  			polling-delay-passive = <0>;
> > 
> > No polling to mitigate?
> 
> Polling to mitigate what?
> 
> The driver is using interrupts whenever new reading is available, and
> notifies tz of the change. I don't have a reason to believe any new
> values are available from thermal sensor outside of the interrupt
> period.

To be more clear, new temperatures are available from the thermal sensor driver
at the rate of 4 per second, which should be enough to do quick adjustments to
the thermal zone/cooling device even for quick temperature rises.

https://elixir.bootlin.com/linux/v5.6-rc3/source/drivers/thermal/sun8i_thermal.c#L442

There's no slow/fast period depending on whether the cooling is active.
It's always fast and no polling of the thermal sensor is needed.

regards,
	o.

> > >  			polling-delay = <0>;
> > >  			thermal-sensors = <&ths 1>;
> > > +
> > > +			trips {
> > > +				cpu1_hot: cpu-hot {
> > > +					temperature = <80000>;
> > > +					hysteresis = <2000>;
> > > +					type = "passive";
> > 
> > I'm curious, can you really reach this temperature with a cortex-a7
> > running at 1.2GHz max?
> 
> That depends on ambient temperature. I'd say easily. My A83T is running
> iniside enclosed space with no cooling other than dissipating heat to
> the board.
> 
> Anyway, I'm running my A83T boards at 1.8GHz. And A83T can run up to 2GHz
> at the best SoC bin.
> 
> I'll probably submit updated cpufreq table at some point too, once I fix
> it up to use the SoC bin information.
> 
> https://megous.com/git/linux/commit/?h=ths-5.6&id=171b7c3c3db98b5939d28d0c96b384edda95cec3
> 
> regards,
> 	o.
> 
> > > +				};
> > > +
> > > +				cpu1_very_hot: cpu-very-hot {
> > > +					temperature = <100000>;
> > > +					hysteresis = <0>;
> > > +					type = "critical";
> > > +				};
> > > +			};
> > > +
> > > +			cooling-maps {
> > > +				cpu-hot-limit {
> > > +					trip = <&cpu1_hot>;
> > > +					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +				};
> > > +			};
> > >  		};
> > >  
> > >  		gpu_thermal: gpu-thermal {
> > > 
> > 
> > 
> > -- 
> >  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> > 
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> > 
