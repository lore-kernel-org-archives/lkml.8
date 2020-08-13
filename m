Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882462074D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:14:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40011 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:14:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id h16so4240150oti.7;
        Thu, 13 Aug 2020 02:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6deScSjL4QPU+1nm9bXBybyRqV1GDJ1sApO6/RiKbQU=;
        b=VGbrwNcZ3/J4uijzuU/SX72K4DIcpm1fy3kXkKAo9p++CkbJhCdgaPqR8KsKUICW+2
         LctVbMJcgCPLHtv6PNnpK8ZDE4BRagDvGHx4AgaVBvXFU1mjyngwHstvOTo9jQKrinkk
         1KLuGLHMbZ2aZgbiL9TSk5Yc+ver3yPjLAwDCejHw2Wr60zMaNr7nSKqgxLyg1t2lsqZ
         EEgjSbfim+Q6fln+nJ/CpVmNlk3XYAkQuWW6SdB47BTyuA/AYNJanhrJXXiFfEhfvnlR
         ipW73fcXROj/8x82rDqfYARPgz0wcSKke3YfqBbuwz2y1oTDgmtiOYZShJuNyGk6Xpzo
         hXBQ==
X-Gm-Message-State: AOAM531bDTAWKKRx55VCYrXafRRvYgknppPFMPAeclWKwCD8Pj5n6SV7
        PCeHEQz5toNVz8IflRuZaGJviNRGpjb5vkvdaClxxQ==
X-Google-Smtp-Source: ABdhPJxZzEDqr9QJqNG51CIenvHAo83Rhirby8BLtJumtqG8XOC3gc7VCxo0DqRRIU++IWQ6D6dQIcAZYqRgLk9McTQ=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr3418868otn.250.1597310053733;
 Thu, 13 Aug 2020 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200812140217.24251-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200812140217.24251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200812140217.24251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Aug 2020 11:14:02 +0200
Message-ID: <CAMuHMdU-hHmLeGkgC+mBD5nwWXGsD=fGcywyQgx86cPtxgyrSw@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: renesas: r8a774e1: Populate HDMI encoder node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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

On Wed, Aug 12, 2020 at 4:03 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Populate HDMI node properties in R8A774E1 SoC dtsi.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10 (after resolving the port numbering).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
