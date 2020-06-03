Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F572068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFCGKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:10:25 -0400
Received: from mail.loongson.cn ([114.242.206.163]:35386 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgFCGKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:10:24 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9+9Ptde2PM8AA--.844S2;
        Wed, 03 Jun 2020 14:10:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2] tools build: Check libasan and libubsan in Makefile.feature
Date:   Wed,  3 Jun 2020 14:10:04 +0800
Message-Id: <1591164604-20806-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxn9+9Ptde2PM8AA--.844S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW7XF4fZw1DKw1kJw1kXwb_yoW5GrW7pw
        4SkrWDtrWfXrWxZr18CF4rWr1rGFZ2qayjgan8J3sFyrn8Gw42yr4Fya4YqFy7Jw18Xay3
        u34xWFWIgw4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUFhF3UUU
        UU=
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

 tools/build/Makefile.feature | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3abd431..e147c17 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -252,3 +252,10 @@ ifeq ($(feature_verbose),1)
   $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
   $(info )
 endif
+
+ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
+  msg := $(error No libasan found, please install libasan);
+endif
+ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
+  msg := $(error No libubsan found, please install libubsan);
+endif
-- 
2.1.0

