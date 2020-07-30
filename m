Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ABCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB712082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUuZ4yIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgG3PhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgG3PhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:37:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7391C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:37:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b127so16846707ybh.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IxpQl+U4Cci+VujQeEVAy+X3aO84K4nWxe4WSDjauTc=;
        b=IUuZ4yIPiNNKD7wzRr7z//0o/R3OjV7yHYGXQWvGy2iAQ4BWK9M1eVKaxEhD403+KF
         M3ALR70+4KVyqznMOqnXQ8yMz9bDv2IF4FSy123jSwWcMJR1hqBK3ZpJVbtEMxKJR4yz
         GnoQLLpEYsQX0DGTZ7DBIRXk2bmdxalvVu2gziRivHLe4cdoDRRoKNz8N+Oil7ikHLKT
         TFsGtcOAG3aAHcLsZnYmMrq2GNSkj2Xx2hGy0fOIxWulD6SgV3nWv+KyZph5ieTAfCLL
         JlLrmEWHVaqDbaepEr+nEd0U4rH6dcVN/4oAQ7kGiCc+PoV7X/09SduIWIEb+XazTiqu
         tYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IxpQl+U4Cci+VujQeEVAy+X3aO84K4nWxe4WSDjauTc=;
        b=CJrFwyv4OTZfzxf2cS6dfVZENcnh1qYQGEdTWSqbyuJPlSoTVtL4dmOVi0E8YapGx0
         ZjqgLFrZIWqpwSUZGeIGDATmeevAfa8tDzlxJrIkgI3n1BV7otbh+AkysU7fD48bRJsq
         jjzJ0eqJqHANeJyijiB/JkzwF3PMUKfRiiuDV5KeHYAQUJUzDph+MN9h/oHeAUKW/aFY
         iWK5oemD5CJhc5tNOpTquvkMQ8Wm7aMZZh3Cv/WVurlRLQfhUfIjzzDM+4ytryGUA/hl
         N5JNYRjr4a29pDPw4R2GxsWgJN4EOCoz/YdVsb6frie2H8dWNHd0CL0poTJ8KVVYIOPI
         yA4w==
X-Gm-Message-State: AOAM533fad2/oRtOkpbiA3q8PyuAnXlkl5zUEeDNhQjXkx18Na2nkXSo
        YJG36yb5Z7ZLfpBAapyjajCoL0Hbq5Oo1bKpYNo=
X-Google-Smtp-Source: ABdhPJzcj+/fyYup62Pb5vBi5uJFCfbTGtxNScJYQNvFrcTXPq8Z0QUD4AnWOU0P6pOttuZ1A2TSbvaltVZkQHUu5WA=
X-Received: by 2002:a25:d785:: with SMTP id o127mr5444399ybg.378.1596123426342;
 Thu, 30 Jul 2020 08:37:06 -0700 (PDT)
Date:   Thu, 30 Jul 2020 08:37:01 -0700
In-Reply-To: <20200729215152.662225-1-samitolvanen@google.com>
Message-Id: <20200730153701.3892953-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200729215152.662225-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2] arm64/alternatives: move length validation inside the subsection
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
sequences") breaks LLVM's integrated assembler, because due to its
one-pass design, it cannot compute instruction sequence lengths before the
layout for the subsection has been finalized. This change fixes the build
by moving the .org directives inside the subsection, so they are processed
after the subsection layout is known.

Link: https://github.com/ClangBuiltLinux/linux/issues/1078
Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
v1 -> v2:
- Added the missing Fixes tag and dropped CC: stable@.

---
 arch/arm64/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 12f0eb56a1cc..619db9b4c9d5 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -77,9 +77,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
-	".previous\n\t"							\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".org	. - (662b-661b) + (664b-663b)\n\t"			\
+	".previous\n"							\
 	".endif\n"
 
 #define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\

base-commit: 83bdc7275e6206f560d247be856bceba3e1ed8f2
-- 
2.28.0.163.g6104cc2f0b6-goog

