Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1E9206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgG2M7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:59:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53099 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgG2M7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:59:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=cambda@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U49f54P_1596027572;
Received: from localhost(mailfrom:cambda@linux.alibaba.com fp:SMTPD_---0U49f54P_1596027572)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 20:59:32 +0800
From:   Cambda Zhu <cambda@linux.alibaba.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Cambda Zhu <cambda@linux.alibaba.com>
Subject: [PATCH] checkpatch: skip macros when finding missing switch/case break
Date:   Wed, 29 Jul 2020 20:59:11 +0800
Message-Id: <20200729125911.47318-1-cambda@linux.alibaba.com>
X-Mailer: git-send-email 2.16.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checkpatch.pl only searches 3 previous lines when finding missing
switch/case break, and macros are treated as normal statements. If the
cases are surrounded with CONFIG, checkpatch.pl may report false
warnings. For example:

\+#if xxx
\+	case xxx: {
\+		...
\+		break/return/...;
\+	}
\+#endif
\+#if xxx
\+	case xxx:
\+		...
\+#endif

This patch skips lines starting with whitespaces and #, so the counter
of previous statements won't increase in these cases.

Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..2c0a51ac82a7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6503,6 +6503,7 @@ sub process {
 				next if ($fline =~ /^.(?:\s*(?:case\s+(?:$Ident|$Constant)[\s$;]*|default):[\s$;]*)*$/);
 				$has_break = 1 if ($rline =~ /fall[\s_-]*(through|thru)/i);
 				next if ($fline =~ /^.[\s$;]*$/);
+				next if ($fline =~ /^.\s*#/);
 				$has_statement = 1;
 				$count++;
 				$has_break = 1 if ($fline =~ /\bswitch\b|\b(?:break\s*;[\s$;]*$|exit\s*\(\b|return\b|goto\b|continue\b)/);
-- 
2.16.6

