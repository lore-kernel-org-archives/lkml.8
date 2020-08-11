Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91681C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0F320716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHKBtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgHKBtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:49:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18CF20716;
        Tue, 11 Aug 2020 01:49:53 +0000 (UTC)
Date:   Mon, 10 Aug 2020 21:49:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [GIT PULL] ktest: Updates for 5.9
Message-ID: <20200810214952.394ccc78@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates for ktest 5.9

 - Have config-bisect save the good/bad configs at each step.
 - Show log file location even on success
 - Add PRE_TEST_DIE to kill test if the PRE_TEST fails
 - Add a NOT operator for conditionals in config file
 - Add the log output of the last test when emailing on failure.
 - Other minor clean ups and small fixes.


Please pull the latest ktest-v5.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.9

Tag SHA1: 21202864dc2a2ac81997d6ad62f8f36839c7c578
Head SHA1: ff131efff141fc679cccde28bc265f4c79cbe329


Colin Ian King (1):
      ktest.pl: Fix spelling mistake "Cant" -> "Can't"

Steven Rostedt (VMware) (9):
      ktest.pl: Have config-bisect save each config used in the bisect
      ktest.pl: Always show log file location if defined even on success
      ktest.pl: Define PRE_TEST_DIE to kill the test if the PRE_TEST fails
      ktest.pl: Add a NOT operator
      ktest.pl: Just open up the log file once
      ktest.pl: Turn off buffering to the log file
      ktest.pl: Add the log of last test in email on failure
      ktest.pl: Add MAIL_MAX_SIZE to limit the amount of log emailed
      ktest.pl: Change the logic to control the size of the log file emailed

----
 tools/testing/ktest/ktest.pl    | 103 +++++++++++++++++++++++++++++++++-------
 tools/testing/ktest/sample.conf |  18 +++++++
 2 files changed, 105 insertions(+), 16 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 7570e36d636d..cb16d2aac51c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -11,6 +11,7 @@ use File::Path qw(mkpath);
 use File::Copy qw(cp);
 use FileHandle;
 use FindBin;
+use IO::Handle;
 
 my $VERSION = "0.2";
 
@@ -81,6 +82,8 @@ my %default = (
     "IGNORE_UNUSED"		=> 0,
 );
 
+my $test_log_start = 0;
+
 my $ktest_config = "ktest.conf";
 my $version;
 my $have_version = 0;
@@ -98,6 +101,7 @@ my $final_post_ktest;
 my $pre_ktest;
 my $post_ktest;
 my $pre_test;
+my $pre_test_die;
 my $post_test;
 my $pre_build;
 my $post_build;
@@ -223,6 +227,7 @@ my $dirname = $FindBin::Bin;
 my $mailto;
 my $mailer;
 my $mail_path;
+my $mail_max_size;
 my $mail_command;
 my $email_on_error;
 my $email_when_finished;
@@ -259,6 +264,7 @@ my %option_map = (
     "MAILTO"			=> \$mailto,
     "MAILER"			=> \$mailer,
     "MAIL_PATH"			=> \$mail_path,
+    "MAIL_MAX_SIZE"		=> \$mail_max_size,
     "MAIL_COMMAND"		=> \$mail_command,
     "EMAIL_ON_ERROR"		=> \$email_on_error,
     "EMAIL_WHEN_FINISHED"	=> \$email_when_finished,
@@ -273,6 +279,7 @@ my %option_map = (
     "PRE_KTEST"			=> \$pre_ktest,
     "POST_KTEST"		=> \$post_ktest,
     "PRE_TEST"			=> \$pre_test,
+    "PRE_TEST_DIE"		=> \$pre_test_die,
     "POST_TEST"			=> \$post_test,
     "BUILD_TYPE"		=> \$build_type,
     "BUILD_OPTIONS"		=> \$build_options,
@@ -507,9 +514,7 @@ EOF
 
 sub _logit {
     if (defined($opt{"LOG_FILE"})) {
-	open(OUT, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
-	print OUT @_;
-	close(OUT);
+	print LOG @_;
     }
 }
 
@@ -909,6 +914,12 @@ sub process_expression {
 	}
     }
 
+    if ($val =~ s/^\s*NOT\s+(.*)//) {
+	my $express = $1;
+	my $ret = process_expression($name, $express);
+	return !$ret;
+    }
+
     if ($val =~ /^\s*0\s*$/) {
 	return 0;
     } elsif ($val =~ /^\s*\d+\s*$/) {
@@ -1485,8 +1496,32 @@ sub dodie {
 
     if ($email_on_error) {
 	my $name = get_test_name;
+	my $log_file;
+
+	if (defined($opt{"LOG_FILE"})) {
+	    my $whence = 0; # beginning of file
+	    my $pos = $test_log_start;
+
+	    if (defined($mail_max_size)) {
+		my $log_size = tell LOG;
+		$log_size -= $test_log_start;
+		if ($log_size > $mail_max_size) {
+		    $whence = 2; # end of file
+		    $pos = - $mail_max_size;
+		}
+	    }
+	    $log_file = "$tmpdir/log";
+	    open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
+	    open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
+	    seek(L, $pos, $whence);
+	    while (<L>) {
+		print O;
+	    }
+	    close O;
+	    close L;
+	}
         send_email("KTEST: critical failure for test $i [$name]",
-                "Your test started at $script_start_time has failed with:\n@_\n");
+                "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
     }
 
     if ($monitor_cnt) {
@@ -1508,7 +1543,7 @@ sub create_pty {
     my $TIOCGPTN = 0x80045430;
 
     sysopen($ptm, "/dev/ptmx", O_RDWR | O_NONBLOCK) or
-	dodie "Cant open /dev/ptmx";
+	dodie "Can't open /dev/ptmx";
 
     # unlockpt()
     $tmp = pack("i", 0);
@@ -1772,8 +1807,6 @@ sub run_command {
 	(fail "unable to exec $command" and return 0);
 
     if (defined($opt{"LOG_FILE"})) {
-	open(LOG, ">>$opt{LOG_FILE}") or
-	    dodie "failed to write to log";
 	$dolog = 1;
     }
 
@@ -1821,7 +1854,6 @@ sub run_command {
     }
 
     close(CMD);
-    close(LOG) if ($dolog);
     close(RD)  if ($dord);
 
     $end_time = time;
@@ -3188,6 +3220,8 @@ sub config_bisect_end {
     doprint "***************************************\n\n";
 }
 
+my $pass = 1;
+
 sub run_config_bisect {
     my ($good, $bad, $last_result) = @_;
     my $reset = "";
@@ -3210,11 +3244,15 @@ sub run_config_bisect {
 
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
@@ -4077,8 +4115,12 @@ if ($#new_configs >= 0) {
     }
 }
 
-if ($opt{"CLEAR_LOG"} && defined($opt{"LOG_FILE"})) {
-    unlink $opt{"LOG_FILE"};
+if (defined($opt{"LOG_FILE"})) {
+    if ($opt{"CLEAR_LOG"}) {
+	unlink $opt{"LOG_FILE"};
+    }
+    open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
+    LOG->autoflush(1);
 }
 
 doprint "\n\nSTARTING AUTOMATED TESTS\n\n";
@@ -4171,7 +4213,7 @@ sub find_mailer {
 }
 
 sub do_send_mail {
-    my ($subject, $message) = @_;
+    my ($subject, $message, $file) = @_;
 
     if (!defined($mail_path)) {
 	# find the mailer
@@ -4181,16 +4223,30 @@ sub do_send_mail {
 	}
     }
 
+    my $header_file = "$tmpdir/header";
+    open (HEAD, ">$header_file") or die "Can not create $header_file\n";
+    print HEAD "To: $mailto\n";
+    print HEAD "Subject: $subject\n\n";
+    print HEAD "$message\n";
+    close HEAD;
+
     if (!defined($mail_command)) {
 	if ($mailer eq "mail" || $mailer eq "mailx") {
-	    $mail_command = "\$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO <<< \'\$MESSAGE\'";
+	    $mail_command = "cat \$HEADER_FILE \$BODY_FILE | \$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO";
 	} elsif ($mailer eq "sendmail" ) {
-	    $mail_command =  "echo \'Subject: \$SUBJECT\n\n\$MESSAGE\' | \$MAIL_PATH/\$MAILER -t \$MAILTO";
+	    $mail_command =  "cat \$HEADER_FILE \$BODY_FILE | \$MAIL_PATH/\$MAILER -t \$MAILTO";
 	} else {
 	    die "\nYour mailer: $mailer is not supported.\n";
 	}
     }
 
+    if (defined($file)) {
+	$mail_command =~ s/\$BODY_FILE/$file/g;
+    } else {
+	$mail_command =~ s/\$BODY_FILE//g;
+    }
+
+    $mail_command =~ s/\$HEADER_FILE/$header_file/g;
     $mail_command =~ s/\$MAILER/$mailer/g;
     $mail_command =~ s/\$MAIL_PATH/$mail_path/g;
     $mail_command =~ s/\$MAILTO/$mailto/g;
@@ -4338,10 +4394,19 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
     }
 
     doprint "\n\n";
+
+    if (defined($opt{"LOG_FILE"})) {
+	$test_log_start = tell(LOG);
+    }
+
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
@@ -4441,4 +4506,10 @@ if ($email_when_finished) {
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
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 27666b8007ed..5e7d1d729752 100644
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
@@ -557,6 +570,11 @@
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
