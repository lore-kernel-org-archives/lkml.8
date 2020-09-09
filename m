Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA1C21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bndKyFAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIIMDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgIILmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:42:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861CC061795
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:41:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so1411647lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QFqZ8T4Z8Uwssi88QoBtFjRyO2k2yhi/Ck4LHpw7Qk=;
        b=bndKyFALCwNbpGG6biL5LEJoMyzVE3/sE7fOKzM0bdlDG5LYKrVzIyaoIPdR2j3xo9
         ++yPbukmQM8z67YpiR6rloFUdCvnbCIQIwtrfXT11Y3f8mIL6IxU4Ws1RsASWnWA1VXr
         Jk4QHqNo+AhOG+O7PZKZxH/j0N9bJZKi7cSrxQvpusImfogn4uS06eckyz/qrYsyCO1t
         Isn93zwFT14OXhtBmKB6DgUDDY8TndPFTtlvWtMdxc40O0hECK8K5IDySLim670nVZDx
         QhGxOUNiRKJRcPSHjXp2Ggt2pgO9wX7XRbPen0Din2y0bZ5+oALUJdnSVu7jg6Plf+RZ
         KGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QFqZ8T4Z8Uwssi88QoBtFjRyO2k2yhi/Ck4LHpw7Qk=;
        b=nwh6SbTiXLLq76eY9c1O8bezDH2GvGD7BFEvLzwE9evCr4UNIpiJtxl/f1Cuf8E+vD
         cm0isjMQM/hEI4dAHXcUtCQfQcflshufaG3CZNng8idLMP8soiJAVhXhk44icBH/NcU8
         XQEiOzqNiW/CAojC88+Srhdz3a86o/2ZH49qsuuoZQMrBpZrgeeF0I3CazzXNh2kbAX6
         k8znvWXjaSd/iM6nOtVObyg95LxYccOlA0kzjWhftTvJ/5R1/AuFYCo37vshjPtoGFfL
         rZZSe3n1eHo5BfxTUU2ioW2JFNY/Z1ptM+db98WjIT51bKkmwa2IW+POWPLyVQU2M7mD
         MaAA==
X-Gm-Message-State: AOAM533uZZWF4yaRt6htQ7NgD1fG93lOv98ltzg10UoDOKf3C9h3rm9t
        HdtWTS9dcJeKEzWKrhe97Ra1qsWTw5b6HHyhG0d5Xg==
X-Google-Smtp-Source: ABdhPJx1689AN6ZBjH9cFKkBhgvwX3Sn72kLkZELmRxndnnmRkhFO6EY5qp4HI+dRiZKRBpPZpNKfjqIAxtiWfATgOw=
X-Received: by 2002:ac2:5541:: with SMTP id l1mr1734063lfk.89.1599651696103;
 Wed, 09 Sep 2020 04:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200822163250.63664-1-paul@crapouillou.net> <20200822163250.63664-2-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-2-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Sep 2020 13:41:24 +0200
Message-ID: <CACRpkdZmiar+2RrMb8=2UdyH83_8KQD0VvX2oWcBezmCdVwzzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: Document NewVision NV3052C
 DT node
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        od@zcrc.me,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 6:33 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add documentation for the Device Tree node for LCD panels based on the
> NewVision NV3052C controller.
>
> v2: - Support backlight property
>     - Add *-supply properties for the 5 different power supplies.
>       Either they must all be present, or 'power-supply' must be
>       present.
>     - Reword description to avoid confusion about 'driver'
>     - Use 4-space indent in example
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;

This has the right polarity but the code in patch 6
seems to use a device tree that does not?

Yours,
Linus Walleij
