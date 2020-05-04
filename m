Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCFC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A425B20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaJNJgNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEDTeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:34:30 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E12C061A0E;
        Mon,  4 May 2020 12:34:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so9393326iog.13;
        Mon, 04 May 2020 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VLedveHRjOWzxQFafIfJM9vIF9bwIvP2E6cViDidxC0=;
        b=vaJNJgNcxrb1V5Ckol5RMcTftci6iMEwDqjBnwg7I9WEAjRh9OiwFGM1XEAF9FFeFB
         TwTgyft86VFfbUnMYpmPxCfITWODOtjcvxiVdLsdtn/V7Mgb7iHrEOYEHNWkBobsIRJM
         cJpt09Z/GjDpK/iBDC14QsKMe8Y+bOfQmMKDsDe8XofsTdqihOsSRFZwhocx7VgajxY9
         ZAB+ToZsSEVpJzV3lGVsUNRfmktcvgncHQEbmz0Swp3YKoMOByPG8I205KNBzv1Eors6
         PHCPbMmVEUQ0gRcaClkxLC9inREdEBwepLrV9LmsSAHZAZ3O7OW/A8Kt1/bz1TB0Di9c
         JXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=VLedveHRjOWzxQFafIfJM9vIF9bwIvP2E6cViDidxC0=;
        b=qIrMv+SxgBsjfSjmB/AfXyRgeB/c8vvzjuBzBq0yaQuot5NHMleiPKPUxGzfb6LyXz
         GxM5aogsca2Dsq+XpvbZ5souMbiUIssTfcDDLPmMM4I0638nHH24g9lHr5s57Y7QY7Cp
         iiTURBxOKql3mIRtEB8ZOxSSSLXaeRbgFeWeOmXWfSe2Cy5IBq7wU/Vq5YPvnEPOgZfX
         /2+/NDPfSRykMAAMLJDvX4GHi/WW4tgNP2Vzvrf2atl7+bl87Eb3Nf0NN4a4CDps7+x0
         0MmhZq/BfsH2SbjQoYL4t9N6MMtihuJTnXTsv8QToHy/JBVdU9rtoTrq40TgdwpehNkE
         3Evg==
X-Gm-Message-State: AGi0PuaFZQ3zLV5V5QAXzKJEYgzNBj/Z8oqGWEMCN3fLssz/GwGKwe9A
        57lD74GcnpY6HwFv95BoFqbsr/YTOTaS/QQkXiLGDdHn
X-Google-Smtp-Source: APiQypK9Olv8kCXFxHfdydxi6Zo3gzKdeDYOEOWdBFjLcGrNydDzLvq6rm7R+os2X1oVOh/CZoO1TcZcz7TI7xUtcgY=
X-Received: by 2002:a02:a004:: with SMTP id a4mr34524jah.18.1588620869486;
 Mon, 04 May 2020 12:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200428142629.8950-1-peron.clem@gmail.com> <20200504122742.er2jd67bvrn2rfgp@core.my.home>
In-Reply-To: <20200504122742.er2jd67bvrn2rfgp@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 May 2020 21:34:17 +0200
Message-ID: <CAJiuCcdSmgp75ByEDDtH0AtqGsUyc9QrAcD9xqLZduh2ijnrqQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] arm64: dts: allwinner: h6: Use dummy
 regulator for Tanix TX6
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On Mon, 4 May 2020 at 14:27, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hi Cl=C3=A9ment,
>

<snip>

>
> So I guess ignoring the voltage and not disabling this OPP may or may not=
 work
> based on SoC bin.
>
> On Orange Pi One, there's a regulator that supports two voltages (that ca=
n't
> support all the listed OPPs for H3), and cpufreq-dt can deal with that
> automagically, if you specify OPP voltages via a tripplet of [prefered mi=
n max].
> Kernell will log this in dmesg on boot:
>
> [    0.672440] core: _opp_supported_by_regulators: OPP minuV: 1320000 max=
uV: 1320000, not supported by regulator
> [    0.672454] cpu cpu0: _opp_add: OPP not supported by regulators (11040=
00000)
> [    0.672523] core: _opp_supported_by_regulators: OPP minuV: 1320000 max=
uV: 1320000, not supported by regulator
> [    0.672530] cpu cpu0: _opp_add: OPP not supported by regulators (12000=
00000)
> [    0.672621] core: _opp_supported_by_regulators: OPP minuV: 1340000 max=
uV: 1340000, not supported by regulator
> [    0.672628] cpu cpu0: _opp_add: OPP not supported by regulators (12960=
00000)
> [    0.672712] core: _opp_supported_by_regulators: OPP minuV: 1400000 max=
uV: 1400000, not supported by regulator
> [    0.672719] cpu cpu0: _opp_add: OPP not supported by regulators (13680=
00000)
>
> And the list of available OPPs will be reduced at runtime to a supportabl=
e
> set by the CPU regulator.
>
> If you look at:
>
>   https://megous.com/git/linux/commit/?h=3Dths-5.7&id=3Dd231770195913cf54=
3c0cf9539deee2ecec06680
>
> you'll see a bunch of OPPs for H3 that are specified as a range. So
> for example if you want 480MHz, and your regulator can't produce
> 1.04V exactly, cpufreq will set the voltage to something supportable
> in the range.
>
> I think the proper fix is to fix the OPP table for H6, so that it uses
> voltage ranges for each OPP and not a single fixed voltage, to support
> boards that don't have the standard PMIC that goes with H6.

Thanks for the suggestion and I agree with you, this is a good way to
keep the same OPP table for all the H6 devices and handle both board
with PMIC and with fixed regulator.

I will propose a patch.

Thanks clement

>
> regards,
>         o.
