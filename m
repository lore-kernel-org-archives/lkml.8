Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6780C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C712087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgIHLY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:24:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57358 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729851AbgIHLRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:17:19 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx+MQQaFdfRkgTAA--.2597S2;
        Tue, 08 Sep 2020 19:16:33 +0800 (CST)
From:   Zejiang Tang <tangzejiang@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Zejiang Tang <tangzejiang@loongson.cn>
Subject: [PATCH v2] Improve perf option help information in perf.txt
Date:   Tue,  8 Sep 2020 19:16:32 +0800
Message-Id: <1599563792-20711-1-git-send-email-tangzejiang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx+MQQaFdfRkgTAA--.2597S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4xAw17Kr1UGryfWF47twb_yoW5Jw43pa
        9xCry3tr1DJ343Awn5J3WIvFy3XrZ3ua1fG34Skr48Xr1DCrsFgryYkFyFqFy7Wry8AayU
        Kr42qFy5Grs2yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUn1v3UUUUU
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
index 3f37ded..5edb854 100644
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
+        Display absolute html path.
+
+-p::
+--paginate::
+        Set up pager.
+
+--no-pager::
+        Add or change the content of environment variables.
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

