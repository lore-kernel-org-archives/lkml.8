Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C409C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F183D208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGAXST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgGAXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BEE208DB;
        Wed,  1 Jul 2020 23:17:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzI-0048z4-3u; Wed, 01 Jul 2020 19:17:56 -0400
Message-ID: <20200701231756.001863687@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 3/8] ktest.pl: Define PRE_TEST_DIE to kill the test if the PRE_TEST fails
References: <20200701231717.757834010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, if a PRE_TEST is defined and ran, but fails, there's nothing
currently available to make the test fail too. Add a PRE_TEST_DIE option that
when set, if a PRE_TEST is defined and fails, the test will die too.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 8 +++++++-
 tools/testing/ktest/sample.conf | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 5d5cf3e1e81a..f99cf633ed84 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -98,6 +98,7 @@ my $final_post_ktest;
 my $pre_ktest;
 my $post_ktest;
 my $pre_test;
+my $pre_test_die;
 my $post_test;
 my $pre_build;
 my $post_build;
@@ -273,6 +274,7 @@ my %option_map = (
     "PRE_KTEST"			=> \$pre_ktest,
     "POST_KTEST"		=> \$post_ktest,
     "PRE_TEST"			=> \$pre_test,
+    "PRE_TEST_DIE"		=> \$pre_test_die,
     "POST_TEST"			=> \$post_test,
     "BUILD_TYPE"		=> \$build_type,
     "BUILD_OPTIONS"		=> \$build_options,
@@ -4347,7 +4349,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
     doprint "RUNNING TEST $i of $opt{NUM_TESTS}$name with option $test_type $run_type$installme\n\n";
 
     if (defined($pre_test)) {
-	run_command $pre_test;
+	my $ret = run_command $pre_test;
+	if (!$ret && defined($pre_test_die) &&
+	    $pre_test_die) {
+	    dodie "failed to pre_test\n";
+	}
     }
 
     unlink $dmesg;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 27666b8007ed..cb8227fbd01e 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -557,6 +557,11 @@
 # default (undefined)
 #PRE_TEST = ${SSH} reboot_to_special_kernel
 
+# To kill the entire test if PRE_TEST is defined but fails set this
+# to 1.
+# (default 0)
+#PRE_TEST_DIE = 1
+
 # If there is a command you want to run after the individual test case
 # completes, then you can set this option.
 #
-- 
2.26.2


