Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B7720722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcehAVis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgGAHtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgGAHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:49:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1055C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:49:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so12544871ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++uGLkdCf/60V7s9CDFLkDgLRpplORGsi+7jDmsg2a0=;
        b=VcehAVisE+6s2+bxMOyJUI3XZCbK9Yqe1A5IAZ74+sXsRGf1//4lTfVXvEi90+ymhA
         XLDA13LVc8yKXBNVrkEwfLG38vrVl1zaJNskU0H4dYNHnlcBml2CT/zODmOcu/Kbg13G
         RN3JWAi4jsyLj0x2pb0JFbZCYjDCTT4oAmZ8FcZVyHnnjv7/arqZaE9Kvh9DM91qcZPu
         b3CEEVEndnTMHN+ovKIZIzL1NDs+cjioV2ZLizrNYhkE86rMVj22ZPag9Wsw8pWFdHJY
         RrNoEe2rMSRtz5HlSpgVjr76KN+8Be6U5GeXpjcCqYwVyGCaaguHqJjxsOWLHgRyYg01
         8ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++uGLkdCf/60V7s9CDFLkDgLRpplORGsi+7jDmsg2a0=;
        b=jOUKM2SfPdC+4jPbu/9h/aEksL3RwY5c/rQ3S4PX5iVkMJiZXHkMoBwF1h5u0MKRRf
         3SVj0ZCDGqJBYmtfUOnE0UZbx6MFpEgFV65n5Puat0f4GIsBeZFGN0in5fzYGi+ZsUWO
         NskuR2i+yOAC8xYTEMmouR610IloUJh6OvabMs2fipxZAi+XFXh8UbVRHOLSTpcikMZ3
         xDIyXVI9PMwPG3p/+wFL4+8fNG41kfZztdPqQ2tt8z2dTFMUfjYULIVWN+QxvjB6sGUA
         6Kliwi7q7NGV/E+BN0j7q3PcvKckg1GRuzi3G4isv1OjVqxEqK7uvGlWuTR+FUEsJvdB
         cYgQ==
X-Gm-Message-State: AOAM530UyoNv+iK7L+8ozrYWbsMXZg5ufGkXxaTbJajVEbcI4x7th2bX
        2BCwIqeKk7EqU0Ia2KroGcTX9zK32qut/C+w/40tTQ==
X-Google-Smtp-Source: ABdhPJw1FRf3UGjIm8Aw/1ssXYvNABKPHlodmDoTYJBWduHQRMKFH+GUhry8/4a3iTFlum0ADTfAg+Z+9PH8e1iUju4=
X-Received: by 2002:a05:651c:284:: with SMTP id b4mr1764447ljo.283.1593589761445;
 Wed, 01 Jul 2020 00:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-8-megous@megous.com>
In-Reply-To: <20200626005601.241022-8-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:49:10 +0200
Message-ID: <CACRpkdZN2rEB9gSQiBiB5Fu8tUUt=DCfF3dpfOBTsUbCc7HUgw@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] drm/panel: st7703: Move code specific to jh057n
 closer together
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

> It's better than having it spread around the driver.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
