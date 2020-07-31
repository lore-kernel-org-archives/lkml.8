Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E32C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB51F20672
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d74fEfH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGaXSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGaXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E0C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so8085936pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=d74fEfH+AJT4QLl/pweek9M8JQU04VeKWDA6U2gixgr/mciheG5Ezlv7MgN6Rb1HWY
         2OBg7xnc3sUVIMCFnR1Y+igiUqbxr8jaR2zt1f0TV1ldOv8LhbyjysXpqao6LAEOouE3
         Rwi1z6MIeG7fXDb29GK8Dc5L/EDvqKHqNhytQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=lOgO7cYODi/RlmbouGSn2rBO6mg9n8fSS3+nlJ8GwgPLKTHADmVRifthWz899PiRSa
         zJKYw6CsXP1E0rfxZzPLq/r+lsU3jd4wYKYGJT2w+M7grjaWWyybJ43RXcwXqY/be4G8
         XZB6N1DrGQRXeVweoyEDAOPoORyeFcqsVz2eqM/xRATB0kkoKmjky6mckegzMgAcrjXZ
         D71aYvcI4sd0CDImkk+J2sLzQV4r8UhF4pn41sDnl5i7wHSGZp1/mqcyyoCARZ2jJd+H
         AYOhgeT+jWJw6MbgWFLabV3lMWk03iVv3PtMcbX2Sxsuvhd/2STwOScBCDA2LlkAh8Od
         t9vQ==
X-Gm-Message-State: AOAM5313ptXLuuIK3G4IsWb4Kqh/PCx5F2dk7Oj69UkLD5t2RirkOfYb
        S6MLKDNjIK8YJSEIBSeGQ/MRdw==
X-Google-Smtp-Source: ABdhPJy/UWkqz0kX/iI9reViU3q1mzpCLU62ykzIRw2Fvekz5tfwEf5puBHtXUakR6EdYyybPNSt/w==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr5482552plr.136.1596237494096;
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19sm11621350pfa.9.2020.07.31.16.18.11
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
Subject: [PATCH v5 18/36] arm64/build: Use common DISCARDS in linker script
Date:   Fri, 31 Jul 2020 16:08:02 -0700
Message-Id: <20200731230820.1742553-19-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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
index b29081d16a70..5c1960406b08 100644
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
 	}
-- 
2.25.1

