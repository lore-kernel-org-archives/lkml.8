Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC148C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EF32073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCYQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:41:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgCYQk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:40:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CC27AC79;
        Wed, 25 Mar 2020 16:40:57 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: update docs regarding kernel/user space unwinding
Date:   Wed, 25 Mar 2020 09:40:53 -0700
Message-Id: <20200325164053.10177-1-tonyj@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method of unwinding for kernel space is defined by the kernel config, 
not by the value of --call-graph.   Improve the documentation to reflect 
this.

Signed-off-by: Tony Jones <tonyj@suse.de>

---
 tools/perf/Documentation/perf-config.txt | 14 ++++++++------
 tools/perf/Documentation/perf-record.txt | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 8ead55593984..88cf35fbedc5 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -405,14 +405,16 @@ ui.*::
 		This option is only applied to TUI.
 
 call-graph.*::
-	When sub-commands 'top' and 'report' work with -g/—-children
-	there're options in control of call-graph.
+	The following controls the handling of call-graphs (obtained via the
+	-g/--callgraph options).
 
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
index 7f4db7592467..b25e028458e2 100644
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
-- 
2.25.0

