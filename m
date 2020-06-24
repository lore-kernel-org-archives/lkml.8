Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC83E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdroIDfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406643AbgFXUd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406590AbgFXUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:33:35 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F04C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e4so2429501qtd.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A7cPf0bNRtzZYfE1vc1rDopHSIr0k7cT2ZUm+OLZjv0=;
        b=QdroIDfhWPMl7iB8nPdG8F9r+Jm4224Qh0WRTBS1efFhFRpvTdOpw1Wqlz8qn+FYQH
         CFYve9pYyAVcIOznwtpq4QOlb+uiIUyfq16PYsXpTvWntxsZXcxPZ5lIUBkOt4NXo1Sm
         PFaSdzav1KtGvpCE5Ob7mVSvukaW8AVYgaIRlUr52jjyj1zFJ6R084rNzCDR/va5Iujh
         UoakKiURAbGW8xR0S2+Nw0cEeLy4uPMRYJtFclzKSks+5zyjfrBf44Qy3NgDTq9URhoR
         JWQuukFmtbdz9DrqDBlQZj0VkdPwnrqlxkdn89XzL10tIPUOY5/Zz6v6QbMuu+nDt0wT
         e8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A7cPf0bNRtzZYfE1vc1rDopHSIr0k7cT2ZUm+OLZjv0=;
        b=PHEcPhUsmQhBX54aHTSNvTTix7W+KadUu/eflJnOyMoWYMWcyJ9xfxBWUnOo1p7OY7
         uzyAHknM3NvVLGVNvqb9Y9RLcaewbxd8Z4NJGOZwfypurkryz2HzV0hnF6BfN2H0cB3y
         2DIxYOXSkhVB8SIknk4Xf471odDu2emZ8dlun0zV6ZTUP9pu/oDOLCP8+EZU30omS/Kv
         D6PlWG3Ebxj8jZ7FsemCUT9VFe4S8LuQ4xsKbeBxrQTbTORy7LOpBgJPBeElo6+me1da
         lpimdGFPW8SmVtdRH9tgvc2djPqbVsR5mkQYyY+5xSin3GrSKzqJf1vEyS22GHZuBgc3
         I99Q==
X-Gm-Message-State: AOAM532g9R/VE5u+rgTEhldYRppH/EAmMuvGk0qyYTjyCTTLzxXGKhki
        UHBS5uLcfEjwuOEAkvCkIHRNNT+ymTipxvQZkZ8=
X-Google-Smtp-Source: ABdhPJzex3csdM9Cm9Zm5kqXnJN1Q6l9vC80id+c8eDzSpyHr7eNMt7lOs0z0JRAKDBh+QA/j3WYj56ZTQDnUtqmFPY=
X-Received: by 2002:a0c:fcca:: with SMTP id i10mr21455652qvq.150.1593030812853;
 Wed, 24 Jun 2020 13:33:32 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:57 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 19/22] x86, vdso: disable LTO only for vDSO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the undefined DISABLE_LTO flag from the vDSO, and filter out
CC_FLAGS_LTO flags instead where needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 04e65f0698f6..67f60662830a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -9,8 +9,6 @@ ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
 ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
-KBUILD_CFLAGS += $(DISABLE_LTO)
-
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
@@ -92,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -150,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.27.0.212.ge8ba1cc988-goog

