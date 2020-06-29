Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3170AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12055206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5louE6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgF2VAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbgF2TM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E7C08EB04
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so6682079plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0P/zigfbEYVemiv+chkLi1sxk82Ehd4Rswu0BvpDuE=;
        b=G5louE6Uyd2kc+xV2J1VjkFKPj4o3+7iuP5vPYPCWk+r8gutkK73zgcof6KUBrCFWp
         NA/YHDMZXOj7EKNzEtTGayNRzAljV3w+YWfaERiAi1wGVtDGv2A1+AtbnH1n8Rlsjznr
         ZVcm+cqp/UVyef3E1570F2Ni4TsttMaQCB9Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0P/zigfbEYVemiv+chkLi1sxk82Ehd4Rswu0BvpDuE=;
        b=IEpJZUL2zKr7lIdiVDgKh1+QIGerlTM9+mw6VH7qaF3T9TMGPnHhc6xt6HBUbnDgGI
         d1s/MUfkSM1LeOqI6vBYUPv+5P85XmST0GnOKTWbJTDLK52GQEYyVM6wyHUEW8ZSCudG
         A8eWN2Bn7rnyZGNIAwJFLJkaDPLGpInJqE2ZOEdKwUH02zX3KKKz+8oXOEGNvZ+0gwWm
         xHxzCZDepMNzxPUkOmQuoFXeWDbiwhQ0+NoKiaDF/eKWHmcF6+SOz6t7CJI+2l/VuQQK
         eBOC1O+131qt8HkS4qHQEmZKiIXUT5ISO+M8R0V938nV7l28BqCjNQ8YeIJqrnB+7+AH
         Pl6w==
X-Gm-Message-State: AOAM530ma+TiwCAEjMKECzNObXKcxRlq5qUi5JmEFFQnPMQdY4FAeHzS
        U71d2MsuX+O6KLW7TX6SIEPKKw==
X-Google-Smtp-Source: ABdhPJxGErTr5qdj/h+EXAH5O68jFfE2tqj+62XVCx45BXGt9Nz2IQt9L7atafYyKCZkdIT/G4UB5A==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr10404879pjn.127.1593411530770;
        Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp15sm17957978pjb.45.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date:   Sun, 28 Jun 2020 23:18:31 -0700
Message-Id: <20200629061840.4065483-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1

