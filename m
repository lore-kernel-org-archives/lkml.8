Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7FB2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0rNlhVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgC0S1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:27:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44394 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0S1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:27:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so10724641otc.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mUgPEhhQcjfKASu4ovKrH+viuyNdfG4nZwjDD1Ymszw=;
        b=r0rNlhVimz1jLFP4LI5uNfJbXruYRsORoEQ0uyvX0mufWuM8CdPFKzLwq4qrJwOWhO
         uFle0oNx9vT9khT+B+CDzwhYESTBUcmysC9xEDxsq2tcOy43loZE7UtmxLjaazwY4rg8
         flx79GrN7yot+qtLDdKrdcF3vxg/xUme2bxdqLfQFInktyLoNg3hfId+VXqV+EHpNJGt
         /gOwF8cuoyzuG18OjUaiz8PH4dM2bgatOd6+7qoAyzxj4QMuic4HYtftQ2/bstRJBI6a
         zLAQEqh3wmcJzDKeyXqkMCi0YWiYm5h6rbvxCjDIUeNFwWVaRA9ZgsKOOoZtsqdklvOP
         BxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mUgPEhhQcjfKASu4ovKrH+viuyNdfG4nZwjDD1Ymszw=;
        b=WSYhAT3hkKlhuNDbiiVQ4gSfJbd6z6mHZkwJYyHundOZOcjZsW08K5h4OkH+vRZkOQ
         cHcoxX/uqD6pZumRoNOu3M7QPLQGrZ3h+KGLhBIW70saZzG5ytGQLPqZh1VcAO2nuIMs
         /WZ34Wxf4uarBDTeukUDgdXDZ7rBwUIaKVkbcCiiWbKWgsy7h+3bJGjX6XakaQHhIr/e
         wXPCnV9ImfF3LxaSA772UQO2QbSduMCgeNMUNyWnHStyMhIl0JSK54JB4asbBeoZvulI
         O6D3kqdpNfUDxZ/rkA4F4ZNGHUwN2xhh3DOLyxfq2MZS9AtuWtwlELSHjy9EOBjUU673
         5dwA==
X-Gm-Message-State: ANhLgQ1KBg/+5rQBjEViFSZ6JNEYqeUo+dcHOPA+wbKyJtSWQdI6YXR7
        0DrUni74o4BU5f2rbKDUTtg=
X-Google-Smtp-Source: ADFU+vtdpg8Fj9qWpoFZDCMJMpqvoI2Km1QbYSGsd9kgZPB7kySBYzo13mltBcCSQCDysnICymSguQ==
X-Received: by 2002:a4a:da48:: with SMTP id f8mr632811oou.44.1585333633780;
        Fri, 27 Mar 2020 11:27:13 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b2sm2094786oii.20.2020.03.27.11.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 11:27:13 -0700 (PDT)
Date:   Fri, 27 Mar 2020 11:27:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Clement Courbet <courbet@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v1] powerpc: Make setjmp/longjump signature standard
Message-ID: <20200327182708.GA13308@ubuntu-m2-xlarge-x86>
References: <20200327100801.161671-1-courbet@google.com>
 <f1b85a2a-1c60-9a12-f547-13ff255f18f0@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1b85a2a-1c60-9a12-f547-13ff255f18f0@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:45:21PM +0100, Christophe Leroy wrote:
> Subject line, change longjump to longjmp
> 
> Le 27/03/2020 à 11:07, Clement Courbet a écrit :
> > Declaring setjmp()/longjmp() as taking longs makes the signature
> > non-standard, and makes clang complain. In the past, this has been
> > worked around by adding -ffreestanding to the compile flags.
> > 
> > The implementation looks like it only ever propagates the value
> > (in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
> > with integer parameters.
> > 
> > This allows removing -ffreestanding from the compilation flags.
> > 
> > Context:
> > https://lore.kernel.org/patchwork/patch/1214060
> > https://lore.kernel.org/patchwork/patch/1216174
> > 
> > Signed-off-by: Clement Courbet <courbet@google.com>
> > ---
> >   arch/powerpc/include/asm/setjmp.h | 6 ++++--
> >   arch/powerpc/kexec/Makefile       | 3 ---
> >   2 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
> > index e9f81bb3f83b..84bb0d140d59 100644
> > --- a/arch/powerpc/include/asm/setjmp.h
> > +++ b/arch/powerpc/include/asm/setjmp.h
> > @@ -7,7 +7,9 @@
> >   #define JMP_BUF_LEN    23
> > -extern long setjmp(long *) __attribute__((returns_twice));
> > -extern void longjmp(long *, long) __attribute__((noreturn));
> > +typedef long *jmp_buf;
> 
> Do we need that new opaque typedef ? Why not just keep long * ?

Yes, otherwise the warning comes back:

In file included from arch/powerpc/kexec/crash.c:25:
arch/powerpc/include/asm/setjmp.h:10:12: error: declaration of built-in function 'setjmp' requires the declaration of the 'jmp_buf' type, commonly provided in the header <setjmp.h>. [-Werror,-Wincomplete-setjmp-declaration]
extern int setjmp(long *env) __attribute__((returns_twice));
           ^
arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of built-in function 'longjmp' requires the declaration of the 'jmp_buf' type, commonly provided in the header <setjmp.h>. [-Werror,-Wincomplete-setjmp-declaration]
extern void longjmp(long *env, int val) __attribute__((noreturn));
            ^
2 errors generated.

> > +
> > +extern int setjmp(jmp_buf env) __attribute__((returns_twice));
> > +extern void longjmp(jmp_buf env, int val) __attribute__((noreturn));
> >   #endif /* _ASM_POWERPC_SETJMP_H */
> > diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> > index 378f6108a414..86380c69f5ce 100644
> > --- a/arch/powerpc/kexec/Makefile
> > +++ b/arch/powerpc/kexec/Makefile
> > @@ -3,9 +3,6 @@
> >   # Makefile for the linux kernel.
> >   #
> > -# Avoid clang warnings around longjmp/setjmp declarations
> > -CFLAGS_crash.o += -ffreestanding
> > -
> >   obj-y				+= core.o crash.o core_$(BITS).o
> >   obj-$(CONFIG_PPC32)		+= relocate_32.o
> > 
> 
> Christophe
