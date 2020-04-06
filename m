Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB80C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BE92496E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzysDj83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgDFQmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:42:15 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41008 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgDFQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:42:13 -0400
Received: by mail-qk1-f202.google.com with SMTP id d18so366937qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y7rlrv2nhrkBeB3yxrt1isCdPASfC8dC7N7qsaqIYpI=;
        b=uzysDj83wFfvyx5+xHx53APFuGywhQGNYTYnY3+lbcNA+3qpT2RyVCtTCzOVWuYtrd
         IJ7VKcld7TMSS+B4Duop178kHp3dnyyCbFCaQG30nNlIZu2qp3pd8gPvWCQ/vh5UCVNI
         qYZP5lzEpIK9s82LrNfMVTyGg0YHy+wtBcdXCYONK5VtuSr/B+ie2tXtTLyaJ9IPy1+g
         3D+xo+ACBtd8mKECNNqIvX1PJ+oInNfLa3VP4gJ7IaAStMJAKw0/1v2sPcOcrSw5vqh7
         xI4vpzaPpkYp+bSxRgABVKY3EorsZQeCB4tyb7kBdLZS86i8LGqxeDzzj01uFZHbP3SR
         Lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y7rlrv2nhrkBeB3yxrt1isCdPASfC8dC7N7qsaqIYpI=;
        b=rzruPKPJ5muO8Vo3HkG8CwQ/hwJ6snyBc1/jP9uV+J0YOQRCIzRUtyHHI9Znc1dAQl
         V+l/MluDs4LXj3bHHSBMegXM0zpezAM89rtSrZ+ZXLwDd55IFbrNMdy2Hm1E1SJfAsAD
         6CbaTM7EpfmjS8Ja8Xqb+sesuf2FRK+2lYFfMtIl5qmlgvl7yKRZ/PBElDi3HOZY9B92
         aItBEq1PzQkqW42eaOWj4vbxLIZmlnx3BspQiZy5bp8LqULrozny9ZU4ey6rSc3s7Sgi
         oemYHpAPDs/eVi2uZdDLUSkwjK3YgdwQR1A9694ldEPdvMn1kUCh/BTmQl9+Zi2YPnov
         aLjA==
X-Gm-Message-State: AGi0PuYCfw2+Qz4lCZw1S5sthf5ZbB/mn0y2pQj5Bv7jCcYe6REY9vW2
        Nr4MwlBqbXDWRB2c5q+QuwfPR2x7Ly1ahRBZdqM=
X-Google-Smtp-Source: APiQypIq6K+/6sNFF07UPysJVLbTskXzuAKdx/I5NBmymQNj01YODUpkepZADD3StGdWVd8jEygPyA4Kk1CGRFm+W3w=
X-Received: by 2002:a37:4d88:: with SMTP id a130mr21585753qkb.443.1586191332817;
 Mon, 06 Apr 2020 09:42:12 -0700 (PDT)
Date:   Mon,  6 Apr 2020 09:41:21 -0700
In-Reply-To: <20200406164121.154322-1-samitolvanen@google.com>
Message-Id: <20200406164121.154322-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200406164121.154322-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v10 12/12] efi/libstub: disable SCS
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
index 094eabdecfe6..fa0bb64f93d6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -32,6 +32,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   $(call cc-option,-fno-stack-protector) \
 				   -D__DISABLE_EXPORTS
 
+#  remove SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.26.0.292.g33ef6b2f38-goog

