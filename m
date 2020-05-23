Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFB52070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqruLYnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEWTLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEWTLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:11:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B0C061A0E;
        Sat, 23 May 2020 12:11:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f4so6584097pgi.10;
        Sat, 23 May 2020 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZCYCKt8hk9QIQfn0xrqZC7q5fnuUUU5zpxiiVNk2Yw=;
        b=QqruLYntyD9aClo2B1GNWbtwdUT62onV7z4WJ7qucpkaU7lrOTNl8ObzkOq02IW4JC
         80YOOnZna6T3+4NYITK73VIygeSmnUkgh9jErhCp+aN/99qiZLmlMHkw0D/pIaf5vZwx
         eJX3B4GCJZB87BPNEjmMfm4yar/4bUEhLH2+uHzG51Q29aSY8smAKHmRoJAva4/VZ9f0
         XDRFaTJpoSLkxMxpVb2aAZgzQMUb+Yg+mnAExjFSH5vk+c6Les6mAm65TgY6DLVmMTq8
         h2nRUqbi+Sad/YO4styj6g7zvr/i55/ZOCRAIUDUI2ThzWBte7rTX4G2P6spSBVFN1bR
         ZL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZCYCKt8hk9QIQfn0xrqZC7q5fnuUUU5zpxiiVNk2Yw=;
        b=ME7JbhxsWFR6T84Nj1B2uZAgrVeKUCvDQNO6psu+gqvxtH0maHeskrai/uYg2lvHbf
         /Fx1CcAAYkAU4tRep/nbXnHWNlzcUZ/ekMrKhtDa208wcruCs3jJ6brakKtyJpmscj6E
         0bKLqtP1ae9E1LTRKyJgQApCh6N0gE18f4UaT0SMGXLhOvUrHQl1LWLL0yx+dw8N7yuO
         r6JRXyRHjReEMAQTQtlpsAJ7yGa8yZWw2rMMO4pJzr2R2HEwGaevvgcsOpOYuUHkmvza
         HYD0wkGmTVRoHghvcQ9VNkz7qV4HgMcxUXnG1dYysJxMZA1WhChCjwkk0+GB5J4slMnV
         LBFw==
X-Gm-Message-State: AOAM533p0nmyiqW9P9ZMHgWVZpLkr6ic5T2jjgzvmcLk1b1HiEKO1c98
        JMxue6FkhqP6+OLvgFti5EhGzsidlOsOoA==
X-Google-Smtp-Source: ABdhPJx1dmCAqxV6GCBK+1wP2AMHL/Qqhl0ro2PkpRwmweaDCchE/AZ1pForXFfcXDxRKQMZJPy1lQ==
X-Received: by 2002:aa7:9e92:: with SMTP id p18mr9787794pfq.195.1590261111013;
        Sat, 23 May 2020 12:11:51 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id a14sm9385904pfc.133.2020.05.23.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 12:11:50 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
Subject: [PATCH] Documentation/features: Refresh the arch support status files
Date:   Sat, 23 May 2020 21:11:35 +0200
Message-Id: <20200523191135.21889-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was manually editing the arch-support.txt for eBPF-JIT, when I
realized the refresh script [1] has not been run for a while. Let's
fix that, so that the entries are more up-to-date.

[1] Documentation/features/scripts/features-refresh.sh

Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
---
 Documentation/features/core/eBPF-JIT/arch-support.txt       | 2 +-
 Documentation/features/debug/KASAN/arch-support.txt         | 6 +++---
 .../features/debug/gcov-profile-all/arch-support.txt        | 2 +-
 .../features/debug/kprobes-on-ftrace/arch-support.txt       | 2 +-
 Documentation/features/debug/kprobes/arch-support.txt       | 2 +-
 Documentation/features/debug/kretprobes/arch-support.txt    | 2 +-
 .../features/debug/stackprotector/arch-support.txt          | 2 +-
 Documentation/features/debug/uprobes/arch-support.txt       | 2 +-
 Documentation/features/io/dma-contiguous/arch-support.txt   | 2 +-
 Documentation/features/locking/lockdep/arch-support.txt     | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt  | 4 ++--
 Documentation/features/perf/perf-regs/arch-support.txt      | 4 ++--
 Documentation/features/perf/perf-stackdump/arch-support.txt | 4 ++--
 .../features/seccomp/seccomp-filter/arch-support.txt        | 2 +-
 Documentation/features/vm/huge-vmap/arch-support.txt        | 2 +-
 Documentation/features/vm/pte_special/arch-support.txt      | 2 +-
 16 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 9ae6e8d0d10d..9ed964f65224 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 304dcd461795..6ff38548923e 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -22,9 +22,9 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
-    |       riscv: | TODO |
-    |        s390: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: |  ok  |
+    |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
     |          um: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 6fb2b0671994..210256f6a4cf 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 32b297295fff..97cd7aa74905 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index e68239b5d2f0..caa444a2a89f 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index f17131b328e5..b805aada395e 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 32bbdfc64c32..12410f606edc 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 1c577d0cfc7f..be8acbb95b54 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index eb28b5c97ca6..895c3b0f6492 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -16,7 +16,7 @@
     |     hexagon: | TODO |
     |        ia64: | TODO |
     |        m68k: | TODO |
-    |  microblaze: | TODO |
+    |  microblaze: |  ok  |
     |        mips: |  ok  |
     |       nds32: | TODO |
     |       nios2: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 941fd5b1094d..98cb9d85c55d 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index d8278bf62b85..518f352fc727 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
@@ -21,7 +21,7 @@
     |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 687d049d9cee..c22cd6f8aa5e 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 90996e3d18a8..527fe4d0b074 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index 4fe6c3c3be5c..c7b837f735b1 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 019131c5acce..8525f1981f19 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 3d492a34c8ee..2e017387e228 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -17,7 +17,7 @@
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
     |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |

base-commit: 423b8baf18a8c03f2d6fa99aa447ed0da189bb95
-- 
2.25.1

