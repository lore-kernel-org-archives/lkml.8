Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB815C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5B220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgGBM6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgGBM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3041420772;
        Thu,  2 Jul 2020 12:58:51 +0000 (UTC)
Date:   Thu, 2 Jul 2020 08:58:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the
 amount of log emailed
Message-ID: <20200702085849.16999b39@oasis.local.home>
In-Reply-To: <20200702123402.GA1773770@kroah.com>
References: <20200701231717.757834010@goodmis.org>
        <20200701231756.790637968@goodmis.org>
        <20200702074103.GA1076415@kroah.com>
        <20200702081949.2bfd2417@oasis.local.home>
        <20200702123402.GA1773770@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 14:34:02 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > I can add an option to do that if you want. My full logs end up being a
> > few hundred megabytes. Perhaps I could add a compress option too.  
> 
> It's fine, the default should be good enough for me for now.  If not,
> I'll just bump the value, or add compression.

If we compress, it would need to be an attachment. I'm guessing you are
fine with that. Do you already make it an attachment?

BTW, my test just failed and for some reason it created a 13162697 byte
log file to include in my email, which failed to send :-p 

Strange that it did that, as I had the max set to 950000. Thus, I've
changed this code to be:

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 917810fa4c85..9363a5b27339 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1499,18 +1499,21 @@ sub dodie {
        my $log_file;
 
        if (defined($opt{"LOG_FILE"})) {
-           my $size = 0;
+           my $whence = 0; # beginning of file
+           my $pos = $test_log_start;
+
            if (defined($mail_max_size)) {
                my $log_size = tell LOG;
                $log_size -= $test_log_start;
                if ($log_size > $mail_max_size) {
-                   $size = $log_size - $mail_max_size;
+                   $whence = 2; # end of file
+                   $pos = - $mail_max_size;
                }
            }
            $log_file = "$tmpdir/log";
            open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
            open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
-           seek(L, $test_log_start + $size, 0);
+           seek(L, $pos, $whence);
            while (<L>) {
                print O;
            }

Let's see if this now limits it :-/

-- Steve
