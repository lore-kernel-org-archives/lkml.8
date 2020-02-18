Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D2C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EDF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582057302;
	bh=IBVL74SnrYmiqDQpWv1eT+NGXtOTU9qM3y6BaOyQDi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MmbNvumJibghYvEPKUqGy11IGqn5tnVAlXC9tmklRUv/mhnXSVjj4FYoAmmkEkBmS
	 lhUNkrFBlVLLGJ4dJbXWOIsk6mx1a1ZlWn7JD4mk6kBdAXkKsLQnZzOmJ/iKlymrDa
	 +8eD2+eoyo5sSf5oWI6MawNxLG7KGOxQwGQzCffM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBRUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:21:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37924 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:21:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so24497717ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXYAWFIqJMq3HTxGjGDjlwoSLEj34xndPUBaLkhbg5Q=;
        b=FSKR92uXCGily3RwFxxGKgH6TvMWowyk56U4IagyvRxIVgkJZbBX+iSeyxW683rg1Q
         L9+iM3m+RYGI6RMbyk5kI9L+syeJkAptCMh+8+TV0Vl3XcdUygoBkwPWTKfLwSU9tcIf
         LgMbg7KoYSbITUZWot9yh2QP3xLd7nGWeo5ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXYAWFIqJMq3HTxGjGDjlwoSLEj34xndPUBaLkhbg5Q=;
        b=V6+laiVGJw4nxnc/Kb3GKPTfI+ItuLj9EX9G2f36sC6GHkOY68nWkXxD45m0p/2od4
         SCcKwwMY0UPXw9XB0ZQc0jYvfruTasniXIPYzeKo1cD12aGlLZCssbvHNVnblZBEjUnq
         dFFHox5MwMFKs3YJZ8fci9GpNDaPRkPO7xvIJYqdE92iWXhtjoUPvZ8VfVdw+ZaS/Qbp
         p9+48wXnTt3Xv7TWXt2ThY/6qGpMYK3qjYLmBQvTtf7FgiNE6ClmyfyB4NicQV95mmql
         iAAKrW9/JEYpUDs9RSpQbMM/cVJTDIte0FDOkrENrfrLrhuxcxw7Aloz4WSPc92ctVwj
         XO3Q==
X-Gm-Message-State: APjAAAUUcn4ljLBYNjHF5ixVLJfeDyoIiliW6svBm55rX/jHhCSOt3K/
        st5wUtxMoCaEeKzxVryPxWT2wHQ3LxI=
X-Google-Smtp-Source: APXvYqy1tSz15MmNC/ILQf6RJGH1pdNVnDiRFVkfqFYpyA7Vv2A3zf/SrKhIPSyligiX2rv01B7riQ==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr13582836ljj.270.1582057298359;
        Tue, 18 Feb 2020 12:21:38 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b1sm3365848ljp.72.2020.02.18.12.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:21:37 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id l18so15533125lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:21:37 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr11447787lfb.31.1582057296853;
 Tue, 18 Feb 2020 12:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
 <20200218193136.GA22499@angband.pl> <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <CAOi1vP_Ned9QG32+o9KT-Bh3qMTb6h0SaP8W74Am_gkVX3mcSQ@mail.gmail.com>
In-Reply-To: <CAOi1vP_Ned9QG32+o9KT-Bh3qMTb6h0SaP8W74Am_gkVX3mcSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 12:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2MDhU05UiR26Rn6+uywgwZPE134hPBOuLwKwFs=_GKw@mail.gmail.com>
Message-ID: <CAHk-=wj2MDhU05UiR26Rn6+uywgwZPE134hPBOuLwKwFs=_GKw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:18 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> >   %p:            0000000001f8cc5b -EFAULT NULL
>
>     ^^^
> I assume you meant %pe here.

Heh, yes.

> Looks sensible to me.  Without this patch NULL is obfuscated for
> both %p and %pe though.  Do you want this patch amended or prefer
> a follow-up for %pe "0000000000000000" -> "NULL" so that it can be
> discussed separately?

Yeah, as an independent follow-up. I think your first patch is fine,
and I think this %pe NULL behavior thing is a completely separate
issue that just came up when %pe was mentioned.

            Linus
