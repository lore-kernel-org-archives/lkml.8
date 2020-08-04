Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AAD2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgHDXsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:48:22 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:36682 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHDXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:48:20 -0400
Received: by mail-qk1-f173.google.com with SMTP id g26so40191396qka.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QvfEfO8IBghnaUgLlFqd4u0DuhzyDQws42YHmBxEAY=;
        b=H+SKMvD2/36JBAczBBMikRbJkbLPQkZADg64YHezBrU1fLRY2p+wLqG+akX++aHwSK
         t+CaZwYfp1u1lj4vO2TtbY6E/spMHXI0dmfs+C8IuCALfVo3BLnuUndwhs2MdezNddb6
         qhsr0ayDqYn9fnQm+xbuuaXgGX8fUvyFpsflK8m22ijUY/A3EetOtH0j/82cpmn3wBy8
         H99tXgt5vXE3owVStid9j9ZzyPUWG5WcPCvVNNNDl0q7C5L9YdYDobF70lfGm3AJB2hO
         lPKqwHlDDNq5ShG6z90Z9SYmuBT6YzTYx7MVqvehNtWNoa8BOT2no0lYZRG+5tdj/C2A
         DWbg==
X-Gm-Message-State: AOAM532Q9zryLUaxvLw5a60dhx602sC+6rw69qLZx3HVY50PA5UU11hC
        oIXUCNr1I6L4ZkxuqDoFDyQ=
X-Google-Smtp-Source: ABdhPJztCo7YGwrnK5E46QW6jjqevLYJ3RxyHFm6E89jKmniqxGKDuuKx113XdkYVrKGFJQAv3Wccg==
X-Received: by 2002:a05:620a:128e:: with SMTP id w14mr692046qki.97.1596584899709;
        Tue, 04 Aug 2020 16:48:19 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e61sm526475qtd.20.2020.08.04.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 16:48:19 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <xiang@kernel.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Subject: [PATCH 1/1] x86/boot/compressed: Use builtin mem functions for decompressor
Date:   Tue,  4 Aug 2020 19:48:17 -0400
Message-Id: <20200804234817.3922187-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804234817.3922187-1-nivedita@alum.mit.edu>
References: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com>
 <20200804234817.3922187-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commits

  c041b5ad8640 ("x86, boot: Create a separate string.h file to provide standard string functions")
  fb4cac573ef6 ("x86, boot: Move memcmp() into string.h and string.c")

the decompressor stub has been using the compiler's builtin memcpy,
memset and memcmp functions, _except_ where it would likely have the
largest impact, in the decompression code itself.

Remove the #undef's of memcpy and memset in misc.c so that the
decompressor code also uses the compiler builtins.

The rationale given in the comment doesn't really apply: just because
some functions use the out-of-line version is no reason to not use the
builtin version in the rest.

Replace the comment with an explanation of why memzero and memmove are
being #define'd.

Drop the suggestion to #undef in boot/string.h as well: the out-of-line
versions are not really optimized versions, they're generic code that's
good enough for the preboot environment. The compiler will likely
generate better code for constant-size memcpy/memset/memcmp if it is
allowed to.

Most decompressors' performance is unchanged, with the exception of LZ4
and 64-bit ZSTD.

	Before	After ARCH
LZ4	  73ms	 10ms   32
LZ4	 120ms	 10ms	64
ZSTD	  90ms	 74ms	64

Measurements on QEMU on 2.2GHz Broadwell Xeon, using defconfig kernels.

Decompressor code size has small differences, with the largest being
that 64-bit ZSTD decreases just over 2k. The largest code size increase
was on 64-bit XZ, of about 400 bytes.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Nick Terrell <nickrterrell@gmail.com>
Tested-by: Nick Terrell <nickrterrell@gmail.com>
---
 arch/x86/boot/compressed/misc.c | 7 ++-----
 arch/x86/boot/string.h          | 5 +----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 39e592d0e0b4..e478e40fbe5a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -30,12 +30,9 @@
 #define STATIC		static
 
 /*
- * Use normal definitions of mem*() from string.c. There are already
- * included header files which expect a definition of memset() and by
- * the time we define memset macro, it is too late.
+ * Provide definitions of memzero and memmove as some of the decompressors will
+ * try to define their own functions if these are not defined as macros.
  */
-#undef memcpy
-#undef memset
 #define memzero(s, n)	memset((s), 0, (n))
 #define memmove		memmove
 
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 995f7b7ad512..a232da487cd2 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -11,10 +11,7 @@ void *memcpy(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
 
-/*
- * Access builtin version by default. If one needs to use optimized version,
- * do "undef memcpy" in .c file and link against right string.c
- */
+/* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
 #define memset(d,c,l) __builtin_memset(d,c,l)
 #define memcmp	__builtin_memcmp
-- 
2.26.2

