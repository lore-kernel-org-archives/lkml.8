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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BBC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528722071C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taljpVsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgECLy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgECLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 07:54:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC34C061A0C;
        Sun,  3 May 2020 04:54:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s8so7164257pgq.1;
        Sun, 03 May 2020 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=BUkMHQD/V/0ORXwYkMywhz4/rrG1c8EmuLKXI0QJv5w=;
        b=taljpVsPcYgjASQ7IomkR3YZJbOLGafzFyqXmnvC+6zVFMEzneQ/8JJmzqgIPrWV1w
         rNfS74InWNxXvxnoxhsfXdS9foq22gGlbS7hBBDXSYKxaGhzfDNHbIr9xP5GIbu5jMti
         jqbeMBcvYK37h4NxLpjBckvG8fuJdlpw3xs5DUT4HnCNMSo/GPXlHN07v8npHM+3Pjag
         WBlMXAH66S4vfAbf1Fzxw8ddkyylrOv4UKPSoKyyScfS6zzQYyKN4lM4JQOyWPn9WYIe
         BCYi26Y4EAF6gM7zNQhDkRlkRcMypDdVJjG8QxV6pbUyO9vuBMmwSA2pcxjiQhY4RsuN
         mq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=BUkMHQD/V/0ORXwYkMywhz4/rrG1c8EmuLKXI0QJv5w=;
        b=FbIeuAEcJ/5kap8L313Qzpsm02yXNeppmS5dGlKD9J8UBVER4VWHekANcwn9yel1L8
         AaEe2DLSqgyuOdIQoPbZWNumRqUGn+6oCMo4Us0C5ofAUiUwwgAsa82bJpA8Ml0VHjzV
         h40EP9Oz39Wm0rA6YQpLSw1F72AGQlzh3UbGf3MWZDjfDif5hMTCMww+Yww91q/N0BSM
         xkYt1msvPZAWnHPB3tllO2W3Fhx27yuUHTunxgdd9tTBBdRpTT/IHSPmYfKibC1OGrJP
         u/OWzPUE23hN5+2K6szmKzZLg5SIfoF81GuBjaTKWgaaJEqtTDUz+5yGK47aYjmlUF2p
         ad8w==
X-Gm-Message-State: AGi0PuYAL1+rBq+U7qz5ILPUOGDdovV/JUzjeW45PWsRuEr9Bam+Qv6J
        uV76aQKOXNUr7gk6lEx+Eo8=
X-Google-Smtp-Source: APiQypLSSrXj5uw+ridEe+sj0GIban+7bcW+DaU/Y1Q3vv/3T6eTmpmIzsNSRfjyeFG4O42Em5UXAQ==
X-Received: by 2002:a62:1415:: with SMTP id 21mr12503275pfu.203.1588506865450;
        Sun, 03 May 2020 04:54:25 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id r18sm5775570pgu.93.2020.05.03.04.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 04:54:24 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 043Bs62H010515;
        Sun, 3 May 2020 19:54:06 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 043Bs6Zl010514;
        Sun, 3 May 2020 19:54:06 +0800
Date:   Sun, 3 May 2020 19:54:06 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] checkpatch: fix can't check for too long invalid commit id
Message-ID: <20200503115406.GB10332@udknight>
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

The current UNKNOWN_COMMIT_ID doesn't check for 41+ length commit id,
and although GIT_COMMIT_ID will check for 41+ length commit id, but
it willn't warn anything about it due to 41+ length commit will never
be defined.

This patch moves the unknown commit id check for normal commit description
to GIT_COMMIT_ID, and uses ERROR instead of WARN, because unknown commit
id is total useless to track change history in changelog, it deserves the
ERROR.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 v2:
 1: Fix annonying "Invalid commit id" reports for non commit id number string.
 2: Fix indentaton issue, reported by Joe Perches.
 3: Reword the error message in code, suggested by Joe Perches.
 4: Delete unnecessary capture group in UNKNOWN_COMMIT_ID, suggested by Joe Perches.

 scripts/checkpatch.pl | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a..9b47584 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2829,18 +2829,21 @@ sub process {
 			my $space = 1;
 			my $hasdesc = 0;
 			my $hasparens = 0;
+			my $hasprefix = 1;
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
+			my $sha1_length_min = 12;
 
 			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
+				$hasprefix = 0;
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{$sha1_length_min,40}/i);
 			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
 			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
 			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
@@ -2865,10 +2868,21 @@ sub process {
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
+			if ($hasprefix && !defined($id)) {
+				if ($long) {
+					ERROR("GIT_COMMIT_ID",
+					      "Invalid commit id '$orig_commit' length '" . length($orig_commit) . "' exceeds allowed maxium of 40
+					      ($sha1_length_min+ chars of sha1 is recommended).\n" . $herecurr);
+				} else {
+					ERROR("GIT_COMMIT_ID",
+					      "Unknown commit id '$orig_commit', maybe rebased or not pulled?\n" . $herecurr);
+				}
+			}
+
 			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style 'commit <$sha1_length_min+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
 			}
 		}
 
@@ -2969,13 +2983,13 @@ sub process {
 		}
 
 # check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+		if ($in_commit_log && $line =~ /^fixes:\s+([0-9a-f]{6,40})\b/i) {
 			my $id;
 			my $description;
-			($id, $description) = git_commit_info($2, undef, undef);
+			($id, $description) = git_commit_info($1, undef, undef);
 			if (!defined($id)) {
 				WARN("UNKNOWN_COMMIT_ID",
-				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
+				     "Unknown commit id '$1', maybe rebased or not pulled?\n" . $herecurr);
 			}
 		}
 
-- 
1.8.5.6.2.g3d8a54e.dirty
