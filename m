Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95943C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F501206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIwT+DkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgDZQTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDZQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:19:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43222C061A0F;
        Sun, 26 Apr 2020 09:19:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so21834446otk.12;
        Sun, 26 Apr 2020 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj77SUe5CaP0v/pGWWFayVD62/A8i5UvOJukuyc5CVo=;
        b=SIwT+DkVtRJGCGDj8udPoICtBFP7hrscvBQWiU0tS87Hi5Ub3I1cYpvxxILSYGE4mX
         MlfGSgGmoKDKR+oBhDomOElD2/kvt1RWQwS8rofoR3mG9BLTlgM1Zyb+Ud4o+KY6zy3Y
         LrWRcaznHY/gjdDzpHdFmNK2YPN/SnoAzv7eUtCZJbgVgYlIcjonkoh4AXWFMoKRaW+f
         edblil7K6KgdjdQXccDkJuWlnZr6A0Nbl2HRRU43++iafGWFdzM3iv2CUX3Nx/HF7p8W
         Tyi1v4Lw5TcsD8B2kMJeeuBpQePpEdWfHYh0muGgmhrqB7dtKAk8LOn0bnH9+eHzOPWD
         /qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj77SUe5CaP0v/pGWWFayVD62/A8i5UvOJukuyc5CVo=;
        b=c6CFeRWvP6i2LDnfXMrDrj+3Pen3nukJ/H69e4Ma1oey1389HQ83RUBPLHiMWSSNzO
         XkAw4XEnhsLuSminfDqsEa6LhX6vsOeTfB47RJYsAgvXGBXBMFhourB4H2GvSdr5MhLN
         vrbL5A4+4fELeputX76fpIXJiVyBGtxqkGupbxBShcUG5Ro+XuwWePiK6B25WXwhKfKo
         ISoIaPbSQhPsHqyQEBtQH2lAksMnXvCRHuHwITDV2zutEv8TyXUhig+kA1tL8cGuOcOb
         IlQb+qqYERGi6Udym3X/+yYPHi67jsuEY8U/UJcnyLkiJ2XSl9a0TXTGfITsAGqGvA7I
         aUhg==
X-Gm-Message-State: AGi0PuYUECRbuoBU8/IbBirbX3zHkvuSi82DZDx6QY3bzTCdthgMsg9b
        HWxexmrxa/KgfS4gazzngqMzGe1zgg8NpJeMc99SqILD
X-Google-Smtp-Source: APiQypJ5+V3+lSZEofKJqMAVpQSdTAk1rec+Esu8ZijtDxFh7g90i2TLV7E4NrCm5MZu1Oonan3gRu8weMxFg1oIXTo=
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr15145763otb.15.1587917945530;
 Sun, 26 Apr 2020 09:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200422233928.GA2816@imac> <8255d8b1-f652-9ece-67d2-68c30a5cfbac@baylibre.com>
In-Reply-To: <8255d8b1-f652-9ece-67d2-68c30a5cfbac@baylibre.com>
From:   Tim Lewis <elatllat@gmail.com>
Date:   Sun, 26 Apr 2020 12:18:54 -0400
Message-ID: <CA+3zgmsVK9Uuv947-pniByP7QJVGcVK_EgiRkFipV5CUx70sHQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: meson: S922X: extend cpu opp-points
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com,
        Christian Hewitt <christianshewitt@gmail.com>,
        joy.cho@hardkernel.com, tobetter <tobetter@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, will fix in v4.


On Thu, Apr 23, 2020 at 3:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 23/04/2020 01:39, Tim Lewis wrote:
> > HardKernel supports overclock through the addition to extra opp points
> > in their official kernel sources for odroid-n2 [1]. Christian tested
> > on other S922X devices with "no obvious issues". Neil thinks dvfs and
> > thermal managementis can keep other S922X devices safe.
> --------------/\
>           management
>
> >
> > [1] https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6bd5a2ad2f
> > Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> > Signed-off-by: Tim Lewis <elatllat@gmail.com>
> >
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi | 15 +++++++++++++++
> >  1 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> > index 046cc332d..1e5d0ee5d 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> > @@ -65,6 +65,11 @@
> >                       opp-hz = /bits/ 64 <1896000000>;
> >                       opp-microvolt = <981000>;
> >               };
> > +
> > +             opp-1992000000 {
> > +                     opp-hz = /bits/ 64 <1992000000>;
> > +                     opp-microvolt = <1001000>;
> > +             };
> >       };
> >
> >       cpub_opp_table_1: opp-table-1 {
> > @@ -120,5 +125,15 @@
> >                       opp-hz = /bits/ 64 <1704000000>;
> >                       opp-microvolt = <891000>;
> >               };
> > +
> > +             opp-1800000000 {
> > +                     opp-hz = /bits/ 64 <1800000000>;
> > +                     opp-microvolt = <981000>;
> > +             };
> > +
> > +             opp-1908000000 {
> > +                     opp-hz = /bits/ 64 <1908000000>;
> > +                     opp-microvolt = <1022000>;
> > +             };
> >       };
> >  };
> >
>
> The patch is well formed but I can only test on Odroid-N2.
>
> Anyway, Christian did a test other S922X boxes and it doesn't crash.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Neil
