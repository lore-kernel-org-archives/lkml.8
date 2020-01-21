Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445DC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE30C24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZW+7CkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAUSst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:48:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44485 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:48:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id w8so3471257qts.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gcjbt/f2IWl06GbS/u53lANqReBi2slHilk3OT8D7PQ=;
        b=jZW+7CkLrHEnzQEQRabNc7ECI23liTIsyvT7iRYK8lxCiDma7OFjrpsSR6sClkAbmC
         12LrjCGO/T13qtko/pkOdnPEE7UcKCU/8OCub2N0x6gBl2pPK2yyI0sdp/nY3f3Y0Smo
         1mhItqjj20ORVcfbMUl6k2J9NI3CbtSvP1kmuGZoMzhwiBHd5SjZDcEIL4g+um/R4+w+
         w0zLN/sdx7EG9vPmlPJFL8mcpCLMnYjHQ91FEnH1HfTvQqlfzYp+Iz3P1ggltPaafznw
         7MtSVDzQFcImBKkZ9OqrBzyQqwXX6Xej7ngm6dFqcyY0l9vsPF8LDjTR6qhGcq/AVDyE
         JdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gcjbt/f2IWl06GbS/u53lANqReBi2slHilk3OT8D7PQ=;
        b=BxoZWWLK2et00C2lH9oFdlcKehjVJOhqb7uc6R6FtkF/kGCXR2U1vn5g+tSKAt6wa1
         /HQhuYPEz7D/3Bs5Lqj8LjnosUDWjj0kx3PHSi6TnUt2HZ/1W1aIxjTpsJ6I8+xvmOjJ
         8outEQAWm7oc9XrgKfTvRiqzcsJkD2Tm2PsPdq8/NMeoKzcmnGw2KtDbONA90SqQhMaZ
         HMwizrZlMaKgc1YHDvAAK1ZH8h6S/E40lO8Kv4ZjXlzM7MrZUNhSHv+knLA0V91ug4xU
         RfRr6zool4fkArSrHZuYpD90hjha8U99sisPrghXhYB/3mAQLrVSQsCReJpUkQXH3dv+
         RejA==
X-Gm-Message-State: APjAAAU5MdHgqGHijETWwBIPR6Rl/yGikWS1zLRFDfDrBwIBti6+I6Sf
        hsKWuUIjWhmfvoBxt8QOnugFmCGRr6E81T4CcXw=
X-Google-Smtp-Source: APXvYqyWi/C1DQePOtb0Gxc6V7Ze34ZYUTXa7cphunXNt0w1icdGaKitimVOcgcZehrEAruCzz/mmNRFDTxM48RTWsk=
X-Received: by 2002:ac8:337c:: with SMTP id u57mr5873302qta.42.1579632527734;
 Tue, 21 Jan 2020 10:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20200119163104.13274-1-samuel@sholland.org> <20200119163104.13274-3-samuel@sholland.org>
 <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
In-Reply-To: <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 21 Jan 2020 10:49:37 -0800
Message-ID: <CA+E=qVcdza_E17_=r+0eZ2UexCYah35jt8=v+uFTLHx3+BvHSg@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused AXP803 regulators
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 1:05 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
> > The Pinebook does not use the CSI bus on the A64. In fact it does not
> > use GPIO port E for anything at all. Thus the following regulators are
> > not used and do not need voltages set:
> >
> >  - ALDO1: Connected to VCC-PE only
> >  - DLDO3: Not connected
> >  - ELDO3: Not connected
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > index ff32ca1a495e..8e7ce6ad28dd 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > @@ -202,9 +202,7 @@
> >  };
> >
> >  &reg_aldo1 {
> > -     regulator-min-microvolt = <2800000>;
> > -     regulator-max-microvolt = <2800000>;
> > -     regulator-name = "vcc-csi";
> > +     regulator-name = "vcc-pe";
> >  };
>
> If it's connected to PE, I'd expect the voltage to be at 3.3v?

Commit message says that PE is not used, so we don't need to set it at all.

> Maxime
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
