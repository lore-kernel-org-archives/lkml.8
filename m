Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC182071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFVMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:49:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35233 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgFVMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:49:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so15501464oik.2;
        Mon, 22 Jun 2020 05:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dAYpU1c+0omFMwewQ7Zp2dGw4F3J5EZFq0iFfoZxAI=;
        b=J55ztwuXcXC1lCwr+tndwcCvVdMqWzXjKF/b9o4nT/qOYVetocZYqMrRVyWjSSsmMW
         Z9hbLJD4EjEYQabyu89SHlyNsoxTjHiC/9OVQWq5xcGIIuwyzvsslUaArQGjCPA55b+7
         fc0xeGChPeGpBhgwr1Jq1mZX+ZHOkMn6gc+OBl8UV4jQoPl1Mas2Hmw/HWxDm1vtFn6E
         QkCkDseh2lk7FID+R2qo3VPzvTF8tizOAgN3ZNs4Q3vxKodFSH8fkAurAxBaT/weTiOB
         cH9CO0BEhcdnzmsINFBCN264qKEbF/OUN8XNrD9XZDVN5PBxz/AFZwklEv/IR0Sx+6Cu
         2cSQ==
X-Gm-Message-State: AOAM533ZuhLeVZlZobAfVUDHBqPWdbrQq6SYoLn0xtpYv4v4y0f5tCYU
        FjfTI4TMb8jWnpycmbLBYt9zIVwlGXiylFBl4BU=
X-Google-Smtp-Source: ABdhPJyi2SBTi38RvRrJ8xesD3xyuDcqlHuNTdDX4MnHLITVUj7m+dDJnt+4xzfduFu43MsuzTE49U8fElVPsoTj2ZI=
X-Received: by 2002:aca:849:: with SMTP id 70mr11836517oii.153.1592830154983;
 Mon, 22 Jun 2020 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <1591555267-21822-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591555267-21822-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591555267-21822-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 14:49:04 +0200
Message-ID: <CAMuHMdXa+kuSNhQr4QC-jWbF=fwguaCsUQUfcW4251A5JuZ3YQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0
 board with idk-1110wr display
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
> Add support for idk-1110wr display as similarly done for Rev.2.0
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
