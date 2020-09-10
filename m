Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7082AC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E034206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIJJED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:04:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46576 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgIJJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:04:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id u126so5202631oif.13;
        Thu, 10 Sep 2020 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyZ7f5uXtM7ISWgSMBc6d2lGqzDhzGCA2R8PUpwU1as=;
        b=PL2G/FMnhH8YF8exjS2fYXePnacjxyvhHjEGc/N9PYjxvY6H6JiD4mMXRVQYFGvR0N
         gPmC0GeDLlArjX2Lg2tvQ5wkVulTXWQH9icnW0aYxunxlDVQIG67G4n44Ztiq2bdtnZe
         O9hUOCwFYmtMgbdBJPZdHowsSPfiDeK9I0im4qkkKWUMmGWESK1F8yUBT0JZBiqQ05fG
         2FE7cwviHMhXQyyqzqHHzkfWHrBSv6EJVtqpOAX17OeVls72tdD7zIFtOagnV6l1ivMk
         aJnPjSUjc5kO1Dl0zR66cXv5TT5ZcD/F/uQNAKBIfsjg1joNqr/Nr97UegXg9p9Z3AnV
         oYLw==
X-Gm-Message-State: AOAM532rAunHoppwPrJ0eMIQ3cv8fOD4iKiarqiuL/hnTcIQhzfocSR5
        gWy1zHHUtp2N+0MqplnRdXf4ppHcblJDenmgv78aGUm4
X-Google-Smtp-Source: ABdhPJwK9joVgz1WweswXwyB16kFHPWfbKTRZyivUL59SmLk3d2uai4kHvjqbeTX6rdOTm5Fwy2TiNP8DwpVO8PJgIE=
X-Received: by 2002:aca:b742:: with SMTP id h63mr2973435oif.148.1599728640909;
 Thu, 10 Sep 2020 02:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200907155541.2011-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200907155541.2011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200907155541.2011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Sep 2020 11:03:49 +0200
Message-ID: <CAMuHMdV9Ydnqp-XXVDGaRCVMT+-hyb6a96tVsBz5R=x-C4K3Ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: r8a7742-iwg21d-q7: Add SPI NOR support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 5:56 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for the SPI NOR device which is connected to MSIOF0 interface
> on the iWave RainboW-G21d-q7 board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the update, will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
