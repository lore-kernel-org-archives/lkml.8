Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40352C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A54D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LILlQRFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgD0NQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0NQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:16:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0640C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:16:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so9009988pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=AtVxPA+abih+6PcdJSDFXbwqig8XiO36RhS1by5PBss=;
        b=LILlQRFX1Dnxrt3IvHDJacv7N5nZv4OlIHGyXV/FpGjsp8tE6GxtNiI/scN5xIC3Q2
         y8a1a5MHYWwNjB8I+p5PrTKCVGzrsgtCD7VOovS/dRMtYHkGSp19/O00EaM+TKxNcrYr
         2fKUsk+ktoDCGQlla/Dg0u+ipZkHANpZ6UuaduR2eMhJf6sjcg1225atf+N28CppWOal
         v8v277+aHseM/Vxndgm5A1akZCMw9E0w4zsn/ICMKw2zWWSnBA23F74aKK45+TeUdQwH
         Af5MSJaUz1y3fMuWbrU+5/vsggnosc8xpPJ7cfBZDdA9uVCdljOiXV687BXZYHFqLlwG
         DokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=AtVxPA+abih+6PcdJSDFXbwqig8XiO36RhS1by5PBss=;
        b=STiXcSoodRDIgoAFBJSEtDbigYiWpLZiwQLsg3b7ru2xl6iw98g6jApweuNtYAm/Ja
         5ag5IIwqMtkTQibCEH95ZzpjxFEJ8HtpB1ZK1F6qowkHFpz6U653I0r0VROKihm0IfK8
         5AGmj3NwxHjMMQm1lul5IWbtD7FXh7z8SHkP48tmA/63AZN3fGbS+RhcIpwp8vQSvXmW
         TyvSZLV8PDlCp2/WKBeHGrjqHKlLWad/Pp1sgkquFPtiTYhq0R1ZHl1/cFeNTWqltxJH
         U8F/JpHCWnN7RbgDKuy0PGe8bo6bXgm+hv4rr0h9Grz0lGU/NKxX1hm70sfyiLTPEDRF
         hwvA==
X-Gm-Message-State: AGi0PuY//B26qviCpl/En/mB/2jVtyMORDv75TRkWBSKNQWfKk1nIcRS
        cT0wAyF4/Mdp78xcoJGdi38=
X-Google-Smtp-Source: APiQypJBfyoNlmd+Mh9sw4j36gl7szCVUAGfocfbrVsjyDlr+4wCQXfC+fmTcff4TI91OKXDKDfeMw==
X-Received: by 2002:a62:1984:: with SMTP id 126mr24088026pfz.158.1587993391213;
        Mon, 27 Apr 2020 06:16:31 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id 185sm13127345pfv.9.2020.04.27.06.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 06:16:30 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03RDFMmg015710;
        Mon, 27 Apr 2020 21:15:22 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03RDFJpB015709;
        Mon, 27 Apr 2020 21:15:19 +0800
Date:   Mon, 27 Apr 2020 21:15:19 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     apw@canonical.com, alexei.starovoitov@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add dedicated checker for 'Fixes:' tag
Message-ID: <20200427131519.GA15664@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        apw@canonical.com, alexei.starovoitov@gmail.com,
        linux-kernel@vger.kernel.org
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
"
Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts
"

And the current 'Fixes:' checker in "# Check for git id commit length and
improperly formed commit descriptions" doesn't check for invalid commit id
length, so I think it is better to add dedicated checker for 'Fixes:' TAG.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a..fbb31bc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2820,7 +2820,7 @@ sub process {
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
 		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		      $line !~ /^\s*fixes:\s*([0-9a-f]{6,40})\s*(.*)/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
 			my $short = 1;
@@ -2979,6 +2979,13 @@ sub process {
 			}
 		}
 
+		if ($in_commit_log && $line =~ /^\s*fixes:\s*([0-9a-f]{6,40})\s*(.*)/i) {
+		    if (length($1) != 12 || $2 !~ /^\(\"(.*)\"\)$/i) {
+				ERROR("FIXES_TAG",
+					"please use the 'Fixes:' tag with the first 12 characters of the SHA-1 ID, and the one line summary(no across multiple lines)\n" . $herecurr);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
