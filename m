Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D9C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736C9208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBnyG7PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDWHfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:35:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19AC03C1AB;
        Thu, 23 Apr 2020 00:35:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so4604357ilp.13;
        Thu, 23 Apr 2020 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hlTl/zCZbAA+GFl2dvVEJ1v8GPDc+Kbabyo2qL/7PY=;
        b=OBnyG7PTHDCCLUE4ws+cv0rx52XPBDkBrMCNyEZfc9kAQVk3+4lTcKI7hbJtv25yej
         fv4TX/B2zr1x45m1SG5oNY6N7HrCNdF1AVTdschZ5mWmwdvgXbyANO8zmDpCTrg1sM1Q
         8IYYK06n8wgXSzYkkzIKxf1tQY9QDb9UNOu/xrSg6wswcih34vgfVq2d3TKja0szHgmb
         4VZeWTbVGmIfUiagSYTLqT562mhG/GXzAh71Adh4VxD+TGpq66SAVVeTN0ifPV42dIDC
         pz0AcXv+7QFMoWVwrfNwlUlVFJxPfd6kqVJCsrf3dpnxtgmFwiNyRCHN8FYtYXFJbZpK
         ygWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hlTl/zCZbAA+GFl2dvVEJ1v8GPDc+Kbabyo2qL/7PY=;
        b=CwUWT95ZKMyoqi/KhyQVSj/zjZts7aEnlnFXSFWu/ZIlB7Ns9c6ZdSXdm6U7MzTuKU
         bfcDPBGt6JkOSCmirotVIV1EBxfAKViul/b6/nRT9znroQRhFod18FijyYmF3lJkSOHW
         3oLlb8aiU5HI/WwiobJMDgRmI5fWHLdDo2KHckK7f11CfKcyR5l1JCqLbp8WmsAgzjc7
         9qNNNRpTd8nv2ksXT9uVy94kqxuJ5DnSBXkm8cDXU5Sx40Dlx6bgC+PhqwbrMt2dU/tu
         0j5GVnkeIjrjSN1eernLABKoHuAla8rAL5vEgKYg0AsmIE/KalcFvK02rPAVNFO/iM6p
         uMQQ==
X-Gm-Message-State: AGi0Pub3FqE8sj85JewDEd50ow8jVsNuSSQPOi5n5NFeypSOYXa/nTyD
        T8BOG+mCWVS3LbSmWv/LSqqKuv34Kh3/cn7Iu+kuULb8Xp0=
X-Google-Smtp-Source: APiQypKXWH4EZsa3e+ik+tfviGjD3zqic9BgcJWx+N0WLN2FGGHy7WvCtX5MXcR6RsFDgYNqLahTpflaJeSW9U3t+TA=
X-Received: by 2002:a92:d443:: with SMTP id r3mr2212189ilm.293.1587627327911;
 Thu, 23 Apr 2020 00:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200422041502.7497-1-samuel@sholland.org> <20200422151616.httmhmo2tbd4m4eu@gilmour.lan>
 <b554ea70-16da-1637-d349-db51dddcf95b@sholland.org>
In-Reply-To: <b554ea70-16da-1637-d349-db51dddcf95b@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 23 Apr 2020 09:35:16 +0200
Message-ID: <CAJiuCcfxokJr3Tj9XY8AT8O2y68RpuO+O3QZRvfCjVbu6s9aUw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] arm64: dts: allwinner: a64: Disable
 SPDIF by default
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel, Maxime,

On Thu, 23 Apr 2020 at 01:50, Samuel Holland <samuel@sholland.org> wrote:
>
> Maxime,
>
> On 4/22/20 10:16 AM, Maxime Ripard wrote:
> > On Tue, Apr 21, 2020 at 11:15:02PM -0500, Samuel Holland wrote:
> >> As of v5.7-rc2, Linux now prints the following message at boot:
> >>
> >>   [   33.848525] platform sound_spdif: deferred probe pending
> >>
> >> This is because &sound_spdif is waiting on its DAI link component
> >> &spdif to probe, but &spdif is disabled in the DTS. Disable the
> >> audio card as well to match.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >
> > The patch looks good, but don't we have some boards with SPDIF enabled that
> > should be modified accordingly?
>
> I don't see any in-tree. The only A64 DTS that references &spdif at all is
> sun50i-a64-pine64.dts, which explicitly disables it:

This has been introduced by Marcus Cooper for the Pine64 audio extension.
https://store.pine64.org/?product=pine64-stereo-audio-dac-pot-board

So this should be moved to an overlay no?

Regards,
Clement

>
>         /* On Euler connector */
>         &spdif {
>                 status = "disabled";
>         };
>
> I'm leaning toward agreeing with Clement that the sound_spdif node (and also
> spdif_out) should be removed altogether from the A64 DTSI.
>
> Regards,
> Samuel
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/b554ea70-16da-1637-d349-db51dddcf95b%40sholland.org.
