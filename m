Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F1C206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nWWIozjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFJJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:09:56 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:38221 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgFJJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591780194; x=1623316194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=KPPDIbWDIIi7NcSqSfqP/mK+TVSC91eXbOcvGk49e8c=;
  b=nWWIozjEJsaZvpDBF2HNiKSMhlCwlvVppEcAPoeYdms8p7OqPnAKrjZT
   pH3nD7ITiU1FsW5fe27zLB2ySOQg6EZkWZ8voLa0rqWOrUIXiZGhp9aj1
   kJMn329fAGMiXLRkwvjDaAdic0swnjLNGRKTsMPtvU+eqEIdpeUHrPts/
   k=;
IronPort-SDR: 0edSOZcR2gKDa4qC/LHclU+V8vU3A6CUjYH5h59O4SLzvbQaROCJoduC9+yJqjIvWrXFweMGjp
 zPrGWzlyVzkw==
X-IronPort-AV: E=Sophos;i="5.73,495,1583193600"; 
   d="scan'208";a="42946930"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Jun 2020 09:09:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E9D9FA255A;
        Wed, 10 Jun 2020 09:09:50 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 09:09:50 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 09:09:43 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Joe Perches <joe@perches.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        <apw@canonical.com>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: Re: [PATCH v3 1/2] checkpatch: support deprecated terms checking
Date:   Wed, 10 Jun 2020 11:09:27 +0200
Message-ID: <20200610090927.2383-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9fcbcf91beb884ef8eac64471fe769edebce660c.camel@perches.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D02UWC003.ant.amazon.com (10.43.162.199) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 01:45:41 -0700 Joe Perches <joe@perches.com> wrote:

> On Wed, 2020-06-10 at 10:01 +0200, SeongJae Park wrote:
> > On Wed, 10 Jun 2020 00:13:42 -0700 Joe Perches <joe@perches.com> wrote:
> []
> > > This is a direct copy of the spelling dictionary
> > > loading code, so maybe these could be consolidated.
> > 
> > Agreed, how about below one?
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 524df88f9364..226f24e1f1f3 100755
> []
> > +sub read_word_corrections {
> > +	my ($file) = @_;
> > +	my $suspects;
> > +	my %fixes;
> 
> Right.
> 
> But I think this should take a hash reference
> as the second argument so the complete hash
> isn't created and returned.
> 
> []
> 
> > +# Load deprecated terms and build regular expression list.
> > +my %deprecated_terms_fix = read_word_corrections($deprecated_terms_file);
> 
> So this might be something like:
> 
> my %deprecated_terms;
> read_word_corrections($deprecated_terms_file, \%deprecated_terms);
> 
> etc...

Appreciate your nice suggestion!  So, I updated the patch as below:

================================= >8 ==========================================
From 0bcba551f429b0ccec4183437098b3b961d0a724 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Wed, 10 Jun 2020 07:11:57 +0200
Subject: [PATCH] checkpatch: support deprecated terms checking

Some terms could be deprecated for various reasons, but it is hard to
update the entire old usages.  That said, we could at least encourage
new patches to use the suggested replacements.  This commit adds check
of deprecated terms in the 'checkpatch.pl' for that.  The script will
get deprecated terms and suggested replacements of those from
'scripts/deprecated_terms.txt' file and warn if the deprecated terms are
used.  The mechanism and the format of the file are almost the same as
that of 'spelling.txt'.  For the reason, this commit modularizes the
read of the 'spelling.txt' and reuses.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/checkpatch.pl        | 60 +++++++++++++++++++++++++++---------
 scripts/deprecated_terms.txt |  5 +++
 2 files changed, 50 insertions(+), 15 deletions(-)
 create mode 100644 scripts/deprecated_terms.txt

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..c672091932bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -57,6 +57,7 @@ my $max_line_length = 100;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
+my $deprecated_terms_file = "$D/deprecated_terms.txt";
 my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
@@ -692,29 +693,40 @@ our $allowed_asm_includes = qr{(?x:
 )};
 # memory.h: ARM has a custom one
 
-# Load common spelling mistakes and build regular expression list.
-my $misspellings;
-my %spelling_fix;
+sub read_word_corrections {
+	my ($file, $fixesRef) = @_;
+	my $suspects;
 
-if (open(my $spelling, '<', $spelling_file)) {
-	while (<$spelling>) {
-		my $line = $_;
+	if (open(my $corrections, '<', $file)) {
+		while (<$corrections>) {
+			my $line = $_;
 
-		$line =~ s/\s*\n?$//g;
-		$line =~ s/^\s*//g;
+			$line =~ s/\s*\n?$//g;
+			$line =~ s/^\s*//g;
 
-		next if ($line =~ m/^\s*#/);
-		next if ($line =~ m/^\s*$/);
+			next if ($line =~ m/^\s*#/);
+			next if ($line =~ m/^\s*$/);
 
-		my ($suspect, $fix) = split(/\|\|/, $line);
+			my ($suspect, $fix) = split(/\|\|/, $line);
 
-		$spelling_fix{$suspect} = $fix;
+			$fixesRef->{$suspect} = $fix;
+		}
+		close($corrections);
+	} else {
+		warn "No correction will be found - file '$file': $!\n";
 	}
-	close($spelling);
-} else {
-	warn "No typos will be found - file '$spelling_file': $!\n";
 }
 
+# Load deprecated terms and build regular expression list.
+my %deprecated_terms_fix;
+read_word_corrections($deprecated_terms_file, \%deprecated_terms_fix);
+my $deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
+
+# Load common spelling mistakes and build regular expression list.
+my $misspellings;
+my %spelling_fix;
+read_word_corrections($spelling_file, \%spelling_fix);
+
 if ($codespell) {
 	if (open(my $spelling, '<', $codespellfile)) {
 		while (<$spelling>) {
@@ -2957,6 +2969,24 @@ sub process {
 			}
 		}
 
+# Check for deprecated terms
+		if (defined($deprecated_terms) &&
+		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
+			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) {
+				my $deprecated_term = $1;
+				my $suggested = $deprecated_terms_fix{lc($deprecated_term)};
+				$suggested = ucfirst($suggested) if ($deprecated_term=~ /^[A-Z]/);
+				$suggested = uc($suggested) if ($deprecated_term =~ /^[A-Z]+$/);
+				my $msg_level = \&WARN;
+				$msg_level = \&CHK if ($file);
+				if (&{$msg_level}("DEPRECATED_TERM",
+						  "Use of '$deprecated_term' is deprecated, please '$suggested', instead.\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($deprecated_term)($|[^A-Za-z@])/$1$suggested$3/;
+				}
+			}
+		}
+
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
new file mode 100644
index 000000000000..6faa06451c3d
--- /dev/null
+++ b/scripts/deprecated_terms.txt
@@ -0,0 +1,5 @@
+# License: GPLv2
+#
+# The format of each line is:
+# deprecated||suggested
+#
-- 
2.17.1

