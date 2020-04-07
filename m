Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54A206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgDGLND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:13:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38708 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgDGLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id t28so2671157ott.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3iXkpvKQTrS/mZHkPAUFQihvDgmhgnkcQpveYe+iPU=;
        b=J17uUbbLxJz6rl7dd45Mv8Z54VA7cl1V/mfhoeVpL/0i7TJeT+vOquS7s9IwoGKBNq
         EnfvtN3VEoJEDfFKHDBEvU0FLEns3roU9ckgSfePP4n4x2hbWbPD1TcCjF6b8HB0eqtC
         PPB2opFKNPwK2xqGsazl42ABPkpj6ZyhWu0IcjPdZ35h9hLritWOaR2QevlegDDrUoso
         nNhvJ3IDmgi3e7BVMjkaw6Eu8v5JOd6ahcu32vxRPSKXUYjpKGNjvx8/JYWe559WUkZm
         hdWGBACgLp8mQk3bxqh8a8ecQ/0TKO2nb5c+mos7WSewx63BGMZdIxi/cxar3ZhNg6ZQ
         5fMw==
X-Gm-Message-State: AGi0PuYWRIWaOhqaOmlvW3T0lAOvcDNBsl8W6/lRfJsK5aay7s5W2DZG
        1sXk921DOzfhiyUk1f0pV2zaIP4zvMEJ4lkgj3U=
X-Google-Smtp-Source: APiQypIyZ+zMrT0ob34m67/8h1bW9LCddkuTM0bzGelJ4kZB59WKXowcJiddAufEynRIza37fmpf86cW43QFEiMVzAc=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr1044046otl.145.1586257980496;
 Tue, 07 Apr 2020 04:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103537.4138-1-max.krummenacher@toradex.com> <20200407103537.4138-2-max.krummenacher@toradex.com>
In-Reply-To: <20200407103537.4138-2-max.krummenacher@toradex.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Apr 2020 13:12:48 +0200
Message-ID: <CAMuHMdX3EDwrBJQvqpoGkbWjFkEth6wpdk40pZjCydfssJ2T9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed
 config symbol name
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> This occurrence wasn't changed in the original rename commit.
>
> Fixes commit 0411374bdf2b3 ("drm/bridge: dumb-vga-dac: Rename driver to
> simple-bridge").
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
