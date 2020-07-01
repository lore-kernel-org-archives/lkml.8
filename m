Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36444C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A9206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3vWfnzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgGAHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgGAHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:50:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF8DC03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:50:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so900448ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BK6LxcRRscqsnEluIPMx3er/wRY4fpMutYOWykUjzz8=;
        b=s3vWfnzqTWTwOUb5oa/2WEKziwyZzj5P21ho4P1IyINRBBNYpb5sRzdLP2skObVtce
         ivbDf8XMoC+QAkjxEBT0WtQ58ZuKaw27t7XvTi3rW25VVJJH/FwRc0EY3368hJixCYaM
         Z8Q9IK68mxFCDPiSXtl3aCA9E0tZhB6n3euJ65+MJM1jldE+RnVoGvM6SfzV188kugqu
         BGknh6a3NCrCbH0eppFCaZHHrhhsDyvDDb3N51tFAp3aUb2wNufBbUh0pQhpQvHxgCns
         orFgCtiZDeF+ppwNMX/J6Icgerpaii4OLN2Ydw76eQWP2rg9HSx/8yvoUvzWhKI2Hw25
         7DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BK6LxcRRscqsnEluIPMx3er/wRY4fpMutYOWykUjzz8=;
        b=Pzidmh7Bclwusd41JVIjA9L5ueOclinbL+TGsHuR20VFhVHmesEjfkZEnKPcYNOXVF
         ZF7HxvhZK4e7dyp27cFvRFz/G6xZGWqn4fSmQ6+qFpx1cm9xXyVabZMT1TO9mChkNPqn
         B5KXvQSotJKtdekgyFcdaFlOxAWpgArPQHjOq3uYtqldZyi1tJ9cWOcrEsa0eb3TJqzs
         HNeDQ7Jfxe7vRr3dS2qTsPccB4+SJ68VfeNiQuFDO9nagzNO6Yz3IvgCVUQzxolxbwhW
         k2Yqfkimk3SGowQVdcILQg/ei1HrFPk3HObHINh6kzubVU1Vm9J64fvwdUqWPqY243ig
         jwvg==
X-Gm-Message-State: AOAM530oVBGC5X8mX/2xz9SxDZ7Jc/bhE/6xIG7ETbVoWHL0+3UZqXd+
        C72rL3EAw51BZnmAqwKoZtjXu298Bp15k0sLPAQz3C9Xgt0=
X-Google-Smtp-Source: ABdhPJyDVgBP0COvfyAl2ABGdKqijtb4W240jklwI9mjQ/CSvLAJC8aqzhqumLuGWJRH5kaYpZDb17Vcges4Q5+E7mQ=
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr13146317ljj.293.1593589813316;
 Wed, 01 Jul 2020 00:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-9-megous@megous.com>
In-Reply-To: <20200626005601.241022-9-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:50:02 +0200
Message-ID: <CACRpkdZAZauS19W7GTbhB4FgjrVtd2+RPx9cuLAac4s4vx234A@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] drm/panel: st7703: Move generic part of init
 sequence to enable callback
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

> Calling sleep out and display on is a controller specific part
> of the initialization process. Move it out of the panel specific
> initialization function to the enable callback.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
