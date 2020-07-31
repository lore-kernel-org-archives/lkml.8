Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AACF2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSM4iLNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgGaXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgGaXIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042AC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so10284446plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuSQYLk8rDTcldYHXnDKkaosbMzbCM9W/MwjNJB3VcU=;
        b=NSM4iLNCt+PSZ5hBbvabEzpJMd1hF6J/aIjXJAdH5r95qlIezJOL072waTPx269b/t
         VJ+YGliWX0o2ljvRIiFg0BXQ8UsnDJZGud3+eV+6jqhaEi2NoGhj3XMvM1zGexRcCA8N
         FCSROmuOt7+fbj9lG4wnKvZY3Nzk/gWgfpQUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuSQYLk8rDTcldYHXnDKkaosbMzbCM9W/MwjNJB3VcU=;
        b=cjUh2uyyk7B/egb5dM5aIe5cLh9UepEGhGRUUzJVdsIuJN6Q/5NoOG0OjgfJ/PulHT
         2OCAa+xExJY33UXOoStGgxtJgjNd0/a4hYBO5XDZ8WHof3y1IQr8jPZjov9XmCYN8nAu
         LOgl3xtIDc8fut8w1sR9d7nOLOlnliC9s6sgcISGDBHLXzMiVzpPvMV9z9Qt0+ZkjLzk
         3FoC/LY5tx1jr9IhkXSizGiWAevDEVJvMujeOMQKqAB6a2QD5FoC/PdSp+D0vlfJiIbd
         qTv+s09DK4R3hOYpKuC0m7xpkJomtzl4ifY9Z9Isk/34aqihYCCQvUZ2EZzlsg8kdHN2
         1Fsg==
X-Gm-Message-State: AOAM531pm5hGS1KAa/q0iXiTydYRgFRTV2acqX/YmV0/cfIk5jd0MzQ4
        /Tq815vhzBw4vCslm9D2qLugCw==
X-Google-Smtp-Source: ABdhPJzXJUWqCrkj1WaxJQEgHP2rE3r7Clf90BCuwH6WeoGyW0Z+5DDM353CVntBZ2TEmf3Y7y3zVg==
X-Received: by 2002:a17:90a:18c:: with SMTP id 12mr6239206pjc.74.1596236929572;
        Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm3935045pfm.201.2020.07.31.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
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
Subject: [PATCH v5 34/36] x86/boot/compressed: Add missing debugging sections to output
Date:   Fri, 31 Jul 2020 16:08:18 -0700
Message-Id: <20200731230820.1742553-35-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the missing DWARF and STABS sections in the compressed image,
when they are present.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 1fb9809a9e61..a7a68415b999 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -80,6 +80,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	DISCARDS
-- 
2.25.1

