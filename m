Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D5D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXdY9FVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbgFXBuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbgFXBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:49:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA7EC061795
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so550384pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=TXdY9FVpjgIhWRYoyXUuLGhQMeQ53VV4aKQM/q7y25nB8/JtVWIste/uTV5qFOVEAg
         AiwFcvmIJkGaP01f+FxsRre0U1D530Nko+V2qMyhP3wgN3vMhwW/eYK/szMmI5u22cDZ
         jsFw2NfSpjfdjBM4ANCXNfUIMmS92dojpKWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=CYoVjqMdLciQGweGxSJndY+6RWowDG6YyVp34ermMcYBCuSdy1S/Mt3+4ypAcSlUbv
         eJzQHoB+j6XhFDI5x0R6fyC6nI2spu9rj8nAIYtV22ZzGr2qiQicMmmqRch8/S/InbJ1
         jEY3O1VITuYpEFJruwUUKH1wqLxpH6xC3fgobHnuSzSKabzmOvs4LiGP1vS1CEHz1xLU
         yjgMxLHmO6sOgjvtBzfXPoLJVltuawjGaqaHFdtoBkogfZho+sN4xfzH3aDHG63J0MXJ
         lbIIisqpQinAgRs+v4D9d2GmPyIJSjs1022om++D7uc4fYMzy8wFE0Pe8ZV/+bhpm4mY
         Qhcg==
X-Gm-Message-State: AOAM532i6gnEiA3ArRFgwphY8nvL7hQtChd5A4p3a2yFoMKC6gkEWeMa
        wIzcap7UbdQqF5DMO0C79q1HRw==
X-Google-Smtp-Source: ABdhPJwP+OIipEHU1rtWwvydXUxFmj7C6Qtq9SLHZvGQi6oapb1adwvvBObqNVtv97LQal3R11cR2A==
X-Received: by 2002:a62:2acf:: with SMTP id q198mr28740207pfq.48.1592963390089;
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a33sm7555553pgl.75.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
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
Subject: [PATCH v3 1/9] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Tue, 23 Jun 2020 18:49:32 -0700
Message-Id: <20200624014940.1204448-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..1248a206be8d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,6 +934,8 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.25.1

