Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C402FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BFD22314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707592;
	bh=hWOUsQDSd12FU9xG5/9EgpQv/R8EQ+m2nCeUIbrcB7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6VA8kMLNFnCULCZo736LLTbcKWKbUSDZJjBL+wQ/OSigPgZ5BZRNvv5TO6xEPAM+
	 m+7oRio7kLq+eljJQtbMXAzrGtt2nF4m2K1bNYezcxcbu0ouwV29rwyJQXKRS6ycRY
	 VVMbhNlO9jHMVNmmgg3TL1V3nOUXIefq2rkb3PW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbgBNTNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388364AbgBNTNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:13:08 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422EE206D7;
        Fri, 14 Feb 2020 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707587;
        bh=hWOUsQDSd12FU9xG5/9EgpQv/R8EQ+m2nCeUIbrcB7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL7I2QJaFBvbuqI7SSqxa7OqeAzd20ACcCCkITVIpMwYImFcXQQgrgfzebx7a3mHv
         tEgaT6r9g97D/WxvRRK7y0WmE300gO1TdLHFtgwVh1Kfv918i7H/fRRvT/DA2BhUJL
         sErLpUMMy6sDDAeBFiFlOU0d/rNeOAnXRII/HjZ4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        He Kuang <hekuang@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Zefan Li <lizefan@huawei.com>
Subject: [PATCH 23/23] perf llvm: Fix script used to obtain kernel make directives to work with new kbuild
Date:   Fri, 14 Feb 2020 16:10:57 -0300
Message-Id: <20200214191057.26266-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index eae47c2509eb..b5af680fc667 100644
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
-- 
2.21.1

