Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1E2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPcfZIGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUTot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:44:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9BC061798
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so1567771pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9ju+r34sWfhod71XL1bT+zi6vF+Wn+whGvig44U/H8=;
        b=mPcfZIGuf1IZHjreJOKyf+8HKo4m4M4Fs7OCfWzQHGepGQ2VKw/pZolBRvYuRnsgrD
         iO6Sm/0z9adI7m403A/1my//6tCmpz/F5LGl8FcvQXkQNaGnonYynUO4LclCHmwMJqs0
         O0N8myI4UIrjk5XmzJuV30avHlcvBnyogqviE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9ju+r34sWfhod71XL1bT+zi6vF+Wn+whGvig44U/H8=;
        b=ppHmMVVYTxIs97UHhGDabjcz8QxE+4oZlJIHWIC3DkoXNXp6bCZvInhcQAOdKLojTJ
         x/JSsdODyfgqzAkEJWLSZrt5JUvCVm/g9m4qZeQf4HoJ2uZ03H1/4hXczz5kEM+jrTff
         D7+WzgiY5rXayv5wlfUuiI3wVgJAGlFxePufZRS5Efj8ouhjq+wi3jdeyFNQ2AA+PFpn
         koQbp/w9bVnEdy8UXhH8dYtT3uSqnkUl25U/PWkkQDwu4GO+qmOAkr1KW2l0TcdtI0+f
         mjaNTRfdFMXFiTEysy67C4n1w3RarvmZYvcVYj06lJ1BSGtaTFVqlt5Zh0a8QW0Sc+DR
         Prxg==
X-Gm-Message-State: AOAM533LG/xkwvK1c8NiRuyamQg3obr1h/LlIA2finGk5EVLuLtGK/P3
        FQMc/PFq3/8+VECOuIjrLNj4+Q==
X-Google-Smtp-Source: ABdhPJxNUi6ggriXccpA572qG6bm/FjMSOm/9dg/71/aIV6K+hAYLL89xzLCOF1RLAPDkBnD4lQ2Ag==
X-Received: by 2002:aa7:8bd2:: with SMTP id s18mr3530477pfd.284.1598039062849;
        Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y28sm3504632pfq.83.2020.08.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
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
Subject: [PATCH v6 02/29] vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
Date:   Fri, 21 Aug 2020 12:42:43 -0700
Message-Id: <20200821194310.3089815-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the COMMON_DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 184b23d62784..f1f02a2f71b7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -957,7 +957,9 @@
 #define COMMON_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
-	*(.modinfo)
+	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
-- 
2.25.1

