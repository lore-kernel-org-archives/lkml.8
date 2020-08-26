Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EF6206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438873;
	bh=EZABWEC2zyUZs3dyK/9XZyyWy54P8ZkdUh98NXKYLP8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ANOGBH/1twEctISIChtnmQE0QlnfeowHQI07OsqK4jMA+cHNeWj2fkvPTjlb/5f5h
	 r1DE7VBIFBc1YZoyUwTk5+FHS0ELHWsW6kGTHbC6SwQP0uFjQcShAl74HhqH4LHeQK
	 WSyMopRrxwCPar+MbxPpMPiByiLTqk6L/XxXNJ2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgHZKrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbgHZKr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:28 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70F1206EB;
        Wed, 26 Aug 2020 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438847;
        bh=EZABWEC2zyUZs3dyK/9XZyyWy54P8ZkdUh98NXKYLP8=;
        h=From:To:Cc:Subject:Date:From;
        b=SQtRr4R9kvhJrLy6859jN392gXMmQqTwcJve9cZwsZXeoZyrE+MWNIKwpIRn6/TAy
         L4H7s5TFE2fF4JOyTXoN/ECPJLOohbm8lMBrUJz680baiIgEf8YF/SCsuyd9/Ybn7T
         2G2VIW+1y2MEvSOvBelf4YmGL5V9F4McLUDCDpsQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxh-002E1M-LC; Wed, 26 Aug 2020 12:47:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: trace: fix the location of kprobes.rst
Date:   Wed, 26 Aug 2020 12:47:24 +0200
Message-Id: <20200826104724.530513-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was moved out of staging.

Fixes: 2165b82fde82 ("docs: Move kprobes.rst from staging/ to trace/")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/kprobetrace.rst | 2 +-
 samples/kprobes/kprobe_example.c    | 2 +-
 samples/kprobes/kretprobe_example.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c1709165c553..10850a9e9af3 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -40,7 +40,7 @@ Synopsis of kprobe_events
  MEMADDR	: Address where the probe is inserted.
  MAXACTIVE	: Maximum number of instances of the specified function that
 		  can be probed simultaneously, or 0 for the default value
-		  as defined in Documentation/staging/kprobes.rst section 1.3.1.
+		  as defined in Documentation/trace/kprobes.rst section 1.3.1.
 
  FETCHARGS	: Arguments. Each probe can have up to 128 args.
   %REG		: Fetch register REG
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 240f2435ce6f..8b718943d603 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -5,7 +5,7 @@
  * stack trace and selected registers when _do_fork() is called.
  *
  * For more information on theory of operation of kprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * You will see the trace data in /var/log/messages and on the console
  * whenever _do_fork() is invoked to create a new process.
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 78a2da6fb3cd..69fd1235108a 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -11,7 +11,7 @@
  * If no func_name is specified, _do_fork is instrumented
  *
  * For more information on theory of operation of kretprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * Build and insert the kernel module as done in the kprobe example.
  * You will see the trace data in /var/log/messages and on the console
-- 
2.26.2

