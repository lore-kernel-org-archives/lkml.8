Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CB92076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dXhvjxgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgFVW14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbgFVW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so9073970pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JI0wkwVCNwXzxyeXGfReWogDJ8TItG8DNO4AEUQrZHU=;
        b=dXhvjxgsKaYVqQPZKIedonRiQSDzKyvMILv82JolQOk3j6k4i+l8LLeVQR0zMdWyMF
         NV4K5H1nj1Fe6XqV4PoiAxy70HQrCiGYUADhUS3shyAnm3nLjJyCum+9jvjgntLPNBNg
         s10y2Bg2EUA1xvV2Tk/e1CQRLU91b62R9aXyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JI0wkwVCNwXzxyeXGfReWogDJ8TItG8DNO4AEUQrZHU=;
        b=lY+jhLAAkW0s5zaCgnzwY2ubhKuFHOMDJAgaF69emS62NIJ0r3KIb2fG1nBvU6Fq00
         mbzI7KV15s0rTNzlSl1Q83WgN/L+fYvqxCNLgVijqzG9R3bDOWaJWx8LjQ0R5TAU33ww
         eOONltEYqzehFRcuG45ESKYC9A+cnPqDEKZRuKfGjR5Pq/EEQFPD+RtToLHm134ua2EP
         P4BKUKti086nloXdeBVKYNvn+AU0/lROhUkj4IL2OMAXwyl+m7LdIM0Vrf+fl4+ilGHT
         OmIXAYiWF1sgX8LAbOSeoXq3ZSh97LUg++U7FNii/ZoOrHfCQ9djnsZNLEVlgQhZbXUE
         V1xA==
X-Gm-Message-State: AOAM530Lu3W4dOIzHXunjR6iaLI1hOK4iBryqxcS7ap6TWayFMj+zL48
        LmOVMSUNer8kTtv5uEo05sssVw==
X-Google-Smtp-Source: ABdhPJw5Vi6XCzy6KcvEhS8a1/qSQm1bAo70j7dQ+DEeYLhkCjl8U+R/8n9cXiPZR7Z/RPMXOKbyzA==
X-Received: by 2002:a62:2743:: with SMTP id n64mr21722151pfn.163.1592864869777;
        Mon, 22 Jun 2020 15:27:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7sm453463pjb.41.2020.06.22.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:49 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:27:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221524.CEB86E036B@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220043.6j3vl6v7udmk2ppp@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > For vmlinux linking, no architecture uses the .gnu.version* section,
> > so remove it via the common DISCARDS macro in preparation for adding
> > --orphan-handling=warn more widely.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > include/asm-generic/vmlinux.lds.h | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..6fbe9ed10cdb 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -934,6 +934,7 @@
> > 	*(.discard)							\
> > 	*(.discard.*)							\
> > 	*(.modinfo)							\
> > +	*(.gnu.version*)						\
> > 	}
> > 
> > /**
> > -- 
> > 2.25.1
> 
> I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

This looks like a bug in bfd.ld? There are no versioned symbols in any
of the input files (and no output section either!)

The link command is:
$ ld -m elf_x86_64 --no-ld-generated-unwind-info -z noreloc-overflow -pie \
--no-dynamic-linker   --orphan-handling=warn -T \
arch/x86/boot/compressed/vmlinux.lds \
arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
-o arch/x86/boot/compressed/vmlinux

None of the inputs have the section:

$ for i in arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
; do echo -n $i": "; readelf -Vs $i | grep 'version'; done
arch/x86/boot/compressed/kernel_info.o: No version information found in this file.
arch/x86/boot/compressed/head_64.o: No version information found in this file.
arch/x86/boot/compressed/misc.o: No version information found in this file.
arch/x86/boot/compressed/string.o: No version information found in this file.
arch/x86/boot/compressed/cmdline.o: No version information found in this file.
arch/x86/boot/compressed/error.o: No version information found in this file.
arch/x86/boot/compressed/piggy.o: No version information found in this file.
arch/x86/boot/compressed/cpuflags.o: No version information found in this file.
arch/x86/boot/compressed/early_serial_console.o: No version information found in this file.
arch/x86/boot/compressed/kaslr.o: No version information found in this file.
arch/x86/boot/compressed/kaslr_64.o: No version information found in this file.
arch/x86/boot/compressed/mem_encrypt.o: No version information found in this file.
arch/x86/boot/compressed/pgtable_64.o: No version information found in this file.
arch/x86/boot/compressed/acpi.o: No version information found in this file.

And it's not in the output:

$ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
No version information found in this file.

So... for the kernel we need to silence it right now.

-- 
Kees Cook
