Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C357C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F6322CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yJBzt1F6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgHGDdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:33:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C089C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HV8mvY3C1w6vmO5NhDHOYNV0jKhpN1NFtJW78pTmE4g=; b=yJBzt1F6/V0liLZT1UDXFFHG25
        Z6aZ5vyT9fnYh/iZkMxG3XlE+nMmEM7yrx82EtZ6s1qyVkbnw0VGQ3QE+6U1SfH/GBkONaQC+Iksc
        lWkmnTB0RnMHvwpR1SteXFHddO7/lusMyxzjaeFR/sDSj4GNDGBehrh2ZMLH67PQL7p49AZikLcPN
        PZn2hrDeR1aRY27IkRW8ApqiSu0gk83oSxC7S1ywmZH5L2odNSaXCIQ7Lh/2kkKsujiVdQ9eCSHiK
        mZjrgTEfW0qCxlvvauBqeqOR7pnrBRzSzzqU5e7pfxHOb7HM/KtodiCIO0ZfcWlBtLXiEplA/e5YV
        L0XTdV0g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t7v-0006s3-5C; Fri, 07 Aug 2020 03:33:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] kernel: trace: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:32:59 -0700
Message-Id: <20200807033259.13778-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/trace/.
{and, the, not}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/ftrace.c             |    2 +-
 kernel/trace/trace.c              |    2 +-
 kernel/trace/trace_dynevent.c     |    2 +-
 kernel/trace/trace_events_synth.c |    2 +-
 kernel/trace/tracing_map.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20200806.orig/kernel/trace/ftrace.c
+++ linux-next-20200806/kernel/trace/ftrace.c
@@ -2402,7 +2402,7 @@ struct ftrace_ops direct_ops = {
  *
  * If the record has the FTRACE_FL_REGS set, that means that it
  * wants to convert to a callback that saves all regs. If FTRACE_FL_REGS
- * is not not set, then it wants to convert to the normal callback.
+ * is not set, then it wants to convert to the normal callback.
  *
  * Returns the address of the trampoline to set to
  */
--- linux-next-20200806.orig/kernel/trace/trace.c
+++ linux-next-20200806/kernel/trace/trace.c
@@ -9243,7 +9243,7 @@ void ftrace_dump(enum ftrace_dump_mode o
 	}
 
 	/*
-	 * We need to stop all tracing on all CPUS to read the
+	 * We need to stop all tracing on all CPUS to read
 	 * the next buffer. This is a bit expensive, but is
 	 * not done often. We fill all what we can read,
 	 * and then release the locks again.
--- linux-next-20200806.orig/kernel/trace/trace_dynevent.c
+++ linux-next-20200806/kernel/trace/trace_dynevent.c
@@ -402,7 +402,7 @@ void dynevent_arg_init(struct dynevent_a
  * whitespace, all followed by a separator, if applicable.  After the
  * first arg string is successfully appended to the command string,
  * the optional @operator is appended, followed by the second arg and
- * and optional @separator.  If no separator was specified when
+ * optional @separator.  If no separator was specified when
  * initializing the arg, a space will be appended.
  */
 void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
--- linux-next-20200806.orig/kernel/trace/trace_events_synth.c
+++ linux-next-20200806/kernel/trace/trace_events_synth.c
@@ -1211,7 +1211,7 @@ __synth_event_trace_start(struct trace_e
 	 * ENABLED bit is set (which attaches the probe thus allowing
 	 * this code to be called, etc).  Because this is called
 	 * directly by the user, we don't have that but we still need
-	 * to honor not logging when disabled.  For the the iterated
+	 * to honor not logging when disabled.  For the iterated
 	 * trace case, we save the enabed state upon start and just
 	 * ignore the following data calls.
 	 */
--- linux-next-20200806.orig/kernel/trace/tracing_map.c
+++ linux-next-20200806/kernel/trace/tracing_map.c
@@ -260,7 +260,7 @@ int tracing_map_add_var(struct tracing_m
  * to use cmp_fn.
  *
  * A key can be a subset of a compound key; for that purpose, the
- * offset param is used to describe where within the the compound key
+ * offset param is used to describe where within the compound key
  * the key referenced by this key field resides.
  *
  * Return: The index identifying the field in the map and associated
