Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C11E20731
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr5WJqOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgEBSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgEBSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:54:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C21C061A0C;
        Sat,  2 May 2020 11:54:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s8so6359676pgq.1;
        Sat, 02 May 2020 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=gYq5vmxOomsqWPpkcNRbfrWZVck9J/o1hmTDMesCO0w=;
        b=Fr5WJqOzB1YpznML2R0wb6vQuQqxc6kv82NR8AXYygaK3S+trETf+ETJE/Ik+74eLk
         pymLm93Nac2xeEzPmzyYUkuu98KnZPxjoGYNCn3gN7AWR0s4bPkvCzqSNGoneFK5x4Av
         RLc/jelHHomkGztXarzJ+E6LCn533pTX/z4pzGhgDC7Eu6O6FV2x1Fo6+1V+Qdha0EF0
         4MaDy1fGxLqxhmuureNg1H/3c76jtQeBXSQejaZjC47dmlG1wWS3XLfQ8FBzh0vJ6Aqh
         o6grW6qEgd/TgSvmOVb/UTlv0NBWHJZlS+sxVE5Bw60ZCCn0e01DFE7pBtH1qj+fZr+v
         GJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=gYq5vmxOomsqWPpkcNRbfrWZVck9J/o1hmTDMesCO0w=;
        b=tU0z4kLAkS1GTmmAGGg0ZQSyBUeSEENk4CJCjS9c8Un7d2PlKue25N8U3zS2Lq1TAA
         lXxtfP3HazMstRN6972aptnWQiSLzpbGJCnvatxL2sW7fe9HgSVW3F+OwCVaBBy9eFHz
         rV5LmlB9yzzWTHHLFZUBOJxqCMAKxJ4npV2/6UbAsd9Y0OonNAcAaF4ij/R6VNvS5weh
         x9f94xszCQUza8KCI0d4Mwo3d1PXgPqeiVyneD+9OIKYgjBv1xp/2LuCXrFSLUZ6WeOR
         MAA6o5ERaNuP09cDe0E3EnOIZjQ3M9RP+8GK/Dg7Z6L2fw5TmHJCXSftlBcA6cyBSyHU
         NpUA==
X-Gm-Message-State: AGi0Puaj4eh2GLXJ3iJ9iEBJwsrXVUbavVYYrGFKK6C0m2k1hSxTjdfm
        BkYXw+7upfS10UrPk7bmflU=
X-Google-Smtp-Source: APiQypIq/Pcr366W5iK/254l7DQEV+GHcMJAl+8C0DyHj0yD9ehplx6Kw0ME+Z9nHKaNt75FiRGAqA==
X-Received: by 2002:a62:b501:: with SMTP id y1mr9991767pfe.307.1588445665786;
        Sat, 02 May 2020 11:54:25 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id a16sm4568693pgg.23.2020.05.02.11.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 11:54:25 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 042IsLa8009279;
        Sun, 3 May 2020 02:54:21 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 042IsLUj009278;
        Sun, 3 May 2020 02:54:21 +0800
Date:   Sun, 3 May 2020 02:54:21 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v4] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200502185421.GB9082@udknight>
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

 scripts/checkpatch.pl | 115 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 30 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 143bb43..b5768e0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2818,48 +2818,93 @@ sub process {
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
 			my $hasdesc = 0;
-			my $hasparens = 0;
+			my $has_parens_and_dqm = 0; # Double quotation mark
+			my $hasprefix = 1;
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
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
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			if ($line !~ /\b$prefix\s+/i) {
+				$hasprefix = 0;
+				$diagnostics .= "Missing prefix \"$prefix_case\".\n";
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{41,}/i) {
+				$long = 1;
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{12,40}/i) {
+				$short = 0;
+			} else {
+				$diagnostics .= "Commit id $orig_commit is too short.\n";
+			}
+
+			if ($line =~ /\b$prefix [0-9a-f]/i) {
+				$space = 0;
+			} elsif ($hasprefix) {
+				$diagnostics .= "Extra whitespace between prefix \"${init_char}" . substr($prefix, 1) . "\" and $orig_commit.\n";
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
+					$diagnostics .= "The title acrosses lines.\n";
+				}
+			} elsif ($hasprefix) {
+				$diagnostics .= "Missing a pair of parentheses '()' or a pair of double quotation marks (\"\").\n";
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
@@ -2875,10 +2920,31 @@ sub process {
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
+			   ($short || $space || $case || $desc_mismatch || !$hasprefix || !$has_parens_and_dqm || $acrosslines)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$prefix <12+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) . " $id (\"$description\")'\n" .
+				      $diagnostics . $herecurr);
 			}
 		}
 
@@ -2978,17 +3044,6 @@ sub process {
 			}
 		}
 
-# check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:)\s+([0-9a-f]{6,40})\b/i) {
-			my $id;
-			my $description;
-			($id, $description) = git_commit_info($2, undef, undef);
-			if (!defined($id)) {
-				WARN("UNKNOWN_COMMIT_ID",
-				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
-			}
-		}
-
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
