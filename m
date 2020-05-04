Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944AD206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4xzFRWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEDIox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727837AbgEDIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:44:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61BC061A0E;
        Mon,  4 May 2020 01:44:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so843238plr.4;
        Mon, 04 May 2020 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5Yai1mh62Q1solPiCk5A4JNZMG/ryoGn53TObEH/YFg=;
        b=o4xzFRWzU2tr+XLFo5PWGsZcaQY2ul5XDfU2Lvl3XWIQP8GbUBh+YbC5zHZ+8QRU7m
         lOdGw0Qpw6rH8Waj/DANKJ/WMIRXeAykFQLUHxOg4UYTz5RQFVkyPYqpxyB6pXH7R04w
         ryVJm5xNKoAzJofrqEUxD1gDLDePO7EymsLodc0Mw3/OO5fM9UMdM16j8t9G4LMvGMcb
         /w0pkat6A2aGaOWVM1AY1xcWcxx/TU79Dgs1BEuwuvJVRvrey8YNxRanCn0PK2PdbA/w
         FRvYEd8ngU9imdW+TU1RziWcMGHeQSbFxLfNTYCHpyRjaS1y+ML3A6GYmbrE74ufC7Ss
         J1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5Yai1mh62Q1solPiCk5A4JNZMG/ryoGn53TObEH/YFg=;
        b=GARrR10EDvvvDQJvhPUS/xIbMxpeNDHvkfG6OkVtjbZMJg0Y8VhV7uk0DoX2VSob0q
         WaREuFGEU0NuXvs8TUIfLGxuSM3HWc/I53lKhjG1RZMyJzmZSdQtHvAe1QuYC6quyedC
         7k3VlDMjEs9z+icw3xJVqLN0g7pYtj4Xlp7ImeYbXQoOheqqE506Ju9Fw3uCrTMtFfJl
         OTPUYCv4ptLje0y71oUAGI6EHe8rDUKA4y2zlY7Ed7eIOMJJtpuYiZW+uqom4KEPvb3U
         rIUGjqLqUY1WYxyKTQWVLLs/AlsUhQJh/OjGQlw2NAtQEovD1Qr51wIDMmceepIN5Pjm
         i3YA==
X-Gm-Message-State: AGi0PuZe58xhDHOX0HxCOMLWIeYXQa+mhITqICT9Nwf2xWmMZY6BdH/r
        8I+VBK29WbJejxs1hk3qXxrEYelJ
X-Google-Smtp-Source: APiQypL1d3S6fbyn5nuBIaRXSKWV95qY4ZOfDy3bzbc8FMQrI/UCvoUVGtihU9OrNIenG7FMETsSyQ==
X-Received: by 2002:a17:90a:2709:: with SMTP id o9mr16113434pje.168.1588581892236;
        Mon, 04 May 2020 01:44:52 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.67])
        by smtp.gmail.com with ESMTPSA id gv24sm6202193pjb.6.2020.05.04.01.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 01:44:51 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 0448K61i030281;
        Mon, 4 May 2020 16:20:06 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 0448K2fm030280;
        Mon, 4 May 2020 16:20:02 +0800
Date:   Mon, 4 May 2020 16:20:02 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v6] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200504082002.GA29972@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to submitting-patches.rst, 'Fixes:' tag has a little
stricter condition about the one line summary than normal git
commit description:
“...
Do not split the tag across multiple lines, tags are exempt from
the "wrap at 75 columns" rule in order to simplify parsing scripts
...”

And there is no sanity check for 'Fixes:' tag format in checkpatch
the same as GIT_COMMIT_ID for git commit description, so let's expand
the GIT_COMMIT_ID to add 'Fixes:' tag format check support.

The check supports below formats:
Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")

The check doesn't support below formats and it will emit diagnostics info for them:
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')
Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")

Because after GIT_COMMIT_ID supports 'Fixes:' tag format check, it could do
the same check as the UNKNOWN_COMMIT_ID, so we don't need UNKNOWN_COMMIT_ID
anymore and I decide to delete it.

Note: this patch also fixes double quotation mark issue for normal git
      commit description, and now it supports double quotation mark in
      title line, for example:
      Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
      when checking usable channels"")

Note: this patch also adds diagnostics info support for normal git commit
      description format check.

Based on original patch by Joe Perches <joe@perches.com>

Link: https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 v6:
 1: Fix indentation issue.
 2: Fix a typo issue, reported by Markus Elfring.
 3: Reword some diagnostics info.
 4: Add support to check and emit sensible diagnostics
    info for description which spans across more than
    two lines.
 5: Avoid the word "acrosses", suggested by Markus Elfring.

 v5:
 1: Rebased on '[PATCH v2] checkpatch: fix can't check for too long invalid commit id'.
 2: Fix wrong diagnostics info for below non-standard 'Fixes:' formats.
    a: Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
    b: Fixes: da97e18458fb: ("perf_event: Add support for LSM and SELinux checks")
 3: Reword the diagnostics info for non-standard title format.

 v4:
 1: Add diagnostics info support, suggested by Joe Perches and Markus Elfring.
 2: Delete UNKNOWN_COMMIT_ID and do the check in GIT_COMMIT_ID.

 v3:
 1: Fix a bug in short title line support.

 v2:
 1: Add support for double quotation mark in title line, suggested by Markus Elfring.
 2: Add support for short title line with/without ellipsis.
 3: Add supported format examples and unsupported format examples in changelog.
 4: Fix a little wording issue in changelog , suggested by Markus Elfring.

 scripts/checkpatch.pl | 129 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 99 insertions(+), 30 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9b47584..ef34716 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2818,51 +2818,109 @@ sub process {
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+		     $line =~ /\bfixes:\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
+			my $prefix = "commit";
+			my $prefix_case = "[Cc]ommit";
 			my $short = 1;
 			my $long = 0;
 			my $case = 1;
 			my $space = 1;
+			my $space2 = 1;
 			my $hasdesc = 0;
-			my $hasparens = 0;
+			my $has_parens_and_dqm = 0; # Double quotation mark
 			my $hasprefix = 1;
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
 			my $sha1_length_min = 12;
+			my $acrosslines = 0;
+			my $title = "title line";
+			my $desc_mismatch = 0;
+			my $diagnostics = "Diagnostics info:\n";
+			my $name = "commit description";
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
+			if ($line =~ /\b(f)ixes:\s+([0-9a-f]{5,})\b/i) {
+				$init_char = $1;
+				$orig_commit = lc($2);
+				$prefix = "Fixes:";
+				$prefix_case = "Fixes:";
+				$init_char = "F";
+				$title = "a single line title (without line breaks but ellipsis is fine!)";
+				$name = "Fixes: tag";
+			} elsif ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 				$hasprefix = 0;
+				$diagnostics .= "Missing prefix \"$prefix_case\".\n";
+
+			}
+
+			if ($line =~ /\b$prefix\s+[0-9a-f]{41,}/i) {
+				$long = 1;
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{$sha1_length_min,40}/i) {
+				$short = 0;
+			} elsif ($hasprefix) {
+				$diagnostics .= "Commit id $orig_commit is too short.\n";
+			}
+
+			if ($line =~ /\b$prefix [0-9a-f]/i) {
+				$space = 0;
+			} elsif ($hasprefix) {
+				$diagnostics .= "Extra whitespace between prefix \"${init_char}" . substr($prefix, 1) . "\" and $orig_commit.\n";
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{$sha1_length_min,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			if ($line =~ /[0-9a-f]{5,} \S+/i || $line =~ /[0-9a-f]{5,}\s*$/i) {
+				$space2 = 0;
+			} elsif ($hasprefix) {
+				$diagnostics .= "Please use a and only a single whitespace between $orig_commit and title line.\n";
+			}
+
+			if ($line =~ /\b$prefix_case\s+[0-9a-f]{5,40}[^A-F]/) {
+				$case = 0;
+			} elsif ($hasprefix) {
+				$line =~ /(\b$prefix)\s+[0-9a-f]{5,40}[^A-F]/i;
+				$diagnostics .= "The prefix \"$1\" has case error.\n";
+			}
+
+			if ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {
 				$orig_desc = $1;
-				$hasparens = 1;
+				$has_parens_and_dqm = 1;
+				# Drop the ellipsis
+				if ($prefix eq "Fixes:" && $orig_desc =~ /(\s*\.{3}\s*$)/) {
+				    $orig_desc = substr($orig_desc, 0, length($orig_desc) - length($1));
+				}
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
+				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
 				$orig_desc = $1;
-				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+				$has_parens_and_dqm = 1;
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
+				$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)$/i;
 				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
+				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
 				$orig_desc .= " " . $1;
-				$hasparens = 1;
+				$has_parens_and_dqm = 1;
+
+				if ($prefix eq "Fixes:") {
+					$acrosslines = 1;
+					$diagnostics .= "The $name spans across lines.\n";
+				}
+			} elsif (($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+				  defined $rawlines[$linenr] &&
+				  $rawlines[$linenr] =~ /^\s*\("/) ||
+				 $line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i) {
+				$diagnostics .= "Missing right '\")' at the end of title line?\n";
+				$diagnostics .= "The $name spans across more than two lines?\n";
+			} elsif ($hasprefix && !$space2) {
+				$diagnostics .= "No title line in '(\"<$title>\")' format is found.\n";
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
@@ -2879,10 +2937,32 @@ sub process {
 				}
 			}
 
+			if (defined($id) && $has_parens_and_dqm && ($orig_desc ne $description)) {
+			    # Allow short description without too short!
+				if ($prefix eq "Fixes:") {
+						if (length($orig_desc) >= length($description)/2) {
+							my $desc = substr($description, 0, length($orig_desc));
+
+							if ($orig_desc ne $desc) {
+								$desc_mismatch = 1;
+								$diagnostics .= "The title line doesn't match the original commit.\n";
+							}
+						} else {
+							$desc_mismatch = 1;
+							$diagnostics .= "The title line is too abbreviated, at least half of original commit is necessary.\n";
+						}
+				} else {
+						$desc_mismatch = 1;
+						$diagnostics .= "The title line doesn't match the original commit.\n";
+				}
+			}
+
 			if (defined($id) &&
-			   ($short || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $space || $space2 || $case || $desc_mismatch || !$hasprefix || !$has_parens_and_dqm || $acrosslines)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <$sha1_length_min+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style:\n$prefix <$sha1_length_min+ chars of sha1> (\"<$title>\")\n" .
+				      "i.e.: '${init_char}" . substr($prefix, 1) . " $id (\"$description\")'\n" .
+				      $diagnostics . $herecurr);
 			}
 		}
 
@@ -2982,17 +3062,6 @@ sub process {
 			}
 		}
 
-# check for invalid commit id
-		if ($in_commit_log && $line =~ /^fixes:\s+([0-9a-f]{6,40})\b/i) {
-			my $id;
-			my $description;
-			($id, $description) = git_commit_info($1, undef, undef);
-			if (!defined($id)) {
-				WARN("UNKNOWN_COMMIT_ID",
-				     "Unknown commit id '$1', maybe rebased or not pulled?\n" . $herecurr);
-			}
-		}
-
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
