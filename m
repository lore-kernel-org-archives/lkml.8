Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7FC35DF7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B624689
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNMuINYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgBYFNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43961 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBYFNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so6271811pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFgEd5ihB5mpYJHgTJ73YmLe+8HUk6ELkCILmCi0oOk=;
        b=FNMuINYqjkWcMKmsC54Bq/gTZBk8TfWE/kHSeHazPaZ6Qsgq4UEwtaKxNjx3U/LSOL
         lSxriB94mOtmP7ZumY1pLpyXNh1eiELD+deo2AfzoltvtXbJresnxC13IfnGI7/zF0u8
         gfw7+zy+BpP4vi9hf0mYsgj0+sBmXM2UX7Dlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFgEd5ihB5mpYJHgTJ73YmLe+8HUk6ELkCILmCi0oOk=;
        b=CmF0hHovJCU5yDRxBH0shhA3bbUbrDvNq609gTIRNveoQYla3WyYJYAJeu/wvk9k6j
         61pXqQ0HMHv8m/Q3V5q1pMa+rGreVDohyc3VRgBSp79Cfutv3BR289BSk2cDcYM1V6ym
         LmkyANADzwDIox90tWGg9+O/yLxf5oeKoQ74tKZKXQC43FFmH4e1ntd5Nw+pA0CiCi5w
         ifZytMq3l5s9GyJHE5StIm4lfF67sjPEl9OccDeTgyawYT3znuv6ArTecfL4pRAYLkMp
         /Ucf/l2VEaeUEJiZmzZzhhpmS6bfehJDmvhwVS+zUYubNzwo0YJbMokK6987Sb4ZnmAl
         umWw==
X-Gm-Message-State: APjAAAU+PVovzWzHP6LWONVYOyVw1crguRkIVjekVGC488ITLAcqLHkF
        2ZroEYqTj/YJUBbt4NXnqO7EZvG3i/U=
X-Google-Smtp-Source: APXvYqwchftXeveUuXJHknSGejturvoBpu91/DIibP3TqJfUAAo+U3HXFzD6DGyObdeKZ5MP3RURPQ==
X-Received: by 2002:a63:5b54:: with SMTP id l20mr19043243pgm.324.1582607596247;
        Mon, 24 Feb 2020 21:13:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm14695804pfa.16.2020.02.24.21.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Mon, 24 Feb 2020 21:13:07 -0800
Message-Id: <20200225051307.6401-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225051307.6401-1-keescook@chromium.org>
References: <20200225051307.6401-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With arm64 64-bit environments, there should never be a need for automatic
READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
(as in, the default memory protection should be NX unless a region
explicitly requests to be executable).

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 fs/compat_binfmt_elf.c       | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 03ada29984a7..ea9221ed68a1 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -105,7 +105,7 @@
  *             CPU*: | arm32      | arm64      |
  * ELF:              |            |            |
  * -------------------------------|------------|
- * missing GNU_STACK | exec-all   | exec-all   |
+ * missing GNU_STACK | exec-all   | exec-none  |
  * GNU_STACK == RWX  | exec-stack | exec-stack |
  * GNU_STACK == RW   | exec-none  | exec-none  |
  *
@@ -117,7 +117,7 @@
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex,stk)	(stk == EXSTACK_DEFAULT)
+#define compat_elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index aaad4ca1217e..3068d57436b3 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -113,6 +113,11 @@
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
+#ifdef	compat_elf_read_implies_exec
+#undef	elf_read_implies_exec
+#define	elf_read_implies_exec compat_elf_read_implies_exec
+#endif
+
 /*
  * Rename a few of the symbols that binfmt_elf.c will define.
  * These are all local so the names don't really matter, but it
-- 
2.20.1

