Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD57C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679DB20720
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qymiIJ3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgGNUHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgGNUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:07:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56619C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:07:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p7so8107256qvl.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9SCRkrwWjdQ5zfni8Ib6fHh6wrOMaYQCuz7BKbHiAVQ=;
        b=qymiIJ3VMLZ3efzNY7vRE7JJ3GbaeOTsIGrVEDJantLumkjUPXRJuVn8EedGdzRAUF
         FFD1S3RirRJ+/WUT/F9MaXS7we7zDQbHCZKJcxhSc2s2jV/srDbKKd0nQXKuvUKK5v9o
         WPnoPb+DEfrOMeXV9SuQ/B2TupcbHh83Up3HIsVFnSUg9WizFa1esRzSEmvzDvzOBjBe
         cpRWtFjdar0+CyNB7lI2F9t4x3d9DKJaP8qUuYfpHMiokBjkgDQ6XR8xu85ixtVl+J1Q
         8JcOhqoM9PnVf74udK3XerIYS8lNA2lRblbI6NFsrw5n/rs0RPx7Jcn1YdHqaRbqzHUf
         SL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9SCRkrwWjdQ5zfni8Ib6fHh6wrOMaYQCuz7BKbHiAVQ=;
        b=dyPeEw1q3DYWaCIK1w1Z/3fvUqEbKRRijMDRmNCsvASCgwYhxMWJqbFjtBIlh9kiC9
         JHQstTiYJBNubr7+ZkUfOEJXtvlxuRl9h/73TKv2jhnEIJ9P8/1sAjoX1D0y05BZ/HD4
         r5AOrOTkMJuBjiyMS/3eQa6fNdWIXC92/FXAaWt+6dZafYMI/ZLhQXsaJgsFhr1Sa3TW
         qZun1JW9gOK7LzZYGF9WW+vSvS5NcCidoz99YZODBUo4e/iWUKSIArU2RDAIOmfYgHmh
         Z3P6TW74o7jyUlN3g8NvoVCxktAZCMzLyUM29deDiPq8W6qNmQjrCAxqmT5+LQF0m1JJ
         +ruA==
X-Gm-Message-State: AOAM53217/tC0ZwbHuvupSed/P4UxHyIJgDEJhr5Ltuobx0S+X2m9Oif
        IeEBlTKIASG+Bvtr5tt9hFg=
X-Google-Smtp-Source: ABdhPJxpkzYEUh4OdGbw5iJ1WhpjkR2UgsCcqi7M27r+SgE/Vcz13AFiLjnVu6yIyfULw2Aj6kxjqg==
X-Received: by 2002:ad4:4ae1:: with SMTP id cp1mr6310367qvb.91.1594757251563;
        Tue, 14 Jul 2020 13:07:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p36sm79341qta.0.2020.07.14.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:07:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 16:07:28 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714200728.GA894572@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:53:19PM +0200, Sedat Dilek wrote:
> 
> Hmm, you might be right with moving to LDFLAGS_vmlinux.
> 
> Attached are my linux-config and dmesg-output.
> 
> - Sedat -

Which tree are you building against? I notice you have KERNEL_ZSTD
enabled, which hasn't been merged yet.

Are you using Nick's series [v7]?

Also from the naming -- are you using LLVM_IAS=1 with some patches to
make it work?

[v7] https://lore.kernel.org/lkml/20200708185024.2767937-1-nickrterrell@gmail.com/
