Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544F02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMJQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:16:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39662 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:16:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id w17so10405282oie.6;
        Mon, 13 Jul 2020 02:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nv2vtxhSh+ZKUdTydfbNIbF9mND4vrqOIiE1Ajf6/Y=;
        b=o+XL7alODxLbyw7nKFbL0mNkbZ30x3AfKztM7i9j/lZHyWfInyfqqhZGs01Dzfk7ip
         nmo8kAUUeF82UV4FABAMYfvAZw5raZN2YNWKSWdAsbRjuWX2PmNLPcxVXw6q8ql1XQbc
         7KDz+RKrH/59dygYTL9KFgCVDdjZM2T/ZmVlS/sR1Tp0VlDZ8+B0qbUDsPg+XxA7SD8v
         UgPs7obqX6BtT3rqmBd910FJtSMHdy6M7HjXi7aKoCA2KfQbiX0wxZBVFCLtUNKlqygB
         M08JN7dB1lpbpI0NM2dU2gMLBSikimnkgXHWDOwh0piickWb+NKXlho2cpyKkIq9i0Sl
         tBTw==
X-Gm-Message-State: AOAM531VZscikTbGqCf2aF83PrQNOMLaDhPVK9APE0AIwRqWoYLYZINU
        hYuDL1pKGVhngAammktD+do0p/MtEs6RU/spNHo=
X-Google-Smtp-Source: ABdhPJyOy0X7AvLPgPT1hOSMERCtAXtP3F/7/Ig/A0LXkb1aAY4y0Dm1uV0JHAeN/dwmm0qFtnvwrS/KuGqrdgun+cU=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr13204412oih.54.1594631795385;
 Mon, 13 Jul 2020 02:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-5-hch@lst.de>
In-Reply-To: <20200710135706.537715-5-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 11:16:24 +0200
Message-ID: <CAMuHMdXQGj=ic_8U4GRmpPtECsC=2pVi-Mjrek9RoC-126yDRg@mail.gmail.com>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 3:58 PM Christoph Hellwig <hch@lst.de> wrote:
> segment_eq is only used to implement uaccess_kernel.  Just open code
> uaccess_kernel in the arch uaccess headers and remove one layer of
> indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/segment.h       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
