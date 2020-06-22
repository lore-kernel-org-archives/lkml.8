Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C63C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A159720716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgFVMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:32:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40265 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:32:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id s13so12887887otd.7;
        Mon, 22 Jun 2020 05:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibxUnRRCECiCbSmDxzdIIXocGNM6i8JlycCHedFdcTI=;
        b=pxmMi1G8yNT5kXMHnm/oaaCn25zK3wLRRFwqk7EMg3d8Ay9SC02BdHjxhM5liwzEzK
         MYCqftsb0h/yqgVwfS7BlELWKkUeFUMJXyi6lkH0VKvcjhCtxyj8raQwx8984/p6RVmn
         wU1qcbeBgj2V7caO9pg9sMVP0hVw2ccu7gT9SwI+h4fa9goFfbpJwaiBw9DauySXvyvu
         KKT8QOG+B96K/9niG4R+gOnOdUljMcbCl8dT6MgipkBx0b7lEgynHuxD45HY+AvFxzGX
         Oda750jHv01NDf7arZvSiY8k+yD1vwJXWFPQ6v3fBwUdV1CbsYWLhAfHrsNG5GtXD34/
         WWaw==
X-Gm-Message-State: AOAM532TZuyLMnnUVt9TynD4LERSi0OOm+900YcSrg+O1gMon4IsgnrY
        4m3RlNePXDK9IfxM5xthHnn95ww5Wf7tbBQA2p0=
X-Google-Smtp-Source: ABdhPJzIeiFPEgRt94Dd9Zt37v6KnXnM7WPcdiPuluhCOlGqTR5Pc0TZnvyL2WxJTIMQFFHCC0xL30KawJ1LQKjLg9M=
X-Received: by 2002:a9d:62c2:: with SMTP id z2mr13406400otk.145.1592829140448;
 Mon, 22 Jun 2020 05:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <1591555267-21822-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591555267-21822-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591555267-21822-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 14:32:09 +0200
Message-ID: <CAMuHMdWY=2YxxYX8pOCTzaH9q7-cNYpiL9mQhzwQK4C3NN+kqQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0
 main board support
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

On Sun, Jun 7, 2020 at 8:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for HiHope RZ/G2M Rev.3.0/4.0 main board support based on
> r8a774a1 SoC.
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
