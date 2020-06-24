Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C339C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03072206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNA6AWzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgFXHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgFXHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:40:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:40:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so1021361pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZjFgd7MYI2dHNgHaw1XgA8rETt57Q052rzjGYBMB+dc=;
        b=cNA6AWzFxJlRgnAaib3oOtJuR4F72L8/dpeH5qIUy5F9BBBCoSa2eE/MkJurridSQA
         zxE68LDinwkYqUj9hqLTFgu/aGoFGpunFqB4RtGr1ePuj0Wc5O6QcV7rtoh+A1tkpgol
         f+Re6nImXYLR0owDD2eLMwBJN7XUfBZOE/LoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjFgd7MYI2dHNgHaw1XgA8rETt57Q052rzjGYBMB+dc=;
        b=hPaxkNcJrBfbm4aTNRJYzDB9QB9hO+pppnMAwxS68quwRLrgGX4IAvMYhAEpfNjh+K
         VzLn+lrAEVgY87C5DWOKu+djK48rjqiOI/HNCMfMOb2Lccv57xJYLUO8N96jCmsgruVI
         UhU5AHM/ZyHAJjvVS02ucafVY05aEh3sjHi9D4bqiO3sdOJfWEUKNdo6LBuamDdFUbJv
         657ZXLM9qQ+PM+8IhhPtgh3Smx6C2whVq5SiezKQG2rFJwO6DnUvmG+WFyTR4nBCLXFe
         sWHwX6PDrL67L6evae/Mc+Uql5p4hoJUdKruTFxT7oeW/QHxI7uwonDW7lWPiNlBF2lm
         F3Fg==
X-Gm-Message-State: AOAM530Efz8lfcaKYOSOG0An5MxJvY+4qh49Qcmiwv5FLbCpfBmajfRb
        yN5/F3ab1gyCP1Dgl7OOIsNKDg==
X-Google-Smtp-Source: ABdhPJz6lWBy+r+L9baXGHSjjxMmjx707wUWhbPXLXy/Aa3CnBUACvPWdZDZmeukBISeqptmQpFI8A==
X-Received: by 2002:a63:f541:: with SMTP id e1mr20175113pgk.375.1592984431665;
        Wed, 24 Jun 2020 00:40:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f131sm14942421pgc.14.2020.06.24.00.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:40:30 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:40:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v3 00/10] Function Granular KASLR
Message-ID: <202006240030.60C3490@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-1-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:17AM -0700, Kristen Carlson Accardi wrote:
> Function Granular Kernel Address Space Layout Randomization (fgkaslr)

I've built and booted this successfully with both GCC/bfd and Clang/lld:

gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0
GNU ld (GNU Binutils for Ubuntu) 2.34

clang version 11.0.0 (https://github.com/llvm/llvm-project.git c32d695b099109118dbd50dd697fffe23cd9a529)
LLD 11.0.0 (https://github.com/llvm/llvm-project.git c32d695b099109118dbd50dd697fffe23cd9a529)

Tested-by: Kees Cook <keescook@chromium.org>

Clang + objtool is a bit noisy, but I haven't investigated why:
kernel/panic.o: warning: objtool: .text.nmi_panic: unexpected end of section
kernel/panic.o: warning: objtool: .text.__warn_printk: unexpected end of section
kernel/cred.o: warning: objtool: .text.exit_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.get_task_cred: unexpected end of section
kernel/cred.o: warning: objtool: .text.cred_alloc_blank: unexpected end of section
kernel/cred.o: warning: objtool: .text.abort_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.prepare_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.copy_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.override_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.revert_creds: unexpected end of section
kernel/cred.o: warning: objtool: .text.prepare_kernel_cred: unexpected end of section

And when interacting with my orphan-section series[1], this patch is
needed to keep from getting A LOT of warnings. ;)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index af3d004d9a7e..de687ffa4966 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -57,9 +57,14 @@ ifndef CONFIG_FG_KASLR
 	endif
 endif
 
+ifndef CONFIG_FG_KASLR
 # We never want expected sections to be placed heuristically by the
 # linker. All sections should be explicitly named in the linker script.
+# However, without a way to provide a wildcard mapping from input
+# sections named .text.* to identically named output sections, this
+# can only be used with FGKASLR is disabled.
 LDFLAGS_vmlinux += --orphan-handling=warn
+endif
 
 #
 # Prevent GCC from generating any FP code by mistake.


[1] https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/

-- 
Kees Cook
