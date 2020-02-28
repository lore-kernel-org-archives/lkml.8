Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC764C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3892469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="krC6xmNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgB1AXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:23:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34160 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgB1AWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id f2so3738735pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVpHeuxipIPK/qd0iCdiGqFiQMqEhmX8CGXx2I34f0o=;
        b=krC6xmNgw5C2QYlaOO7YN2OpvJP+ov9IyIlPgq0DXWrHV9QPfrB/V2c9HARqDeyVlZ
         sbobrSdf3PuOxYRxxISvcUJUmQP1jaLlm2A+bGY0UwvmvfbkOinG7qJ0aqiD+JNnfd8f
         ebMF68HeaLLIxb73BOCWdAV1jFz++pJGNFM2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVpHeuxipIPK/qd0iCdiGqFiQMqEhmX8CGXx2I34f0o=;
        b=q9eKEE9DqZgiXGRQN5n1gDiUgU4P47dr91GyUTta420D4chOB5C4p7TG/r+bjz2m9k
         s9GEL3BF9Ab3JnPwpTUnYz6R5sBQ37SId9CFzw5VVvskFtFP5OkU9UnTXpmx6ZL0Io5l
         z/YLjCrAh3qd6jw1hwS8XzsaF14eKgPEX13ssVJDSaHhA0PuwTvk9cyBdx3p3E8hbCNN
         AX834fjsYeVQ0JlgQpCGN17OaqxpnHhdtCg9ALK6OD8WkHItndyv0Ntp47z1JBVazCw3
         5nmM4uZ8TlXTmG11nLokvyUe8fKrKYDEPAfigF7TpkiJcf73BvWXYA5d76EQnDhHER+0
         UjLg==
X-Gm-Message-State: APjAAAU9Kyl7fCuO5FkjnedMf1WEXiI0TRHeZMUGdE0aKB4j4qnn4SB0
        pwPMNTSpRm0s0JvZtrM9rO3X1A==
X-Google-Smtp-Source: APXvYqwL7Pts9z/sbRgRZgMFUPPpjfZxHHeQCL3ybGBJta4uKv6RUba5OOEn0ffoF3CqGS5GRVG4Qw==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr1413232plb.123.1582849373376;
        Thu, 27 Feb 2020 16:22:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e28sm8072097pgn.21.2020.02.27.16.22.50
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
Subject: [PATCH 7/9] arm64/build: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:42 -0800
Message-Id: <20200228002244.15240-8-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
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
index dca1a97751ab..c682a65b3ab8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -30,6 +30,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
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
index c61d9ab3211c..6141d5b72f8f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -98,7 +98,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
+		*(.plt) *(.data.rel.ro)
+		*(.eh_frame) *(.init.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -212,6 +213,7 @@ SECTIONS
 	_data = .;
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
+	.got.plt : ALIGN(8) { *(.got.plt) }
 
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
@@ -246,6 +248,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 
 	HEAD_SYMBOLS
 }
-- 
2.20.1

