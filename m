Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B392074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZrWU9av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFOWaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:30:11 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA37C061A0E;
        Mon, 15 Jun 2020 15:30:10 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id q10so4345731vka.4;
        Mon, 15 Jun 2020 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rpEvl9+AZzZHXUNhYOtOBN1Cia0euR/+OQQwMFjqbXo=;
        b=EZrWU9avSmTrOwBXllhDDMODBVzH65l8k5aNUhbaqaWoKi47mpiTGyycaJKbRHhiMk
         JjyGTxJ9j1gybEjiOi5FMcA67moDtX5wzTchiQcT4QMnOz2NRLTS2qNpdj1NyX0YFu2a
         c7421yxvBXpnB/5b4C9dcUMLia0gSZINQtSz9wvYFXMnhQy3+a/WT/HDbF6G0Dqnsbpd
         r8+/i1JEnSUpQjP/Mx7scH0soh3FYqcJ01A1gV+t799kpHAP62FsK3zMhXF4GIAVW7Rv
         uO1hfODdOQ8/lnT/wIWEa/P/OFjQItWwx0BKWAbSnTXZtRFUi1fhmZMr2ATB7cLDi4fO
         iMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpEvl9+AZzZHXUNhYOtOBN1Cia0euR/+OQQwMFjqbXo=;
        b=X/dvTpKo37cpiHYVzW+sgg7WfIv7ryjmnF4KP/29Q+SOi+tE9py/gFZIGONV0DYEtJ
         z3Me1wge6gW1rxJlxaZLm5YHo7fOS/wc3eO9mm1ghy0mvj5VFoRW77krloITJrws6bSr
         1dG5n5yb7njkE7ex1w9Awp20o5OqS3zjgyPkDZd9bOhZi1REgUQ3qO1NFGgb/h15jOK4
         ANCTzD3EqRqcRJHxqT98KIeIK+EMaKRV9kmn/wOLGa1Y4K1cVVSbaKSpygySPRWI2xrS
         Kwkgl8IW23uewb278KjXGv7e0/CaGCvsdsBYR8BbCzopl37mgUaD7ZbDQDSUba03dxEe
         GlcQ==
X-Gm-Message-State: AOAM5300QwqOAJ844a8PfwTj29rYxU/rzuHBxPUYaJLu/zN+TJnlsHOt
        l3z3Y1i/eBvpA3DBq/8R48rXLkAUV9Wz6gUV3wbf/w==
X-Google-Smtp-Source: ABdhPJwlZ736CSyVAz5cSN0v84AJqRxTSjDwcbeB0kNdNx5+26a5GPHmih8UIPJ4PlSyNQ7QirNClwKcrpKoDwxYJGo=
X-Received: by 2002:a1f:9445:: with SMTP id w66mr11075500vkd.22.1592260209977;
 Mon, 15 Jun 2020 15:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200614200121.14147-1-digetx@gmail.com>
In-Reply-To: <20200614200121.14147-1-digetx@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 23:26:29 +0100
Message-ID: <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Hello!
>
> This series adds 180=C2=B0 display plane rotation support to the NVIDIA T=
egra
> DRM driver which is needed for devices that have display panel physically
> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
> DRM panel rotation is a new thing for a userspace, currently only
> Opentegra Xorg driver handles the rotated display panel [2], but this
> is good enough for the start.
>
> Note that later on it should be possible to implement a transparent 180=
=C2=B0
> display rotation for Tegra DRM driver which will remove the need to have
> a bleeding edge userspace that knows how to rotate display planes and I'm
> slowly working on it. For the starter we can go with the minimal rotation
> support, so it's not a blocker.
>
> This series is based on the work that was made by Derek Basehore for the
> Mediatek driver [3], his patch is included into this patchset. I added
> my tested-by tag to the Derek's patch.
>
> Please review and apply, thanks in advance!
>
> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327=
.18589-3-digetx@gmail.com/
> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a39=
59bbe5bc3a3b67e55977093fd5114ca
> [3] https://lkml.org/lkml/2020/3/5/1119
>
> Changelog:
>
> v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
>       turned out to be obsolete now.
>
>     - Renamed the cover-latter, hopefully this will fix the bouncing emai=
ls.
>
> Derek Basehore (1):
>   drm/panel: Add helper for reading DT rotation
>
> Dmitry Osipenko (4):
>   drm/panel: lvds: Set up panel orientation

IMHO it's perfectly reasonable to report the panel orientation to
userspace, which can apply plane rotation as needed.

Although I see that this series, alike Derek's, has a couple of issues:
 - only a single panel driver is updated
 - rotation is _not_ listed as supported property, in said panel
driver device-tree bindings

My personal inclination is that we should aim for a comprehensive solution:
 - wire all panel drivers, as currently documented (quick grep list below)
 - document and wire-up the lvds and boe panels - as proposed by you
and Derek respectively

HTH
Emil

Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2
