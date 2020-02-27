Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E3C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244C6246AC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFeWkNfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgB0RNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:13:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52663 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgB0RNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:13:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so176465wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRFodb2ms+/Ze84f7ezZLQgjnfHyEqMYKFplavQU274=;
        b=GFeWkNfAeFE1PGxbru1Sszjp4401EcQ+VWatx1HlhLSe4ix2kBEeJ41isVFUKdvpXf
         Qc5kYZCEp5CrqbH2wU0Qhzq6BBm0MsrxtA1EhRqOY10IY+N0Ssefg+CyCKkeVgOxbVtJ
         VqrKS2fJ06pY/5Sv/021+h54fqqCO7WwOsbDXrzZM6ejGQFYRK9CB/0onzt0KnP0Xyfg
         aUljwm5ng9jv7V1otJqoMYEdb76PfawPqdgV1TdgZBlgEaSieGAjel1n29ALB1XcT4Pt
         BpUBteZTDViUBBZD7Kua27z1UaRzJmAA2J1aKm3e0dVywvpTUP0Eqbex73loF8rZA4x2
         wDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRFodb2ms+/Ze84f7ezZLQgjnfHyEqMYKFplavQU274=;
        b=NLUdKGH9Y7Q0iP95dCTsxUY2i0C1i8G9pSnm399XWaxgA1Q17f4yx33MAgKwQ3o3UY
         jxsXFj07fAaQMEcQmsKwAd0wLHrsF6qt3HoSm7bPWfcX6EiSAooOeNbBCs7pvmBefBks
         C4YDthEUzSu4qwKr/9upsHHjrXotjt2tSNHt6YUWg0RLSc2fDejTpdty1FBW8bb5BCKl
         I3wOJhK8UZk5XodWO54pQPcMJQ78DYVg3CwHy6IeS1PO7v5+dWIRNhTaBmC0HlpcHGup
         qIVhBBUlS1sI9PH5ZkQ9s/TQfL+tWoItUM7PXXyPAjZFhF3aua62n43LeKqlp5AViBBJ
         pOLA==
X-Gm-Message-State: APjAAAX5zXu1av5AiPORjh2bAkdGbcrndiKezNqiXowP9jlKa2MxFSij
        CuDP9uXd4l09stqxMor1KOTrttSwRVVv0ZRlH6bHIL4M
X-Google-Smtp-Source: APXvYqzFW1PtGlKB8R/X9OvHP+SCq22XUNfUC5pbpz3qORBFSTYYYtRqiPKMJqj1H+J2yo2wzf6sS/WyUUnY2nIBPpI=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr510453wmj.137.1582823629861;
 Thu, 27 Feb 2020 09:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20200227151143.6a6edaf9@canb.auug.org.au> <CAMuHMdVc-vyQfuLUgbF6ei9Qrr+fryA-j1PHsrsjTNiOYvUk+w@mail.gmail.com>
In-Reply-To: <CAMuHMdVc-vyQfuLUgbF6ei9Qrr+fryA-j1PHsrsjTNiOYvUk+w@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Thu, 27 Feb 2020 09:13:38 -0800
Message-ID: <CAOFY-A0=AYDSdGq5tf7s6_kRjnDGLfLjCV9p+LdKbLwyw0J9nA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 1:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Stephen et al,
>
> On Thu, Feb 27, 2020 at 5:12 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > After merging the akpm tree, today's linux-next build (sparc defconfig)
> > failed like this:
> >
> > In file included from include/linux/list.h:9:0,
> >                  from include/linux/smp.h:12,
> >                  from include/linux/kernel_stat.h:5,
> >                  from mm/memory.c:42:
> > mm/memory.c: In function 'insert_pages':
> > mm/memory.c:1523:41: error: implicit declaration of function 'pte_index'; did you mean 'page_index'? [-Werror=implicit-function-declaration]
> >    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
> >                                          ^
> > include/linux/kernel.h:842:40: note: in definition of macro '__typecheck'
> >    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >                                         ^
> > include/linux/kernel.h:866:24: note: in expansion of macro '__safe_cmp'
> >   __builtin_choose_expr(__safe_cmp(x, y), \
> >                         ^~~~~~~~~~
> > include/linux/kernel.h:934:27: note: in expansion of macro '__careful_cmp'
> >  #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
> >                            ^~~~~~~~~~~~~
> > mm/memory.c:1522:26: note: in expansion of macro 'min_t'
> >   pages_to_write_in_pmd = min_t(unsigned long,
> >                           ^~~~~
>
> Same issue on m68k, as per a report from kisskb.
>
> > Caused by patch
> >
> >   "mm/memory.c: add vm_insert_pages()"
> >
> > sparc32 does not implement pte_index at all :-(
>
> Seems like about only half of the architectures do.
>

:/ I begin to suspect the only sane way to make this work is to have a
per-arch header defined method, returning a bool saying whether
pte_index() is meaningful or not on that arch, and early on in
vm_insert_pages() if that bool returns true, to just call
vm_insert_page() in a loop.

-Arjun

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
