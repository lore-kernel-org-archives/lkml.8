Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B892C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0492073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZ7miNZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgGAHvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGAHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:51:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE742C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:51:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so13018354lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA5bM+WCP+6+xrqHaHAfQZE4418oC7dBfKlNpFampf8=;
        b=ZZ7miNZVWKO46LJ8/TJl+yA0Ss4HFjwCQ1PS4s0VXxhfJW8E2Jda12hCRQW811RZAB
         rJ0G6F9L7j+s72JYwWteMsMWXhGguGPC6uKnDggH6FlBlnVMzjs4R+zzeBUCCH881MDm
         wSDDeUfbKti0XT7PZAM1hGGuTatJwiR+0N2CfoGeDTc/cWfiKbvR6xqwTihHm0PPBc1K
         32ca+MBKN3hCPSOozfWTmjbty1CRTMNtoGHNVGiiM55RomC+hUSpX2e1/qdf0809XS7b
         hcZLzAQpP7wZKj5F2vpZmvnbAlSdfyRrpeVLeC6RBZ00tG1Hviiw8oXq6WUv9vvARvzJ
         GMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA5bM+WCP+6+xrqHaHAfQZE4418oC7dBfKlNpFampf8=;
        b=KSDmN4JCx9L3gGBTiS2BVM2ohKv4NoHIgKifu++7IbKZTFPIf5Wxdycphf6M0uJHVm
         1l+ZbO4YEvAdCmg5TQKJLGsTs5xj3h4nxTsfeQRoQEuBlsVgkqX+PkHFyvEY4XDDDVpD
         z9lhiK/4VXSXJ6ELyv5gVlQlBxb60smUSmj6btVaKcUe4DuOBtmAmOfTk5C8itmJZDh+
         ryL5kWltovXzY1XyK+2uNjqYlsGUvkgPeH4ec3sKO6CBP/i/5NeoKxMNBw9q93OwOn4c
         UxJe5UZ2ZL+pwNCtsXvk/7OlibpzSopqgrAb+e+zRiI0QgtulXFRyIFeQHKhjFSZcr8+
         WtFw==
X-Gm-Message-State: AOAM532TjwkpARBrCvUbojRnPBVIYy1hlrYM4sfDaZH7xO7RHjmoqf28
        5Cn1CyZvaudyHIJZv5Njg+bFzsafbx3fNu+YATuolA==
X-Google-Smtp-Source: ABdhPJyrJFAzSG4TfNUteKjvVvXNEtpwXJyb/bxaFmIvpSRTkSG+0rgLXE3upuXl29SouGIj3HRAshWvgCk19SJwY8Q=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr3355246lfi.47.1593589880512;
 Wed, 01 Jul 2020 00:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-11-megous@megous.com>
In-Reply-To: <20200626005601.241022-11-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:51:09 +0200
Message-ID: <CACRpkdYHmZi+BCRs8xzCUqiCEK7RHynHWeptTtEzJ1WHToMRFg@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] drm/panel: st7703: Enter sleep after display off
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:56 AM Ondrej Jirman <megous@megous.com> wrote:

> The datasheet suggests to issue sleep in after display off
> as a part of the panel's shutdown sequence.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
