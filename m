Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B9C83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D62206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8IkeBYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD1CFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1CFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:05:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE88C03C1A8;
        Mon, 27 Apr 2020 19:05:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so8244136pfn.3;
        Mon, 27 Apr 2020 19:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=iaEo+aXGN1886U/ejlK7E7NqK0GEbEQjzNlbY/x0wxA=;
        b=C8IkeBYdDEg5qInKWwVDQv8tNVsLvW+AUaNTaqzNeGlikMJHdexucuB5bqinuq3ul6
         yp1H9qPoxO/J8+YzZEkr6lgUtGohvWzeb+ObieJT3woWi4P/nsu+7yAm3Bw1pKxxHCcz
         iS5LaA7SYL3R5VPyHpvvy3EMPQufxnB2z23fuZk9GPxot4OOnhBagYUFjhK5rJ3WUAOq
         Le2bxJaseAkvj/ptknJvPmb0S8GuW3v9u/5dSRk0GOISC/ndakDZY1RLtXuh/bMH9f8U
         QnfnrW70dGUrh1DAhoTFRIJoCJflO8A5AY+ynguy/8RZvMjrhCw1GnJV+QJnRfAu21rn
         jJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=iaEo+aXGN1886U/ejlK7E7NqK0GEbEQjzNlbY/x0wxA=;
        b=YZ2teKPJgtZcXP1m3Tl0Mx0DbPbGo7u2cx6iMJcHzlq1Osc0yzWyu0roHcsSlf5Qcx
         v1tNUypxrcZs9WlSbJgFBaYJnXEOehexAkkXGjMMiX0E+gIL238WDEHrOasXxmmQR8Xh
         SYYnl2K3eDeE6gkxH8wuU5/N0etn4vxLFl+UAvZK864n0vrraBY1ORQVShXXae1p+eZG
         Qm3bHuc03/ou+q6+CKyBBfn1sT2wfyC/ImtoskQRc2mZDkdBMWpoXg8pNQf19j10YPe6
         v7H8VsT74Ih2uf+1ryrZ7J99AsU/k7Kj5xH4eadCTAJyhFab7+jy5cR2xDUC0fbalV1g
         yhgQ==
X-Gm-Message-State: AGi0Pua2WGlyTcEu1YWyiQurQ4D/O2iskrbql0W6cH/Vb1wRmedgaDxC
        20DaLWVrSnReytFvoyu4tcA=
X-Google-Smtp-Source: APiQypIOI5TJS9YoA2klTM6rNlCFaFcy3Ok4Qu37Cx7XWDNL9/qYEIaiKGMVDjpnpeWwfOt7ksVfRg==
X-Received: by 2002:a62:81c6:: with SMTP id t189mr27042827pfd.174.1588039517113;
        Mon, 27 Apr 2020 19:05:17 -0700 (PDT)
Received: from udknight.localhost ([183.250.89.86])
        by smtp.gmail.com with ESMTPSA id v94sm511622pjb.39.2020.04.27.19.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 19:05:16 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03S22NC7028208;
        Tue, 28 Apr 2020 10:02:23 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03S22NT0028206;
        Tue, 28 Apr 2020 10:02:23 +0800
Date:   Tue, 28 Apr 2020 10:02:23 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
Subject: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
Message-ID: <20200428020223.GA28074@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to submitting-patches.rst, 'Fixes:' tag has a little
stricter condition about the one line summary:
...
Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts
...

And there is no 'Fixes:' tag format checker in checkpatch to check
the commit id length too, so let's add dedicated checker to check
these conditions for 'Fixes:' tag.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 scripts/checkpatch.pl | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

 v2-v3
 1:No modification to GIT_COMMIT_ID checker.
   I make a mistake previously, GIT_COMMIT_ID doesn't check 'Fixes:' tag in any way,
   it isn't designed to do it, so let's don't touch it.
 2:Check for too long commit id too.
 3:Check for title line mismatch too.
 4:Move invalid commit id check for 'Fixes:' tag from UNKNOWN_COMMIT_ID to FIXES_TAG checker.
 5:Reword the error message (Markus Elfring).
 6:Reword the commit log (Markus Elfring).

 v1-v2:
 1: Reword commit log (Markus Elfring).
 2: Allow more than 12 characters of SHA-1 id (Markus Elfring).
 3: Update the error message according to reflect the second update.
 4: Add missing (?:...).


diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a..4de05b5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2969,7 +2969,7 @@ sub process {
 		}
 
 # check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+		if ($in_commit_log && $line =~ /(\bcommit)\s+([0-9a-f]{6,40})\b/i) {
 			my $id;
 			my $description;
 			($id, $description) = git_commit_info($2, undef, undef);
@@ -2979,6 +2979,45 @@ sub process {
 			}
 		}
 
+		if ($in_commit_log && $line =~ /^fixes:\s*[0-9a-f]{6,40}\b/i) {
+		    my $short = 1;
+		    my $long = 0;
+		    my $lines = 1;
+		    my $orig_commit = "";
+		    my $id = '0123456789ab';
+		    my $orig_desc = "commit description";
+		    my $description;
+
+		    $short = 0 if ($line =~ /\bfixes:\s+[0-9a-f]{12,40}/i);
+		    $long = 0 if ($line =~ /\bfixes:\s+[0-9a-f]{41,}/i);
+
+		    if ($line =~ /^\s*fixes:\s*[0-9a-f]{6,40}\s*(.*)/i) {
+			$lines = 0 if ($1 =~ /^\(\"(?:.*)\"\)$/i);
+		    }
+
+		    if ($line =~ /^\s*fixes:\s*([0-9a-f]{6,40})\s+\("([^"]+)"\)/i) {
+			$orig_commit = lc($1);
+			$orig_desc = $2
+		    }
+
+		    ($id, $description) = git_commit_info($orig_commit,
+							  $id, $orig_desc);
+
+		    if (!defined($id)) {
+			WARN("FIXES_TAG",
+			     "Unknown commit id '$orig_commit', maybe rebased or not pulled?\n" . $herecurr);
+		    } elsif ($orig_desc ne $description) {
+			WARN("FIXES_TAG",
+			     "Provided title line doesn't match the original title line of commit '$id', maybe misspelled?\n" . $herecurr);
+		    }
+
+		    if ($short || $long || $lines) {
+				my $fixes_tag_fmt = "Fixes: 54a4f0239f2e (\"KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed\")";
+				ERROR("FIXES_TAG",
+					"Please use 'Fixes:' tag with commit description style '<12+ chars of sha1> (\"<title line>\")', and the title line doesn't across multiple lines - ie: '$fixes_tag_fmt'\n" . $herecurr);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
