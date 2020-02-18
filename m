Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13440C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8C5207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2etLP6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBRLjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:39:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43774 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBRLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:39:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so19751095oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 03:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUPzsUk1wu+gPhqdi+1tZpybnOvga12zZ1MGyKCA/rU=;
        b=L2etLP6IYwFIW3FyevHBpWly/BSpXYuv/jq3DPu5AB2ejfQtcQDJjrS9OE9cFEcp0z
         ZAE05qdVy9AwI3/tcEHZ7L+P6ksqA9p2tv2HT8TUHi3DGqldEZRE7vExUeHGeLw4SBsL
         WPIZqrpCUr+/Q1k0nt7VlDRiMl//NW7uMT6vLHy6abNjbFpZWCzRiuKzqRld02kwluvo
         q9E06Xz1dQjqWj6JbbfIy6aIFI8vg8KklO1IeAMUsaZCtoRlpmIXFeARyLgmf9+0Fj6P
         LWSNVMaPlH3oC+inPyfIlnxzYP9/VrqsAntZjBp9Ur8KPm6iOt9aGKRJVr71NGc5PHuj
         xW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUPzsUk1wu+gPhqdi+1tZpybnOvga12zZ1MGyKCA/rU=;
        b=fKdXn6ofjB5LYpHl6sQNiYBRaBPvQJhxIX+XBLg+3deDOvyL6J5HZXO02jRima38tc
         2ZpS3OyH6p12JA7m7pO3muTOLj4WS5aj7MMVHF5QfvGAQKr/s35yIfh1LnZX307nALM2
         C1qdF3El9Gd34FDzWL0ES+tC3LExm3HXhYcgenSRygGVgDn8P3c33hC1QgLXMKgb7abx
         BBwS3yJc9iuQghvw+OBYjlfKDOuL6GTcGxjgYOt6JS2nWsRiCyIKEr1P+XG5Z5w6BNLo
         p9K7CMwGnyFEawfCkS6xMRSJPd9rwD6uoqBhtl0Vqq1Qnrqe7k6MYG2u+6QkM3Aj8FGa
         5IoA==
X-Gm-Message-State: APjAAAX2sUTYU4IPo+jo8D8fnJ/N6SgMLLL4vXWrD+/ivvyKhKzrk5l/
        wsa5TVUzEeoQw4Hy0wZS75PkEAv1KE0yeoOsRRLw9SG3
X-Google-Smtp-Source: APXvYqz29iGao91H+1lCMqGZV/+PUEBjuNNJdnFuDjAM+V1tt+JID5O9GWf62dxM+b0xDwTMT8pYAtkKGPudb75BLVk=
X-Received: by 2002:aca:cd46:: with SMTP id d67mr945511oig.156.1582025970745;
 Tue, 18 Feb 2020 03:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20200124181811.4780-1-hjl.tools@gmail.com> <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
 <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
 <CAMe9rOrtj-Hrr6tmSrwg_V9bawXXB2WjsSedL=aCaaH-=ZSKsA@mail.gmail.com> <20200218104552.GA14449@zn.tnic>
In-Reply-To: <20200218104552.GA14449@zn.tnic>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 18 Feb 2020 03:38:54 -0800
Message-ID: <CAMe9rOpyb0-DZME8fdqjvD4fM7-0ZugM3YcPfX9i-kGM1Yj_QA@mail.gmail.com>
Subject: Re: [PATCH] x86: Don't declare __force_order in kaslr_64.c
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 2:45 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 24, 2020 at 10:44:30AM -0800, H.J. Lu wrote:
> > This updated patch fixed a typo in Subject: "care" -> "declare".
> >
> > From c8c26194cf5a344cd53763eaaf16c3ab609736f4 Mon Sep 17 00:00:00 2001
> > From: "H.J. Lu" <hjl.tools@gmail.com>
> > Date: Thu, 16 Jan 2020 12:46:51 -0800
> > Subject: [PATCH] x86: Don't declare __force_order in kaslr_64.c
> >
> > GCC 10 changed the default to -fno-common, which leads to
> >
> >   LD      arch/x86/boot/compressed/vmlinux
> > ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
> > make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1
> >
> > Since __force_order is already provided in pgtable_64.c, there is no
> > need to declare __force_order in kaslr_64.c.
> >
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
> What is Yu-cheng's SOB supposed to mean here?
>
> The only case where it would make sense is if he's sending this patch
> but he isn't. So what's up?
>

I wrote this patch as the part of the previous CET patch set Yu-cheng submitted.
Since this is a standalone patch, he asked me to send it separately.  I didn't
remove Yu-cheng's SOB when I submitted this patch.

-- 
H.J.
