Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51366C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324492078A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDTHR2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:17:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42281 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDTHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:17:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so7216583otq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G3napZOIiOeELwzchvRdOdrsSpD1AM8O7v/VEufzELY=;
        b=ZGs+kRjohSq0/w4Nzrw0Yu3f6WZnJjw2G6E6VA0lfJVILA7zfCQpxBAkrry0N9472B
         wv8Sp/JwF8LaWttlZpqsImBb0tqGm6zTuuUcYkEZ8lBk3Z1C+w0yRIBpXs+LPDCBbvh3
         1vWGFJnVgmwOQrg9+8egnuNc5RgVpx0P4gp539t8c9WxFe1kwOxT7EUymnyXoY3Tj9a4
         7mt68zeULrNdT+cYVyi5aYD5hCPIzraXLB/dKiktYKeuMXUqowC4hfVx3HUhsY6nYdvt
         E2wedjVA7m6Gpc8c2D3LvEnLVhFGF8L4CpGohHkxb/H+DI/x51SDH7V9buGe8Oz8EPMI
         oU6Q==
X-Gm-Message-State: AGi0PuZ6xAQbDw+RQC0X0sPRFOG0Ogy0BE4FiS5iTEjKjqzTeWbtgnqw
        G3+Lhe51Tk6k+hLQqjnz6EsLc/6dOkAOz4QhAMo=
X-Google-Smtp-Source: APiQypL3yJvEJ1ORa0rBSqiAogEf52f1uzA/DePnuFLo6bfN15Rej0ftXMj/yihJTMnfOzKrMkt869r6j631tPhZOKY=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr4938576ots.250.1587367047061;
 Mon, 20 Apr 2020 00:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585264062.git.gustavo@embeddedor.com> <14ff577604d25243c8a897f851b436ba87ae87cb.1585264062.git.gustavo@embeddedor.com>
In-Reply-To: <14ff577604d25243c8a897f851b436ba87ae87cb.1585264062.git.gustavo@embeddedor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 09:17:15 +0200
Message-ID: <CAMuHMdW4f-sPPY9sOU-xdVJ-0zsix4wcMTxUz48GopqnWDVTAg@mail.gmail.com>
Subject: Re: [PATCH 2/2][next] m68k: amiga: config: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:25 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: allmodconfig m68k):
>
> arch/m68k/amiga/config.c: In function ‘amiga_identify’:
> ./arch/m68k/include/asm/amigahw.h:42:50: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  #define AMIGAHW_SET(name) (amiga_hw_present.name = 1)
>                            ~~~~~~~~~~~~~~~~~~~~~~~^~~~
> arch/m68k/amiga/config.c:223:3: note: in expansion of macro ‘AMIGAHW_SET’
>    AMIGAHW_SET(PCMCIA);
>    ^~~~~~~~~~~
> arch/m68k/amiga/config.c:224:2: note: here
>   case AMI_500:
>   ^~~~
>
> Replace the existing /* fall through */ comments and fix the issue above
> by using the new pseudo-keyword fallthrough;
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
