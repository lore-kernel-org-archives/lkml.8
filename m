Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7B24692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDUCet3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgB0RpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:45:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34133 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgB0RpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:45:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so4545974wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WixaM9tNI8jnTh9C4+zTeTZp1lxDIM/c/EPF+3v0ZBE=;
        b=KDUCet3qoAEaSacVzuXwe3JXolr9HmgHhC00ZjEyN12KdAZzPjkwxMYSF3VaIUHJoM
         bpu5F79pIc91/TImFBOK34U/6TrFa0dvkKANTi4aZL8uJpMsvb1t/ywuXH8nUdEIvLmO
         XlGtPRbZi9RWArB5f43EpVdrrn3vhnykxhPXDhT/jLvH/+smjUGkohWMJfAoZFO31hcM
         tKc7ABcXYFEC2ysVSQRGKuCZyrBbMnW/Joy9VqtMH5/FFljEqQaxq7FioaRIcR/HcbWc
         86CYOefkozOo91gDg/8hiBPn4UeCJSH/ZxIDDxJH7FxuFAaRUGBY037M5wjHACD545C0
         TQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WixaM9tNI8jnTh9C4+zTeTZp1lxDIM/c/EPF+3v0ZBE=;
        b=p9q1YN2pfwllTqw5J6cnoshKN1tPIpOprZv3a9QbE1dJwRNNa8butffxljOmq1S/1q
         /4N+8HBWhi1rgUTPxMcLjpqQYae7ZSopdA0XVDUxUWqPU6RHtNt7LFYiIqtPeduX7mKM
         9L20HX/hRb0rqnjL6mTMI3+TLL/Eee1Qrt7yVuohCOhhXLT0DngzrmUMjdJfksUXlS1b
         6OZV5BuplM2I5AjqTAGJkY3AtrP8RJs7CqZccFT56xNv9BCbDlTkX4ta+krEYr/TI5v4
         78DoXqQcOatxZtNeYzt0dY38Dcs9M29l3C+xF3ZrX1NbiXlLbGpVupCNi5VQOoRMrCOM
         7zHw==
X-Gm-Message-State: APjAAAWHOB/9F+BaNA1o/bAnGNK5VXKqkavusV508PpUBaR43ifGT4zv
        lAKW37GGX6Io4rDEsyCgH4iZuC19ZgiN0Witlcmv3g==
X-Google-Smtp-Source: APXvYqz21p2um6MK62mRZ+SLuFxx5C/Fc3SSLuIrFollTsWhEO4W2YdbT0+eur1+lWAujIwnB6aoW5WY0MRu3tAN8TA=
X-Received: by 2002:a5d:674d:: with SMTP id l13mr8276wrw.11.1582825505785;
 Thu, 27 Feb 2020 09:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20200227151143.6a6edaf9@canb.auug.org.au> <CAMuHMdVc-vyQfuLUgbF6ei9Qrr+fryA-j1PHsrsjTNiOYvUk+w@mail.gmail.com>
 <CAOFY-A0=AYDSdGq5tf7s6_kRjnDGLfLjCV9p+LdKbLwyw0J9nA@mail.gmail.com>
In-Reply-To: <CAOFY-A0=AYDSdGq5tf7s6_kRjnDGLfLjCV9p+LdKbLwyw0J9nA@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Thu, 27 Feb 2020 09:44:54 -0800
Message-ID: <CAOFY-A2CFi0pX1BBsuruntk0AM9doseCMnFCJi192BYojaBUUw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:13 AM Arjun Roy <arjunroy@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 1:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Stephen et al,
> >
> > On Thu, Feb 27, 2020 at 5:12 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > After merging the akpm tree, today's linux-next build (sparc defconfig)
> > > failed like this:
> > >
> > > In file included from include/linux/list.h:9:0,
> > >                  from include/linux/smp.h:12,
> > >                  from include/linux/kernel_stat.h:5,
> > >                  from mm/memory.c:42:
> > > mm/memory.c: In function 'insert_pages':
> > > mm/memory.c:1523:41: error: implicit declaration of function 'pte_index'; did you mean 'page_index'? [-Werror=implicit-function-declaration]
> > >    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
> > >                                          ^
> > > include/linux/kernel.h:842:40: note: in definition of macro '__typecheck'
> > >    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> > >                                         ^
> > > include/linux/kernel.h:866:24: note: in expansion of macro '__safe_cmp'
> > >   __builtin_choose_expr(__safe_cmp(x, y), \
> > >                         ^~~~~~~~~~
> > > include/linux/kernel.h:934:27: note: in expansion of macro '__careful_cmp'
> > >  #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
> > >                            ^~~~~~~~~~~~~
> > > mm/memory.c:1522:26: note: in expansion of macro 'min_t'
> > >   pages_to_write_in_pmd = min_t(unsigned long,
> > >                           ^~~~~
> >
> > Same issue on m68k, as per a report from kisskb.
> >
> > > Caused by patch
> > >
> > >   "mm/memory.c: add vm_insert_pages()"
> > >
> > > sparc32 does not implement pte_index at all :-(
> >
> > Seems like about only half of the architectures do.
> >
>
> :/ I begin to suspect the only sane way to make this work is to have a
> per-arch header defined method, returning a bool saying whether
> pte_index() is meaningful or not on that arch, and early on in
> vm_insert_pages() if that bool returns true, to just call
> vm_insert_page() in a loop.
>

So, here is what I propose: something like the following macro in a
per-arch header:

#define PTE_INDEX_DEFINED 1 // or 0 if it is not

In mm/memory.c, another macro:

#ifndef PTE_INDEX_DEFINED
#define PTE_INDEX_DEFINED 0
#endifndef

And inside vm_insert_pages:

int vm_insert_pages() {

#if PTE_INDEX_DEFINED

// The existing method

#else

for (i=0; i<n; ++i)
        vm_insert_page(i)

#endif
}

That way:
1. No playing whack-a-mole with different architectures
2. Architecture that knows pte_index is meaningful works can define
this explicitly
3. Can remove the sparc patches modifying pte_index that Stephen and I
contributed.

If that sounds acceptable I can cook a patch.

Thanks,
-Arjun

> -Arjun
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
