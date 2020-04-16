Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E311AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA084206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLxFQroY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506912AbgDPQN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506879AbgDPQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA372C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c62so3434776pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SV1DVkULqNa+FuGbiBRMBHT4OnEsBDpzGAv6cWsD5ng=;
        b=sLxFQroYETeBwkC7GL2sYyxH2hNaeokGKsdeLtXjhCO6cOtPj2JOlGsmapVVPWTSK1
         uZovYKEMjxeKiEqbJmm1N7h1ZuFNEWeqj4HZX6p71THvzQF8G9M+4JNKvHa1/tmuIfCm
         6EVESi0OEnWDzNouoomBEUVi/Rq0z+KDY6RjRyGUB3tsfFtJuEFP+col35MQzcyIEv98
         JSCbKVeCMC9JhoiaW1ka8ABAA/JedzZ9Vi0vS2OTLgQwsGeOmODa1mbGdE1L5+3CEz9R
         c0a2TlVnEXnb/0S7j/hvoXDbtLEn1ydd7L+LiJbescqWyWwpPatKM4QMw31dYxQHQmR6
         pJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SV1DVkULqNa+FuGbiBRMBHT4OnEsBDpzGAv6cWsD5ng=;
        b=S0gvjPNr7hEPe4p4NNs2SAJDDe+hVaACnJmfOeq4UajM+WCE0OgGxceegaNSJFNubT
         IRwybk+o2z0+8g2Y5D5YgsvvqHkIuw+XiPHjldGGqT1thBk3O5sqFh40VrvOyUfoHDex
         Q/+sa0Tf7W2ometslhUy2LXD/g7f5VaRUJ6+oToljtkWPuO/AL2tCrKovv3g9KLTzQmg
         O8qSBNvJEcvnigY1apwjT8/qtpF6rkNqnmpOmRetnKn+sLTTPBGRYJDseMceiQIV2K4/
         0mIHGCNFyygnqjpBW8TGgU+CvmqFVLydRvdhXoAUr4PIWiXNKb83jWZB1YrTODomWJyi
         0M4A==
X-Gm-Message-State: AGi0PuajAIaRgVcvJNHcUGRDw9DCwPlfUEMAlZjFBM/1OZwFTeR7gD3V
        8/5IFHczWGa+c9iPF3C7HBb5lSMm8G8RlhZ5n2g=
X-Google-Smtp-Source: APiQypJNkpQBGKyIWPV2BtmwX/E/gHMUX9jAQmns+9eOAcaQtZAXVp0Bz90VtPtI2vifzdaZP44LMcdHl+FTfzmDINE=
X-Received: by 2002:a63:ca41:: with SMTP id o1mr33386721pgi.419.1587053591236;
 Thu, 16 Apr 2020 09:13:11 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:42 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 09/12] arm64: disable SCS for hypervisor code
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

