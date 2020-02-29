Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4CC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA28246CB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgB2JR1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgB2JRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEq-0005pp-S5; Sat, 29 Feb 2020 10:16:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 809E51C2187;
        Sat, 29 Feb 2020 10:16:48 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:48 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Fix perf config option description
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213064306.160480-8-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-8-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158296780822.28353.7462284638060309141.tip-bot2@tip-bot2>
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

Commit-ID:     cd0a9c518db123e2097e03eae374e822d82493fd
Gitweb:        https://git.kernel.org/tip/cd0a9c518db123e2097e03eae374e822d82493fd
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 13 Feb 2020 12:13:05 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 10:45:13 -03:00

perf annotate: Fix perf config option description

perf config annotate options says it works only with TUI, which is wrong.
Most of the TUI options are applicable to stdio2 as well. So remove that
generic line and add individual line with each option stating which
browsers supports that option. Also, annotate.show_nr_samples config is
missing in Documentation. Describe it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-8-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c4dd23c..9dae0df 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -239,7 +239,6 @@ buildid.*::
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
 annotate.*::
-	These options work only for TUI.
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
@@ -269,6 +268,8 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 		│              return n;
 
+		This option works with tui, stdio2 browsers.
+
         annotate.use_offset::
 		Basing on a first address of a loaded function, offset can be used.
 		Instead of using original addresses of assembly code,
@@ -287,6 +288,8 @@ annotate.*::
 
 		             368:│  mov    0x8(%r14),%rdi
 
+		This option works with tui, stdio2 browsers.
+
 	annotate.jump_arrows::
 		There can be jump instruction among assembly code.
 		Depending on a boolean value of jump_arrows,
@@ -306,6 +309,8 @@ annotate.*::
 		│1330:   mov    %r15,%r10
 		│1333:   cmp    %r15,%r14
 
+		This option works with tui browser.
+
         annotate.show_linenr::
 		When showing source code if this option is 'true',
 		line numbers are printed as below.
@@ -325,6 +330,8 @@ annotate.*::
 		│                     array++;
 		│             }
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_nr_jumps::
 		Let's see a part of assembly code.
 
@@ -335,6 +342,8 @@ annotate.*::
 
 		│1 1382:   movb   $0x1,-0x270(%rbp)
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_total_period::
 		To compare two records on an instruction base, with this option
 		provided, display total number of samples that belong to a line
@@ -348,11 +357,30 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+		This option works with tui, stdio2, stdio browsers.
+
+	annotate.show_nr_samples::
+		By default perf annotate shows percentage of samples. This option
+		can be used to print absolute number of samples. Ex, when set as
+		false:
+
+		Percent│
+		 74.03 │      mov    %fs:0x28,%rax
+
+		When set as true:
+
+		Samples│
+		     6 │      mov    %fs:0x28,%rax
+
+		This option works with tui, stdio2, stdio browsers.
+
 	annotate.offset_level::
 		Default is '1', meaning just jump targets will have offsets show right beside
 		the instruction. When set to '2' 'call' instructions will also have its offsets
 		shown, 3 or higher will show offsets for all instructions.
 
+		This option works with tui, stdio2 browsers.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
