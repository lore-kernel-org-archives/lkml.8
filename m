Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA5BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAAF21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hRstqoH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIJD1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgIJD0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B82C061757;
        Wed,  9 Sep 2020 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gEEFpySiPTiiHwPOJ1wZ69U79PgFpaRdkCZJ5P1YanY=; b=hRstqoH+Iq/vm6BZL837Lnwzjh
        7/F/JB1Y0prIWgS9C77diYbsijjq8L1hCTJFXg7Ep4jI9deasNE3hlKY1j/U5NLOYyp/vhbI0ENP2
        eHlQL+Sax3aJSIbotGWxm+estXqy7Pj38Zu0uI3ps0xFL5+yJfkI7c+BC/AUZMGMJ614zBTFuW139
        A+HsPoMLq94SjBf0CX7qHNH84/6JLehpEUq9REy2K68y8LJtd80fiAzQNqWOTLKY3RCT7jfxUX6sZ
        Ff1qwt3tufA/mJUKqN+l0WYa1gNhRDQ3Di9BEJbwMVgAUmhMPcrcan4JRq8SSAKKk7nVwBhEFypz8
        Kx2fIdKQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDDy-000659-S9; Thu, 10 Sep 2020 03:26:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/3] Documentation/admin-guide: kernel-parameters: hyphenate comma-separated
Date:   Wed,  9 Sep 2020 20:26:05 -0700
Message-Id: <20200910032606.7355-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910032606.7355-1-rdunlap@infradead.org>
References: <20200910032606.7355-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "comma separated" is used as a compound adjective, it should be
hyphenated.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200909.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200909/Documentation/admin-guide/kernel-parameters.txt
@@ -1385,7 +1385,7 @@
 
 	ftrace_filter=[function-list]
 			[FTRACE] Limit the functions traced by the function
-			tracer at boot up. function-list is a comma separated
+			tracer at boot up. function-list is a comma-separated
 			list of functions. This list can be changed at run
 			time by the set_ftrace_filter file in the debugfs
 			tracing directory.
@@ -1399,13 +1399,13 @@
 	ftrace_graph_filter=[function-list]
 			[FTRACE] Limit the top level callers functions traced
 			by the function graph tracer at boot up.
-			function-list is a comma separated list of functions
+			function-list is a comma-separated list of functions
 			that can be changed at run time by the
 			set_graph_function file in the debugfs tracing directory.
 
 	ftrace_graph_notrace=[function-list]
 			[FTRACE] Do not trace from the functions specified in
-			function-list.  This list is a comma separated list of
+			function-list.  This list is a comma-separated list of
 			functions that can be changed at run time by the
 			set_graph_notrace file in the debugfs tracing directory.
 
@@ -2407,7 +2407,7 @@
 			when set.
 			Format: <int>
 
-	libata.force=	[LIBATA] Force configurations.  The format is comma
+	libata.force=	[LIBATA] Force configurations.  The format is comma-
 			separated list of "[ID:]VAL" where ID is
 			PORT[.DEVICE].  PORT and DEVICE are decimal numbers
 			matching port, link or device.  Basically, it matches
@@ -5123,7 +5123,7 @@
 
 	stacktrace_filter=[function-list]
 			[FTRACE] Limit the functions that the stack tracer
-			will trace at boot up. function-list is a comma separated
+			will trace at boot up. function-list is a comma-separated
 			list of functions. This list can be changed at run
 			time by the stack_trace_filter file in the debugfs
 			tracing directory. Note, this enables stack tracing
@@ -5326,7 +5326,7 @@
 	trace_event=[event-list]
 			[FTRACE] Set and start specified trace events in order
 			to facilitate early boot debugging. The event-list is a
-			comma separated list of trace events to enable. See
+			comma-separated list of trace events to enable. See
 			also Documentation/trace/events.rst
 
 	trace_options=[option-list]
