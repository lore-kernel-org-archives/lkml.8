Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E676C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D032073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+w4anAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgF3X2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgF3X2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:28:03 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:28:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so20417281qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iirypFBp2xtegwS2Iq4B1iPUgMABexUaf6RMKakBSKI=;
        b=D+w4anAV9FqpiC8o3zpYnCH9ve8Tz0CdVll9wHtzOiCDDAZWWgSfDolrIa+ceJvU+y
         EWtPGt9GK0Eg56kfb2X3t8Xj7kzm9nLcgwKr8zlWkRE/fUP+RDaAk4QD3iMU4Oi/IAXG
         dGbgfTBrlhi3c9aLE6INbEnFr8lWSXaDpdMQ5g6JSZYUUG6LbXpX496c41z48vDLMRXh
         Y3CiV775LOD8komjPGlDaV1pJKecdBr4LohTHFmv3wNs7pS/krHJlawVB2jMZUmHOeOu
         LxbKeErT2KLqfvA5rNdaoIdsmAVvtcjFR2e8Jr2tedwCHuC5aMdU/5Md+gVyNo+/5N9R
         EJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iirypFBp2xtegwS2Iq4B1iPUgMABexUaf6RMKakBSKI=;
        b=NPr4wKr9H9yihK/b8av29b97Jr5Y94717h2vd3wUGCM6LghsJkyCHNHPm/nQxenZSl
         D4YLCcURINesQzfUC1hDUgxpXGycy5tZqeW31YtuvbmorzQecbkDr4jj0cpJE/6X3sSa
         5IfAtodMNNeg9CNp25R+hv//tBXRnz9LgpyPCxYxho6NI1FqV1odcnitHxtrHkEtn3Gt
         S3yRTtl9cnIJQwkDniyR0EOSN6LQFGLoWweijLN7JM2xBWxY2/N1IMmUu0abUWR4RdEb
         8uDunmFqWx1uskUagPi24wCFDLL2+ZBaokNzuEJHDkIbA1oDLi9qmpxncEMEIpGT4l5h
         8NUA==
X-Gm-Message-State: AOAM533XAd/6+oDpcrQJSsHvlPWK8VVlvydqPX53S8hmSyTL6itAhmAi
        lgSUDPcCe4mKdnfT9/m9FGc=
X-Google-Smtp-Source: ABdhPJwjmCFf0FSJ9sq3xPbIH6a6uMutO+swEhEFAoU5cSvs0hsfpCCdfwJGGVjUVa5/m4fbCAn6vA==
X-Received: by 2002:a37:4c0d:: with SMTP id z13mr21851974qka.170.1593559681849;
        Tue, 30 Jun 2020 16:28:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x13sm3868567qkx.10.2020.06.30.16.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 16:28:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 30 Jun 2020 19:27:59 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200630232759.GA2641539@rani.riverdale.lan>
References: <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
 <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com>
 <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
 <20200630175408.GA2301688@rani.riverdale.lan>
 <20200630220043.4snabunhgvfdktte@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630220043.4snabunhgvfdktte@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> * Ard Biesheuvel
> > On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
> 
> If the executable is purely static, it does not need to have PLT. All
> calls to a PLT can be redirected to the function itself.  Some range
> extension thunks (other terms: stub groups, veneers, etc) may still be
> needed if the distance is too large.
> 
> There are cases where a GOT cannot be avoided, e.g.
> 
> extern char foo[] __attribute__((weak, visibility("hidden")));
> char *fun() { return foo; }
> 
> If foo is a SHN_ABS, `movq foo@GOTPCREL(%rip), %rax` can't be optimized
> by GOTPCRELX (https://sourceware.org/bugzilla/show_bug.cgi?id=25749 binutils>=2.35 will be good)
> Many other architectures don't even have a GOT optimization.

Urk -- the example given in that bug report isn't even weak. Are you
guys proposing to pessimize every access to a global symbol, regardless
of visibility, by going through the GOT on the off chance that somebody
might define one of them as SHN_ABS? Can we at least gate it behind
something like __attribute__((might_be_shn_abs))?

> 
> >I don't think it's really relevant for the kernel build -- all we get is
> >ld -static --no-dynamic-linker, all -static does is prevent searching
> >shared libraries, and we already pass --no-dynamic-linker if it's
> >supported.
> >
> >[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81498
