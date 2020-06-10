Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4387B20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fqv5Ov6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFJGwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:52:53 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25991 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJGwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591771971; x=1623307971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=X/KMG1Y0K6zFZI74wO31eP5vnYbsFkbehcRe0e5hYVY=;
  b=fqv5Ov6jfrifJB5Q8cK9rWZr5HdF7j/Q1v20WcZr/UAbzTH1utQ35LR4
   jvHjJbf/a0xDFeRg0ODu4UIGbOBvmQmnkNVVDyUh/fQ/Nw7TePfeitggR
   kbroHYgzoDFPAsab2Gef66EvirYEaKV/bcpXMKIuBJj1lLWCbPc3OKG/s
   c=;
IronPort-SDR: 8oyw6uOn+cA8McMpvVpS8K/xh0UNMhJaCsXlLb374LZM9IcSEaNtfeb3g/YHb1NTKvFey5fsgY
 4pqdSTuD2JAQ==
X-IronPort-AV: E=Sophos;i="5.73,495,1583193600"; 
   d="scan'208";a="51175488"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Jun 2020 06:52:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 324CEA2613;
        Wed, 10 Jun 2020 06:52:48 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:47 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 06:52:43 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, <apw@canonical.com>, <joe@perches.com>
CC:     <colin.king@canonical.com>, <sj38.park@gmail.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 1/2] checkpatch: support deprecated terms checking
Date:   Wed, 10 Jun 2020 08:52:22 +0200
Message-ID: <20200610065223.29894-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610065223.29894-1-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13P01UWB002.ant.amazon.com (10.43.161.191) To
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
that of 'spelling.txt'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/checkpatch.pl        | 44 ++++++++++++++++++++++++++++++++++++
 scripts/deprecated_terms.txt |  5 ++++
 2 files changed, 49 insertions(+)
 create mode 100644 scripts/deprecated_terms.txt

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..970e0444dc1f 100755
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
@@ -692,6 +693,31 @@ our $allowed_asm_includes = qr{(?x:
 )};
 # memory.h: ARM has a custom one
 
+# Load deprecated terms and build regular expression list.
+my $deprecated_terms;
+my %deprecated_terms_fix;
+
+if (open(my $deprecates, '<', $deprecated_terms_file)) {
+	while (<$deprecates>) {
+		my $line = $_;
+
+		$line =~ s/\s*\n?$//g;
+		$line =~ s/^\s*//g;
+
+		next if ($line =~ m/^\s*#/);
+		next if ($line =~ m/^\s*$/);
+
+		my ($suspect, $fix) = split(/\|\|/, $line);
+
+		$deprecated_terms_fix{$suspect} = $fix;
+	}
+	close($deprecates);
+} else {
+	warn "No deprecated term will be found - file '$deprecated_terms_file': $!\n";
+}
+
+$deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
+
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
 my %spelling_fix;
@@ -2957,6 +2983,24 @@ sub process {
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

