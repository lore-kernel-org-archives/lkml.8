Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E3820663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGuj7q/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgF2Uvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbgF2TN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5BC08EAD6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so7455337pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYEfxa7OKW4v9GzIhRwTOUIFBqV9srsfVDhYF/BxOH4=;
        b=UGuj7q/WS0KExRsg2CLBONUZs7T3XsjCMG/yvyLhtdKaUxcYROcvoBOHpNAFhy3W6X
         hRSrOBP/yNeMA7/dIhR3oCJW8Q2Ny4KVxmm6Vjh8bZXH5/6i5EtAUXUY8d0+u7DSSe3D
         eLJOO3rK0lYMIO5dti5mWzX97ev2/r072VzHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYEfxa7OKW4v9GzIhRwTOUIFBqV9srsfVDhYF/BxOH4=;
        b=cFFvtqG9f31iOrE6wXB745x6rI9WXboj4zFGMUo3RrE70CsnmuH+7zBNI75i5NMYqp
         6xMbHLzmjPp2G2MDgW4zE9JplgofjpVgZBOagUtCK+B0iAtPJ7BHOIXdw5xDhu5wPmSy
         oItohpnTRt1wMvA1R9qWlm23/H/r33Byc0y9NTbOFfhyzgSow0/Y6bfodYgoWero2WUy
         PO//uYNT1TJwXCGZxSYW1GhPd3brDK80VV2OJKAtSEFlpDbYEsSFM/emh+jFFBiFbuWu
         3GZ+H3Ch9mmj8xnJIY9vK9vmkS+dewZP7QjwE6nD2aY5T++vSYwyBjTh5OOnY2Czafd4
         KbYw==
X-Gm-Message-State: AOAM530ZmVwFxJpseZTuAwd0coIoQ8vEWPiNKVtlFjlKI1kq6EDv+sRZ
        W8J/YxmABZHCMv6zJXkFsA0r4QnioUA=
X-Google-Smtp-Source: ABdhPJw01U8lgdzVeHYlSAg3jRburoo7yEiQmP++SKqH4gvPoLztfxnPJpbsXaeAqVpc8BiwbFDEkg==
X-Received: by 2002:a05:6a00:148c:: with SMTP id v12mr12987122pfu.171.1593411524779;
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o207sm33243245pfd.56.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/17] vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
Date:   Sun, 28 Jun 2020 23:18:25 -0700
Message-Id: <20200629061840.4065483-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN (-fsanitize=kernel-address) and KCSAN (-fsanitize=thread) produce
unwanted[1] .eh_frame and .init_array.* sections. Add them to DISCARDS,
except with CONFIG_CONSTRUCTORS, which wants to keep .init_array.*
sections.

[1] https://bugs.llvm.org/show_bug.cgi?id=46478

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1248a206be8d..e53a2d4f47f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -927,10 +927,30 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * unwanted sections (.eh_frame and .init_array.*), but
+ * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+# ifdef CONFIG_CONSTRUCTORS
+#  define KASAN_DISCARDS						\
+	*(.eh_frame)
+# else
+#  define KASAN_DISCARDS						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+# endif
+#else
+# define KASAN_DISCARDS
+#endif
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
+	KASAN_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
-- 
2.25.1

