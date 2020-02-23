Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B3C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58BF214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="KBLgQTYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgBWJ5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:57:39 -0500
Received: from vps.xff.cz ([195.181.215.36]:41430 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWJ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582451857; bh=Hc3Q/e3isq42FZVZz5Pj1+rkdYA5T7YqVfZ3lSbKHwM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=KBLgQTYNtOdfr0C8KgWxzTcFc9H4LySTQ3Y2+AYmD1O0bUlSZ7CqOWG9Bnmy4p0aN
         UHCxvhQuuCvVN/Eathp3L8kX54EJBUF2WnR1EY0HTlyZJ/EEWGNPCbqE5N2n7BnzCf
         v4yNsINPB0peqyQ18CwD8sYkROsvuULDUSk5C2J0=
Date:   Sun, 23 Feb 2020 10:57:36 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH 2/4] ARM: dts: sun8i-a83t-tbs-a711: HM5065
 doesn't like such a high voltage
Message-ID: <20200223095736.5c3dr66734kv3ypg@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222223154.221632-1-megous@megous.com>
 <20200222223154.221632-3-megous@megous.com>
 <CAGb2v67uOXE7_28yn8Q2uo320vE1FsqL-ewG4p1nViim3q0xbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v67uOXE7_28yn8Q2uo320vE1FsqL-ewG4p1nViim3q0xbw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 23, 2020 at 11:39:17AM +0800, Chen-Yu Tsai wrote:
> On Sun, Feb 23, 2020 at 6:32 AM Ondrej Jirman <megous@megous.com> wrote:
> >
> > Lowering the voltage solves the quick image degradation over time
> > (minutes), that was probably caused by overheating.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Makes sense. A lot of camera sensors run their digital parts off 1.8V.
> This one is no different.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> The whole CSI stuff isn't enabled in the device tree yet though, and
> there are a lot of regulators with CSI in their names. Will this get
> worked on?

Yes, I'm preparing support for both cameras in this branch:

  https://megous.com/git/linux/log/?h=cam-5.6

Both already work quite well. I'm just sending some fixes early.

Both cameras work best at 1.8V for the digital part.

regards,
	o.

> ChenYu
> 
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > index ee5ce3556b2ad..ae1fd2ee3bcce 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > @@ -371,8 +371,8 @@ &reg_dldo2 {
> >  };
> >
> >  &reg_dldo3 {
> > -       regulator-min-microvolt = <2800000>;
> > -       regulator-max-microvolt = <2800000>;
> > +       regulator-min-microvolt = <1800000>;
> > +       regulator-max-microvolt = <1800000>;
> >         regulator-name = "vdd-csi";
> >  };
> >
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200222223154.221632-3-megous%40megous.com.
