Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FE2221EE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/ZioOvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIHMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbgIHL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:57:21 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AAC061573;
        Tue,  8 Sep 2020 04:54:45 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v78so11085769ybv.5;
        Tue, 08 Sep 2020 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL3PNWhyNAiygS2fKeCGKkHLdzzbSTf5CFsAzvXhVIc=;
        b=o/ZioOvSrmbKkCWAvGMuu44+jTXgqVyP19XMAhvHqqrO2ACsyDq9NeQJrwb913wD5u
         wCZWUnfdjSWDAQ2F+lnDvVDClA7Qwj3CNp+QX+L+3M+U+OOr8g1DgrVGSYbRzd1Uh2Lk
         xDGI4ilg/9zY3YuUCzwlQCPp5Ss7kvN94EG8qdOaHPHAb6M4An3lO023vHASM3Li9Ii4
         afTg5uiMbfTzzImvOoFCi/GV+ehze96hBhRpG4Ib5EP5DfiQ1qSXtpgHf6XlHUr2K0MW
         sXQJXLW2Fvmq6HObfuC5PPRUvHBudPCwg0ks2tJiq+YOTd7VHWg0BQLNK7QpQ0sI5EZW
         +XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL3PNWhyNAiygS2fKeCGKkHLdzzbSTf5CFsAzvXhVIc=;
        b=NNseXYhJTfAKO09m0Y2l+MDtFi0FhDhFTUJT9VEziFRsMCO7k7yrgutWoi6ISDzMKl
         ZSOyVwaoV2VO1WM1pL1TtVFCSYESRbBHX82grnFbBTN+nm1kUrNwDrv7NOFlZtpU92q0
         nauIV4s5Xf2wSX1k66rXPDVVe6ZlpcFU4lRMJSeu8dtuO88ySCcKot7ISJvRoux51Uor
         X2sQ8ixz1xlhg5ViPMAoiQSBWrAA/JHn0FMzQOho6K6ERgFkxSt9I023JJ4qBW+MblgG
         ZMirALh6HAH3YwjGq8SZGwBwkDEEmbBocLw2+U0dw9ICsylMuCd1lc9/Jc6q+zh4GrND
         90uw==
X-Gm-Message-State: AOAM532O+vjgeNR5XZKmSpJopUs69zRzoDoMTYv49G3WolCkLJmDYeqd
        RIwSX01KgwN293pq7ad8497yCTZVaa1IhzSB8+o=
X-Google-Smtp-Source: ABdhPJyQInhue+DlddoZBgO8uBL4O09RA4EKtxxJsOSZSUJFu1uCkxOZEpGO9sz6Qzi0PK33pZ4iV34kj76CqAkmK38=
X-Received: by 2002:a25:bbcf:: with SMTP id c15mr33057595ybk.127.1599566084641;
 Tue, 08 Sep 2020 04:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200908110640.5003-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXD88LKVUcXTa=yWreqWZ0O0G+dF7WK=ioVwJo2OTd_PQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXD88LKVUcXTa=yWreqWZ0O0G+dF7WK=ioVwJo2OTd_PQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Sep 2020 12:54:18 +0100
Message-ID: <CA+V-a8tg2UpcKKnqnXTbhOOikbYaPziwgkP+yWKOJ8Lt-f4UVw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Kconfig: Update description for RCAR_DMAC config
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tue, Sep 8, 2020 at 12:22 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Sep 8, 2020 at 1:06 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > rcar-dmac driver is used on Renesas R-Car Gen2 and Gen3 devices
> > update the same to reflect the description for RCAR_DMAC config.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want to mention RZ/G1 and RZ/G2?
>
Agreed. will include RZ/G as well and post a v2.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
