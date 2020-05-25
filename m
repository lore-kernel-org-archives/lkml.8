Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F603C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2077D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgEYIly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:41:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46011 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbgEYIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:41:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so13267736otr.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNxHiGKTUaqqtcDRq8VnjaaZW8RYfmi7EaIhBh+1QIo=;
        b=llQ17uSJ2K5hDKjPt178gOgmKECf8N1x5cLhrO7jm4S89asczqpY61gqfTuhE0jrRP
         VKEnmVnfouwrlc1ziUyS6Y46mRTc817E+wfiIq723iBmuNIKh9Wq8aA1yFxaWVfIzSRA
         wMRZTnMf39lpKPeyWKY5xxP+GRC4VLD8916O8EqqQyXo+88ujZpgwbdiJGNZxMbjT4dO
         EYao3pJBk6AcANeZQ3+I5mp2aN0Id9rsiR5B+tvNIZ9+lnOmDyqbVpqOr13hAuOqkGDl
         v1pR85sPHalRkabeadKhME+yyISmh0SlBbE+RIrdgU5cLh/lZmfxUCyj2g2wa8SgG2AL
         RpYw==
X-Gm-Message-State: AOAM532teZ9hvQYt4hm82EA2Do+1Soi2swzg6wHmjGUsNgOWgjIqCE4Y
        V84bNH4pxdaR3IaR4KGA57v/NVt7aIpDlB7XtAHjLg==
X-Google-Smtp-Source: ABdhPJwMfzpAhgdZHYHqNibp9K/eOBvrJiqyC1XftuMg80buIAAriAK5BwI3LKLtcWgCY3lza0Ny9JWBwSV6ZKPbcT0=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr19834887otp.145.1590396113033;
 Mon, 25 May 2020 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <b8bbeef197d6b3898e82ed0d231ad08f575a4b34.1589949122.git.fthain@telegraphics.com.au>
In-Reply-To: <b8bbeef197d6b3898e82ed0d231ad08f575a4b34.1589949122.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 10:41:41 +0200
Message-ID: <CAMuHMdWarWbrk102wRMgpM=D9TjEYJFP=WakD=rca_EgORxedw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Don't call via_flush_cache() on Mac IIfx
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 6:41 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> There is no VIA2 chip on the Mac IIfx, so don't call via_flush_cache().
> This avoids a boot crash which appeared in v5.4.

[...]

> Thanks to Stan Johnson for capturing the console log and running git
> bisect.
>
> Git bisect said commit 8e3a68fb55e0 ("dma-mapping: make
> dma_atomic_pool_init self-contained") is the first "bad" commit. I don't
> know why. Perhaps mach_l2_flush first became reachable with that commit.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.8 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
