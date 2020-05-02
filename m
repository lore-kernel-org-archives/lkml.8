Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C5EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C4B206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9qi38I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgEBSyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgEBSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:54:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB650C061A0C;
        Sat,  2 May 2020 11:54:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so5445767pjz.1;
        Sat, 02 May 2020 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=2r+1yVPOglt4gj5XLUdHS7cxi4oqb67JRmvdg4JUpMs=;
        b=iE9qi38Iu6GH1F7xZ9HHUiU/kJXeyzOqk+2gyFZg2F+GkePgCBKPIcmnYfhYqrgWiv
         9dcrrkrP+kneqozsqiEu7UDNFm1Vcr4qCSG5tdQK11QMGeGHB7A/GQ87qkWeolCePbyd
         pg6LMDmOO3KUXdzmDhTB80BNetDwX5TEatu8gczuCKWLLuPv16e0wPGRhsQ+ws2OaQGl
         kQiR6ToxoSL0tEZCgFfY0sLhjW+mu6ZWSjNQ4ExFuPspYvcwPLQAgeU33EWwKJ9Aedj6
         SMpOt9yQVEYKGYaXstv8oYjZZTEq6hgBCcFq9uWUX0d27IqXKrrLj52l4BY6itw3iptV
         WycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=2r+1yVPOglt4gj5XLUdHS7cxi4oqb67JRmvdg4JUpMs=;
        b=UKJaQh5cQ350MHkbMlXxYjtG9fUBBCJIXxjZySrCQR9kqVMlDx1Awy9JA33kuz7Swi
         IUE/mp/HsmkG9V66Qlar2FC1H+PU+UIDDLaPCG43XDQuPTxFCWdTGCEgYAmpdN2VP8J/
         77sN+tb2hCyGT27dAuBdoVlg4GlFbEsDytgd06YmXe//bBRQG+w/7PUmPHdNAEWb++Ww
         3uBZCUgET0Ezmq5VvwE76WaHVCHzLy3kUr9ZCCEDaLwbjZPZN6VfGEzbBDXWjYxImw68
         UUcovb/TOB/LV3Alb4MXHN9ElgXqhHabzaaIRtlTfkapaqvztG5xse3Dvy9Hc3W+w8W6
         q4xA==
X-Gm-Message-State: AGi0PubSOtFFXFyWEmPf3pgIiqiMEKkQS3ZGFViUclBnlaFVOss0z2Kk
        kMgTiT3qOVUpRicsyxzNrPLUTrcd
X-Google-Smtp-Source: APiQypIs4e+TkMq35dY62ktGP/u5qteJzEQbZIICyeh7FwBPWfse3gYTpcN+mJXkdgMk413Ugr9NYQ==
X-Received: by 2002:a17:90a:1464:: with SMTP id j91mr7121807pja.87.1588445649250;
        Sat, 02 May 2020 11:54:09 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id bo19sm2694712pjb.26.2020.05.02.11.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 11:54:08 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 042IontN009203;
        Sun, 3 May 2020 02:50:49 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 042IofgZ009202;
        Sun, 3 May 2020 02:50:41 +0800
Date:   Sun, 3 May 2020 02:50:41 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] checkpatch: fix can't check for too long invalid commit id
Message-ID: <20200502185041.GA9082@udknight>
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
 After this patch, in another patch 'checkpatch: add support to check 'Fixes:' tag format',
 I will delete UNKNOWN_COMMIT_ID, because we don't need it anymore after GIT_COMMIT_ID could
 do the same check as UNKNOWN_COMMIT_ID for 'Fixes:' tag.

 scripts/checkpatch.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a..143bb43 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2865,8 +2865,18 @@ sub process {
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
+			if (!defined($id)) {
+			    if ($long) {
+				ERROR("GIT_COMMIT_ID",
+				      "Unknown commit id '$orig_commit' is too long, maybe misspelled?\n" . $herecurr);
+			    } else {
+				ERROR("GIT_COMMIT_ID",
+				      "Unknown commit id '$orig_commit', maybe rebased or not pulled?\n" . $herecurr);
+			    }
+			}
+
 			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			   ($short || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
 				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
 			}
@@ -2969,7 +2979,7 @@ sub process {
 		}
 
 # check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+		if ($in_commit_log && $line =~ /(^fixes:)\s+([0-9a-f]{6,40})\b/i) {
 			my $id;
 			my $description;
 			($id, $description) = git_commit_info($2, undef, undef);
-- 
1.8.5.6.2.g3d8a54e.dirty
