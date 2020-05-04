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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99403C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667F5206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOMsWwB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgEDIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgEDIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:37:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C095C061A0E;
        Mon,  4 May 2020 01:37:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so6513146plo.7;
        Mon, 04 May 2020 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=F4fr9XBi1a/oSkiQzUJpCLmRF7yWLA9/RoAGqLKM65U=;
        b=BOMsWwB01TCxwzPOJoHmTnCHW3jYNKZB7GWyOete9/X0teL4bxx9EaY1d8wFMlGZRA
         x/ZryFxdEMkl9Acn7n+MkofZ4lRWnfam8m+NiNTvdnq5jYe8HYz8B6YMwHDSXilWa6tb
         jh5bGQNOYps9Ee02CK3qEEhqTYkRIlkHigUJKpmfVy5zt5unbWIU+CeVXdD+yeMgSW5b
         8ow24MtCnBUVyj6OrlD3iNxH6hxZaTTZROgifuOE5QzwN2mw7QGhk8aXqbKyX0fYrq1L
         YLO9RvWDf9AzAU4CjQQUrZewbchEPC/e0JbRdXNbvfKjE77EhKG5Im8SVZL89k2sjNai
         ThGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=F4fr9XBi1a/oSkiQzUJpCLmRF7yWLA9/RoAGqLKM65U=;
        b=kIjDV18+DIwhg4cqRcopomzjGvotfFFStY8NQowt+MLrwxEAke2/f5VXoLQSlE7soJ
         0BRuMzr7mjOfeoAUsUOKR0W+BPAdcYNDOXW5BFBPw6Ik0TUF5hK6DjI6wlIP38xsTSft
         LTF4n4pEtQJ21sbSeeOgyW98I8t5bTEHVri+SKqPSAF8/1Dsw9aL9qANgoX4BNCsHv5B
         T2I2tvG90/LYrw/zzT2MGeiivhPsgHETYIfztHOpUapw/e47N+h3BhUWi8jmxYBDFZa3
         iyEHFiC9W8kgtQ4zvASu+EaZocmdbMQUxvuQhQYfTx0vQH1heZ6+ITNkAn9f7gmLlSK/
         zLJw==
X-Gm-Message-State: AGi0Pub2LlyX2NH9GDjB34oiBN+lez+t8Cz54oR9hmRkLG2zQTzG8xiN
        b07FmhT/vchhvrOHN1MO2Xs=
X-Google-Smtp-Source: APiQypJJ/XkAPpX53ra71qD6r+VzFBmf9NoajSmGICFKdxVuhiQng5atd8KdB+uelFWV+UVaKLaR8w==
X-Received: by 2002:a17:90a:68cb:: with SMTP id q11mr16665686pjj.15.1588581432612;
        Mon, 04 May 2020 01:37:12 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.67])
        by smtp.gmail.com with ESMTPSA id v7sm8156629pfm.146.2020.05.04.01.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 01:37:12 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 0448b726030855;
        Mon, 4 May 2020 16:37:07 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 0448b64s030854;
        Mon, 4 May 2020 16:37:06 +0800
Date:   Mon, 4 May 2020 16:37:06 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] checkpatch: allow commit description spans across three
 lines
Message-ID: <20200504083706.GA30290@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current GIT_COMMIT_ID will report error when the commit description
spans across three lines, for examples:
"...
To rehash a previous explanation given in commit 1c44ce560b4d ("net:
mscc: ocelot: fix vlan_filtering when enslaving to bridge before link is
up"), the switch driver operates the in a mode where a single VLAN can
be transmitted as untagged on a particular egress port. That is the
"native VLAN on trunk port" use case.
..."

The above changelog comes from commit 87b0f983f66f ("net: mscc: ocelot:
fix untagged packet drops when enslaving to vlan aware bridge").

"...
With the optimizations for TLB invalidation from commit 0cef77c7798a
("powerpc/64s/radix: flush remote CPUs out of single-threaded
mm_cpumask"), the scope of a TLBI (global vs. local) can now be
..."

The above changelog comes from commit cca19f0b684f ("powerpc/64s/radix: Fix
missing global invalidations when removing copro").

The total length of commit description ("commit"+"12+ SHA1"+("title line"))
exceeds 85 isn't uncommon thing, and it isn't uncommon thing that the ~85
characters span across three lines, see above examples.

This patch adds support to recognize commit description which spans across
three lines, then it will not emit error message for such situation.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Hi! Joe
 
 I have tested with below command:
 git log -10000 --format=%H -i --grep=" commit " | \
 while read commit ; do \
    echo $commit; \
    ./scripts/checkpatch.pl --git $commit --types=GIT_COMMIT_ID --quiet --nosummary --color=never; \
    done

 There are ~50 properly formed commit descriptions belong to this class, and I haven't check for
 the non-standard commit descriptions, for examples:
 3403e56b41c176f6531a2a6d77d85b46fa34169c
 a78945c357f58665d6a5da8a69e085898e831c70
 87b0f983f66f23762921129fd35966eddc3f2dae
 ac8517440344dbe598f7c1c23e686c800b563061
 cca19f0b684f4ed6aabf6ad07ae3e15e77bfd78a
 53406ed1bcfdabe4b5bc35e6d17946c6f9f563e2

 This number isn't big, but they are all in properly formed format, so I think we should support them
 and avoid emitting false positive error report.

 v2:
 1: Reword the title line.
 2: Reword the changelog.
 3: Rewrite the implementation.

 scripts/checkpatch.pl | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ef34716..8cfc3a9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2900,6 +2900,16 @@ sub process {
 				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
 				$orig_desc = $1;
 				$has_parens_and_dqm = 1;
+			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+				 defined $rawlines[$linenr] &&
+				 $rawlines[$linenr] =~ /^\s*\(".+$/ &&
+				 defined $rawlines[$linenr + 1] &&
+				 $rawlines[$linenr + 1] =~ /^\s*.+"\)/) {
+				$rawlines[$linenr] =~ /^\s*\("(.+)$/i;
+				$orig_desc = $1;
+				$rawlines[$linenr + 1] =~ /^\s*(.+)"\)/;
+				$orig_desc .= " " . $1;
+				$has_parens_and_dqm = 1;
 			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
@@ -2913,12 +2923,29 @@ sub process {
 					$acrosslines = 1;
 					$diagnostics .= "The $name spans across lines.\n";
 				}
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i &&
+				 defined $rawlines[$linenr] &&
+				 $rawlines[$linenr] !~ /^\s*.+"\)/ &&
+				 defined $rawlines[$linenr + 1] &&
+				 $rawlines[$linenr + 1] =~ /^\s*.+"\)/) {
+				$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)$/i;
+				$orig_desc = $1;
+				$rawlines[$linenr] =~ /^\s*(.+)/;
+				$orig_desc .= " " . $1;
+				$rawlines[$linenr + 1] =~ /^\s*(.+)"\)/;
+				$orig_desc .= " " . $1;
+				$has_parens_and_dqm = 1;
+
+				if ($prefix eq "Fixes:") {
+					$acrosslines = 1;
+					$diagnostics .= "The $name spans across lines.\n";
+				}
 			} elsif (($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				  defined $rawlines[$linenr] &&
 				  $rawlines[$linenr] =~ /^\s*\("/) ||
 				 $line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i) {
 				$diagnostics .= "Missing right '\")' at the end of title line?\n";
-				$diagnostics .= "The $name spans across more than two lines?\n";
+				$diagnostics .= "The $name spans across more than three lines?\n";
 			} elsif ($hasprefix && !$space2) {
 				$diagnostics .= "No title line in '(\"<$title>\")' format is found.\n";
 			}
-- 
1.8.5.6.2.g3d8a54e.dirty
