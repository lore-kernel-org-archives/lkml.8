Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A7C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01C420752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgDDIoB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgDDImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNJ-00017m-As; Sat, 04 Apr 2020 10:41:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5A521C07FA;
        Sat,  4 Apr 2020 10:41:52 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:52 -0000
From:   "tip-bot2 for Tony Jones" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf callchain: Update docs regarding kernel/user
 space unwinding
Cc:     Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325164053.10177-1-tonyj@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
MIME-Version: 1.0
Message-ID: <158598971254.28353.5713347561008942769.tip-bot2@tip-bot2>
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

Commit-ID:     eadcaa3dfd706bbf46682c8b8b5979262443c3c3
Gitweb:        https://git.kernel.org/tip/eadcaa3dfd706bbf46682c8b8b5979262443c3c3
Author:        Tony Jones <tonyj@suse.de>
AuthorDate:    Wed, 25 Mar 2020 09:40:53 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 25 Mar 2020 16:13:21 -03:00

perf callchain: Update docs regarding kernel/user space unwinding

The method of unwinding for kernel space is defined by the kernel
config, not by the value of --call-graph.   Improve the documentation to
reflect this.

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lore.kernel.org/lkml/20200325164053.10177-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 14 ++++++++------
 tools/perf/Documentation/perf-record.txt | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 8ead555..f16d8a7 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -405,14 +405,16 @@ ui.*::
 		This option is only applied to TUI.
 
 call-graph.*::
-	When sub-commands 'top' and 'report' work with -g/—-children
-	there're options in control of call-graph.
+	The following controls the handling of call-graphs (obtained via the
+	-g/--call-graph options).
 
 	call-graph.record-mode::
-		The record-mode can be 'fp' (frame pointer), 'dwarf' and 'lbr'.
-		The value of 'dwarf' is effective only if perf detect needed library
-		(libunwind or a recent version of libdw).
-		'lbr' only work for cpus that support it.
+		The mode for user space can be 'fp' (frame pointer), 'dwarf'
+		and 'lbr'.  The value 'dwarf' is effective only if libunwind
+		(or a recent version of libdw) is present on the system;
+		the value 'lbr' only works for certain cpus. The method for
+		kernel space is controlled not by this option but by the
+		kernel config (CONFIG_UNWINDER_*).
 
 	call-graph.dump-size::
 		The size of stack to dump in order to do post-unwinding. Default is 8192 (byte).
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 7f4db75..b25e028 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -237,16 +237,22 @@ OPTIONS
 	option and remains only for backward compatibility.  See --event.
 
 -g::
-	Enables call-graph (stack chain/backtrace) recording.
+	Enables call-graph (stack chain/backtrace) recording for both
+	kernel space and user space.
 
 --call-graph::
 	Setup and enable call-graph (stack chain/backtrace) recording,
-	implies -g.  Default is "fp".
+	implies -g.  Default is "fp" (for user space).
 
-	Allows specifying "fp" (frame pointer) or "dwarf"
-	(DWARF's CFI - Call Frame Information) or "lbr"
-	(Hardware Last Branch Record facility) as the method to collect
-	the information used to show the call graphs.
+	The unwinding method used for kernel space is dependent on the
+	unwinder used by the active kernel configuration, i.e
+	CONFIG_UNWINDER_FRAME_POINTER (fp) or CONFIG_UNWINDER_ORC (orc)
+
+	Any option specified here controls the method used for user space.
+
+	Valid options are "fp" (frame pointer), "dwarf" (DWARF's CFI -
+	Call Frame Information) or "lbr" (Hardware Last Branch Record
+	facility).
 
 	In some systems, where binaries are build with gcc
 	--fomit-frame-pointer, using the "fp" method will produce bogus
