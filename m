Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE6C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026CE206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDUHGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:06:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42365 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgDUHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:06:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id m18so10392522otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUpfxDrNH3G3nD39W0HvSE2shtfsQaSA2W5+bYY8bCE=;
        b=KmNic0wAow64TGbHOmTXn6bVy7baS6scf+gkSn5ywJlwRdG9zgAK+uRJgHI22z3Lij
         csNbBBiEHXsLNMMm13CBG5cEloNBgsaSQx7HCVF244YDm/Wq1ZFYdCDgZgFgduCnHSXY
         lzHpQcm+Y9Zy+IiCohFOJQ94t08Nw0b8NOKHAtObvmrkFmsrKQdm0pCzMEVil5GgnJES
         TwgXCpapiGUJmegIMCQavH4j95FBThHxE+VJjqXUT9VEOihdYugUPfdKBtmszX9UYMxe
         fLDsPAHdxewTTpPFmhhj7cPmKAchqtIYUrdOJIl6gDKhXVj7hwIlUpUYKAFQCvCg3aMs
         W/fA==
X-Gm-Message-State: AGi0PuZYEVjMiXiGl+0Vxn8kBHAHYYqaFNZi4CcXfo3Lzs1P9d0oJswu
        o4XCqgaf74Rc7UGJRDOXmV3ZriaBj0GeEP9W2GmQnQ==
X-Google-Smtp-Source: APiQypLDO6mX576dsj4gDLr34JhuGAGiTxbaCkVRzIRSYyDEXiPioRacua+yZQPdyVGDqaNGqAx2kFXTxKugkS9lBA4=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr8902539ots.250.1587452790128;
 Tue, 21 Apr 2020 00:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585264062.git.gustavo@embeddedor.com> <20200420181401.GA32172@embeddedor>
In-Reply-To: <20200420181401.GA32172@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Apr 2020 09:06:18 +0200
Message-ID: <CAMuHMdXjj9=FmrMSu4BHbt05ueGYWBZCyfTds7prtN5WPXP81g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2][next] m68k: amiga: config: Replace zero-length
 array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:09 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.8 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
