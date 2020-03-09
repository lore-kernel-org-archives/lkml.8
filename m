Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92515C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A4E24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCIUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgCIUYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A7824679;
        Mon,  9 Mar 2020 20:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jBOxH-00341u-S8; Mon, 09 Mar 2020 16:24:51 -0400
Message-Id: <20200309202451.752853896@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 16:22:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>
Subject: [for-linus][PATCH 4/4] ktest: Fix typos in ktest.pl
References: <20200309202231.580868511@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

This patch fixes multipe spelling typo found in ktest.pl.

Link: http://lkml.kernel.org/r/20200309115430.57540-1-standby24x7@gmail.com

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 8bdd7253c110..7570e36d636d 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1030,7 +1030,7 @@ sub __read_config {
 	    }
 
 	    if (!$skip && $rest !~ /^\s*$/) {
-		die "$name: $.: Gargbage found after $type\n$_";
+		die "$name: $.: Garbage found after $type\n$_";
 	    }
 
 	    if ($skip && $type eq "TEST_START") {
@@ -1063,7 +1063,7 @@ sub __read_config {
 	    }
 
 	    if ($rest !~ /^\s*$/) {
-		die "$name: $.: Gargbage found after DEFAULTS\n$_";
+		die "$name: $.: Garbage found after DEFAULTS\n$_";
 	    }
 
 	} elsif (/^\s*INCLUDE\s+(\S+)/) {
@@ -1154,7 +1154,7 @@ sub __read_config {
 	    # on of these sections that have SKIP defined.
 	    # The save variable can be
 	    # defined multiple times and the new one simply overrides
-	    # the prevous one.
+	    # the previous one.
 	    set_variable($lvalue, $rvalue);
 
 	} else {
@@ -1234,7 +1234,7 @@ sub read_config {
 	foreach my $option (keys %not_used) {
 	    print "$option\n";
 	}
-	print "Set IGRNORE_UNUSED = 1 to have ktest ignore unused variables\n";
+	print "Set IGNORE_UNUSED = 1 to have ktest ignore unused variables\n";
 	if (!read_yn "Do you want to continue?") {
 	    exit -1;
 	}
@@ -1345,7 +1345,7 @@ sub eval_option {
 	# Check for recursive evaluations.
 	# 100 deep should be more than enough.
 	if ($r++ > 100) {
-	    die "Over 100 evaluations accurred with $option\n" .
+	    die "Over 100 evaluations occurred with $option\n" .
 		"Check for recursive variables\n";
 	}
 	$prev = $option;
@@ -1461,7 +1461,7 @@ sub get_test_name() {
 
 sub dodie {
 
-    # avoid recusion
+    # avoid recursion
     return if ($in_die);
     $in_die = 1;
 
-- 
2.25.0


