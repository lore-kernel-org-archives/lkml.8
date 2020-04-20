Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EBAC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032B020735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lMFob3fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDTLDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDTLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:03:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B28C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:03:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so10494318wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=RrxAUu1aJiYwPMpjnlo5gqgVd7ZtEZg5UXQs37AT2OA=;
        b=lMFob3fxLkovbZefAL5wA3odVFIm8ECwFR8ONBNSMabgh9EC7cc1FPL9ylGueS3l7N
         Oao6KqAJmY/5QX0pzOeisTWEPOvDMQG9B+35JR/KSFGBdoV4wZ6OzZWAOvk4hKkMtBWf
         eB8fnGfr2wuWqVXqAmHaYVPGDgRQhRb36FTMASiRw4Neeyms8nCwIKJXjP39wK+Drgus
         sj+0AHJc3GRtn9s+3aA/BEhBpM2xdpMJHCK8Cujl5ZRsEF29TNerD8+rCEQ7LjcNp9nL
         Ddaz7/UXcIR/+wloa0P4zUKSPYl/9Aokn5frOpGbBhU8qUCspjSMMjlUYgNHucJAxPGy
         Uxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=RrxAUu1aJiYwPMpjnlo5gqgVd7ZtEZg5UXQs37AT2OA=;
        b=D0qESVoz9qdUdu+TcZC0yBWzPtlCBa4kH73Kd5f74nt3HEN5RDRXGqw42EU4K6SnJh
         QMabxQ2jPeYv0FYFtcKtMxsXFJ6LacUoJy9I+ykz3/Letd5XQ+e4sowv8iHLIThvMnEq
         6xrh2LK91ip6eHAQFSh1GLovSRXeeYzBOxaK1dw3vDUi+SUWAj+Hfq8Pqyp2/BvsnYF3
         gZLrgzC7hr/o4iujnPqZPO3/g/Q89wEbKRbfmrXoTq0vVMNKvly/Am8j8AC0THUvdlD4
         0fvmDWY2rHTbqds3k9KIkVL7aleYypV5cSNJS4vvRgQus/SqP8BvMJGeVgiwMtNb2pq5
         W5Qg==
X-Gm-Message-State: AGi0PuatI5ZhsIHQHg35Rf5lilwdJq+sdR9gIO4NzYYUpicNd+Zts7VT
        rMzhuiihK1ZxKfhKwUQbgy3j4g==
X-Google-Smtp-Source: APiQypJtVrmYvXvt0ysu+IAoLgUFCE4HqPBjkqhR5RywtPrJXwK2VKvhMirSaf+WR3eKuCnr5dqesQ==
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr17776614wmh.118.1587380588962;
        Mon, 20 Apr 2020 04:03:08 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id m188sm859157wme.47.2020.04.20.04.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:03:08 -0700 (PDT)
References: <20200419053815.15731-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: meson: Simplify G12/SM1 Audio Configs
In-reply-to: <20200419053815.15731-1-christianshewitt@gmail.com>
Date:   Mon, 20 Apr 2020 13:03:07 +0200
Message-ID: <1jk12apggk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 19 Apr 2020 at 07:38, Christian Hewitt <christianshewitt@gmail.com> wrote:

> This series creates two new dtsi with the HDMI and HDMI+S/PDIF audio configs
> used in most G12/SM1 Android box devices and some SBC's and switches most dts
> to use them. I have not touched the SEI510/610 which have extra hardware
> in their dts, and the U200 which does not currently have audio support, but
> will likely receive an 'all possible routings' master config when Jerome
> sends his next set of changes (looking at his WIP branch) so I leave U200
> for him to address later.
>
> One advantaage of common configs is that distros that need to embed alsa
> conf files as part of their userspace support now only need to include two
> confs that will automatically support more boards and boxes as they are
> added, instead of needing to track and add confs or card aliases for every
> new device.
>
> Christian Hewitt (5):
>   arm64: dts: meson: create common hdmi/hdmi-spdif audio dtsi

I'm really not a fan of this. Yes the configuration appear to be similar
but there always the same. When they are, it is usually by lack of
knowledge of the platform and its use cases.

Using the same sound card model is particularily bad.

>   arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
>   arm64: dts: meson: convert odroid-n2 to hdmi dtsi
>   arm64: dts: meson: convert khadas-vim3/vim3l to hdmi dtsi

For example on the vim3, copying the sei610 was not the best choice
possible.

- SEI 610 prepares TDM B for 8 ch HDMI because TDM A is used for the
 internal speaker
- VIM3 has the TDM B on the 40 pin header and TDM C on the M2 port.
  It would be better to use TDM A for HDMI is this case (patch will
 follow)

This is just an example. Bottom, it designs are really copy/paste of the
ref design, the dtsi should include all the platform, not just the
sound.

>   arm64: dts: meson: convert x96max to hdmi dtsi
>
>  .../amlogic/meson-g12-audio-hdmi-spdif.dtsi   | 139 +++++
>  .../dts/amlogic/meson-g12-audio-hdmi.dtsi     |  96 ++++
>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 131 +----
>  .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  85 ---
>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  89 +--
>  .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 541 +-----------------
>  .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   1 +
>  8 files changed, 663 insertions(+), 842 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi

