Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8023A20578
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CgqVD+cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIAWZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgIAWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:25:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E5C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:25:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z190so2017850qkc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xFF5qxswQ8XcvkvdvfVY4/mMkz+/5Nm8uIdW/HNF4l0=;
        b=CgqVD+cUWdzWbxzhIKI7RaHd9LEyOmQtSIfGxSeTZx3wjhQwa49KpJeXWTcaf02UaT
         1t1h7E4GQ51bnUwDBSLFbqTvq29wGC4ct4Zyu8vgZtkM46eQJN1UsEKFm/8Of7YG8Kv5
         A/r8lJXFwwttWKEbrul9OMFa6vSTWwUvt9OXf+wEX4A0aUKS8+RiOBiIr+8uA9ECs8bN
         Vl03pCefqLV6Bj+L87/WKvPDlpeTmXl597+8SYhKOlLzzvbsd2ifJ5UoyxVWQbs3AK3v
         u1F1qssZJ/KbKpGQp1c2MiRQlak+5cFS+kkOb5rIh5b0yPkY6YgNgyaHrOEJD4WpCq9p
         3+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xFF5qxswQ8XcvkvdvfVY4/mMkz+/5Nm8uIdW/HNF4l0=;
        b=RP+AGbaNOrDBHDlrDnag3S4dneW3rzqBGdA8bPEaHTxV8RjERVejz91Xyky3hWn00R
         bbL+vruKOeoFKt2HnJDmE898XLh8G2jYNZ+Apsh1aDzgpg2R006zL98Sw6Ie9i+WlEit
         ZyrPU/nA6SIvN72OWmnFWi+bdTTXb+q1m9hzzj8COJtBciQ2M2x0hzNFnr9CILme+9zp
         UGA3/cGtkd55F71k/m7M96hPk5BgABbzUDYwzmTx2xu4j8Rubcz9/J0kDzE+O5i4LS0E
         qFXgKnhTai/RJyA1GiMu3qn61wD1XHkNmDvxXrN1y/1fwLngAvyCo0qMx5m6y93WnlO4
         +t1w==
X-Gm-Message-State: AOAM531MHwi1oihFaX5HPAmzeGZb4NM61NBmJTf2XyzEfWQuJHlbpByP
        +neJN1zQyEQXCJUTUJLuHaobUtmjWbi0W4UtM/A=
X-Google-Smtp-Source: ABdhPJxyzoZmVuOGUXyZqPhNEmq3n7shEn4qdfzq8u7nGZfUD+VJvMmXZlfbSSn7oT0RWF6YqEQvDoRsCL3W6Eb4Rbc=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:10e8:: with SMTP id
 q8mr4223437qvt.59.1598999138727; Tue, 01 Sep 2020 15:25:38 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:25:23 -0700
In-Reply-To: <20200901222523.1941988-1-ndesaulniers@google.com>
Message-Id: <20200901222523.1941988-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901222523.1941988-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than invoke the compiler as the driver, use the linker. That way
we can check --orphan-handling=warn support correctly, as cc-ldoption
was removed in
commit 055efab3120b ("kbuild: drop support for cc-ldoption").

Requires dropping the .got section.  I couldn't find how it was used in
the vdso32.

Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
Link: https://lore.kernel.org/lkml/CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Not sure removing .got is a good idea or not.  Otherwise I observe the
following link error:
powerpc-linux-gnu-ld: warning: orphan section `.got' from `arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.got'
powerpc-linux-gnu-ld: _GLOBAL_OFFSET_TABLE_ not defined in linker created .got
powerpc-linux-gnu-ld: final link failed: bad value

sigtramp.c doesn't mention anything from the GOT AFAICT, and doesn't
look like it contains relocations that do, so I'm not sure where
references to _GLOBAL_OFFSET_TABLE_ are coming from.

 arch/powerpc/kernel/vdso32/Makefile     | 7 +++++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 87ab1152d5ce..611a5951945a 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -27,6 +27,9 @@ UBSAN_SANITIZE := n
 ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
 	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
 asflags-y := -D__VDSO32__ -s
+ldflags-y := -shared -soname linux-vdso32.so.1 \
+	$(call ld-option, --eh-frame-hdr) \
+	$(call ld-option, --orphan-handling=warn) -T
 
 obj-y += vdso32_wrapper.o
 extra-y += vdso32.lds
@@ -49,8 +52,8 @@ $(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 
 # actual build commands
-quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn) -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+quiet_cmd_vdso32ld = LD      $@
+      cmd_vdso32ld = $(cmd_ld)
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
 
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 4c985467a668..0ccdebad18b8 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -61,7 +61,6 @@ SECTIONS
 	.fixup		: { *(.fixup) }
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
-	.got		: { *(.got) }			:text
 	.plt		: { *(.plt) }
 
 	_end = .;
@@ -108,7 +107,9 @@ SECTIONS
 	.debug_varnames  0 : { *(.debug_varnames) }
 
 	/DISCARD/	: {
+		*(.got)
 		*(.note.GNU-stack)
+		*(.branch_lt)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
 		*(.glink .iplt .plt .rela*)
-- 
2.28.0.402.g5ffc5be6b7-goog

