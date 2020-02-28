Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C1FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE87246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aprtzyrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgB1AWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:22:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45997 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1AWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so713797pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uceCceIOG2DmkN987H8EhCgiSZQG4q+SFGBRris4xG0=;
        b=aprtzyrZ60FGeJNkJNjVIQbc99c/fsdw9OKOw87YzHK/0SfhsWmA8PcyTPqZq9ptEL
         0CNjt4bV3uQWUOlnulxZY8ZKsGjdFr3XpcUK9eN4hf7vx57s1iHQvbosRZGY9/LJNRxo
         MYhTtklU93oiIUE0nKY046nfAGvZw6E1IkunM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uceCceIOG2DmkN987H8EhCgiSZQG4q+SFGBRris4xG0=;
        b=L9/kcL8ZzJFconcksRwpcyjrxTaPj5OZOBw2ZYhLCcoNIbCEQQXsIXrLqClmUmItqW
         tKj62gBy57oXQ/jrF4mMDWPr1Rc/gvm6/guzdk6bjnLtmyIMCTG1mdGira63quESOPMB
         knnPo+e3bxFv6PKRKhYm8w1npu+4flOttAcwZKdR7Y+3xYmqRbI3i/FAQ/lgYZyGlsf1
         Ztssw68Sbtr6nbwwKipY0juNga7xB8yst0PBW5xJdpqSiyFQCIUKMjXHTDwXuqT/kzZV
         xXCG1SvqLYv5WVPZi1oVwwC1eTa4Md1NMD2F9NtYMJNQkUzz/KVjUKgsuSYkSaNWB7p9
         X0Ig==
X-Gm-Message-State: APjAAAVK1RfBnaL6uLb7fRO3d8JVtbOO1xsIQm/OA6NL38D0jklRzfLV
        YFbJhh4UciAqDX07Y4LWxJXgWQ==
X-Google-Smtp-Source: APXvYqyjOck/5wJSSqU+VYB+XqwXzBg0gQ0/fmVPRW162tG0JSVUcNPf0a5ewRShW9E52SJeL0B9Pg==
X-Received: by 2002:aa7:9f90:: with SMTP id z16mr1671592pfr.161.1582849370382;
        Thu, 27 Feb 2020 16:22:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm3646141pjd.4.2020.02.27.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:48 -0800 (PST)
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
Subject: [PATCH 3/9] x86/build: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:38 -0800
Message-Id: <20200228002244.15240-4-keescook@chromium.org>
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

Discards the unused rela, plt, and got sections that are not needed
in the final vmlinux, and enable orphan section warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile             | 4 ++++
 arch/x86/kernel/vmlinux.lds.S | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94df0868804b..b2c8becadce5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -51,6 +51,10 @@ ifdef CONFIG_X86_NEED_RELOCS
         LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 #
 # Prevent GCC from generating any FP code by mistake.
 #
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5cab3a29adcb..1e345f302a46 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -412,6 +412,12 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.got) *(.got.*)
+		*(.igot.*) *(.iplt)
+	}
 }
 
 
-- 
2.20.1

