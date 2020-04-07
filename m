Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE61B20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDGUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:49:14 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:37636 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:49:13 -0400
Received: from localhost.localdomain ([93.22.37.82])
        by mwinf5d58 with ME
        id PwpA220021mLNr903wpAaH; Tue, 07 Apr 2020 22:49:11 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 07 Apr 2020 22:49:11 +0200
X-ME-IP: 93.22.37.82
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] checkpatch: check for missing \n at the end of logging message
Date:   Tue,  7 Apr 2020 22:49:08 +0200
Message-Id: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strings logged with pr_xxx and dev_xxx often lack a trailing '\n'.
Introduce new tests to try to catch them early.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is more a PoC for now.

Regex could be improved, merged, ...
We could also check for surrounding pr_cont...

This patch is based on idea from [1]. coccinelle spots too many places
where \n are missing (~ 2800 with the heuristic I've used).
Fixing them would be painful.
I instead propose to teach checkpatch.pl about it to try to spot cases
early and avoid introducing new cases.

[1]: https://marc.info/?l=kernel-janitors&m=158619533629657&w=4
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c392ab8ea12e..792804bd6ad9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5676,6 +5676,16 @@ sub process {
 			}
 		}
 
+# check for missing \n at the end of logging function
+		if ($line =~ /\bpr_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\("([^"]*(?<!\\n))"/) {
+			WARN("MISSING NL",
+			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
+		}
+		if ($line =~ /\bdev_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\([^,]*,\s*"([^"]*(?<!\\n))"/) {
+			WARN("MISSING NL",
+			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
+		}
+
 # check for logging functions with KERN_<LEVEL>
 		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
 		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
-- 
2.20.1

