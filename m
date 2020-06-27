Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A86C208B6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jiwENKYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgF0PoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0PoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:44:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D4C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:44:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so5970473pfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ahst1LcMGvptdzipciPn0ZwzebgDhHbEcFE0yzAK/o=;
        b=jiwENKYxefqPrFkfjnTPCIT0ryoMIBZ0MbhwjWEweX5EGllbIIYLBnJdM3q90H5+aw
         bPapNDFocd2S6j6dhXBeBJA2DKsdT/GNVuR3sosrYL0XxP6KiXmXmqdNFWyw2s8SpXoz
         tnCehRhI1hZsjMpmTDwQdVzvyhWHEkdXgWQ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ahst1LcMGvptdzipciPn0ZwzebgDhHbEcFE0yzAK/o=;
        b=tHc35f7Kf2M01SIsSgYD+b/FBKNEiJy/X6EXxDoLF2ALrlwuPdqJElGvEY+v0m4NHl
         ZPrExYFzSoLonPaZ+JTqA9zIxdGZuZjRDFvm0m4S7uqRtr3bkcQw+vq96+OPiN8FRETU
         AwruiPJxIVeWZDW4S1mVPVa/gF/QeDeywn00IpB0RCRNkhDi2zqVgduuIgzH2iaY1YMY
         nuNNPyaFfbOR7fzVZ9D3hflhFdY1rqBHHsU6HJ2idGc34z2yxT3OPpAOPBkl/7Qa93ij
         26CY0SnCJeoLVUDQyLWTz2/j/7TbakLxk7Tlmi32v8MkHBOxvBjJFXIRfWq19zLNKJXt
         bZoQ==
X-Gm-Message-State: AOAM530gvvPqUlh+7Pw+FLiUZXkfyQwOb3zraBYgsFndK6y/QpdgetCS
        +3G7y1e634AfhK2mizCATlW0YQ==
X-Google-Smtp-Source: ABdhPJxqF5OY/T7436acgnQIOSWxsZPiRH3viVr7XZyoJ90uqTybtRX5sbzeL5U4g2x4LJpPIxJ2Ww==
X-Received: by 2002:a62:1790:: with SMTP id 138mr7148783pfx.306.1593272651229;
        Sat, 27 Jun 2020 08:44:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l134sm25302847pga.50.2020.06.27.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 08:44:09 -0700 (PDT)
Date:   Sat, 27 Jun 2020 08:44:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 4/9] x86/build: Warn on orphan section placement
Message-ID: <202006270840.E0BC752A72@keescook>
References: <20200624014940.1204448-5-keescook@chromium.org>
 <202006250240.J1VuMKoC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006250240.J1VuMKoC%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 02:36:27AM +0800, kernel test robot wrote:
> I love your patch! Perhaps something to improve:
> [...]
> config: x86_64-randconfig-a012-20200624 (attached as .config)

CONFIG_KCSAN=y

> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 1d4c87335d5236ea1f35937e1014980ba961ae34)
> [...]
> All warnings (new ones prefixed by >>):
> 
>    ld.lld: warning: drivers/built-in.a(mfd/mt6397-irq.o):(.init_array.0) is being placed in '.init_array.0'

As far as I can tell, this is a Clang bug. But I don't know the
internals here, so I've opened:
https://bugs.llvm.org/show_bug.cgi?id=46478

and created a work-around patch for the kernel:


commit 915f2c343e59a14f00c68f4d7afcfdc621de0674
Author: Kees Cook <keescook@chromium.org>
Date:   Sat Jun 27 08:07:54 2020 -0700

    vmlinux.lds.h: Avoid KCSAN's unwanted sections
    
    KCSAN (-fsanitize=thread) produces unwanted[1] .eh_frame and .init_array.*
    sections. Add them to DISCARDS, except with CONFIG_CONSTRUCTORS, which
    wants to keep .init_array.* sections.
    
    [1] https://bugs.llvm.org/show_bug.cgi?id=46478
    
    Signed-off-by: Kees Cook <keescook@chromium.org>

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f8a5b2333729..41c8c73de6c4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -195,7 +195,9 @@ endif
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+KBUILD_AFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b1dca0762fc5..a44ee16abc78 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,10 +934,28 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=thread produces unwanted sections (.eh_frame
+ * and .init_array.*), but CONFIG_CONSTRUCTORS wants to keep any
+ * .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KCSAN) && !defined(CONFIG_CONSTRUCTORS)
+#define KCSAN_DISCARDS	 						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+#elif defined(CONFIG_KCSAN) && defined(CONFIG_CONSTRUCTORS)
+#define KCSAN_DISCARDS	 						\
+	*(.eh_frame)
+#else
+#define KCSAN_DISCARDS
+#endif
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
+	KCSAN_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\

-- 
Kees Cook
