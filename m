Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914142072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlR5zQFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHUTpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHUToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:44:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4853C0617BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j13so1248203pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuU6+2YeRUFxWKjj7Z5/wAYkCT2n/Otc0iy3c5gDK6c=;
        b=GlR5zQFUZPyZN2xj2JZwbsd+nhmW4YrsAiNDspKlZSHIVFCaiwpu22zpQk8g1mPkD4
         uL0gfTyd6RZ41fhOBJ8O7qPIY2yarQAieyWySyZtzw9F84HAFF/dGTHkR8qjcoeeFhLR
         kxmlF5bkG7LX0OWEqpt9f6F/IKJimzW3fMjFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuU6+2YeRUFxWKjj7Z5/wAYkCT2n/Otc0iy3c5gDK6c=;
        b=qK4knpZSykrczYel3q1LAX1MxAmMtNlWPcPy9BIq1dEnePaOa1Id0Je5o5hOKv3Z2B
         HAH/qcEFGpPOWL7IpkIC73FJJCUNzooVRlQu6Y6jDU4rAFgROs2G1StcZFQyIOaFHO4A
         OrRWDZYMHXaIpfGqMCwPGfKcNzBS5C4N+gQzJA8u3MRjH5G0xSwzOPBBNp1lwnPE3OJN
         ECeXgZz9wMv4UMDdgOvfQUl2xTBHyaTcJTdeI6vI3pfxA9miW1KKSJILU+2ZATkUZ89y
         5n/ASK/be4DfcgVnyMm+IQw4CdbvHFGh3QfGL87iMICZBypAlnBWE0x03hcDsM68iHmr
         BzhQ==
X-Gm-Message-State: AOAM531BB6cP/gTlUEiciF/L95eQ/Ae8ZbsV+UoVler85eAinHJKXMSO
        B8VIWShSaGT4UOAszdXA6C1gLg==
X-Google-Smtp-Source: ABdhPJwhqJDgxru2YIkrhKiac4wFZ7e/7/Sgw8YpVmg5RV/C1Br7xa8dVv+HqKXZX/CaKWJr+nVfqg==
X-Received: by 2002:a17:902:b686:: with SMTP id c6mr3542403pls.133.1598039069315;
        Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm3442830pfq.146.2020.08.21.12.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
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
Subject: [PATCH v6 11/29] arm64/build: Use common DISCARDS in linker script
Date:   Fri, 21 Aug 2020 12:42:52 -0700
Message-Id: <20200821194310.3089815-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
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
index c2b8426bf4bd..082e9efa2b43 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -88,10 +89,8 @@ SECTIONS
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
 	}
-- 
2.25.1

