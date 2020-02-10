Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E541C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B420838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dq23bl6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgBJTbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:31:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38124 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBJTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so7565438oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhYTjIJlfhAdVkQDwNkbgCuN+O7kJMRLXmPZSNfrFMQ=;
        b=Dq23bl6vQ5GYWu+qXbbm3ywpJuoquMABzduG3ja8SrHuEWakgb5g99LQjU9/o1Dasx
         BSdy+vt620n5X/zV49LCGyY1+af2KOLd6H9OKdhofiuqC49AzF8MrE82v122cbzl6q+1
         5NFBliiePxKLKssh2fiNiQKRiSvwHByvjxNnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhYTjIJlfhAdVkQDwNkbgCuN+O7kJMRLXmPZSNfrFMQ=;
        b=cbC/I8YMDiF2UWTF2HegKEAydntyVPf40u/EvJdWUorVLW9e3Luz7xxqhuTvBH7iX2
         SThtqp8eOjQtz2hCJ0RNdTxh6xDAKvFNFSBN+kCnmmnx3BUQDP6aDKSe5R4gIAjoo00S
         FlNJmweHkdf3X1anwiaLVyBOLN6Ba4SfWS7gPNW0JhSuDcs07nijMKwa8a4yj8VbR9yt
         MT2uLDFAIz49ePjGSMBQ5gt2h2d9THXoCQtgy7zxT81QttlndKkuQAqdDgSkoMm2m95p
         6G65l4p6hYxkqzblGxHmZ5SOrqQWZzI6Dnl4Un+7yJMELxVcVSanfexifJ0s/YX1zhV+
         PzRw==
X-Gm-Message-State: APjAAAXZtArcQfJe0rPfff9mxG6+ZpqP1egtH3IikRTe/JnCh1Xm+dbt
        Hsj3AQpKMnXG+iwTDKcCJzB0wg==
X-Google-Smtp-Source: APXvYqwa0CUBeygnsizZAtkXo0YElyu1+Z7uLDxN7c38yNFFZ5699HBdDmcdJAXUU7zBCJHjZcCrcA==
X-Received: by 2002:a9d:7508:: with SMTP id r8mr2262030otk.116.1581363063188;
        Mon, 10 Feb 2020 11:31:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t22sm416199otq.18.2020.02.10.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:31:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/7] arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Mon, 10 Feb 2020 11:30:48 -0800
Message-Id: <20200210193049.64362-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
References: <20200210193049.64362-1-keescook@chromium.org>
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

