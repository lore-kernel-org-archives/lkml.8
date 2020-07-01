Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A36C433E5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7B020936
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGAXSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgGAXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D79C20A8B;
        Wed,  1 Jul 2020 23:17:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzI-004906-DW; Wed, 01 Jul 2020 19:17:56 -0400
Message-ID: <20200701231756.300002527@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 5/8] ktest.pl: Just open up the log file once
References: <20200701231717.757834010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, every write to the log file is done by opening the file, writing
to it, then closing the file. This rather expensive. Just open it at the
beginning and close it at the end.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 0d04b8a2b5a2..f20a81bb3abe 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -509,9 +509,7 @@ EOF
 
 sub _logit {
     if (defined($opt{"LOG_FILE"})) {
-	open(OUT, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
-	print OUT @_;
-	close(OUT);
+	print LOG @_;
     }
 }
 
@@ -1780,8 +1778,6 @@ sub run_command {
 	(fail "unable to exec $command" and return 0);
 
     if (defined($opt{"LOG_FILE"})) {
-	open(LOG, ">>$opt{LOG_FILE}") or
-	    dodie "failed to write to log";
 	$dolog = 1;
     }
 
@@ -1829,7 +1825,6 @@ sub run_command {
     }
 
     close(CMD);
-    close(LOG) if ($dolog);
     close(RD)  if ($dord);
 
     $end_time = time;
@@ -4091,8 +4086,11 @@ if ($#new_configs >= 0) {
     }
 }
 
-if ($opt{"CLEAR_LOG"} && defined($opt{"LOG_FILE"})) {
-    unlink $opt{"LOG_FILE"};
+if (defined($opt{"LOG_FILE"})) {
+    if ($opt{"CLEAR_LOG"}) {
+	unlink $opt{"LOG_FILE"};
+    }
+    open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
 }
 
 doprint "\n\nSTARTING AUTOMATED TESTS\n\n";
@@ -4453,14 +4451,16 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 }
 
 
-if (defined($opt{"LOG_FILE"})) {
-    print "\n See $opt{LOG_FILE} for the record of results.\n";
-}
-
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
     send_email("KTEST: Your test has finished!",
             "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
+
+if (defined($opt{"LOG_FILE"})) {
+    print "\n See $opt{LOG_FILE} for the record of results.\n\n";
+    close LOG;
+}
+
 exit 0;
-- 
2.26.2


