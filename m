Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6931F20836
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLAgtFMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGaXSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGaXSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so7287755pfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYWiGkzrodMZw8E6moJnKNf+2pJurSr6gU0bXIJriLs=;
        b=XLAgtFMgltivYzdrmr7mPeCf/STVStGznvQ9AetuyotpG77ihapGJPSOw6e/9bGeJC
         hnPfgK4hvRPSwIXsU3jsGjxizKoPAk/GU0DAj6GDqHdxtQmLultetRDJHUsYBQ5wLmRe
         GyZCYcSM9scCXDQH2r7rsPLe7prnm0EXpd4kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYWiGkzrodMZw8E6moJnKNf+2pJurSr6gU0bXIJriLs=;
        b=GQs+tHlDS94KDMAop/7JwgqXgbVtIBHcgk9nUn8aAN0pyskebqVlRgUa8d/c020Om6
         nxsj7eakTMpy03XCwnRvu7vK7IP1gzLI9124cVmk21V0LztiqX6eLNoMXbqtmmRSFEAk
         hAuzFsOPWjzLKNhmAv8D4y/gIw08uWQWgHEI+LrgYQCxNUu8XVAWKR39viIoOptfb4so
         ErUVwRgwnwI+/y92IX4HzCfbTB9wnLMhmCFEdn3ftACPJz0a+1GgD/2LgpkvCtbDaTfj
         09LbQwF9XA+T+n7aaxVhffcqynQBAhbW4NoXTJn2SoSXddNdH2fFlLJszS5ZJA2yaD2C
         +SEQ==
X-Gm-Message-State: AOAM5311CGLk4+y+9sTzJnyGyQkI3Q1guHLApc8rEasOvhwmySSZDgSh
        x9eGtYfhbxtOA9V03c07wAgUkA==
X-Google-Smtp-Source: ABdhPJwz7lNV75l53ANINXJYmgu5YglRuap1WdUm9GJ6Hh16kc46QlK2SQ2/0EKz7ozsRQIWIWRvRg==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr5904939pfc.134.1596237492142;
        Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7sm6300502pfl.156.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 28/36] x86/asm: Avoid generating unused kprobe sections
Date:   Fri, 31 Jul 2020 16:08:12 -0700
Message-Id: <20200731230820.1742553-29-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !CONFIG_KPROBES, do not generate kprobe sections. This makes
sure there are no unexpected sections encountered by the linker scripts.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0f63585edf5f..92feec0f0a12 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,11 +138,15 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_NOKPROBE(entry)					\
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
 
 #else
 # define _EXPAND_EXTABLE_HANDLE(x) #x
-- 
2.25.1

