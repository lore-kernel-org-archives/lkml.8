Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA61C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48122241
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e31q5D2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDUCPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727046AbgDUCPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:19 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:19 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t9so5487105pfq.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SV1DVkULqNa+FuGbiBRMBHT4OnEsBDpzGAv6cWsD5ng=;
        b=e31q5D2LrF426GuLmKIN4uDuIUm2ZlLf+lRFsNEbELVTAOal8baaG14T9DuGBQz14r
         9Sto7/6FnMn7605IKHg2tf5tw7v+feFsEopk4mtmCip0yo8yDm7Sny62DxKqEH8EV614
         4cTMwKZcAj3aIykYJCFNeM2dddIQaDNfUJ6G5vsq6dSzq9a93ykfl7fWvHYOYeMBNO4G
         1AdylY/8z0uA5mBptLxCAUS/3ywEaqpAYW8Opd2HGdYzg2Ovv2fTec1epYlugUIrLtLa
         hSZOcKEYjSTr5Y6X4B5SgVnahzxKHNojuiY6qPK/Iwbq3wwfF8vt+aWPW3Ij55A/TxGv
         zh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SV1DVkULqNa+FuGbiBRMBHT4OnEsBDpzGAv6cWsD5ng=;
        b=nJvYeTntXF2bnQI/iR4KYWVPJWO8uAbi+8OiR8PJzcyF0gdmRrjO3wg1sg/a1B0SJE
         gTNcKdQpdCHGYrO8IN81vqjGXGbdg8ruiGTxYY9QMiBbH7vp84C+fFaDxVkVtBwerbaG
         Qh9XKiAgYVl36THv11nCLkdVkjcHVmJn0QfAvhe1U764PigT2cFyy6Vu2bf9+HlPnoM/
         pvpVdm1GX4IPqX6nHtVpecSeOCQxbxvv52O4VKwQ/Ba754fUu3qdLVxwrQf9sL1SOSXJ
         IaeGNk8+4sHyZQJbTzy0Xs6mbyFQLGPithy4UnqWowur7TtkDK9Wg51cCOTv3TY8FxqC
         BWWg==
X-Gm-Message-State: AGi0PuZpWo5ne3GxLla0079f1+Y36pDqSbe6/c86GwZj0/yM6s8Batke
        ORV4EbNGca/Y074NH1kcqYwVfmUphy7lHw5clT4=
X-Google-Smtp-Source: APiQypJ9tTRXTUL1zr6rmczfjnjv8aBX2IxTWUoRDjJtoqdCJcveKeh8g26L37LntO5tp4a613singP8/fZsqc3oszc=
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr2797895pjs.18.1587435319203;
 Mon, 20 Apr 2020 19:15:19 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:50 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 09/12] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable SCS for code that runs at a different exception level by
adding __noscs to __hyp_text.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index fe57f60f06a8..875b106c5d98 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -13,7 +13,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
-#define __hyp_text __section(.hyp.text) notrace
+#define __hyp_text __section(.hyp.text) notrace __noscs
 
 #define read_sysreg_elx(r,nvh,vh)					\
 	({								\
-- 
2.26.1.301.g55bc3eb7cb9-goog

