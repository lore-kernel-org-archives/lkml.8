Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13496207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwWt2Olm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGNUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:10:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:10:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x9so15321968ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/s7mXKyDFtdZcyZoCObU9RfK9Dh7wLJ8B6HW6u/J2Dc=;
        b=NwWt2Olm2sU+Bt83UQdFbInvtNIkq5uAkS1dHp6eu5V0+V9Wuj0MubDVIL9WRZx3qn
         raAz9LogpCZBPPy4F3OHtT6ivp6EII+5HHL3ArWAMQNpl9W8eYGYGaDJZg1PDkpG/I1T
         qGC0CRAPdxNST1HIScfM+CsOzrF3hN2sUANtvVY1rw5nLMk+Kc/8zl6hZQvyn5iqlXCB
         71CvbycTuuMmP4oS5LZwkPjXtkLKMlRqGeFnHgzwGBN400zuuMGApCnHFTD0/9/pGxEg
         BC8iQTcjq20ez5s3CJ1YdqoMnlCZBaGvoiAGbl4nSafnJ00yKuPZDdLjE7MuaAgkFlLN
         Q0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/s7mXKyDFtdZcyZoCObU9RfK9Dh7wLJ8B6HW6u/J2Dc=;
        b=s8zjSIf5926VamjEXZh27NHmIyt7iRtLBpQJRDqBclweRGwFVv+v8pjZmBKw5uuv2J
         UOjUt+C1JQyToMeLtu42PHFtZIuR6FtaGcfuFCRLT5VP9slfjhNZwS8HnuuoObIpCEqn
         W0t5mr2KVL9m5EXhhNyS7W1QKwz3ZfZW6EG3IOGIYxxTU9iGsH8vidIBAI0xaEOi5Ugj
         ctNxotmbJ67O6FiRSRwvRveYBZyaXpvJROoxkUIJO2wh/MSUtUMMC2Kuq5ZVWk3Z0NZF
         qOdLXlfGImltKhvQdVuQS10PUBnflm5P/LCBjFKCj3joFtv4EMIw7Tg1eCD/LAU1ZJ4Q
         pjgw==
X-Gm-Message-State: AOAM531FixyEthOWdmHjkG45IKqBTj8UYhfDoDaY9My8Z3Y5033azu6u
        zr+Cvq02pOorzGnhHel1G3uPOPVzFJXp7Bf9GRw=
X-Google-Smtp-Source: ABdhPJztz5j8hd6Frw031lswxBaRu7sEmqbqOHhAF4c98XXJRr6f95DsIo794YH2x+vPaRsOOPQXZNd/htGpEHXovSg=
X-Received: by 2002:a92:290a:: with SMTP id l10mr6797006ilg.204.1594757425513;
 Tue, 14 Jul 2020 13:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan> <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <20200714200728.GA894572@rani.riverdale.lan>
In-Reply-To: <20200714200728.GA894572@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 22:10:14 +0200
Message-ID: <CA+icZUV9_ox9q+yANQQ-6X41fRb5K7mMn3NSh0_E9R1hO4oC4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:07 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jul 14, 2020 at 09:53:19PM +0200, Sedat Dilek wrote:
> >
> > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> >
> > Attached are my linux-config and dmesg-output.
> >
> > - Sedat -
>
> Which tree are you building against? I notice you have KERNEL_ZSTD
> enabled, which hasn't been merged yet.
>
> Are you using Nick's series [v7]?
>
> Also from the naming -- are you using LLVM_IAS=1 with some patches to
> make it work?
>
> [v7] https://lore.kernel.org/lkml/20200708185024.2767937-1-nickrterrell@gmail.com/

Sorry for not telling you the full story.
Yes, I have some additional patches like Nick T. "zstd-v7" which
should IMHO not touch this area.

- Sedat -
