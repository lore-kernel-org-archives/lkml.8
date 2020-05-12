Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC923C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF220740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leVp22z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgELWWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgELWWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:22:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779FC061A0C;
        Tue, 12 May 2020 15:22:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so12427983eju.1;
        Tue, 12 May 2020 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTu+/lBxphIeONkAftRaM2A0yWudXbGp7Sg8PNs0kb4=;
        b=leVp22z6ld7uf0tDfKHVk50y/PXGKlHpEZtbxOkL+78duApFIMAXzKwtAhBjmpA7Mu
         txCJtNt2Gsq53f2x7TV0u7f9iw1T87amQ956irizi0oJVQJWXDYw+KrZ6PtdpxvCJzwx
         m+N47dN/wFQOICvScfe8iEwNBChSLWTwws36fA4JyS5BaWJ06sWyxHKqNl5hBMq9/big
         mdRrSde0diGuSWpWkD/k3+gu07U76g4lH5Rx3UYKffPHwOigjSbNi9mnnOmM2WQnD9y0
         xR6bAt9bq1QHhaQhoCD2LZYBun+MSYnOZmsy3FR+Thfyar6WVmidgktZ8dj+7kViqEff
         4lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTu+/lBxphIeONkAftRaM2A0yWudXbGp7Sg8PNs0kb4=;
        b=Pl7DwcUmSb9jP8uUUDSpzmjHSXvrsPRp3lPM6ve8mLPR4KjMWiYzhOmIzcdu4wEYmh
         4fetob92I0HRIBRQXKzl1KIrA4s9Wmu//skOUrANieH4+7n+X86xG+xwtP6OJuI+N97J
         hLPbszs88kcH8p1qP0XcZv7UWZ9N/keSNjN1vM1F/P04MundHWssSoY3kH4v+0KpESXQ
         oSWIZ1X5sjSEel9NjQqO5EKNgbGSR4dpO3fH5KcWo2NfAJud5KnPRmxvROGSfohrZ4OM
         QaVy+kiuk3PvzrPvVkSWc8F65oLrIPbQKr2Vcd/Cmum2fTn+rE3gOEBh1q1WZro39u8Y
         Ng/A==
X-Gm-Message-State: AGi0PuYEII3BQLwJqPS4xf7/gsmPhIpJL4+a9szWEvIQVsOj3BKoIYjs
        1x3dz8Ele8gR8M6IiuzpIPzdH2Cg3xFOhRtw7lc=
X-Google-Smtp-Source: APiQypIWL4GQlg5RfOecFwcGgMdewtQ5eTurEO0trwTD9tGMYGTv8NhjXyDNYYacbSU7MM18V8xv5jpG33xjsUv+enU=
X-Received: by 2002:a17:906:86d6:: with SMTP id j22mr12731665ejy.1.1589322120790;
 Tue, 12 May 2020 15:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200502122126.188001-1-aford173@gmail.com> <20200502122126.188001-2-aford173@gmail.com>
 <20200512220537.GA14318@bogus>
In-Reply-To: <20200512220537.GA14318@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 12 May 2020 17:21:49 -0500
Message-ID: <CAHCN7xLtLPqZV7Qhs1zufzLES3LTh11yyAmOto7EwDQyDEvrVQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] clk: vc5: Enable addition output configurations of
 the Versaclock
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Charles Stevens <charles.stevens@logicpd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 5:05 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, May 02, 2020 at 07:21:25AM -0500, Adam Ford wrote:
> > The existing driver is expecting the Versaclock to be pre-programmed,
> > and only sets the output frequency.  Unfortunately, not all devices
> > are pre-programmed, and the Versaclock chip has more options beyond
> > just the frequency.
> >
> > This patch enables the following additional features:
> >
> >    - Programmable voltage: 1.8V, 2.5V, or 3.3V
> >    - Slew Percentage of normal: 85%, 90%, or 100%
> >    - Output Type: LVPECL, CMOS, HCSL, or LVDS
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
>
> > diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clk/versaclock.h
> > new file mode 100644
> > index 000000000000..c6a6a0946564
> > --- /dev/null
> > +++ b/include/dt-bindings/clk/versaclock.h
>
> Belongs in binding patch.

I can do that, but the binding patch will have to be applied before
the rest of the series, or the source won't build because it's
referencing the bindings.  Is that OK?

adam
>
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/* This file defines field values used by the versaclock 6 family
> > + * for defining output type
> > + */
> > +
> > +#define VC5_LVPECL   0
> > +#define VC5_CMOS     1
> > +#define VC5_HCSL33   2
> > +#define VC5_LVDS     3
> > +#define VC5_CMOS2    4
> > +#define VC5_CMOSD    5
> > +#define VC5_HCSL25   6
> > --
> > 2.25.1
> >
