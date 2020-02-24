Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RHS_DOB autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64548C38BE1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7202084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="L3/tRvvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBXSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:33:03 -0500
Received: from vps.xff.cz ([195.181.215.36]:33236 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582569181; bh=9mqkV16PsZRdF8vb7JAmbDN3tZ6Pelbha30uweql6Dc=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=L3/tRvvN9VGe+SIY9zKlDypNgHtG9CvMG6/DnGGu/Pj5Xoykbk7JMbxD4PZ5Z6HGL
         uthPS2w4LoCkM8jw2Ec6jipbasGJ6RnXPbqAzUu1aYXv8/rQ4xhC+4TRf/dXAbngHM
         6Tc/o3+stmYbsNKoyrsPJmEvUHT1htQRM9Y00k+A=
Date:   Mon, 24 Feb 2020 19:33:00 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20200224183300.jnclticehmc7uevs@core.my.home>
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
 <20200224173940.huwpaqhrc5ngbmji@core.my.home>
 <25a5dfb2-93bb-90c3-8156-0cfbed1f9995@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25a5dfb2-93bb-90c3-8156-0cfbed1f9995@linaro.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:56:18PM +0100, Daniel Lezcano wrote:
> On 24/02/2020 18:39, Ondřej Jirman wrote:
> > On Mon, Feb 24, 2020 at 06:23:28PM +0100, megous hlavni wrote:
> > 
> > To be more clear, new temperatures are available from the thermal sensor driver
> > at the rate of 4 per second, which should be enough to do quick adjustments to
> > the thermal zone/cooling device even for quick temperature rises.
> > 
> > https://elixir.bootlin.com/linux/v5.6-rc3/source/drivers/thermal/sun8i_thermal.c#L442
> > 
> > There's no slow/fast period depending on whether the cooling is active.
> > It's always fast and no polling of the thermal sensor is needed.
> 
> Thanks for the clarification. All sensors have their specificity.
> 
> Does the sensor allow to create a threshold temperature where an
> interrupt fires when crossing the boundary? That would be interesting
> for performance and energy saving to disable the interrupts until
> 'cpu0_hot' is reached, no?

I think so. I don't think it would affect this binding though. It would still
require no polling, and thermal driver would probably just have to be updated
to get the relevant information about trip points from the thermal zone and
notify it of changes/trip point crossing.

I don't think it would affect performance or energy saving much though.
4 interrupts per second is barely noticeable, and there are much bigger
fish to fry, when it comes to power savings on A83T at this point.

thank you and regards,
	o.


> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
