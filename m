Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FE1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BF821D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgIIJxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:53:37 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56374 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgIIJxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:53:35 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz90LplhfX98TAA--.4442S2;
        Wed, 09 Sep 2020 17:53:16 +0800 (CST)
From:   Zejiang Tang <tangzejiang@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Improve perf option help information in perf.txt
Date:   Wed,  9 Sep 2020 17:53:14 +0800
Message-Id: <1599645194-8438-1-git-send-email-tangzejiang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz90LplhfX98TAA--.4442S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry5KFW8Jry8urW3Wr4fAFb_yoW5JFW8pa
        9Ikry3tr1DJ343Awn5Jw1IvFyfWrZa9a13Gw1Skr48Xr1DCrsagFyYkFyFqFy7XFy8AayU
        Kr42qFy3Grs2yw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7TmhUUUUU=
X-CM-SenderInfo: pwdqw6phmlt03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf could use many options, such as:-vv, --exec-path,
--html-path, -p, --paginate,--no-pager, --debugfs-dir,
--buildid-dir, --list-cmds, --list-opts. Add these options
in perf.txt.

Signed-off-by: Zejiang Tang <tangzejiang@loongson.cn>
---
 tools/perf/Documentation/perf.txt | 69 ++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 3f37ded..c130a3c 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -12,32 +12,57 @@ SYNOPSIS
 
 OPTIONS
 -------
---debug::
-	Setup debug variable (see list below) in value
-	range (0, 10). Use like:
-	  --debug verbose   # sets verbose = 1
-	  --debug verbose=2 # sets verbose = 2
-
-	List of debug variables allowed to set:
-	  verbose          - general debug messages
-	  ordered-events   - ordered events object debug messages
-	  data-convert     - data convert command debug messages
-	  stderr           - write debug output (option -v) to stderr
-	                     in browser mode
-	  perf-event-open  - Print perf_event_open() arguments and
-			     return value
-
---buildid-dir::
-	Setup buildid cache directory. It has higher priority than
-	buildid.dir config file option.
+-h::
+--help::
+        Run perf help command.
 
 -v::
 --version::
-  Display perf version.
+        Display perf version.
 
--h::
---help::
-  Run perf help command.
+-vv::
+        Print the compiled-in status of libraries.
+
+--exec-path::
+        Display or set exec path.
+
+--html-path::
+        Display html documentation path.
+
+-p::
+--paginate::
+        Set up pager.
+
+--no-pager::
+        Do not set pager.
+
+--buildid-dir::
+        Setup buildid cache directory. It has higher priority
+        than buildid.dir config file option.
+
+--list-cmds::
+        List the most commonly used perf commands.
+
+--list-opts::
+        List available perf options.
+
+--debugfs-dir::
+        Set debugfs directory or set environment variable PERF_DEBUGFS_DIR.
+
+--debug::
+        Setup debug variable (see list below) in value
+        range (0, 10). Use like:
+          --debug verbose   # sets verbose = 1
+          --debug verbose=2 # sets verbose = 2
+
+        List of debug variables allowed to set:
+          verbose          - general debug messages
+          ordered-events   - ordered events object debug messages
+          data-convert     - data convert command debug messages
+          stderr           - write debug output (option -v) to stderr
+                             in browser mode
+          perf-event-open  - Print perf_event_open() arguments and
+                             return value
 
 DESCRIPTION
 -----------
-- 
2.1.0

