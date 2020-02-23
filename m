Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EDCC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1F2208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="EUkfKzys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:16:49 -0500
Received: from vps.xff.cz ([195.181.215.36]:41622 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582453007; bh=z9sC5wOeZ8k/vAYXkg0uXqw7iHlxu3PkoDa1zkNANqo=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=EUkfKzysbsZv/G2CQHBgmg57Mjo5pY2Tv1ICSiqbr8bgTmRbvOiwKlrH0dI4iCKH6
         f2sR6XefKn/pzCE9nQQooHrTywRSCrda5EPehSjYOPf72B8p0pFhcn/2XOu6YgLyb4
         +u7CCVPdFCmvzZ6giMTnggkNR5+KOfBuY8uuyhII=
Date:   Sun, 23 Feb 2020 11:16:47 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Add thermal trip points/cooling maps
Message-ID: <20200223101647.wqhya3uqvgmsvj32@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222214224.209860-1-megous@megous.com>
 <CAGb2v671FS+k07xWRbr1+3XWNKAsVx2AaWKOrDfyYpt2Lf-gtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v671FS+k07xWRbr1+3XWNKAsVx2AaWKOrDfyYpt2Lf-gtg@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 23, 2020 at 11:29:31AM +0800, Chen-Yu Tsai wrote:
> On Sun, Feb 23, 2020 at 5:42 AM Ondrej Jirman <megous@megous.com> wrote:
> >
> > This enables passive cooling by down-regulating CPU voltage
> > and frequency.
> 
> 
> Please state for the record how the trip points were derived. Were they from
> the BSP? Or the user manual?

I used a slightly lowered value from the BSP code. 110 seemed like a lot for
the critical temp. So I rounded it off to 100°C.

https://megous.com/git/linux/tree/drivers/thermal/sunxi-temperature.c?h=a83t-3.4-bsp-tbs-a711#n1139

H3 lists the same recommended ambient temperature range as A83T. -20 to 70 °C.

regards,
	o.

> ChenYu
> 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
