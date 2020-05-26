Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04038C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6505206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDx1rAuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbgEZPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEZPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:36:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148ADC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:36:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so15465086qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kOaEeDNNDbr5A18fELJn1A8SP35RyFdZgGb0lfoRlU=;
        b=nDx1rAuAahvdyIagOM6nr9EhhZhs3kHHpZUQxuiAGyC9v14GLtvEKO+QG+yEblcUiB
         i78CzO4Ud1CSb+8Hi8B6XtnL6obi/o9t7l59Q9hIcbctV4nodflZcSa1mW2Zg8sOi0VC
         3wv+6+qhLkD8aaInYPadLCMluxU9MZFS0hLrz3XYgrMzLhJszQSk/HDsfoNYBwZPEFWI
         0RVPxpCdyu/ia5MbpF4j84bclZjDBm0BWSr9KKVJyDUv0NT5UaZIDBUm1SOBomeutC0V
         P68/hHC+XUkgvtCnRWfMPd+EuipzLK7hL9IHINil9tdYnJEzzo45EPBxVbF24QGUsVcX
         lCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0kOaEeDNNDbr5A18fELJn1A8SP35RyFdZgGb0lfoRlU=;
        b=nfb6VkVAfp01W44fnLAEKF4Aq6RusaZWzwJSClzphOzc3w1Ro1We7qxx6NwiW97d0L
         dE5qNcchxgB+ND3YunTGcrk6LgVrroV+3BEyzlpC5/qaWIsn8qO9Jp4bT8d0lz9wiS6Q
         5tB+zLzlmoKkuDpY776UYyyz7ANnmSPbBAz7NTYS10QMha7dc4vlBWmtAN57rgsdbZld
         si7Nig24Jzok9LpTbCV27zv/elt/MyMROU9XjFu0n4MEP7hRFu/bWgfYTFwnjO4wjgfw
         jJ9whKL+RY5UggJLCy6juckHsQ14EC8TMf3KxYrN1NR8M6RNu/qftCeGjzpgT33EBoDu
         2saw==
X-Gm-Message-State: AOAM533o4rhqazmeHydlxG15JB20kWduIalLJ3YfQXNCDr//Gip3aMWN
        exFVRd8CMtMcbmEjAdck7JY=
X-Google-Smtp-Source: ABdhPJxqEFAudnxzJDAVNnvuhVkNYeZKTB+d5uG/IqMt1dYt45Rg7t8ylDuhV7tCgA9tT/aF3Ol/dg==
X-Received: by 2002:a37:dce:: with SMTP id 197mr2023209qkn.250.1590507399282;
        Tue, 26 May 2020 08:36:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d5sm4784878qkj.64.2020.05.26.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:36:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 26 May 2020 11:36:36 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200526153636.GD2190602@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu>
 <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <20200526144748.GA2190602@rani.riverdale.lan>
 <CA+icZUUY7a5XGwcQQ511OeoTjOzWbrgF8BZdTrLDK09QWG4hwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUY7a5XGwcQQ511OeoTjOzWbrgF8BZdTrLDK09QWG4hwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:50:38PM +0200, Sedat Dilek wrote:
> On Tue, May 26, 2020 at 4:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, May 26, 2020 at 02:44:29PM +0200, Sedat Dilek wrote:
> > >
> > > Are those diffs correct when using "x86/boot: Correct relocation
> > > destination on old linkers"?
> > >
> >
> > It looks ok, but that patch (and even marking the other symbols .hidden)
> > should be unnecessary after this series.
> 
> You mean _bss, _ebss and _end?
> 
> - Sedat -

Yes. Those .hidden markings are there to ensure that when relocations
are generated (as they are currently), they're generated as
R_386_RELATIVE (which uses B+A calculation, with A being the link-time
virtual address of the symbol, and stored in the relocation field)
rather than R_386_32 (which uses S+A calculation, and so doesn't work
without runtime processing). After this patchset there aren't any
relocations, so while the .hidden markings won't hurt, they won't be
necessary either.
