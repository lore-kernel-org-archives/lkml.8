Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F78C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2522075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="xdayWTMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgFVUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgFVUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:49:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so32639wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAxXw0P+7fxIv8XDeAsMIWiKTTgiRvEnr1gYhF4aqDM=;
        b=xdayWTMfcnj9BL4Q/497ZIEo8KpNEk/mhOwdmzGQf4Pjv21yHpjP2x+/pZqEhvtfKy
         kQoLzoFlMNqqTN6d+H0u2jj1QvfxEh9JFAAYCRhDxu3cvv1EntkeLWf2MzM3Hnpp7g6l
         YCKC4tsxLzwYZzPa18lOti+gNylnlEzFvTLvug4S0N2F08al6Nyc6jUDfC9Nba5THlUt
         8hPn4wcYs+tB8sFRTPS0g5Fmre5UJNLMAP3z2KKJQX62OQCupovbtLUL5E1QEDr8QRCN
         Cs+SrjxkPhkMzTV5qVfhNbDGrokD6nDNQ4totde1IJJpcLaJBtmjg5tSmYJP06E8KQ8A
         vCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAxXw0P+7fxIv8XDeAsMIWiKTTgiRvEnr1gYhF4aqDM=;
        b=hLj4f1hwc0woGsI3X1iRgLa2THkhz64qtcLrZblfQaz1779nRtmKcasLVfqfEzvYTs
         2/qdMtNHnvKaRdryNfguqc1cLoa4k3O1nrhAukAUCJPZpjcfAtf7lZFlYqWMI69lGurK
         5JVWd+Opl0k+2xY2AdDQFnrL+PnbagNtdoN1gYmXS98JChUT59XGHhNyTgimefhJ6xJC
         z23RMW1JRRS81HUla89eNGXw+DNo9eD2RfJv3gPr0ocmkY+w979KZNmVK8NLeHKTVntC
         YKYChX637m2bhboK4CJ+NjTjbxxuMgi7oV+vEBxtr3jGINfip2yRwUyVSeQfCwAlmo6u
         Wc9Q==
X-Gm-Message-State: AOAM5313+tpqJ0WeEiOpQT2jj8zS2bxx2O8j3tYzxzSYDaW1/tV7Yh3V
        SpM7qaOGUewdyMGl87vGW7Z6pA==
X-Google-Smtp-Source: ABdhPJzrxBMb7aICDtcTivTZt/0N4IDma8H11KKSTACEDvMEWomIvk3wdH6CnEUTeffNe+JG5MbH8Q==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr21336746wmi.82.1592858944236;
        Mon, 22 Jun 2020 13:49:04 -0700 (PDT)
Received: from localhost.localdomain ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id z1sm11144565wru.30.2020.06.22.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:49:03 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH] checkpatch: fix CONST_STRUCT when const_structs.checkpatch is missing
Date:   Mon, 22 Jun 2020 21:48:44 +0100
Message-Id: <20200622204844.21030-1-quentin@isovalent.com>
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
external file (scripts/const_structs.checkpatch). This introduced two
minor issues:

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
skipping the test if $const_structs is an empty string.

Fixes: bf1fa1dae68e ("checkpatch: externalize the structs that should be const")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b06093777fd8..dcbf4ff5d445 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -781,8 +781,10 @@ sub read_words {
 }
 
 my $const_structs = "";
-read_words(\$const_structs, $conststructsfile)
-    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+if (show_type("CONST_STRUCT")) {
+	read_words(\$const_structs, $conststructsfile)
+	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+}
 
 my $typeOtherTypedefs = "";
 if (length($typedefsfile)) {
@@ -6660,7 +6662,8 @@ sub process {
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
+		if ($const_structs ne "" &&
+		    $line !~ /\bconst\b/ &&
 		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);
-- 
2.20.1

