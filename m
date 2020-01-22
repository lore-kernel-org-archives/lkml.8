Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D2EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FD321835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox4HKIMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAVQj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:39:57 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35459 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:39:55 -0500
Received: by mail-wm1-f54.google.com with SMTP id p17so7904526wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISOzxj90O+fz5CSuTDY5BazvTkazsQWlW34bj31h6NU=;
        b=Ox4HKIMgjYRHxQmUzOeTEsAyVhpRANJMIEvrvIiSyK3ySpsiiDytvMlexgR6RtzC+y
         e+5SnP0VNJAWpRqRHFgIhnf8/vHcOSKD6GtKqvjbHO8Qe3HcsW/3nTDBBFx5zx5dcNlt
         s36JgXeMnfpcGW5y5MCy4JHRw+BQzehG4MU5pJamVSrlwUf1nCBZDS+EOQXD49XcAgm3
         b8oR49r2BddUotlSa6E5op5bFQEQhaFg46H0TDKA8sZdpKkF2MX0fBai+uOhWd3/27X4
         jotT2dXlF6apVByEwjbMvTi6+O1cujS7p6/dN1sMdZWmhVksAoIb4QViJpOBz0EjXPXl
         DOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISOzxj90O+fz5CSuTDY5BazvTkazsQWlW34bj31h6NU=;
        b=MzAvYZHe8+8JGI8GWA5jrA3c3N9/CY9+2+5ydRBPW77W7H2aAQBoG+MN/QBn+9p2qd
         J3zutVOZ6LWuStq4uC7PqvvhXQn2xrbM+YV8AXaVRZR2EooYndafZsGkH7HsxL41I362
         54J6/LNa9VL4DleaZdpROf6lfw4xqMa7VWxbeALApxnH59uQCE4iVe8IrPEbdPsqWWxq
         kILy5LHPev4FArbo77nyC276qryP9pHEqoWTBGK+K551/uk2C2IdDXVw4P9UJlCR/ALd
         ErDLhdnSn+75jr/knw/PtFMBPFkc7v0NlLVVwSNZR3H94dFw6swLua27s2AymgN6QR1x
         ndOQ==
X-Gm-Message-State: APjAAAV3kyIC4t+iC+VB66j838xwsHz5avfRizJq3jZa79YlOXOaXZ5F
        u1ScUj9H3g9jsH1zvyWm3hY=
X-Google-Smtp-Source: APXvYqzB2uhN3Q0rj7xFp3QUCTT9gdy7AH95OSqXjkisE0ZwqmlvzkdZ86Q75SBm06XEJ+I8EcgqIA==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr3711671wmf.113.1579711193374;
        Wed, 22 Jan 2020 08:39:53 -0800 (PST)
Received: from localhost.localdomain (lneuilly-657-1-69-3.w80-11.abo.wanadoo.fr. [80.11.53.3])
        by smtp.gmail.com with ESMTPSA id j2sm4908557wmk.23.2020.01.22.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:39:52 -0800 (PST)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] checkpatch: fix minor typo and mixed space+tab in indentation
Date:   Wed, 22 Jan 2020 17:38:51 +0100
Message-Id: <20200122163852.124417-2-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20190508122721.7513-3-borneo.antonio@gmail.com>
References: <20190508122721.7513-3-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of "concatenation".
Don't use tab after space in indentation.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>

---

v1 -> v2
	rebased

---
 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30da08d9646a..4c1be774b0ed 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4582,7 +4582,7 @@ sub process {
 					    ($op eq '>' &&
 					     $ca =~ /<\S+\@\S+$/))
 					{
-					    	$ok = 1;
+						$ok = 1;
 					}
 
 					# for asm volatile statements
@@ -4917,7 +4917,7 @@ sub process {
 			# conditional.
 			substr($s, 0, length($c), '');
 			$s =~ s/\n.*//g;
-			$s =~ s/$;//g; 	# Remove any comments
+			$s =~ s/$;//g;	# Remove any comments
 			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
 			    $c !~ /}\s*while\s*/)
 			{
@@ -4956,7 +4956,7 @@ sub process {
 # if and else should not have general statements after it
 		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/) {
 			my $s = $1;
-			$s =~ s/$;//g; 	# Remove any comments
+			$s =~ s/$;//g;	# Remove any comments
 			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
 				ERROR("TRAILING_STATEMENTS",
 				      "trailing statements should be on next line\n" . $herecurr);
@@ -5132,7 +5132,7 @@ sub process {
 			{
 			}
 
-			# Flatten any obvious string concatentation.
+			# Flatten any obvious string concatenation.
 			while ($dstat =~ s/($String)\s*$Ident/$1/ ||
 			       $dstat =~ s/$Ident\s*($String)/$1/)
 			{
-- 
2.25.0

