Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8BC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC9208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="QZnsVYfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBWKKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:10:52 -0500
Received: from vps.xff.cz ([195.181.215.36]:41576 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582452650; bh=qHK7thdvdqT9t4EBxhrZdrfCjokfExVrtqLGFwi71Nk=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=QZnsVYfhoZudqeACNggVIuz1GgSeMuF7BQFqwhDGY3UDRBtKEdaAgDhgEDk+S/6EL
         KyQ+Ei1uRjoxnZQNWDJmEjv4+5r0MI6L2njKIKYTp/1UwU3YtPLjBp2PiZFVJAsBnY
         ygFXrtnOGH11lEmUU1yDBwLgAUJmMHzW+Pa1XfS8=
Date:   Sun, 23 Feb 2020 11:10:50 +0100
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
Subject: Re: [PATCH] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
Message-ID: <20200223101050.lqe5uegpmoyqvna6@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222214039.209426-1-megous@megous.com>
 <CAGb2v647zKVrDvnHeLvwNPEZLX+yTgPq-x7MJkp9=duzkQN3mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v647zKVrDvnHeLvwNPEZLX+yTgPq-x7MJkp9=duzkQN3mw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 23, 2020 at 11:29:07AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, Feb 23, 2020 at 5:40 AM Ondrej Jirman <megous@megous.com> wrote:
> >
> > This enables passive cooling by down-regulating CPU voltage
> > and frequency.
> 
> Please state for the record how the trip points were derived. Were they from
> the BSP? Or the user manual?

The values are taken from the BSP for A83T:

https://megous.com/git/linux/tree/drivers/thermal/sunxi-temperature.c?h=a83t-3.4-bsp-tbs-a711#n747

The datasheet only mentions recommended Ta (ambient operating temperature) range
-20 to +70°C. So die voltages will be larger than that. I guess that roughly
matches the BSP values.

regards,
	o.

> ChenYu
