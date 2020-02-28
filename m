Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA23C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7242469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkeoYAU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgB1AXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:23:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41843 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgB1AWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so537756pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fHzEreEHEKZLIitB5E8ew7g5jiGLQoDWIhz+OknFf0=;
        b=GkeoYAU8e8z3RjiVy/lNoEzHu3xfZdCSskh8kGhFyVvHqzRnbnRbxbrn4TM4McSa26
         b5dJvQCjoNTHztfI/3Yk8649TLr/Dejr2bVo8DdGFJbM/WkYGZ0CJ7NMkfa4SauXTXqM
         Nv+INQ8nhKoWxsj1wa0sdOVKRnF3rnDP62/0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fHzEreEHEKZLIitB5E8ew7g5jiGLQoDWIhz+OknFf0=;
        b=LeKL1+2ctnN0YfXq/Tim7u8699tf2nYTUXMEpr3FAleIzkaheWuA1zQOCcs5ekVDih
         Vwmv3xWK+cPQ9P0N1YN0dCfjiNMCgUyubCKHMro0VBjg3v/v/t3xN7ryMkTzth3egCtm
         GZrIV6L+h2yYzKkDtbLa5sv4WxPEOe4/WGEPmM6hadfiDFPuAA9ZZLh9mxt/DCYHFP3i
         LrAnmAdMd/joBCzJ3j7bJrHHV7hzx/uG0WQ+PeJ+Lqu2cOxT0DHP8yir83hQWdVjDdKS
         yqyL4staesL/9OkYlbLd+mv3lpsabMo05OBaIRMFhfL/J3KZ729kTDqbejauwpm69bIn
         EmBA==
X-Gm-Message-State: APjAAAVMV59kAl2qySAWyWOQMtesrg80NFl2HkveZ8JvG/Aaqt1MLbuv
        RGcEJU/ocYXwdUkZGSJg2iTvxA==
X-Google-Smtp-Source: APXvYqznb6YTTAlhNn7JqjD0ERUnnj6NxCnvI3DxIeFfKY/2l5deXUBraE5hW9O+0SqGg2RsiPTeNw==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr1670426pfl.205.1582849372029;
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm8485301pff.131.2020.02.27.16.22.48
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
Subject: [PATCH 2/9] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Thu, 27 Feb 2020 16:22:37 -0800
Message-Id: <20200228002244.15240-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* section,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..303597e51396 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -902,6 +902,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.20.1

