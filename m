Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404C9206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1QcQqHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBTZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:25:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE6C08C5C0;
        Tue,  2 Jun 2020 12:25:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g5so5596449pfm.10;
        Tue, 02 Jun 2020 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZNHGkENnW7p5QnYC1ZvXQjRimlmYQpqW7KCIXsjMOo=;
        b=Q1QcQqHUqLNIrpBnRSEF4hH87gVGsH5KuvGMe1FCb8ZApL7UR/mqtCOZgEG3v7DmDI
         ltyEdb5GHSzAKdt1li0PXnSAE0drq1FC2MliINsjI+iAo7ehYpkZwRbJ4jnNU1PMjTAJ
         73NPZls5lYIRVYc0dleTeDnxFwd/dmb5RibQTpXi0vQC8BpYxZJqFYVTM232U/NIYxM5
         /6A2O/Ys0N1/ZqKnVJstKXGSs3ZGWzVMtm2IJejGREn1PJnXBuO2GQbTTntQBCIvh/xC
         gqFsthkZqTAN7ohya/t0ASPyC1B0SucJcF8bmUlnQFDDRDwGRpukvknzkms4PojTiFyn
         D/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZNHGkENnW7p5QnYC1ZvXQjRimlmYQpqW7KCIXsjMOo=;
        b=o/++C2E/HC7JdBFv3De6P5T/Gy7l5v16VjAI8wF+0E/MBEZjsvRZYe6Py0fQvKbow/
         t+xMWuQ9z0VK5mCxYh2ZttOujVD8ThxnBr3g2bNIv17hEfseAt0uF+K/kvtPKpKm8zJ5
         A+HfoutXsjW3qvuXtZ/n9OGeJ0yeHC6KWSNi4JB+N5jy9+JMJHKZv6adFb4fs7SLU20U
         a5YbQkqKUtKkI7rsOJE3hOJLuAyMNf7OUs6uWjKrj3UwX0rciK2QtSX43T4ihDzUSCuN
         A6g11ZWkh2pPwJVpGS4Sxrv15Hb6ZTiw0spO7uw6EIHTPdHcRsjIsnNmxWlh0tbbvJHG
         x3vQ==
X-Gm-Message-State: AOAM533PWFiudiXpJpJnqsFxDLLW5Wg7rcCcFfM34bIS3pibTA+iyTVh
        gjq5wCwFsctWck6slgv3bFI=
X-Google-Smtp-Source: ABdhPJx7lOQ31u2u6AnEJ8rTcuYRyzgvMyarbm9V74otSHZ9OfT7iLqS1AABko2MRXndIagrI9lmoQ==
X-Received: by 2002:a17:90a:32d1:: with SMTP id l75mr770318pjb.85.1591125952020;
        Tue, 02 Jun 2020 12:25:52 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([107.152.99.41])
        by smtp.gmail.com with ESMTPSA id t2sm2813795pgh.89.2020.06.02.12.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:25:51 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
Date:   Tue,  2 Jun 2020 12:25:24 -0700
Message-Id: <20200602192523.32758-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
References: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the VDSO is being linked through $(CC). This does not match
how the rest of the kernel links objects, which is through the $(LD)
variable.

When clang is built in a default configuration, it first attempts to use
the target triple's default linker, which is just ld. However, the user
can override this through the CLANG_DEFAULT_LINKER cmake define so that
clang uses another linker by default, such as LLVM's own linker, ld.lld.
This can be useful to get more optimized links across various different
projects.

However, this is problematic for the s390 vDSO because ld.lld does not
have any s390 emulatiom support:

https://github.com/llvm/llvm-project/blob/llvmorg-10.0.1-rc1/lld/ELF/Driver.cpp#L132-L150

Thus, if a user is using a toolchain with ld.lld as the default, they
will see an error, even if they have specified ld.bfd through the LD
make variable:

$ make -j"$(nproc)" -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- LLVM=1 \
                       LD=s390x-linux-gnu-ld \
                       defconfig arch/s390/kernel/vdso64/
ld.lld: error: unknown emulation: elf64_s390
clang-11: error: linker command failed with exit code 1 (use -v to see invocation)

Normally, '-fuse-ld=bfd' could be used to get around this; however, this
can be fragile, depending on paths and variable naming. The cleaner
solution for the kernel is to take advantage of the fact that $(LD) can
be invoked directly, which bypasses the heuristics of $(CC) and respects
the user's choice. Similar changes have been done for ARM, ARM64, and
MIPS.

Link: https://github.com/ClangBuiltLinux/linux/issues/1041
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Add -fPIC per GCC's documentation, as pointed out by Nick.

 arch/s390/kernel/vdso64/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index bec19e7e6e1c..67c14732c304 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -18,8 +18,8 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
-KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-		    -Wl,--hash-style=both
+ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
+	     --hash-style=both -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
@@ -37,8 +37,8 @@ KASAN_SANITIZE := n
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
-	$(call if_changed,vdso64ld)
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) FORCE
+	$(call if_changed,ld)
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -50,8 +50,6 @@ $(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
 # actual build commands
-quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 

base-commit: e1750a3d9abbea2ece29cac8dc5a6f5bc19c1492
-- 
2.27.0.rc2

