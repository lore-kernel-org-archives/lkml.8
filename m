Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB40207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgE2Oga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:36:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34419 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Og3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:36:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id w4so2763525oia.1;
        Fri, 29 May 2020 07:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eigH/NKqLHA+pKb5RlSix8yBOEHim34ROTUaKjEAKYA=;
        b=WPUcB3GSDtmVhbp9BXnv7qa8pFwm5lwtebF0k6F8k2SFzTF+eiscw0sKQ2cIhXxqJz
         e+ZC96vv4N2R9Js/4Dl1q1TmS/5bKZReCwd3xYGszYxkXOvlnJOhpKLoB87CefTcrwrv
         FL610taT58p/oP6TiuPqj/FbynZcnyoFQfTugHy44Jv73VYpoAakKJC9oH50b30/o50r
         R81gSGyF/Y+w/W3592A00UvYIA369/h++o2i6QC8cxD7GEOvJqC9BiyCFh7+qaemNzIB
         QLA2RXcbLaLEmo6tIl2EOg5BzkDppQzC3w6RgNcQVsqjGETapLe5pAvV5418hqZPulXR
         OHew==
X-Gm-Message-State: AOAM530Z+Jd9Qlsj79Vr+0bW0DOd/vaCgS0WrW669qQFkIicgW2+lZ0j
        PN6VjXcTxVEkgO54ESNdNU0De6zIfOi9w7r0ojw=
X-Google-Smtp-Source: ABdhPJwfbQ9MFvmgQmXq8nYf91+OI/Nd6yrNQAeK+5+gzzO5FC/uTUz+kmj3R5mac8Gqc8Q03rMoxQfirnPDtGa/ITY=
X-Received: by 2002:aca:210a:: with SMTP id 10mr5706808oiz.153.1590762984703;
 Fri, 29 May 2020 07:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <1590611013-26029-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590611013-26029-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUORdW4EcDLsS0gF9nhQpmOQqceJQzkLXUb9BPs5Av9ig@mail.gmail.com>
In-Reply-To: <CAMuHMdUORdW4EcDLsS0gF9nhQpmOQqceJQzkLXUb9BPs5Av9ig@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 May 2020 16:36:13 +0200
Message-ID: <CAMuHMdU54H0wpikOq+RcFCLbfg7E=8jM9r+EPeEm67dCsy8+1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: r8a7742-iwg21d-q7: Enable SGTL5000 audio codec
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,

Whoops, too much gmail-auto-guessing-completion.
Sorry for that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
