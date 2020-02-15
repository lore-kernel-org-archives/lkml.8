Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD6C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B0C2467D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgBOIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBOImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1E-0005C0-NW; Sat, 15 Feb 2020 09:41:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2077C1C2019;
        Sat, 15 Feb 2020 09:41:44 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf llvm: Fix script used to obtain kernel make
 directives to work with new kbuild
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        He Kuang <hekuang@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Zefan Li <lizefan@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158175610361.13786.10260519734785923475.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     62765941155e487b351a72479078bd6fec973563
Gitweb:        https://git.kernel.org/tip/62765941155e487b351a72479078bd6fec973563
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 14 Feb 2020 09:34:43 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 14 Feb 2020 10:06:00 -03:00

perf llvm: Fix script used to obtain kernel make directives to work with new kbuild

Before this patch:

  # ./perf test 39 41
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : FAILED!
  39.3: Compile source for BPF prologue generation          : Skip
  39.4: Compile source for BPF relocation                   : Skip
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : FAILED!
  41.4: BPF relocation checker                              : Skip
  #

Using 'perf test -v' for these tests shows that it is not finding
uapi/linux/fs.h, which ends up being because we don't setup the right header
path. Fix it.

After this patch:

  # perf test 39 41
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  #

Longer description:

In llvm-utils.c we use some techniques to obtain the kbuild make
directives and that recently stopped working as now 'ar' gets called and
expects to find the dummy.o used to echo these variables:

  $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS)

Add the $(CC) line to satisfy that, making sure this works with all
kernels, i.e. preserving the temp directory and files in it used for
this technique we can see that it works everywhere:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ clean
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 4
  drwx------.  2 root root   80 Feb 14 09:42 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:42 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  #
  # cat /tmp/tmp.qgaFHgxjZ4/Makefile
  obj-y := dummy.o
  $(obj)/%.o: $(src)/%.c
          @echo -n "$(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS)"
          $(CC) -c -o $@ $<
  #

Then build with an old kernel Makefile:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ dummy.o
  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h
  #
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 8
  drwx------.  2 root root  100 Feb 14 09:43 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:43 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  936 Feb 14 09:43 dummy.o
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  #

And a new one:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ clean
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 4
  drwx------.  2 root root   80 Feb 14 09:43 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:43 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  # make -s -C /lib/modules/5.6.0-rc1+/build M=/tmp/tmp.qgaFHgxjZ4/ dummy.o
   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  #
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 16
  drwx------.  2 root root  160 Feb 14 09:44 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:44 ..
  -rw-r--r--.  1 root root  158 Feb 14 09:44 built-in.a
  -rw-r--r--.  1 root root  149 Feb 14 09:44 .built-in.a.cmd
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  936 Feb 14 09:44 dummy.o
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  -rw-r--r--.  1 root root    0 Feb 14 09:44 modules.order
  #

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Zefan Li <lizefan@huawei.com>
Link: https://www.spinics.net/lists/linux-perf-users/msg10600.html
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index eae47c2..b5af680 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -288,6 +288,7 @@ static const char *kinc_fetch_script =
 "obj-y := dummy.o\n"
 "\\$(obj)/%.o: \\$(src)/%.c\n"
 "\t@echo -n \"\\$(NOSTDINC_FLAGS) \\$(LINUXINCLUDE) \\$(EXTRA_CFLAGS)\"\n"
+"\t\\$(CC) -c -o \\$@ \\$<\n"
 "EOF\n"
 "touch $TMPDIR/dummy.c\n"
 "make -s -C $KBUILD_DIR M=$TMPDIR $KBUILD_OPTS dummy.o 2>/dev/null\n"
