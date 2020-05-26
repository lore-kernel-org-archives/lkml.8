Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93222C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D33920776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgEZH6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:58:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40772 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgEZH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:58:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id v128so17899918oia.7;
        Tue, 26 May 2020 00:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsURDC42TSy6y23dlOiFzYIYBJQzEtPc2OlE7GC+Vns=;
        b=Kt8AkJKjOVkEfo6wfsyppIPlYmnqCXHnYpeatwG+1PKFHZdOydKJRtL7Vt26EWHgVz
         T633pFbpk5OGqSj//EgAtPt3KMXWP3IECp0QXQ5CJT8zexXWi3ixjio1BvBPXpHbhzNM
         GhVUYX29wlJAlCOoX05ZdywxMfsbLTNkXRP89EmWSBUjdznIVlhYCwMuQCDd3qOaL30l
         59r95/AXkeNYYcussFoKGx4EDqOfxzoUDbPQml/ShrX96PhnCUPg451BBiHfMwd1ZI0I
         eEIPqhtMkpbfbYypxiMJljEhEXKDWAhpQLoN6aQnsroz//j5LGjUH0106Zx6XvsTvoJy
         Gnuw==
X-Gm-Message-State: AOAM533vU7JUwOFXxTFvhQXoLOz/2gh5E3DbRYs2wGRLQv3ZNbAZQKga
        J3PYDhr9UBKjmuNBsW2Wt4mE2g92bPTrk0uLAas=
X-Google-Smtp-Source: ABdhPJzz2vDoCU5nnj3rrgngnH6zyoxkynMR40cvCYpworU05mERbFwmbsYX2ELTq/5hLIDmaBMk8L0g8VNIzzFqgA4=
X-Received: by 2002:aca:210a:: with SMTP id 10mr12878772oiz.153.1590479918473;
 Tue, 26 May 2020 00:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <1590420129-7531-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590420129-7531-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590420129-7531-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 May 2020 09:58:27 +0200
Message-ID: <CAMuHMdW4OUrm4nbrozj6Rp8L7527sQWmZS-0xa7+sak2CXBu1Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: r8a7742-iwg21d-q7: Add RWDT support
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

On Mon, May 25, 2020 at 5:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable RWDT and use 60 seconds as default timeout.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
