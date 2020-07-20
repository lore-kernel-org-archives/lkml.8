Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F7620773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGTHoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:44:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGTHob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:44:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4C95AC46;
        Mon, 20 Jul 2020 07:44:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] scripts/decode_stacktrace: strip all base path prefixes
Date:   Mon, 20 Jul 2020 09:44:29 +0200
Message-Id: <20200720074429.29359-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When addr2line returns more than one location, decode_stacktrace does
not currently remove base path from the paths. So the result might look
like (line wrapped here):
 ptrace_stop (include/linux/freezer.h:57
 /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:67
 /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:128
 /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:173
 /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../kernel/signal.c:2217)

Make sure all the lines are processed, so the result now looks like
(line wrapped here again):
 ptrace_stop (include/linux/freezer.h:57 include/linux/freezer.h:67
 include/linux/freezer.h:128 include/linux/freezer.h:173
 kernel/signal.c:2217)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 67a28de47faa (scripts/decode_stacktrace: only strip base path when a prefix of the path)
Cc: Sasha Levin <sashal@kernel.org>
---
 scripts/decode_stacktrace.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 4bdcb6d8c605..3fddcb48b464 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -140,14 +140,15 @@ parse_symbol() {
 		return
 	fi
 
-	# Strip out the base of the path
-	code=${code#$basepath/}
-
-	# In the case of inlines, move everything to same line
-	code=${code//$'\n'/' '}
+	declare -a output
+	while read LINE; do
+		# Strip out the base of the path
+		LINE=${LINE#$basepath/}
+		output+=("$LINE")
+	done <<< $code
 
 	# Replace old address with pretty line numbers
-	symbol="$segment$name ($code)"
+	symbol="$segment$name (${output[@]})"
 }
 
 decode_code() {
-- 
2.27.0

