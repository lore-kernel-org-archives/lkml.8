Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE97C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4224B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgHYE71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:59:27 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:35642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728501AbgHYE4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 57793180A9F4D;
        Tue, 25 Aug 2020 04:56:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: deer93_0c0f71527059
X-Filterd-Recvd-Size: 1473
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:48 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 04/29] sparc: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:01 -0700
Message-Id: <9dade53620b9532ff76a726320a497c67138264c.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc/kernel/smp_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e286e2badc8a..28c11f7871cd 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -186,8 +186,11 @@ static inline long get_delta (long *rt, long *master)
 		wmb();
 		t1 = tick_ops->get_tick();
 
-		if (t1 - t0 < best_t1 - best_t0)
-			best_t0 = t0, best_t1 = t1, best_tm = tm;
+		if (t1 - t0 < best_t1 - best_t0) {
+			best_t0 = t0;
+			best_t1 = t1;
+			best_tm = tm;
+		}
 	}
 
 	*rt = best_t1 - best_t0;
-- 
2.26.0

