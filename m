Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758BC433E4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9683208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGAXR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgGAXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE04A20870;
        Wed,  1 Jul 2020 23:17:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzH-0048y2-Qu; Wed, 01 Jul 2020 19:17:55 -0400
Message-ID: <20200701231755.689702121@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 1/8] ktest.pl: Have config-bisect save each config used in the bisect
References: <20200701231717.757834010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When performing a automatic config bisect via ktest.pl, it is very useful to
have a copy of each of the bisects used. This way, if a bisect were to go
wrong, it is possible to retrace the steps and continue at the location
before the error was made.

The ktest.pl will make a copy of the good and bad configs, labeled as such,
as well as a number attached to it that represents the iteration of the
bisect. These files are saved in the ktest temp directory where it currently
stores the good and bad config files.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 7570e36d636d..5f6f88911f5c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3188,6 +3188,8 @@ sub config_bisect_end {
     doprint "***************************************\n\n";
 }
 
+my $pass = 1;
+
 sub run_config_bisect {
     my ($good, $bad, $last_result) = @_;
     my $reset = "";
@@ -3210,11 +3212,15 @@ sub run_config_bisect {
 
     $ret = run_config_bisect_test $config_bisect_type;
     if ($ret) {
-        doprint "NEW GOOD CONFIG\n";
+        doprint "NEW GOOD CONFIG ($pass)\n";
+	system("cp $output_config $tmpdir/good_config.tmp.$pass");
+	$pass++;
 	# Return 3 for good config
 	return 3;
     } else {
-        doprint "NEW BAD CONFIG\n";
+        doprint "NEW BAD CONFIG ($pass)\n";
+	system("cp $output_config $tmpdir/bad_config.tmp.$pass");
+	$pass++;
 	# Return 4 for bad config
 	return 4;
     }
-- 
2.26.2


