Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14518C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C47214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbgAXPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9485C2077C;
        Fri, 24 Jan 2020 15:17:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i5-000qEg-Ht; Fri, 24 Jan 2020 10:17:25 -0500
Message-Id: <20200124151725.438207089@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 08/14] Documentation: tracing: Fix typos in boot-time tracing documentation
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix typos in boottime-trace.rst according to Randy's suggestions.

Link: http://lkml.kernel.org/r/157949060335.25888.13153184562531693684.stgit@devnote2

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/boottime-trace.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 1d10fdebf1b2..dcb390075ca1 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -13,7 +13,7 @@ Boot-time tracing allows users to trace boot-time process including
 device initialization with full features of ftrace including per-event
 filter and actions, histograms, kprobe-events and synthetic-events,
 and trace instances.
-Since kernel cmdline is not enough to control these complex features,
+Since kernel command line is not enough to control these complex features,
 this uses bootconfig file to describe tracing feature programming.
 
 Options in the Boot Config
@@ -21,7 +21,7 @@ Options in the Boot Config
 
 Here is the list of available options list for boot time tracing in
 boot config file [1]_. All options are under "ftrace." or "kernel."
-refix. See kernel parameters for the options which starts
+prefix. See kernel parameters for the options which starts
 with "kernel." prefix [2]_.
 
 .. [1] See :ref:`Documentation/admin-guide/bootconfig.rst <bootconfig>`
@@ -50,7 +50,7 @@ kernel.fgraph_filters = FILTER[, FILTER2...]
    Add fgraph tracing function filters.
 
 kernel.fgraph_notraces = FILTER[, FILTER2...]
-   Add fgraph non tracing function filters.
+   Add fgraph non-tracing function filters.
 
 
 Ftrace Per-instance Options
@@ -81,10 +81,10 @@ ftrace.[instance.INSTANCE.]tracer = TRACER
    Set TRACER to current tracer on boot. (e.g. function)
 
 ftrace.[instance.INSTANCE.]ftrace.filters
-   This will take an array of tracing function filter rules
+   This will take an array of tracing function filter rules.
 
 ftrace.[instance.INSTANCE.]ftrace.notraces
-   This will take an array of NON-tracing function filter rules
+   This will take an array of NON-tracing function filter rules.
 
 
 Ftrace Per-Event Options
@@ -93,7 +93,7 @@ Ftrace Per-Event Options
 These options are setting per-event options.
 
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
-   Enables GROUP:EVENT tracing.
+   Enable GROUP:EVENT tracing.
 
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
    Set FILTER rule to the GROUP:EVENT.
@@ -145,10 +145,10 @@ below::
         }
   }
 
-Also, boottime tracing supports "instance" node, which allows us to run
+Also, boot-time tracing supports "instance" node, which allows us to run
 several tracers for different purpose at once. For example, one tracer
-is for tracing functions start with "user\_", and others tracing "kernel\_"
-functions, you can write boot config as below::
+is for tracing functions starting with "user\_", and others tracing
+"kernel\_" functions, you can write boot config as below::
 
   ftrace.instance {
         foo {
-- 
2.24.1


