Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB3120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkyZjcRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgF2Usn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgF2TNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64854C08EAFA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so7823585pgn.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6elEkxiTC64v4srgfUTdZozPZdv37lYm4BTjSvBzmZk=;
        b=gkyZjcRb94k71tMgV+9TZXhAbV0rJLLGSga2JTiQ29d2jw/h/CmWsxzOrVYJYO18pb
         Rgwb6hMV5w9pjKWTXXBfcS3XfIYbnAKMBcHYDl5Yg6lCPR5OD9BbzveaWsROz9zqj2rC
         FsLqZQZBh83rrB7TDNLbJAZPzlxe+TFWfVRNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6elEkxiTC64v4srgfUTdZozPZdv37lYm4BTjSvBzmZk=;
        b=OU7TuGwgNbTaXpK/Q8JKYqd6O/1ArFEmiCJylPNGfKHJcOVVvQwTGg0E4jUzz/+C/o
         XKKpv/gMaMGmyATxYgcqlb1hu5xWfRnCmAdBFKOxJ9QC+rgOAtL/gNrq89VIJH8ya9fQ
         SMqqlw0Tmbv1YbQRgs0zGgHTmkILPhLdXaWuZDKpHne2+M7+Pq0jXGhoJP6kvSQk63nX
         ird1HDag3gXBzFeFQg6+CweNSrV4whzFx9SlkcwsKqWJLD1RKZIeGUDcMQLkcVfYgLQW
         bEzdNQol6xJvcXeIDN81j/Gg4LxIs3zXm//iP/BGyUoR6tSw+mG0bzpXjIauUTg9/6eE
         /uLA==
X-Gm-Message-State: AOAM530Nm2PyU3RElfkmtTqE1NWhGGmOFOalSYYeJmy39oZpm7fd8ezK
        mqM4XlzCCtZqh/3jxIfgjBbTMQ==
X-Google-Smtp-Source: ABdhPJxJXKXKGxIgf9KhhNRZoNxE/RymgaC1Wp90l3FioPTL2ggfsfaH6bGQODamxEof1p/UWIkdKA==
X-Received: by 2002:a62:f24b:: with SMTP id y11mr12809730pfl.85.1593411528989;
        Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f18sm15312315pgv.84.2020.06.28.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        clang-built-linux@googlegroups.com,
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
        linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/17] ctype: Work around Clang -mbranch-protection=none bug
Date:   Sun, 28 Jun 2020 23:18:28 -0700
Message-Id: <20200629061840.4065483-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for building efi/libstub with -mbranch-protection=none
(EFI does not support branch protection features[1]), add no-op code
to work around a Clang bug that emits an unwanted .note.gnu.property
section for object files without code[2].

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
[2] https://bugs.llvm.org/show_bug.cgi?id=46480

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/ctype.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/ctype.c b/lib/ctype.c
index c819fe269eb2..21245ed57d90 100644
--- a/lib/ctype.c
+++ b/lib/ctype.c
@@ -36,3 +36,13 @@ _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,	/* 224-239 */
 _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};	/* 240-255 */
 
 EXPORT_SYMBOL(_ctype);
+
+/*
+ * Clang will generate .note.gnu.property sections for object files
+ * without code, even in the presence of -mbranch-protection=none.
+ * To work around this, define an unused static function.
+ * https://bugs.llvm.org/show_bug.cgi?id=46480
+ */
+#ifdef CONFIG_CC_IS_CLANG
+void __maybe_unused __clang_needs_code_here(void) { }
+#endif
-- 
2.25.1

