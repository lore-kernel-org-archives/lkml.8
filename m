Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB94BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962AB208B8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGAXSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgGAXR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4463212CC;
        Wed,  1 Jul 2020 23:17:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzI-00491e-Ts; Wed, 01 Jul 2020 19:17:56 -0400
Message-ID: <20200701231756.790637968@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the amount of log emailed
References: <20200701231717.757834010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add the ktest config option MAIL_MAX_SIZE that will limit the size of the
log file that is placed into the email on failure.

Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 12 +++++++++++-
 tools/testing/ktest/sample.conf | 13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 945a7d8c178c..d59a6b6bcfd5 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -227,6 +227,7 @@ my $dirname = $FindBin::Bin;
 my $mailto;
 my $mailer;
 my $mail_path;
+my $mail_max_size;
 my $mail_command;
 my $email_on_error;
 my $email_when_finished;
@@ -263,6 +264,7 @@ my %option_map = (
     "MAILTO"			=> \$mailto,
     "MAILER"			=> \$mailer,
     "MAIL_PATH"			=> \$mail_path,
+    "MAIL_MAX_SIZE"		=> \$mail_max_size,
     "MAIL_COMMAND"		=> \$mail_command,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
@@ -1497,10 +1499,18 @@ sub dodie {
 	my $log_file;
 
 	if (defined($opt{"LOG_FILE"})) {
+	    my $size = 0;
+	    if (defined($mail_max_size)) {
+		my $log_size = tell LOG;
+		$log_size -= $test_log_start;
+		if ($log_size > $mail_max_size) {
+		    $size = $log_size - $mail_max_size;
+		}
+	    }
 	    $log_file = "$tmpdir/log";
 	    open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
 	    open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
-	    seek(L, $test_log_start, 0);
+	    seek(L, $test_log_start + $size, 0);
 	    while (<L>) {
 		print O;
 	    }
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index cb8227fbd01e..5e7d1d729752 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -442,6 +442,19 @@
 # Users can cancel the test by Ctrl^C
 # (default 0)
 #EMAIL_WHEN_CANCELED = 1
+#
+# If a test ends with an error and EMAIL_ON_ERROR is set as well
+# as a LOG_FILE is defined, then the log of the failing test will
+# be included in the email that is sent.
+# It is possible that the log may be very large, in which case,
+# only the last amount of the log should be sent. To limit how
+# much of the log is sent, set MAIL_MAX_SIZE. This will be the
+# size in bytes of the last portion of the log of the failed
+# test file. That is, if this is set to 100000, then only the
+# last 100 thousand bytes of the log file will be included in
+# the email.
+# (default undef)
+#MAIL_MAX_SIZE = 1000000
 
 # Start a test setup. If you leave this off, all options
 # will be default and the test will run once.
-- 
2.26.2


