Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85EEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5FA2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf+M0O6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgF2T2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgF2T1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3C8C031402
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:01:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i3so13344738qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBaB3ONto8Q3Q5gLaEO5EL36PXLUdQ/UsO2Jrx2+HW4=;
        b=Uf+M0O6i9tiJtvyuXdusyRUSR71H1m7gcjbAX6KfnZA5rM1WxK02GX2bCyvesE65iU
         5GVmAx/92SZK1Lyh7utBtPUS167hY4EsTTqXFA1cEJ+lhSfB8dampRNvLp14WUhgdeUa
         mEaXB4F1mW4B0XvsiQrE+znEJ53HEzfw+ubVSZ9wqA8ZuLEyD9VZFGh7O+My9ybeZtfx
         eqwzBaE1sJyt4DULJgOpLzGbRzHQVJQRtUZ3o5ArHYCi8VSZpAlQc56Ujzy980iJblme
         IdiXS5kWWv5Bp4pLRykpuCfOvhjAO1vdAC7NsHmP7tVYKD+PoHT002v2f5/WS4vMqLVm
         M8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UBaB3ONto8Q3Q5gLaEO5EL36PXLUdQ/UsO2Jrx2+HW4=;
        b=lvRH4fUqyomqVvm3r0YKft+i8BPWP/OcWx2NKwWeHd2ccJrHci6tA4ohTFkKP6eQi0
         Rfm8XH9Crh6BVM71k6JjjS7NqHrLRy+dp4adChtM6sjoMVwIVARZprTRECkYLJpoBdrG
         UuFlegCn4hbsSXwStfUviVOq+edPPZ/p1xQMiKEFrsWtyoF4tKL+aU50czQeTz8fZBpU
         Zxrr2yW2j43HIFc90KbSK6qBLaElA/HMwEnz5ARHPfT6wUkPbyd4wpJOcgPpZH19FU83
         L9IOdJ50Gsp5/gK/bBCisQH79y1Gy2LQgmaP35njZJ6btoLKJySTDsc1/q/hKBM7EoZt
         S4pQ==
X-Gm-Message-State: AOAM530i1eL+ZcDsQ+Pxx1wiYXlrKYZAXSCWjghjTOFON7pkUDMoSETn
        d9MpoPTQL7wK4nGYNHx7fUo=
X-Google-Smtp-Source: ABdhPJyzjG5GgBBEYVC8Urgkm5x8J/QJlI3PEfDttafNSqjwSYIB1DmkVO+Gdk156efisAsHejvhTw==
X-Received: by 2002:ac8:794d:: with SMTP id r13mr16071834qtt.314.1593450101660;
        Mon, 29 Jun 2020 10:01:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j9sm218667qtr.60.2020.06.29.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:01:41 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 13:01:39 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] x86/boot: Remove run-time relocations from
 .head.text code
Message-ID: <20200629170139.GE900899@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-6-nivedita@alum.mit.edu>
 <202006290859.14DD408A29@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006290859.14DD408A29@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:04:04AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 10:09:26AM -0400, Arvind Sankar wrote:
> > The assembly code in head_{32,64}.S, while meant to be
> > position-independent, generates run-time relocations because it uses
> > instructions such as
> > 	leal	gdt(%edx), %eax
> > which make the assembler and linker think that the code is using %edx as
> > an index into gdt, and hence gdt needs to be relocated to its run-time
> > address.
> > 
> > On 32-bit, with lld Dmitry Golovin reports that this results in a
> > link-time error with default options (i.e. unless -z notext is
> > explicitly passed):
> >   LD      arch/x86/boot/compressed/vmlinux
> > ld.lld: error: can't create dynamic relocation R_386_32 against local
> > symbol in readonly segment; recompile object files with -fPIC or pass
> > '-Wl,-z,notext' to allow text relocations in the output
> > 
> > With the BFD linker, this generates a warning during the build, if
> > --warn-shared-textrel is enabled, which at least Gentoo enables by
> > default:
> >   LD      arch/x86/boot/compressed/vmlinux
> > ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-only section `.head.text'
> > ld: warning: creating a DT_TEXTREL in object
> > 
> > On 64-bit, it is not possible to link the kernel as -pie with lld, and
> > it is only possible with a BFD linker that supports -z noreloc-overflow,
> > i.e. versions >2.26. This is because these instructions cannot really be
> > relocated: the displacement field is only 32-bits wide, and thus cannot
> > be relocated for a 64-bit load address. The -z noreloc-overflow option
> > simply overrides the linker error, and results in R_X86_64_RELATIVE
> > relocations that apply a 64-bit relocation to a 32-bit field anyway.
> > This happens to work because nothing will process these run-time
> > relocations.
> 
> Are any of Thomas Garnier's PIE fixes useful here too? He had a lot of
> fixes to make changes for PC-relative addressing in the various
> assembly bits:
> https://lore.kernel.org/lkml/20200228000105.165012-9-thgarnie@chromium.org/
> 

The case there is somewhat different -- he needed to convert non-PIE
code into PIE code, and has to worry about the distinction between
physical and virtual addresses. Here we actually already have PIE code,
so the assembly doesn't really have to change.  It's just a matter of
being more precise so that the toolchain understands that it's PIE, and
everything is identity-mapped so it's simpler.
