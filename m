Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B990CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951ED207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ai5PHsxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFKG0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:26:22 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25093 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFKG0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591856780; x=1623392780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+baq+S9QXtjnz6BL0euBamFtPpFNS/Luy21TkafjyqQ=;
  b=Ai5PHsxdo+MruMppH52h3W5PRnHCmvSvIAbwiVX+THeVw/W2ermrd7oG
   GU9G09sMcANRo36vtC97kjpSPeJJ79yCtM7aXKVPUNdfMJIJAYqHn3ltG
   Auvx/CA73dGcuzy2xC0HVt3Ti+dQJbrVmN+0IuzuKfx/fbXnadLUWfFGp
   w=;
IronPort-SDR: WElbp48XphbwCXdz/YzWspjRUJI0pi2RgYKJISH0v2WGeDsI4eCOrBsnjtSdEodADExgJofSls
 x4YhDIpVUf8A==
X-IronPort-AV: E=Sophos;i="5.73,498,1583193600"; 
   d="scan'208";a="35689848"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Jun 2020 06:26:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 4E154C07DD;
        Thu, 11 Jun 2020 06:26:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.97) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 06:26:12 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     SeongJae Park <sjpark@amazon.de>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <jslaby@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] checkpatch: support deprecated terms checking
Date:   Thu, 11 Jun 2020 08:25:49 +0200
Message-ID: <20200611062550.20113-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611062550.20113-1-sjpark@amazon.com>
References: <20200611062550.20113-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.97]
X-ClientProxiedBy: EX13D06UWA001.ant.amazon.com (10.43.160.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

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

