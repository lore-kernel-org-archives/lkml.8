Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C46C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F1F22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNgzTS3M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjA1SmQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgGaJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbgGaJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA0C061574;
        Fri, 31 Jul 2020 02:22:43 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L3ZKqzP4EDmwQ+Z3IDCkj9GRb+lwRh9HrZQGAWXrZGQ=;
        b=cNgzTS3MW0e/wMQUZrqjQJtCZHcj0weppVRoeGI2AM7frCg0hrBRQ9MySDE0A1mx8baluq
        WjBPjqa+EnLsry514tPlIFSMcBX3ep+sA/gZi9J0UNCF8sG0yRBI+EzYOK781gb1mlrDwN
        f68S0TyI5Hu5tiHuBOjIMTROXs4z6CY/BUGIC1pdQZAhLyyVY9+Sz5jfPaeBACot1TjmIS
        SSsd4PycjjxeHceacPzAHub3plNNtRSFpFdPIeqiWuQ6tCh20F3eCweaw0PzminFHH7ucF
        pUfqW4/gp/sdcsfvGonVLUHghl7sOCsHQb1RuywrnZz+AtXdwgG202FG72XNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L3ZKqzP4EDmwQ+Z3IDCkj9GRb+lwRh9HrZQGAWXrZGQ=;
        b=VjA1SmQirV8RvSwAp8tSiabDE2vpFVxTiDL7+8n2WxAMzw8Fgr5OW9MPiQsnslXQu4GZxV
        skYmAx8zLJOX9xCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Abstract out console-log error detection
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736149.4006.2645746856112464460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bc77a72cd188d44881ee1b9d0a9d65ca8108b508
Gitweb:        https://git.kernel.org/tip/bc77a72cd188d44881ee1b9d0a9d65ca8108b508
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 10 Jun 2020 14:08:19 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Abstract out console-log error detection

This commit pulls the simple pattern-based error detection from the
console log into a new console-badness.sh file.  This will enable future
commits to end a run on the first error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 16 +++++++-
 tools/testing/selftests/rcutorture/bin/parse-console.sh   |  5 +--
 2 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/console-badness.sh

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
new file mode 100755
index 0000000..0e4c0b2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Scan standard input for error messages, dumping any found to standard
+# output.
+#
+# Usage: console-badness.sh
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -v 'ODEBUG: ' |
+grep -v 'This means that this is a DEBUG kernel and it is' |
+grep -v 'Warning: unable to open an initial console'
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 1c64ca8..98478e1 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -116,10 +116,7 @@ then
 	fi
 fi | tee -a $file.diags
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for' < $file |
-grep -v 'ODEBUG: ' |
-grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console' > $T.diags
+console-badness.sh < $file > $T.diags
 if test -s $T.diags
 then
 	print_warning "Assertion failure in $file $title"
