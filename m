Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42327C47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104172075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPomszDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgECMls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgECMll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:41:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED3C061A0C;
        Sun,  3 May 2020 05:41:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so2460270pjh.2;
        Sun, 03 May 2020 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=sNWSQ2e3r65fi7p5W91A8INqU44yfXT1VyZpZnHk3PE=;
        b=fPomszDW1YQ8WpuzNi2j+327BhK882U+wiWEjzhDb/iUjNzGmhZ5haSzOJJwW6pVOe
         N7PSWpKoPkT7bgmO1yb27ip0+M5T3puGEBy8Y8VciAePEyyEnrxkiZo6fiIG67fz+2ol
         c988fHeM4JreZIMv3iv0Bz0mqTuP1kn8o32K7JVQky7up6oRW5gyeaSZOUirxZwg6eBV
         uou9HwwwdlrS+tN8zyamoEHVbIhYiqgN2dHwmeYFXrbQMaTbbugJSzjtuq7ZavTCC3ro
         kIFej+/8mZfkj7ARTV06+Khbz/a+sma3dYHQaC8Bkuta4+jqv4nZFLiRSOBKRgMcCr7s
         yB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=sNWSQ2e3r65fi7p5W91A8INqU44yfXT1VyZpZnHk3PE=;
        b=C/jNQRT4AiyZCcZantL6mu3saXLUwofxZEYFIae3vi7vEQybaPBcbShOVispIFlMQO
         Ab1RtWffO0g589eNuH0a8uk47hG4/wnTyGZqjEnU782p1s1lLI3UH6lCsqaVFrNzLDU9
         YT/WiCB2LdgP5c+T7F1+sUgrz9jVsEjRTMarFrGeFQQ8Od9KAUWr9K5PkpmhCHscLTJc
         wD7DWh4nzG14VHh1I/xGACKsv55sCcpdDKJ/m9b05gHxnAs5K9nCpttmhQTI8qcKvUuR
         xmwrVItM+uoxSVPBQH040ZY00FBXvvz38YxzzDDHOuOz+z3IoBwS6vIzB2slvj9/ger3
         lDqw==
X-Gm-Message-State: AGi0PuaXyxfN4+EdnUfKM3c8cZAKdvWg7/sFJ9jxBmoi2EIugtaK3CuK
        vEgNo/qY4bhv2wkrZs03jOg=
X-Google-Smtp-Source: APiQypLjATz9wkmaDQktTALbjScSlhruKcRRHIFI94E+/fZE10QzK1lGQRV4lENpBGFKw6EIzM0fUA==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr11221813pjt.196.1588509700533;
        Sun, 03 May 2020 05:41:40 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id d74sm6512030pfd.70.2020.05.03.05.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 05:41:39 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 043CTdK4011004;
        Sun, 3 May 2020 20:29:39 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 043CTdmC011003;
        Sun, 3 May 2020 20:29:39 +0800
Date:   Sun, 3 May 2020 20:29:38 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v5] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200503122938.GC10332@udknight>
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
 Hi! Joe and all.

 This is the v5 version, and I have tested it with below command:
 $ git log -10000 --no-merges --grep="Fixes:" --format=%H | \
 while read commit ; do \
   ./scripts/checkpatch.pl --git $commit --types=GIT_COMMIT_ID --quiet --nosummary; \
 done

 The result looks good enough already.

 Thanks.

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

 scripts/checkpatch.pl | 120 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 30 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9b47584..a1e4113 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2818,51 +2818,101 @@ sub process {
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
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
+			if ($line =~ /\b(f)ixes:\s+([0-9a-f]{5,})\b/i) {
+				$init_char = $1;
+				$orig_commit = lc($2);
+				$prefix = "Fixes:";
+				$prefix_case = "Fixes:";
+				$init_char = "F";
+				$title = "a single line title (without line breaks but ellipsis is fine!)";
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
+			}
+
+			if ($line =~ /[0-9a-f]{5,} \S+/i || $line =~ /[0-9a-f]{5,}\s*$/i) {
+				$space2 = 0;
+			} elsif ($hasprefix) {
+				$diagnostics .= "We need a single whitespace and only a single whitespace between $orig_commit and title.\n";
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{$sha1_length_min,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
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
+					$diagnostics .= "The title acrosses lines.\n";
+				}
+			} elsif ($hasprefix && !$space2) {
+				$diagnostics .= "No title in '(\"<$title>\")' format is found.\n";
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
@@ -2879,10 +2929,31 @@ sub process {
 				}
 			}
 
+			if (defined($id) && $has_parens_and_dqm && ($orig_desc ne $description)) {
+			    # Allow short description without too short!
+			    if ($prefix eq "Fixes:") {
+				if (length($orig_desc) >= length($description)/2) {
+					my $desc = substr($description, 0, length($orig_desc));
+
+					if ($orig_desc ne $desc) {
+						$desc_mismatch = 1;
+						$diagnostics .= "The title doesn't match the original commit.\n";
+					}
+				} else {
+					$desc_mismatch = 1;
+					$diagnostics .= "The title is too abbreviated, at least half of orignial commit title is necessary.\n";
+				}
+			    } else {
+					$desc_mismatch = 1;
+					$diagnostics .= "The title doesn't match the original commit.\n";
+			    }
+			}
+
 			if (defined($id) &&
-			   ($short || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $space || $space2 || $case || $desc_mismatch || !$hasprefix || !$has_parens_and_dqm || $acrosslines)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <$sha1_length_min+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$prefix <$sha1_length_min+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) .
+				      " $id (\"$description\")'\n" . $diagnostics . $herecurr);
 			}
 		}
 
@@ -2982,17 +3053,6 @@ sub process {
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
