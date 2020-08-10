Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336A92083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgHJS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbgHJS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:29:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E58420885;
        Mon, 10 Aug 2020 18:29:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k5CXd-0071Wa-4M; Mon, 10 Aug 2020 14:29:01 -0400
Message-ID: <20200810182901.020100850@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 10 Aug 2020 14:28:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-linus][PATCH 1/2] ktest.pl: Change the logic to control the size of the log file
 emailed
References: <20200810182836.746909615@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the log file for a given test is larger than the max size given then use
set the seek from the end of the log file instead of from the start of the
test.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 36db5b0b3647..9363a5b27339 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1499,18 +1499,21 @@ sub dodie {
 	my $log_file;
 
 	if (defined($opt{"LOG_FILE"})) {
-	    my $size = 0;
+	    my $whence = 0; # beginning of file
+	    my $pos = $test_log_start;
+
 	    if (defined($mail_max_size)) {
 		my $log_size = tell LOG;
 		$log_size -= $test_log_start;
 		if ($log_size > $mail_max_size) {
-		    $size = $log_size - $mail_max_size;
+		    $whence = 2; # end of file
+		    $pos = - $mail_max_size;
 		}
 	    }
 	    $log_file = "$tmpdir/log";
 	    open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
 	    open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
-	    seek(L, $test_log_start + $size, 0);
+	    seek(L, $pos, $whence);
 	    while (<L>) {
 		print O;
 	    }
-- 
2.28.0


