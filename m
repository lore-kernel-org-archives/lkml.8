Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB42E2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/bNMMik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgEZLWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgEZLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:22:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F2C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:22:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so23951906ljm.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJxI8q9GaxwusSxiN1TRl1t50DLCSayUphT+bXOuVqA=;
        b=M/bNMMikN5rlMrwQqf4wuwwbofYB2P7B1TVibatvt8DV12qC0t3WfTLDIKYPPVaVAr
         A/f3VdlkZ0uoLoIgysMyIpfF1UG/ANS6qt1mUuG29T5Cl6mAeNoOyvzUKOdJJ8uA7giL
         qD7sfjXYbwg4iSJN5ZIRmUBWa2wlbl+Ugvxjeg5ss11qHAsmn25CwI7z6ncTNoh9NJiX
         0sxAbxzSMgfnDrVk5m4SNa5jHt3jgGyiccSWLvURNhA4j4SyZORWhck4vjMgfFGv2a5b
         rPWOMAmALGAVvuNt8rbuXWXGHACZGW4c1S+jz+mgm5NHSXQm2562P12Dnu85ptTxZS39
         9eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJxI8q9GaxwusSxiN1TRl1t50DLCSayUphT+bXOuVqA=;
        b=WYjn13LSYJR+zcl1eQquRDSHjL1LCRzt6JbxqQAPCOOk0lrGdGbGXr2CyFka323Y5X
         tXs4sc1jhKC6wwbSrh0WI50nmqGPGB8EUNqc7SRRUU8/EwRZs91LX8Yev91o+Pz6zRXF
         3B7xkBPxwgCFDgyDam0bm2dnbLKHeRnOJXnqxsByl0Iz7A+3KZdUmWuGLGOT239frtJA
         pnsusuS3Py4LvZ9R/9xn7uxj7ENWE9Bx+yGvNJKgxFfgQanY1pAf/+alnspkJEWZuQT8
         zy/RkaR9dmSCPYREgp31bjfnDjW3YXA7DOtdGoZNAB2tEXX5yYQkFZfYSuiOTS859WCH
         DN0w==
X-Gm-Message-State: AOAM530M9I0SZ+Sbzh9ooW4ZdRViIQ+ppKUexygWEaK7BExwr6kMksXz
        2LsSuKY3eLcfBprDaFC6j5W7ZKOycL4r8j68nKrpeQ==
X-Google-Smtp-Source: ABdhPJzdhwywLZUu1iioOyV4RjM5M1Epk+nZBmMIV652Jit18mFH9boEqTDc5xdPxLb/F7xuG/+hRyaxUu9GK3c0+oc=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr384158ljc.104.1590492148520;
 Tue, 26 May 2020 04:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200513212451.1919013-1-megous@megous.com> <20200513212451.1919013-3-megous@megous.com>
In-Reply-To: <20200513212451.1919013-3-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 13:22:17 +0200
Message-ID: <CACRpkdbb0Y32EG=tEx208eUh_CJndvnQGQvAnF_mG29Hd9-2Jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: panel: Add binding for Xingbangda
 XBD599 panel
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, May 13, 2020 at 11:24 PM Ondrej Jirman <megous@megous.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
> Sitronix ST7703 LCD controller.
>
> Add its device tree binding.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
