Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7067C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8129F2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lP9wwldV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgFVU6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:58:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u14so430593pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1OBEWaxVovTEcB37uBYgE/K0BmOSSCdkkUrY0xJrlc=;
        b=lP9wwldVbiqOOceUWdcR1/C7JaoksAFC1AGEd2IpbVdS5COWrufq97/Clbs06ahpr2
         Ig8zhhzjxNxRym5ybzFNeTJC+U+BpytAyxPh75t0lBs4bq76eLYcLhgFjiDqgxE0E80I
         P1GfY/nA+xqh4eaMGNkWsygArj3VzHmI8Q4wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1OBEWaxVovTEcB37uBYgE/K0BmOSSCdkkUrY0xJrlc=;
        b=ewQcnx4BZoISyyQTnIoxj3DykUUduS0mnNP9qr1/wDy5DFffXlxpgPY/RI/C614er3
         VVivKSqdiiDS8deT8hfzNwKau2O+QFK0bsdMzAaUa4BKqL5YdpAhzU9TPhh05hdCszD4
         0Sz8ZvkoYoRJ7fSXJvRX5GVP4C/PCGTLLEx6k3XQssVHBxnMx4ACQIrLkdqRwf0zbn9f
         ApPv8kRwYtRUs03qvZfSupurK8XhuTGnFH2c165XcSWEVqrHgRM3iXna4eN4p/k0yK5s
         Rw05p0GPcCDyUsa6aYOoySr2tDR4AAE+jefmXYcKFxCzimISUp7I5AeX60OH6WT+cZti
         yFVg==
X-Gm-Message-State: AOAM530giU5o+w7rzqFu7DF5f4bijHB2PZzNEv4A+yhXAOWNntYy1Y6l
        snEU+JVP2N04BdL+Tc0kvnAwQA==
X-Google-Smtp-Source: ABdhPJw8ZfE/t9NOYRfv219EhLime3UVPPpW1/MOsNhWaFmvHsPXrFNhzxDZ8zzY52sAlFVq4jY/Yw==
X-Received: by 2002:a17:90a:e387:: with SMTP id b7mr20930337pjz.176.1592859499822;
        Mon, 22 Jun 2020 13:58:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm12146531pgj.52.2020.06.22.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:58:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:58:15 -0700
Message-Id: <20200622205815.2988115-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205815.2988115-1-keescook@chromium.org>
References: <20200622205815.2988115-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Explicitly include debug sections when they're present. Add .eh_frame*
to discard as it seems that these are still generated even though
-fno-asynchronous-unwind-tables is being specified. Add .plt and
.data.rel.ro to discards as they are not actually used. Add .got.plt
to the image as it does appear to be mapped near .data. Finally enable
orphan section warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             | 4 ++++
 arch/arm64/kernel/vmlinux.lds.S | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..3e628983445a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5427f502c3a6..c9ecb3b2007d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
+		*(.plt) *(.data.rel.ro)
+		*(.eh_frame) *(.init.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -209,6 +210,7 @@ SECTIONS
 	_data = .;
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
+	.got.plt : ALIGN(8) { *(.got.plt) }
 
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
@@ -244,6 +246,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 
 	HEAD_SYMBOLS
 }
-- 
2.25.1

