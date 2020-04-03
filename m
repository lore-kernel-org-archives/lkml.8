Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74151C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C282137B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585925702;
	bh=BA61YB28xh/UbDMrdtnfk381nk1HxAELz4FIea73A+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xEDly7jR3kUPeZonx8ePX+l/cp1/RyoxyQ/RrAnzjUuq9HMRNaxtmfgIgpuvlCCYx
	 niPeyCscCoSj6S+BB2wsmKBw6APYOuilrYFaaMcHU0szR9IIIM+J/4rX9zhTS4QIKe
	 oSYNwKZQeyrnUv+3yMRBh5jruELHFh3tAaSpBoRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbgDCOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCOy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:54:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15D420CC7;
        Fri,  3 Apr 2020 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585925697;
        bh=BA61YB28xh/UbDMrdtnfk381nk1HxAELz4FIea73A+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEMkFfzhvPS06IKvKt2Na0YIy2LfkYy4qJ2JAOjczs+1GtAlT5V3hXfrggDzlb3dP
         uVyJEuH6Ndl6zR7BuBrYXUTAdJtnheQK1xglQwulqvw8orhOS2mS8ela0KlFnX8474
         NEm6/fpcQBw9a+nRJxYkyn6/7lZ8l4zlgC8sAWDw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/31] perf callchain: Update docs regarding kernel/user space unwinding
Date:   Fri,  3 Apr 2020 11:54:13 -0300
Message-Id: <20200403145443.24774-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

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
index 8ead55593984..f16d8a71d3f5 100644
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
2.21.1

