Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CFC5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E432020663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCRGAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:00:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55051 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:00:38 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jERkp-0004y2-De
        for linux-kernel@vger.kernel.org; Wed, 18 Mar 2020 06:00:35 +0000
Received: by mail-pg1-f198.google.com with SMTP id m29so16389425pgd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 23:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b0/tNNqegNvmzJPE8xlSwvL87jSpyw10AJbcYVQwQMg=;
        b=OI7e3XNXrYL7uMP7QrypKhfLWgAcbpqQdx88GnlSZv/Yc1BuXzf+XgEWzUCqKWb9iZ
         DLun8YqFEHN3ib4xtW4v6Od7RTFSAIrRWD3qnfzaIN0psM2PXrfGvKccwBtTX3pldFXN
         ntil2LQKnAqh8YTLuxPtBvY/11Q4XFZiEB4TCF2W6tGxPc/kj1rpbzJrRJ7DMTCfXBVD
         P70xmjBIPBCzMj79rM7bfajIi8/p4F/1vJgdaW/UapMAC123IH5QDc7+jKnY6Z6DjmLq
         Dt2NCquwJeTaW5o1oKsmOF4eLOxB9KA6nqnUN08ZjuXC+cQ7UUDZulEQdvqWwbGy9W4l
         vbOA==
X-Gm-Message-State: ANhLgQ1bCKkj1l8aOS5SXiy67AgjO/fAdqPZbVcZqGmWn58lWwZru/Gt
        yqswSlx7DwxOQ/xLqnNlXzNkRpLIt635rcyfEUBr+3rVcPHFrrR+odvgS58kgu6TRLHrEDNkulp
        2YCcZgKHC30sknDLUb4WpQp8/4vRsT+zXVkaOUiYF
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr2341853plr.106.1584511233912;
        Tue, 17 Mar 2020 23:00:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvVGczB2g1SGGZP1BmZR4xDWO4bLplF3TV1wHlLRgWCjvk6SPk4YN9+wtndPUrGsBimOgK+w==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr2341818plr.106.1584511233560;
        Tue, 17 Mar 2020 23:00:33 -0700 (PDT)
Received: from localhost.localdomain (114-136-162-243.emome-ip.hinet.net. [114.136.162.243])
        by smtp.gmail.com with ESMTPSA id 5sm5081619pfw.98.2020.03.17.23.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 23:00:32 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCHv2] selftests/powerpc: Turn off timeout setting for benchmarks, dscr, signal, tm
Date:   Wed, 18 Mar 2020 14:00:04 +0800
Message-Id: <20200318060004.10685-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some specific tests in powerpc can take longer than the default 45
seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
Add 45 second timeout per test") to run, the following test result was
collected across 2 Power8 nodes and 1 Power9 node in our pool:
  powerpc/benchmarks/futex_bench - 52s
  powerpc/dscr/dscr_sysfs_test - 116s
  powerpc/signal/signal_fuzzer - 88s
  powerpc/tm/tm_unavailable_test - 168s
  powerpc/tm/tm-poison - 240s

Thus they will fail with TIMEOUT error. Disable the timeout setting
for these sub-tests to allow them finish properly.

https://bugs.launchpad.net/bugs/1864642
Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/benchmarks/Makefile | 2 ++
 tools/testing/selftests/powerpc/benchmarks/settings | 1 +
 tools/testing/selftests/powerpc/dscr/Makefile       | 2 ++
 tools/testing/selftests/powerpc/dscr/settings       | 1 +
 tools/testing/selftests/powerpc/signal/Makefile     | 2 ++
 tools/testing/selftests/powerpc/signal/settings     | 1 +
 tools/testing/selftests/powerpc/tm/Makefile         | 2 ++
 tools/testing/selftests/powerpc/tm/settings         | 1 +
 8 files changed, 12 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/settings
 create mode 100644 tools/testing/selftests/powerpc/dscr/settings
 create mode 100644 tools/testing/selftests/powerpc/signal/settings
 create mode 100644 tools/testing/selftests/powerpc/tm/settings

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index d40300a..a32a6ab 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -2,6 +2,8 @@
 TEST_GEN_PROGS := gettimeofday context_switch fork mmap_bench futex_bench null_syscall
 TEST_GEN_FILES := exec_target
 
+TEST_FILES := settings
+
 CFLAGS += -O2
 
 top_srcdir = ../../../../..
diff --git a/tools/testing/selftests/powerpc/benchmarks/settings b/tools/testing/selftests/powerpc/benchmarks/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index 5df4763..cfa6eed 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -3,6 +3,8 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
 	      dscr_inherit_test dscr_inherit_exec_test dscr_sysfs_test	\
 	      dscr_sysfs_thread_test
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/dscr/settings b/tools/testing/selftests/powerpc/dscr/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index 113838f..153fafc 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -5,6 +5,8 @@ CFLAGS += -maltivec
 $(OUTPUT)/signal_tm: CFLAGS += -mhtm
 $(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/signal/settings b/tools/testing/selftests/powerpc/signal/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index b15a1a3..7b99d09 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -7,6 +7,8 @@ TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
 	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt \
 	tm-signal-context-force-tm tm-poison
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/tm/settings b/tools/testing/selftests/powerpc/tm/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4
