Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92484C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD842082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AG/N+nAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgBYRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:27 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59865 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbgBYRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:20 -0500
Received: by mail-pj1-f74.google.com with SMTP id z5so24917pjq.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S6rjWX4zh65J8qRPSZGN8zFIqvl385Xc8XQW3COWMIA=;
        b=AG/N+nAHceAaZJA2t3Ejlewnc800yTOYWW+XxDFlkHuEYsEQXM8laR8JPO6q9sZexT
         Qx9MR9PKuF1TFGK9rO4WrVGkhDFRUGBo3nTHm42lh1aY7DKUsRdqOVC006GRSybPTBpy
         CwdI4+LxD7e+4hZQ2qE/GwtlmXo1ZC8r/ZErTUuiCdp5rmFmAgH5PeFSBDiA+eNFZEE1
         7vUfoZhf7+iQVtJY9b36r4K3TymVF9QDFXBobvvCwA1YLJK0qNYbbXNNu3MS1aQw9yMX
         I0P+8rGbiMpOXi6P0ZHT3Ij2kkgGsyVJDrLVC8dfHFUYAz5mItfFosYAxy/OwBsM9sCx
         TRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S6rjWX4zh65J8qRPSZGN8zFIqvl385Xc8XQW3COWMIA=;
        b=ttX8FfMUY1+Po29ta0WS7hSp0YpHxQpzZ4sEhhg7kGXpqwh96ExqMj4ohNa1ZzRvw+
         3H+zQtM/JsT69Gu9qj0XG58il0uPbI8n8P+LlaP6tBckSmyht9S8//qYcSx4/T4h16x4
         n0x/01PxIk0H3mooetQW9t3dX77BZUOlGCAPbxtNLmtj3NuMH39H1gOjzz/jmI/PT4zv
         F00mXPUm6+HQ63NU1IEYTpzMWxRwO/P+dfxjQrf18Eu2Y5dAcfW7+IyyLxAZWIaqr9P5
         IPeN12B5dhCaHq+Ltb6o78Wu++Ie+cK3b7F+u6bQ6QjTzmixSzzoNMXlsofA52yG0EfQ
         ccSg==
X-Gm-Message-State: APjAAAVN8MBZknQq1mmyMsqYB1stW4dMb7vyMPuTHTkEBW31DgXAgBEa
        OhT0Pv8howDqKA2NVPafYTvTmQdCzAC6spg/E1w=
X-Google-Smtp-Source: APXvYqxga1IezAaj/7lzDoz6ajYcBY13ZBQ7EtWObgAVtXX9jDsYBp8jjd+EWNf7mvFW/jyX4NCc+z3bne5DtOlbYaQ=
X-Received: by 2002:a63:e044:: with SMTP id n4mr57741015pgj.338.1582652419605;
 Tue, 25 Feb 2020 09:40:19 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:33 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 12/12] efi/libstub: disable SCS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
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

Shadow stacks are not available in the EFI stub, filter out SCS flags.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 98a81576213d..ee5c37c401c9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -30,6 +30,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   $(call cc-option,-fno-stack-protector) \
 				   -D__DISABLE_EXPORTS
 
+#  remove SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.25.0.265.gbab2e86ba0-goog

