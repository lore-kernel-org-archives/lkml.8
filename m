Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B535C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823EA2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFVMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:48:10 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38275 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgFVMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:48:09 -0400
Received: by mail-oo1-f67.google.com with SMTP id f2so3316398ooo.5;
        Mon, 22 Jun 2020 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CLPJ8+Le4k5gV5yNEa4L5aQ+1liis/EugptBK4fkV8=;
        b=E0wS8kT/MOmpfXov58ODiRwrwP0SjxTiiWg7i4DkDs912AzrSxwvL++OyRQGKfhhuU
         1Y8VfhNRuviOuRvAXd2MHtq9tij2lc4YVwIR4f25k4c7UtrbHChKdgvTsDgSBRImEdgH
         5m9Kf92bUW2kJA3gb0qvQ+sNXjmzWSxhPbcgE7mMv3RSOEfTNTMjlfOVb/GwfZ1mu+ul
         CXMk9chMWrm4UUcQl7pbenscS29+AYdCG24FIEg3fe5/tEmCBa1dTSTzDZ6i0AAzZFGJ
         rB9GtpwlRmCdYHuOyPSvYlseRN3yP9d/F/d+wygMNQ/2YV8Yb+5OteFcgM9kvHD2ezoU
         sY3A==
X-Gm-Message-State: AOAM532tpQwdq+0z6RkuGpeOy/0MvoDEN2WRL4onVcbJiiFtKyIsTrxP
        c9Eu+ZWCFviaGtd4woI20CV929JWOM0U/U01k1s=
X-Google-Smtp-Source: ABdhPJz5yzVjWAKvq5b+dYFwn1xxZMokS9XOjLsRdcCMMgNeorz6934+g57TWo+JAa4MYw7S2318EBC2h25CTeftg9k=
X-Received: by 2002:a4a:db4b:: with SMTP id 11mr14343005oot.11.1592830088466;
 Mon, 22 Jun 2020 05:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <1591555267-21822-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591555267-21822-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591555267-21822-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 14:47:57 +0200
Message-ID: <CAMuHMdV=AxvQ3HHSFrU_u_8D+MSMmvndwE_QYNLxpQt9135TUg@mail.gmail.com>
Subject: Re: [PATCH 07/11] arm64: dts: renesas: hihope-rzg2-ex: Separate out
 lvds specific nodes into common file
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

On Sun, Jun 7, 2020 at 8:42 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Separate out LVDS specific nodes into common file
> hihope-rzg2-ex-lvds.dtsi so that this can be re-used by RZ/G2M[N]
> variants.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
