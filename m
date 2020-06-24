Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE22078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j28MIPdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgFXBuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388542AbgFXBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:49:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01459C061798
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so327165pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=j28MIPdYYt3rY4/fE2dihfZR9TtTRv8EMgAkzm1ilSN6UZi55d+226fwO0IcvhUj4K
         vHHrxFoODLtRR/epcOqkEuSfW+ofLwENnqR5DFbYOepfBQg9RkNmTQqNF+kXA9wtnTS1
         Tk9UTZMAwnTwdOtIjCCjIuRRK9aYxJ1pREKZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=hCN0HfVIKRHk0fnvGqPR51y84i4ZiZ62Gzf94ZwZ3wosgLm/r+Sz4qqoWoAF6bnssU
         bYTKW9OoxSOWmtrMtO0SZLlfsmGV4gAWMoeYfv0Uf+K30zq9nOJNuXMBISzAydzL1URi
         9E2mfMT2k+JB4L/2ruI786OO+/QgMYYEopgID8JHPEKNByuLp+vFHMKBUaiaeOiq5MbE
         q66sMErAZXVtDaC7GeKMRkjS2h3Ol5wLIYBv9tvitbngoRs7oIHZNj5Yn58FRDk4X+m0
         MtiE8T1BTpYD621asAyglY7gY8VSE7yJkXj5Ofb49eXh+4qRLcKA7CZhQVS86svrmO1Z
         5Zdw==
X-Gm-Message-State: AOAM5334I8/CiaCoaeJkkqFXTYRzIyVkndf31/P/NNLp8tb2DbGC/SK/
        uxt+yk6z4e03nsWpHRh1fzMDHQ==
X-Google-Smtp-Source: ABdhPJx8Traz2lKjHxXn0KSX6VTp95qm0SkAntTLnpPXidTYMSKWi0+Ran7jdJt/zuP45e018upD0A==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr24514257pjf.187.1592963394576;
        Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cv3sm3283177pjb.45.2020.06.23.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
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
Subject: [PATCH v3 8/9] arm64/build: Use common DISCARDS in linker script
Date:   Tue, 23 Jun 2020 18:49:39 -0700
Message-Id: <20200624014940.1204448-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..5427f502c3a6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -89,10 +90,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.25.1

