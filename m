Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D59121475
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFQHnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:43:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40385 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:43:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id t25so961079oij.7;
        Wed, 17 Jun 2020 00:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EL2Yl6+gGOVTM2oxxxE1jtKIVgdnpSG+O8am8qVSvY=;
        b=lYhmpIHpstZ9/cM2x7xNSbcl0/VfyxxO6VRzHKfcC1fPLjSbfd0jVba9zy2uffEn7v
         DlKlrZbyBAaPMdPRKDl0c7GdDHJ5jd0F4P3Po0CJZ5f1ExW2x8iUePW2aWtjuFKKGdY5
         gc4uv9JGnSpySC3NScRw/xDT0aVmeqHwqopHE7Pp6KZSW5O3El5UEjo6kYRG9kGkcyAj
         HVkkFj+ah7rE5oXuhgSIh9qRH8xvcfmhUit5i57X8H1FcohqmaELHl0ckphiDjGM6C1o
         sVjx0n7Z8Tz866o9p97n4aV2UEssyfOXsSS674u5WYko9YaFnGD1IWMBOH0axaq9CvBO
         KVew==
X-Gm-Message-State: AOAM532MNI7yBCQCJpSn8dENB49FoAJaeCLFAR2RK6rITNykfPAYJRC1
        hHeEmZSt1vDGa56utgeZACVtu1L6WxjSiot4DBU=
X-Google-Smtp-Source: ABdhPJwcnhXEzERr2baFtfXHv2RPgR0H7kD/2ORZpKLxq8qlmnPq2RL1E7epPSFQmuPxcYSfgTRGEapwIydanUt8bTw=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr6444782oia.54.1592379802653;
 Wed, 17 Jun 2020 00:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXHT9y09L19j2K=oQ1W+7x=SE7MEyjj6r1i=DPcokvWzg@mail.gmail.com>
 <20200617074023.30356-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200617074023.30356-1-navid.emamdoost@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Jun 2020 09:43:11 +0200
Message-ID: <CAMuHMdULgdhgoydX-nnVSyCEBd4zkCgSyVZ+ojFzGM0gky6OJQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        mccamant@cs.umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 9:40 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
