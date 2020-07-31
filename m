Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B976FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B8A207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZ/hdSqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgGaXSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgGaXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96703C0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so10292122plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTlH0MxU2Zy7x/fgIfuiZYJNDywGHlIxz6xu6/7rQq0=;
        b=XZ/hdSqGOXxtc3cUCRpcO3X+flbjfzVQ9wRzdah5JRxSjtKauEC+KmC6JKLNVw6K0I
         0odKqTFybGrYU3HrvRFA6uTa+ZpJfhVd4ftn5sSo4zWNF0KyI4iOS2pUVCJ6VEYKS+Za
         zJ5gM/J22lvp+RGJ6myvn1iQm4hMGsG/qPnG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTlH0MxU2Zy7x/fgIfuiZYJNDywGHlIxz6xu6/7rQq0=;
        b=Dy6vVLq8nNjwQY5vpZXE18R7N7TW1VgjT3LVCfnUTV9B/PEtu9PEN7XKymcdD/4fWC
         y8Qx+fat5rcEAnAgekf0hzeBvUst+PUQf96DZPJDIagfD1tEtOBdFaBTAqdDD0Qxo7AZ
         ssCqOisXXqVGKBuCE5yUopYl4bqZBxzyT4uH0IxQ92jYX0RXDBY9w0hBs6YGM5OwLcr1
         jPm2ukxHi/2H2OzkodOQftKAkt8QWvKXSDe5/A99rPqEo8G9cddCkkSi4MnMtpNxqGdC
         oKauSN7oy+4nwvdh46ohSl0CX1WshG7+n2TUUhZieBA1xJ7DDpqpjVcF5jldl4LELWKj
         NpEg==
X-Gm-Message-State: AOAM532oTWIbA/ZLfV6O1n0avnpDhQ2UByMAhimTGSK/zHxR/k+7sY4M
        Pbv7KBZAxPsxbeFWMeqIVuN3pg==
X-Google-Smtp-Source: ABdhPJzf0olkAIljTwX2os818gCPZMZcjJOtgbWSTwGCt5MV/6unatQm6z/7QVNN+viuWaDDBfNmHQ==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr5716481plk.198.1596237496047;
        Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mj6sm10153236pjb.15.2020.07.31.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/36] arm64/mm: Remove needless section quotes
Date:   Fri, 31 Jul 2020 16:07:59 -0700
Message-Id: <20200731230820.1742553-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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

