Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1580C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54EB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBZEZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:25:20 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55072 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgBZEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:25:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TqxCOmx_1582691108;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TqxCOmx_1582691108)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Feb 2020 12:25:17 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        luanshi <zhangliguang@linux.alibaba.com>
Subject: [PATCH] perf: arm_spe: remove unnecessary zero check
Date:   Wed, 26 Feb 2020 12:25:06 +0800
Message-Id: <1582691106-3432-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "nr_pages" variable has been checked before, it can't be zero, so a check here would be useless.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/perf/arm_spe_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4e4984a..b72c048 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -831,7 +831,7 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
 	 * parts and give userspace a fighting chance of getting some
 	 * useful data out of it.
 	 */
-	if (!nr_pages || (snapshot && (nr_pages & 1)))
+	if (snapshot && (nr_pages & 1))
 		return NULL;
 
 	if (cpu == -1)
-- 
1.8.3.1

