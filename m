Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC357C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C28208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5m67fmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgEAOUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728839AbgEAOUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:20:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CFC061A0C;
        Fri,  1 May 2020 07:20:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so2343644pje.5;
        Fri, 01 May 2020 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=193/NI27mySpCAh+KIdjYzAM7oxeG6cz6/eob21DaRo=;
        b=A5m67fmSBEIu5hZjxOQ8YzHEgytFHmGf87v6I9J+L9B8TcomiIT/4rg+on+l9ZQC6h
         8uyxO8slRVMWKksaxlPjQYT1SCfcIuIYjfD/vF6b2iVJxs/ZARx+xtjxhvKZHmAD7jA3
         6sTa411e9piBXEWrZ0/cpmEfuvEoVM+wz+9rE7Dg9DitVap9F9Ydjxzmay+fISd4ksDY
         ICsgADrudDavbcH4Gwr2vQaQ5YPLKUl5NlyOv8DT1XZFHnCpPUhCfSc9wwJp5mEozmU1
         /zD51xxlJnUygl73bAn3VXELet49W6ye9qrh9yIOIpYhbhWUPefNDChYiknQQOyBbB3k
         a3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=193/NI27mySpCAh+KIdjYzAM7oxeG6cz6/eob21DaRo=;
        b=OuxX9jVhWZOx5KPdw3E2vdm2lkYjHu6STKGVs77ZOWYZ2stjhQ+myz40r/YaU2F/iY
         m3DcMTZnqeo8Nq+geRKHSNPxjAf9h2HP1WoqwJF8KaXG6HM1VwTbsxB92c0kLxNw+QD/
         60kXcDbAWGtIhZgks6ePUskgiwx7LRU/fnlfgzav5RJfHutAOft6gkqn0PMMWOddq7mi
         IidY2oTbTfplcLNyYkI1xml2XJ89wVYYTvnVWeVraph4bx45wUc0rBXGL4wrCga6RjWU
         vZkpHAsz22SJfuQf7eYG5DqAXtt/SeHZiL6fIVRDEsQnJG2XF47rkG2Gdb8KkzGLLgU0
         1O6g==
X-Gm-Message-State: AGi0PuYp7ArCG86NZFFwcUObhdPq/IeODyB0/1SmELJMI3o5KSJtp36b
        XDeAm5ewnFP7QCD/y9i8xus=
X-Google-Smtp-Source: APiQypI1a2t5ZsdligSOX64uMop1D8qtuO4O9jzzoSUe9OeRRqspFZxxxrK+kdfPQm3AeD8JyPciTQ==
X-Received: by 2002:a17:90a:24ea:: with SMTP id i97mr4907371pje.189.1588342831707;
        Fri, 01 May 2020 07:20:31 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id u5sm2411417pfu.198.2020.05.01.07.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 07:20:31 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 041ECKll029106;
        Fri, 1 May 2020 22:12:20 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 041EC313029090;
        Fri, 1 May 2020 22:12:03 +0800
Date:   Fri, 1 May 2020 22:12:03 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200501141203.GE28404@udknight>
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

The check doesn't support below formats:
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')

Note: this patch also fixes double quotation mark issue for normal git
      commit description, and now it supports double quotation mark in
      title line, for example:
      Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
      when checking usable channels"")

Based on original patch by Joe Perches <joe@perches.com>

Link: https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 If we really need to support for another quotation character, I think it is the single
 quotation mark, we could do it in next patch.

 v2:
 1: Add support for double quotation mark in title line, suggested by Markus Elfring.
 2: Add support for shorter title line with/without ellipsis.
 3: Add supported format examples and unsupported format examples in changelog.
 4: Fix a little wording issue in changelog , suggested by Markus Elfring.

 scripts/checkpatch.pl | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a66006..d9c95f1de025 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2818,57 +2818,83 @@ sub process {
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
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
+			my $acrosslines = 0;
+			my $title = "title line";
+			my $desc_mismatch = 0;
 
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
+			$short = 0 if ($line =~ /\b$prefix\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($line =~ /\b$prefix\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($line =~ /\b$prefix [0-9a-f]/i);
+			$case = 0 if ($line =~ /\b$prefix_case\s+[0-9a-f]{5,40}[^A-F]/);
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
+				$acrosslines = 1 if ($prefix eq "Fixes:");
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
+			if (defined($id) && ($orig_desc ne $description)) {
+			    # Allow short description without too short!
+			    if ($prefix eq "Fixes:" && $has_parens_and_dqm  && length($orig_desc) >= length($description)/2) {
+				$description = substr($description, 0, length($orig_desc));
+			    } else {
+				$desc_mismatch = 1;
+			    }
+			}
+
 			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $long || $space || $case || $desc_mismatch || !$has_parens_and_dqm || $acrosslines)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$prefix <12+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) . " $id (\"$description\")'\n" . $herecurr);
 			}
 		}
 
-- 
2.17.1
