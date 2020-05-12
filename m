Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610AC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88A720674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc2w2MLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgELME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgELME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:04:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05518C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:04:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so13295824ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5btP7gtbpjtG0BhO1UsxQRV4a7bUgE/wIxxtvB4r82k=;
        b=zc2w2MLiS0a8rnKvBR7UNWYE0BbONekozXpNgUqpFZ5kVRg6+oI64tWi9lfGivgNeb
         0xSZwWlbpp/ikbEom6DC9FZDRsko9yRHoXbMTuo/u1I+b77ubHC6tJbNZNCr4PyKXwUi
         gmbc+fu5UbWh1Bta2gBmK2Uit91iJEnEjIP+z41JS8IHO1tSoWXbs9pJm5we8/OsUBSk
         wJG/1Y+j7+2mqdSALCXTh6BPXPi2GTgvWnvDHTRALQ1NkXHztiY+UaKX5G+XGnAkVxzm
         DPKV2Wi8rW9BIu759OOt4uInwbttKSx65J3XY5GsVfHXBlSahmJuIO2atCuXwtGbg85G
         EaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5btP7gtbpjtG0BhO1UsxQRV4a7bUgE/wIxxtvB4r82k=;
        b=MaFDKCDta4sEHGNI3CpfSf1JaEFvq7XTGos07XM6f2gEdUFktGE/l4BO7w3XYHqePW
         SFeJp8RHHVz999wr0JXc0Zz4mG5VieQ4hZpOO5IybFHiHRq2DTwjSpnQYpGRCMkb/aym
         LhmLHIOr1yaAc4awrI8Y22KSxG97aMtRV+l+78JwQ+n4iDy4jlCySGarTV6tszgMJCr6
         OfFPZUl7mfoKdmhtpex6ucSlUi18oModXqzxg9LpNfduecAYe7Jjy/t0vnd28KAPP/Is
         t9nGTJvpIpWubSbJ4LZqb3yHmdFpUtDl3tySLADaJ3EdCpBPVlbNvh/93tml+x2JuJvH
         V70A==
X-Gm-Message-State: AOAM530+9BT048qlxbqVMMtJJSf8OJ8vw+3Eq51tGFAIwreQX7pQ5Q28
        MNaAM5jkdaKrJvlpg5qyIvRCy7MGWnqfugswR9fj+Q==
X-Google-Smtp-Source: ABdhPJwQSmzg18wDAiNLVctzzlRZrCjXxz1QtookN6JLhJ4bNY7gw2amRj0dviJQShJhEFaL/quWNpl+3GN1FMqhN7s=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr13584425ljp.277.1589285096459;
 Tue, 12 May 2020 05:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200428141459.87624-1-weiyongjun1@huawei.com> <20200430073145.52321-1-weiyongjun1@huawei.com>
In-Reply-To: <20200430073145.52321-1-weiyongjun1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:04:45 +0200
Message-ID: <CACRpkda2-EHn3BrMtGoTV4uax6G0JJekEjnnLL1FT+2YQFawTQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] drm/mcde: dsi: Fix return value check in mcde_dsi_bind()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 9:30 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> The of_drm_find_bridge() function returns NULL on error, it doesn't return
> error pointers so this check doesn't work.
>
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 - > v2: add fixes and fix the subject

Already applied v1, no big deal anyways, its a nonurgent fix.

Yours,
Linus Walleij
