Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EF120885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgFRCGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:06:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57486 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730654AbgFRCGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:06:16 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2sJzOpezNpFAA--.8652S2;
        Thu, 18 Jun 2020 10:06:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4] perf tools: Check libasan and libubsan in Makefile.config
Date:   Thu, 18 Jun 2020 10:06:01 +0800
Message-Id: <1592445961-28044-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz2sJzOpezNpFAA--.8652S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW7XF4fZw1DKw1kJw1kXwb_yoW5Ww4fpw
        nIkFWDt3yrXrZ7XF48AF48Wr1rGa92yayjgF98J34qyrsxGw42vrsYyFyYqFy7Jw18JayU
        Z34xGFWIgw4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUCg4hUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build perf with ASan or UBSan, if libasan or libubsan can not find,
the feature-glibc is 0 and there exists the following error log which is
wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
is also installed.

[yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
  BUILD:   Doing 'make -j4' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
<stdin>:1:0: warning: -fsanitize=address and -fsanitize=kernel-address are not supported for this target
<stdin>:1:0: warning: -fsanitize=address not supported for this target

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ OFF ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libcap: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ OFF ]
...                        libaio: [ OFF ]
...                       libzstd: [ OFF ]
...        disassembler-four-args: [ OFF ]

Makefile.config:393: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
Makefile.perf:224: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
[yangtiezhu@linux perf]$ ls /usr/include/gnu/libc-version.h
/usr/include/gnu/libc-version.h

After install libasan and libubsan, the feature-glibc is 1 and the build
process is success, so the cause is related with libasan or libubsan, we
should check them and print an error log to reflect the reality.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - Check libasan and libubsan in tools/build/Makefile.feature
  - Modify the patch subject

v3:
  - Check EXTRA_CFLAGS first

v4:
  - Check libasan and libubsan in tools/perf/Makefile.config
  - Modify the patch subject

 tools/perf/Makefile.config | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 877ca6b..5136338 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -396,6 +396,18 @@ else
       NO_LIBBPF := 1
       NO_JVMTI := 1
     else
+      ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
+        ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
+          msg := $(error No libasan found, please install libasan);
+        endif
+      endif
+
+      ifneq ($(filter s% -fsanitize=undefined%,$(EXTRA_CFLAGS),),)
+        ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
+          msg := $(error No libubsan found, please install libubsan);
+        endif
+      endif
+
       ifneq ($(filter s% -static%,$(LDFLAGS),),)
         msg := $(error No static glibc found, please install glibc-static);
       else
-- 
2.1.0

