Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81992C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5891424681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUGEKZAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA1SuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:50:05 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56883 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgA1SuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:50:02 -0500
Received: by mail-pf1-f201.google.com with SMTP id r29so1208039pfl.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g0WhvzNfeF8IPmBIIuRbqPpME0iXsXClcoR+8QuQDeM=;
        b=XUGEKZAhBvSu9urDokgThLy629jPYLYOSmnR3mhcWiS20LG7HIFJnnyG7U9FeOKODN
         dRcN/ygKYsH8zvUKqKrrEoAeiJh6xj9bUwUihjFNwrC/HNMCo631ZmTMa3qkV5FANr8P
         6Bjc+r6yLtlgBlUAHhWWjX/TBrDG4QySpa2+C3PTWI7oznRugEbMlEysjsNyTLYh3Ly7
         v4QRry1d0cr919cFyJZHFpX/pPX+XmluNzInaHF+jkT6HB6vLrQ8GXNwv3HX2Ci3+Tcp
         DP6fw9+xZnGwQ4GQ+XUf08VGNsAQ/+zNH2o7Wt5M0nyNImoOhkc1Qa5/vpdDpvtQ4s0K
         vK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g0WhvzNfeF8IPmBIIuRbqPpME0iXsXClcoR+8QuQDeM=;
        b=THX9qHvzKly9ERuaR0yu4xk6veTQgwMchQ4NdVw86J+3XrRaUgKoFWpNLFI0tS8z57
         sCw1kXwMAMod5XYlqqqn9bPcT+h3mSe3kQdGhob9p18YpxCg5c+9F9KxxBJNqmsFKpz+
         DwiCPjXb2+EJMuSn0BfPY5amjM6J5uWnAgVUzPc9Be8z/fNUNbdrhzFwvkSdzeK10a4b
         6GktUc8ZQwkBBIdujj7FMNjouJ7ezoLsDeofywU+t6cLw2uMcSEAkO+yUyDV+/uWBAAP
         fD0TBHzGwO0itBhap05DgKcmar63TAvQMUPaE7H8DS9RzRGRcYixOlPw+bzN6hoAjrTW
         R0Eg==
X-Gm-Message-State: APjAAAWFlaiQZiR37amSHKYdUskTRLpwDH2QKBRkeD+suhIZA6WYOLfR
        a1vkcfAglPW1ZwrF5s+tZom4jxSpGZnOOq62pQQ=
X-Google-Smtp-Source: APXvYqwm7y9ypcJdyxgJATkCgSChfFuwRpCL+hYKepF5YmIgtTs92oWD8GlXJgm6y8lRU+5VPoS8wWchRxTA1u6Ws80=
X-Received: by 2002:a63:d90c:: with SMTP id r12mr19771294pgg.106.1580237401355;
 Tue, 28 Jan 2020 10:50:01 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:32 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
different exception level.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index ea710f674cb6..5843adef9ef6 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
+
+# remove the SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
-- 
2.25.0.341.g760bfbb309-goog

