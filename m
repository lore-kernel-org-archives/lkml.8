Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4446B20786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFQC1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:27:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49932 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgFQC1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:27:12 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2l1f+lePf1EAA--.9190S2;
        Wed, 17 Jun 2020 10:27:02 +0800 (CST)
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
Subject: [PATCH v3] tools build: Check libasan and libubsan in Makefile.feature
Date:   Wed, 17 Jun 2020 10:27:01 +0800
Message-Id: <1592360821-2323-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz2l1f+lePf1EAA--.9190S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW7XF4fZw1DKw1kJw1kXwb_yoW5Xw47pw
        4Skr4DtrWrXrWxZw18CF4rWr1rGFZ7tayjga98J3srArn5Gw42yr4Fya4YqFy7Jw18Xay7
        ua4xGFWI9w4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1sYFtUUUUU==
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

 tools/build/Makefile.feature | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index cb15237..bc28dc9 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -250,3 +250,15 @@ ifeq ($(feature_verbose),1)
   $(foreach feat,$(TMP),$(call feature_print_status,$(feat),))
   $(info )
 endif
+
+ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
+  ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
+    msg := $(error No libasan found, please install libasan);
+  endif
+endif
+
+ifneq ($(filter s% -fsanitize=undefined%,$(EXTRA_CFLAGS),),)
+  ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
+    msg := $(error No libubsan found, please install libubsan);
+  endif
+endif
-- 
2.1.0

