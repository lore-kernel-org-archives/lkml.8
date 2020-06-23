Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB753C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDD820888
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="koEyrONJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgFWWSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbgFWWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:18:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B57C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:18:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so307929wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDoDzgwzXvn64FM+iS8jSPBiWeuVTBlMDJ+h6gF0/y4=;
        b=koEyrONJcEQIC2wAovjNrJWAovupzZdarkutAOOx5yvhbte5+hQYIe7v1KJq5XaHSS
         keNxlHwwopHOl7l9QVqdqvfFIsboZ1pkilBayyAL+sBkomcL9Ocu6AW9LoenF4Q9eSL4
         ol3vA5hYPTjO2wJlyum/CqeypM7MXhT2Xb4c6gptcLQOp+92fp+GvcvoMJHaq9s3zMcg
         E+O7kzrUuuKkI6vhco6b0kB4xOxGnzSruDDMPssp18ZGZYhp6+ixgQM4EaBXQC6WVvPO
         n+QyT4mPAuGT6TpvUx07gRo4hsxf3HECBY/pVmslsC4ZHKAMrzkQ6H2sGH1MCgmHOvG/
         MZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDoDzgwzXvn64FM+iS8jSPBiWeuVTBlMDJ+h6gF0/y4=;
        b=Sdv/YAPAcjA//WJf2q9Qw2R+onomI0CSdSUjL2U0GuRfAE2R0ED6OyQefJyCEUep0q
         M4NfF6CMM9w1fEkORUJHeTl1d0NPMujJ3cZjQNAtM1O5FQ8bAX/vVhKUeAlx7QqI6QgR
         AgH+9ySN+52JxcXg6vstR4lya8se0M0RXTXPRHpPoWV3ZmQswwLjYo0MeCAkJ94fbMDw
         4b9jdNvWuC08h2IGHhrWcY5CregMzlUa7N/bnm0amXt5DI/zXanTRiCD/mTdurILnjjt
         tjpjmrTwALbXjBfaOZjvHQe6JDDGw/wbGMONgJGjQPxbTlR/Yl8lSmnJA22FINo5rRQF
         2auQ==
X-Gm-Message-State: AOAM530VwU7t05Jez6A5wHA5Z17Gg4fMrpy+TTzzQ575qv2wpVaIeOVg
        ZD4vUo2/90oBKqmbMmxDkh5ErQ==
X-Google-Smtp-Source: ABdhPJxOc2v1KQEqaQT3MSTid5w9xUAIsfu2wgXdTNOkCyxCjfaz+0FvAQttUAo7kDfAVdPiQod14g==
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr25082188wmf.151.1592950713399;
        Tue, 23 Jun 2020 15:18:33 -0700 (PDT)
Received: from localhost.localdomain ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id x7sm24822120wrr.72.2020.06.23.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:18:32 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v3] checkpatch: fix CONST_STRUCT when const_structs.checkpatch is missing
Date:   Tue, 23 Jun 2020 23:18:22 +0100
Message-Id: <20200623221822.3727-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports warnings when some specific structs are not declared
as const in the code. The list of structs to consider was initially
defined in the checkpatch.pl script itself, but it was later moved to an
external file (scripts/const_structs.checkpatch), in commit bf1fa1dae68e
("checkpatch: externalize the structs that should be const"). This
introduced two minor issues:

- When file scripts/const_structs.checkpatch is not present (for
  example, if checkpatch is run outside of the kernel directory with the
  "--no-tree" option), a warning is printed to stderr to tell the user
  that "No structs that should be const will be found". This is fair,
  but the warning is printed unconditionally, even if the option
  "--ignore CONST_STRUCT" is passed. In the latter case, we explicitly
  ask checkpatch to skip this check, so no warning should be printed.

- When scripts/const_structs.checkpatch is missing, or even when trying
  to silence the warning by adding an empty file, $const_structs is set
  to "", and the regex used for finding structs that should be const,
  "$line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/)", matches all
  structs found in the code, thus reporting a number of false positives.

Let's fix the first item by skipping scripts/const_structs.checkpatch
processing if "CONST_STRUCT" checks are ignored, and the second one by
skipping the test if $const_structs is not defined. Since we modify the
read_words() function a little bit, update the checks for
$typedefsfile/$typeOtherTypedefs as well.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
v3:
- Remove comparison to empty string in read_words() and update checks on
  $typedefsfile/$typeOtherTypedefs in a similar way.
v2:
- Check if $const_structs is defined instead of non-empty.
- Remove "Fixes" tag.
---
 scripts/checkpatch.pl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index db9d94f90431..3804f88c3e15 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,7 +62,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
-my $typedefsfile = "";
+my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
@@ -770,7 +770,7 @@ sub read_words {
 				next;
 			}
 
-			$$wordsRef .= '|' if ($$wordsRef ne "");
+			$$wordsRef .= '|' if (defined $$wordsRef);
 			$$wordsRef .= $line;
 		}
 		close($file);
@@ -780,16 +780,18 @@ sub read_words {
 	return 0;
 }
 
-my $const_structs = "";
-read_words(\$const_structs, $conststructsfile)
-    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+my $const_structs;
+if (show_type("CONST_STRUCT")) {
+	read_words(\$const_structs, $conststructsfile)
+	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+}
 
-my $typeOtherTypedefs = "";
-if (length($typedefsfile)) {
+if (defined($typedefsfile)) {
+	my $typeOtherTypedefs;
 	read_words(\$typeOtherTypedefs, $typedefsfile)
 	    or warn "No additional types will be considered - file '$typedefsfile': $!\n";
+	$typeTypedefs .= '|' . $typeOtherTypedefs if (defined $typeOtherTypedefs);
 }
-$typeTypedefs .= '|' . $typeOtherTypedefs if ($typeOtherTypedefs ne "");
 
 sub build_types {
 	my $mods = "(?x:  \n" . join("|\n  ", (@modifierList, @modifierListFile)) . "\n)";
@@ -6656,7 +6658,8 @@ sub process {
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
+		if (defined($const_structs) &&
+		    $line !~ /\bconst\b/ &&
 		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);
-- 
2.20.1

