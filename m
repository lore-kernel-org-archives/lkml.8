Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF49C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5948920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="oCy6VBPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgFWKhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgFWKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:37:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB34C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:37:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so2482597wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jSGtAZ68yCQRuX8DMTsJCURecPrk2ld6B92Ys0IUNTE=;
        b=oCy6VBPqVEM/fni40MjgDpQuwDrfvIWlZwyOUm7dmIn1XueTNAsWg/6lk7kNFZ3D0G
         K/BM4yxM+R7/HvzxfHGDimmafXrWFo4mAnlu2PpXym9fbw2/3sHkK25EO6jgYkMS0nfO
         dYE7gSqXJnc80DeEi/tA8vVQAqWhP6eFKaCDS/9qKzEDU9M28WE4SxDlsfU4Gtu3/fsW
         dH9TVX1pckgTBnaBT+KRRAj9KnEKdO6e0SdSkO2TggHPfQ9TAg5jiwrB9HFqILIZhddc
         +9y0G6tK2KM9tN5wtvLx6IaMUhbquQyXFfMocuY8HEeoMlka8nO0WEL0wZtJlHeDa31X
         /mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jSGtAZ68yCQRuX8DMTsJCURecPrk2ld6B92Ys0IUNTE=;
        b=H5J2Jw3ca426yb/CmOUP5hnIq5M8NFlrTsxT+AqzUZoZ/OhOjQUp+zikNE6KLo1NU8
         S7Wk4IFb7kuf+0FQYjlZM6fxBHL60vKvMpEBrus5uWpfVUiu1TUMXbtvBriD6ZZupBBd
         sqnvIKHtunnpnWnXy9RYE/SF2kVsSCYj0FD59wIcD7PAN+5tKugQFPbVsuQjxdRzlMT3
         m4K+i6Du6m04DWdySX7gIEy2ZbnoJQkxHarBCJs1Tc6hStKSmG85N2pfGhbOPjbnYuWH
         AYG91cP6zoiJZbgBgttva7RYLFd+7hgaXtBhZGsosO9srWIjxUnBV46TQ4AbUI9iHgOQ
         I0RA==
X-Gm-Message-State: AOAM5331/ZKW2E+6SwREhc9Kh8iiZVWtLV5UEgwAMkCPN6PpOKx2o8Ao
        nEkfeZ8YOENdQ7Uz39SCxGPK0Q==
X-Google-Smtp-Source: ABdhPJyCrbz+c+edm5/R/wpbi6N2oOSNa+mNEgbsuVjzATzIQzBhjJZoTRpbU6ViepS/iD/HL8DSNw==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr24551390wma.83.1592908670822;
        Tue, 23 Jun 2020 03:37:50 -0700 (PDT)
Received: from localhost.localdomain ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id r10sm5283544wrm.17.2020.06.23.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:37:49 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v2] checkpatch: fix CONST_STRUCT when const_structs.checkpatch is missing
Date:   Tue, 23 Jun 2020 11:37:40 +0100
Message-Id: <20200623103740.25876-1-quentin@isovalent.com>
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
skipping the test if $const_structs is not defined.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
v2:
- Check if $const_structs is defined instead of non-empty.
- Remove "Fixes" tag.
---
 scripts/checkpatch.pl | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index db9d94f90431..3b14bf3e4d4e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -770,7 +770,7 @@ sub read_words {
 				next;
 			}
 
-			$$wordsRef .= '|' if ($$wordsRef ne "");
+			$$wordsRef .= '|' if (defined($$wordsRef) && $$wordsRef ne "");
 			$$wordsRef .= $line;
 		}
 		close($file);
@@ -780,9 +780,11 @@ sub read_words {
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
 
 my $typeOtherTypedefs = "";
 if (length($typedefsfile)) {
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

