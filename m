Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53175C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34904208FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDDIlv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:41:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN1-0000uP-NH; Sat, 04 Apr 2020 10:41:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 049901C0243;
        Sat,  4 Apr 2020 10:41:39 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:38 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf python: Fix clang detection to strip out
 options passed in $CC
Cc:     daniel.diaz@linaro.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401124037.GA12534@kernel.org>
References: <20200401124037.GA12534@kernel.org>
MIME-Version: 1.0
Message-ID: <158598969854.28353.7275617434377208248.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9ff76cea4e9e6d49a6f764ae114fc0fb8de97816
Gitweb:        https://git.kernel.org/tip/9ff76cea4e9e6d49a6f764ae114fc0fb8de97816
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 01 Apr 2020 09:33:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 10:04:59 -03:00

perf python: Fix clang detection to strip out options passed in $CC

The clang check in the python setup.py file expected $CC to be just the
name of the compiler, not the compiler + options, i.e. all options were
expected to be passed in $CFLAGS, this ends up making it fail in systems
where CC is set to, e.g.:

 "aarch64-linaro-linux-gcc --sysroot=/oe/build/tmp/work/juno-linaro-linux/perf/1.0-r9/recipe-sysroot"

Like this:

  $ python3
  >>> from subprocess import Popen
  >>> a = Popen(["aarch64-linux-gnu-gcc --sysroot=/oe/build/tmp/work/juno-linaro-linux/perf/1.0-r9/recipe-sysroot", "-v"])
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    File "/usr/lib/python3.6/subprocess.py", line 729, in __init__
      restore_signals, start_new_session)
    File "/usr/lib/python3.6/subprocess.py", line 1364, in _execute_child
      raise child_exception_type(errno_num, err_msg, err_filename)
  FileNotFoundError: [Errno 2] No such file or directory: 'aarch64-linux-gnu-gcc --sysroot=/oe/build/tmp/work/juno-linaro-linux/perf/1.0-r9/recipe-sysroot': 'aarch64-linux-gnu-gcc --sysroot=/oe/build/tmp/work/juno-linaro-linux/perf/1.0-r9/recipe-sysroot'
  >>>

Make it more robust, covering this case, by passing cc.split()[0] as the
first arg to popen().

Fixes: a7ffd416d804 ("perf python: Fix clang detection when using CC=clang-version")
Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Daniel Díaz <daniel.diaz@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ilie Halip <ilie.halip@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200401124037.GA12534@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 8a065a6..347b2c0 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,7 +3,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
-cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
+cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
 
 def clang_has_option(option):
     return [o for o in Popen([cc, option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
