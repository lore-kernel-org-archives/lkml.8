Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CDBC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016F92080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZHkV8yt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgGUIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgGUIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:39:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE246C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:39:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so1943597wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=kffYnJ6AlClklIV94Jnp3wm8cFF3FK2tqJd8e6ndHNA=;
        b=ZHkV8yt3OL5rcS+aqUvhiyM3XF59GBemXA6DwSKA9Wz9bQWUDFlSA/bnjwvE3caBHh
         VZdYeJShAe3TpNjjzybE7oF9oWz1nnYYL/Uz4PEWeEEnzXKisbkZHegFPN0wQBmJ/O3M
         dJx3a+mpMwXZBlrkXt8SdYXmpS4qVwAsf/EwKrxfn+/CTgDV8xDOc2tTNFqE2yT4EjOj
         9T60xEnQC1RnOtV24/SPfaKxK2kfluHHTpcZwQYl8wimTcuXmVe9ct9ZFz20G/rV2/N7
         A4qr+ecDGnGBuDqVfRAHKYXSlmZ6LdpDaxylhOCnchElF6NQjwqC+vimBJqK5K3jXf2x
         T2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kffYnJ6AlClklIV94Jnp3wm8cFF3FK2tqJd8e6ndHNA=;
        b=sYJuYhjjsJoUcdHYhOAQ5cIVCJaAFZseAC7HqyfVe8k3VHKv5be4xIhQE0QDU7sqvI
         XR1+IqcrAsI3I17SCod0K7TKauFCGbD4aAo8gkTIxAcwap6DXUlUlaofEvKKQqf5fo/b
         SGIyCCVLt0SZkaoU9EEhQAKWFf1rjue8i+nL6dlUYUxMx8dVVPRm7TWfNrTbjwOI9gLv
         wWlzMPHdBifI80FtvDUBbGePumY7HxZ2Bb2FUuHeGrU57jlscCINlXGsmYtzUbFAMoa7
         crLcYFPdvgbfRF54GmxxfBlHDnQiJ2cdnLtsQEB2U5P0gkNcd8mRdkQgvE08t/xmwBKq
         BmIQ==
X-Gm-Message-State: AOAM532TvVN5Rak16PXId59GSS0s0ULpAnwGMZeOnGyU0xRp70uJTOmQ
        xubApWl/9A3X12eJAC0m34licA==
X-Google-Smtp-Source: ABdhPJytIMh8MKWLIeaObf5rXO9B9D9co4BaPFgQ7wK5k0hBGSGiAuNpeRqCul3V5nGfvsvi2ap9Rg==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr2537003wmf.132.1595320796488;
        Tue, 21 Jul 2020 01:39:56 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u20sm2478974wmm.15.2020.07.21.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:39:55 -0700 (PDT)
References: <20200718065739.7802-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] arm64: dts: meson: add more GX soundcards
In-reply-to: <20200718065739.7802-1-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:39:55 +0200
Message-ID: <1jtuy18dno.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 08:57, Christian Hewitt <christianshewitt@gmail.com> wrote:

> From: chewitt <christianshewitt@gmail.com>
>
> This series adds basic support for LPCM audio over HDMI and S/PDIF
> interfaces to GXBB/GXL/GXM devices without support. I'm sure audio
> support can be extended in places (some devices have internal DACs
> and headphone hardware) but this gets the HDMI port working as a
> minimum capability.
>
> I have personally tested with the khadas-vim2, odroid-c2, and both
> wetek devices as I have them, and there are positive forum reports
> from users with vega-s95 and some no-name P20X box devices.

I'm under the impression that not *all* the boards below have tested
against these changes, on both output when applicable. I'm a bit
concerned by that. For the boards you don't have, it would be nice if
you could add a Tested-by Tag.

Tiny things, yet critical, such as regulators and pinctrl, may change.
People looking at our DT should be able to expect that things have been
tested and confirmed working at least once.

Apart from the comment regarding the regulators, the changes seems OK.

>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>
> Christian Hewitt (12):
>   arm64: dts: meson: add audio playback to a95x
>   arm64: dts: meson: add audio playback to khadas-vim2
>   arm64: dts: meson: add audio playback to nanopi-k2
>   arm64: dts: meson: add audio playback to nexbox-a1
>   arm64: dts: meson: add audio playback to odroid-c2
>   arm64: dts: meson: add audio playback to p201
>   arm64: dts: meson: add audio playback to p200
>   arm64: dts: meson: add audio playback to p212-s905x dtsi
>   arm64: dts: meson: add audio playback to rbox-pro
>   arm64: dts: meson: add audio playback to vega-s95 dtsi
>   arm64: dts: meson: add audio playback to wetek-hub
>   arm64: dts: meson: add audio playback to wetek-play2
>
>  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++
>  .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++
>  .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 ++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 ++++++++++
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 ++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++
>  .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 ++++++++++++++
>  .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 ++++++++++
>  .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++-
>  .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 80 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   | 80 +++++++++++++++++++
>  12 files changed, 624 insertions(+), 3 deletions(-)

