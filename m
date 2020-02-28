Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3311A246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V36B51rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgB1AW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:22:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgB1AWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id i13so735639pfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njo/Fx4CsF+NQ0G1u7AY1RWSg6ZNLRJXLnHS1KzoDiw=;
        b=V36B51rI6uTfIFQ393op65AYhJqQDQrYEJ6cMpkwv1fytwIQq5RcV2b2ckkCtE1sw0
         YM1LYtZD4DrhdU/Ea540khr3HPTpC+38/5GLj40jxxNahTYQDym9BttSb/i6IQdZFITg
         acSRiJiho/Jbfz/18SE8Y1nmC78EHYUE05Ibw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njo/Fx4CsF+NQ0G1u7AY1RWSg6ZNLRJXLnHS1KzoDiw=;
        b=CPx1cTXezQF1CV5BXFkve/jFZRdW26xVXPFiorf3H8mpBKzQGcpyvwyQk8HcBj3qlS
         AImHu04E1qnGkUmYucTmm6R9cUg569Ce+FdeyhtojlQ1BlsOVeOGnYICHSLNQx/ufHeK
         ZbVnZb6nxdmflee2jrVMK1UEjt4UI/GUqaGG/0ZkAhgwz5DGYprpXQio+14+SYdJrrli
         jlUHNmIM8JkPWcspsz7TLRMJQuOlDz+GrV5aRdFJKnFm/qOmkZXTxkR5UjbGTcEcQEw3
         shbGFvRxJZF7SBWjbD7Ec9P6CZZJpzLOJKjgWNhiVbSk8scakOvKlTwJUxREyW6BJ3Wf
         y17w==
X-Gm-Message-State: APjAAAVkLbRnx8vCCQBYNvotzYo65VsRkn8QjZ87EBzfNF3L3BhUIIGz
        CKRtPwZ17nl4P+5rUzENKZFfKg==
X-Google-Smtp-Source: APXvYqx0VisnNsuBsLs1eNzqbgYv6zuOJyCgm5lqaZQuPJuf7INJygLV6ti12PFdMfz+LSKcLevlLw==
X-Received: by 2002:a63:f403:: with SMTP id g3mr1948825pgi.62.1582849373921;
        Thu, 27 Feb 2020 16:22:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm4184582pfo.154.2020.02.27.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] arm64/build: Use common DISCARDS in linker script
Date:   Thu, 27 Feb 2020 16:22:41 -0800
Message-Id: <20200228002244.15240-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 497f9675071d..c61d9ab3211c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -19,7 +20,6 @@
 
 /* .exit.text needed in case of alternative patching */
 #define ARM_EXIT_KEEP(x)	x
-#define ARM_EXIT_DISCARD(x)
 
 OUTPUT_ARCH(aarch64)
 ENTRY(_text)
@@ -94,12 +94,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		ARM_EXIT_DISCARD(EXIT_TEXT)
-		ARM_EXIT_DISCARD(EXIT_DATA)
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.20.1

