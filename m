Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F701C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D2C206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSGD7z/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGHSVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGHSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:21:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B1C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:21:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124so19967000ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bX/pTo268FT8rnIA4NrPsVndCGHaVKOkE/vDxa6Exek=;
        b=WSGD7z/Q+VxVYqzwGilWyf41A3SssaHCXiFkN0/RVpfY4NEWuGlzNPggymgoAzqN68
         64opKxKFuZNeQA+xKMSxbRnWvHwN97Oncikg0ETG3UeyoCfy9V9llDnxfDtUg344co8O
         sQpTx5v+bgSo27MWxr6gTAwjkg3Cmg829WuzInfUyVGRb7fjUn6SvG8UT85rK2udJThB
         /yVJLn6CrEFnucsa/y/TDLghWW2ZLvcg0ymjdzDmyCIIU5JsVQtz5AONQZslmIwgpWnm
         ROQtLWF2WxsBq+WlgjJzXhxJikh4CrVcfMiATd5maurCk5QiSosxr868qjnoL8bIN7kr
         ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bX/pTo268FT8rnIA4NrPsVndCGHaVKOkE/vDxa6Exek=;
        b=Dnpap3n1VFK8bcDtCz00+WP7X3D6NR6yvu6B2y+vMA79ycP/uqOO8hzf3ndHkIrjnf
         XzMgQUw0mrP3XlCpBJX+v79hiXQ/KoWRuM96Rhrlu6D83dFkOPu8Wt8yzaBWucXGfRcE
         1yHAc81xtBCKJhyuSXkVq8GpekWjNZJreRn75EL+HU2u3cvS/AqpvpCGsGSMtV/uFwzt
         lv/9PLwb7LsSein4Tff8J19i/uSJp2H6Qh9f3sbhsdoHokgb9Cz4jOHCaSVqVNFmJF9N
         Uglp5LG5U2N6uAZdhhzQKTzY1l7LzFhHEa+9bWWllidosZCJnLcK3uee148/4avjCKzN
         5hHg==
X-Gm-Message-State: AOAM533pww6hf8hJyVmg7JaaeUgVx6frcP1AEZCH12paG9tIQkPi2xRB
        LPJBzu+RexHnSHWpYcL3FWL/I1UdRQ==
X-Google-Smtp-Source: ABdhPJyCDo9sfsgUP9YTRz7gwZPwWqD3UlaVUcZLamj01+DwCemOOyVstnmrbOTy5QP5jB+BzRlPfcdMdg==
X-Received: by 2002:a5b:1c4:: with SMTP id f4mr16966937ybp.472.1594232493688;
 Wed, 08 Jul 2020 11:21:33 -0700 (PDT)
Date:   Wed,  8 Jul 2020 18:19:09 +0000
Message-Id: <20200708181905.257691-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v2] Makefile: Add clang-tidy and static analyzer support to makefile
From:   Nathan Huckleberry <nhuck@google.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds clang-tidy and the clang static-analyzer as make
targets. The goal of this patch is to make static analysis tools
usable and extendable by any developer or researcher who is familiar
with basic c++.

The current static analysis tools require intimate knowledge of the internal
workings of the static analysis.  Clang-tidy and the clang static analyzers
expose an easy to use api and allow users unfamiliar with clang to
write new checks with relative ease.

===Clang-tidy===

Clang-tidy is an easily extendable 'linter' that runs on the AST.
Clang-tidy checks are easy to write and understand. A check consists of
two parts, a matcher and a checker. The matcher is created using a
domain specific language that acts on the AST
(https://clang.llvm.org/docs/LibASTMatchersReference.html).  When AST
nodes are found by the matcher a callback is made to the checker. The
checker can then execute additional checks and issue warnings.

Here is an example clang-tidy check to report functions that have calls
to local_irq_disable without calls to local_irq_enable and vice-versa.
Functions flagged with __attribute((annotation("ignore_irq_balancing")))
are ignored for analysis. (https://reviews.llvm.org/D65828)

===Clang static analyzer===

The clang static analyzer is a more powerful static analysis tool that
uses symbolic execution to find bugs. Currently there is a check that
looks for potential security bugs from invalid uses of kmalloc and
kfree. There are several more general purpose checks that are useful for
the kernel.

The clang static analyzer is well documented and designed to be
extensible.
(https://clang-analyzer.llvm.org/checker_dev_manual.html)
(https://github.com/haoNoQ/clang-analyzer-guide/releases/download/v0.1/clang-analyzer-guide-v0.1.pdf)

The main draw of the clang tools is how accessible they are. The clang
documentation is very nice and these tools are built specifically to be
easily extendable by any developer. They provide an accessible method of
bug-finding and research to people who are not overly familiar with the
kernel codebase.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
Changes V1 -> V2:
* Remove dependencies on GNU Parallel
* * Clang-tidy/analyzer now invoked directly from python
Link: https://lkml.org/lkml/2019/8/6/941

 Makefile                                      |  3 +
 scripts/clang-tools/Makefile.clang-tools      | 23 ++++++
 .../{ => clang-tools}/gen_compile_commands.py |  0
 scripts/clang-tools/run-clang-tools.py        | 77 +++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 scripts/clang-tools/Makefile.clang-tools
 rename scripts/{ => clang-tools}/gen_compile_commands.py (100%)
 create mode 100755 scripts/clang-tools/run-clang-tools.py

diff --git a/Makefile b/Makefile
index fe0164a654c7..3e2df010b342 100644
--- a/Makefile
+++ b/Makefile
@@ -747,6 +747,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
+include scripts/clang-tools/Makefile.clang-tools
 
 ifdef CONFIG_READABLE_ASM
 # Disable optimizations that make assembler listings hard to read.
@@ -1543,6 +1544,8 @@ help:
 	@echo  '  export_report   - List the usages of all exported symbols'
 	@echo  '  headerdep       - Detect inclusion cycles in headers'
 	@echo  '  coccicheck      - Check with Coccinelle'
+	@echo  '  clang-analyzer  - Check with clang static analyzer'
+	@echo  '  clang-tidy      - Check with clang-tidy'
 	@echo  ''
 	@echo  'Tools:'
 	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
diff --git a/scripts/clang-tools/Makefile.clang-tools b/scripts/clang-tools/Makefile.clang-tools
new file mode 100644
index 000000000000..e09dc1a8efff
--- /dev/null
+++ b/scripts/clang-tools/Makefile.clang-tools
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Google LLC, 2020
+#
+# Author: Nathan Huckleberry <nhuck@google.com>
+#
+PHONY += clang-tidy
+clang-tidy:
+ifdef CONFIG_CC_IS_CLANG
+	$(PYTHON3) scripts/clang-tools/gen_compile_commands.py
+	$(PYTHON3) scripts/clang-tools/run-clang-tools.py clang-tidy compile_commands.json
+else
+	$(error Clang-tidy requires CC=clang)
+endif
+
+PHONY += clang-analyzer
+clang-analyzer:
+ifdef CONFIG_CC_IS_CLANG
+	$(PYTHON3) scripts/clang-tools/gen_compile_commands.py
+	$(PYTHON3) scripts/clang-tools/run-clang-tools.py static-analyzer compile_commands.json
+else
+	$(error Clang-analyzer requires CC=clang)
+endif
diff --git a/scripts/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
similarity index 100%
rename from scripts/gen_compile_commands.py
rename to scripts/clang-tools/gen_compile_commands.py
diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
new file mode 100755
index 000000000000..d429a150e23a
--- /dev/null
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Google LLC, 2020
+#
+# Author: Nathan Huckleberry <nhuck@google.com>
+#
+"""A helper routine run clang-tidy and the clang static-analyzer on
+compile_commands.json."""
+
+import argparse
+import json
+import logging
+import multiprocessing
+import os
+import re
+import subprocess
+
+def parse_arguments():
+  """Set up and parses command-line arguments.
+  Returns:
+    args: Dict of parsed args
+      Has keys 'file' and 'type'
+  """
+  usage = """Run clang-tidy or the clang static-analyzer on a
+  compilation database."""
+  parser = argparse.ArgumentParser(description=usage)
+
+  type_help = ('Type of analysis to be performed')
+  parser.add_argument('type', choices=['clang-tidy', 'static-analyzer'],
+                      help=type_help)
+  file_path_help = ('Path to the compilation database to parse')
+  parser.add_argument('file',  type=str, help=file_path_help)
+
+  args = parser.parse_args()
+
+  return args
+
+def init(l,t):
+  global lock
+  global analysis_type
+  lock = l
+  analysis_type = t
+
+def run_analysis(entry):
+  filename = entry['file']
+  p = None
+  if(analysis_type == "clang-tidy"):
+    p = subprocess.run(["clang-tidy", "-p", os.getcwd(),
+                        "-checks=-*,linuxkernel-*", filename],
+                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+  if(analysis_type == "static-analyzer"):
+    p = subprocess.run(["clang-tidy", "-p", os.getcwd(),
+                        "-checks=-*,clang-analyzer-*", filename],
+                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+  lock.acquire()
+  print(entry['file'])
+  os.write(1, p.stdout)
+  os.write(2, p.stderr)
+  lock.release()
+
+
+def main():
+  args = parse_arguments()
+  filename = args.file
+
+  #Read JSON data into the datastore variable
+  if filename:
+    with open(filename, 'r') as f:
+      datastore = json.load(f)
+
+      lock = multiprocessing.Lock()
+      pool = multiprocessing.Pool(initializer=init, initargs=(lock,args.type,))
+      pool.map(run_analysis,datastore)
+
+if __name__ == '__main__':
+    main()
-- 
2.27.0.383.g050319c2ae-goog

