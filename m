Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FC9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A20820663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iVT4bBfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgF2Un3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgF2TOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC00C08EB05
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so7565296pjc.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=iVT4bBfQ6leUk5glF2pMl9eJljlvaaSp/YPWKEyom1eoXY38lZNBJs89R68n/TkQRK
         VemoTUlkPcEIj0X5LaHDBpYNb6JR+gzylEyj/6uGQ0zrcsVW6Z2e50vFcw4/LufZ0RlH
         Rr1I65xQHvasMD9B6f8+m9p7uXXbJGaZKEgRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=jZgTMATZJSs/9dc7rjsCSEwNCdL3jIsZbm3c7T26peWS0SOwiJTrtL5sOxvPlWvquv
         etSJ2x/FVj3nt4Yzeyg0cNivU+cA5Hr/ZfwD1W4InlqAdxmcmPV2QKYpiYeuhb7WmTEe
         Ka+9oS4STxujjqhki6MuCzNuUUMBmkst3YbksB+CbWJMJXc83DzogkCN+bQBdFkpeAke
         cQvuIXXqBL8maiGXhGMgV9CZEOmfHLgCmii+o/pBcTHJlvNd46kgnxG9NpxyT+anV5/o
         /7Te/Ly5PoXa7teyuomp01vKAWA3GTlczPmOlTpSP3LcE2iTxHEHWDPRFas2yxk1Rog1
         +d6Q==
X-Gm-Message-State: AOAM530djMskgcVPycIdGYKez4bawxWAXcS48JnApe38/P282PgXSWeN
        THUQNGK/5cq6bgki9j+kirZr1A==
X-Google-Smtp-Source: ABdhPJyhkXUuny1/EwAfUvLAv2Ye21VG04The4ylXZoGinmuezptDR1f9Ju6NVe3PkYUF+OdvxyLJw==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr15976566pju.38.1593411531309;
        Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 199sm23398281pgc.79.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 10/17] arm64/kernel: Remove needless Call Frame Information annotations
Date:   Sun, 28 Jun 2020 23:18:33 -0700
Message-Id: <20200629061840.4065483-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove last instance of an .eh_frame section by removing the needless Call
Frame Information annotations which were likely leftovers from 32-bit arm.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/smccc-call.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
-- 
2.25.1

