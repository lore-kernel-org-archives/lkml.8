Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1001C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18AA207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgHQLbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHQLaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF8D13D5;
        Mon, 17 Aug 2020 04:30:38 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEE213F66B;
        Mon, 17 Aug 2020 04:30:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 17/17] sched/topology: Expand use of SD_DEGENERATE_GROUPS_MASK to flags not needing groups
Date:   Mon, 17 Aug 2020 12:30:03 +0100
Message-Id: <20200817113003.20802-18-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SD flags requiring 2+ sched_group to have any effect are now decorated
with the SDF_NEEDS_GROUPS metaflag. This means we can now use the bitwise
negation of SD_DEGENERATE_MASK in sd_degenerate() instead of explicitly
using SD_WAKE_AFFINE (IOW the only flag without SDF_NEEDS_GROUPS).

From now on, any flag without SDF_NEEDS_GROUPS will be correctly accounted
as a flag not requiring 2+ sched_groups.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8064f495641b..3bb145ef5abd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -165,7 +165,7 @@ static int sd_degenerate(struct sched_domain *sd)
 		return 0;
 
 	/* Following flags don't use groups */
-	if (sd->flags & (SD_WAKE_AFFINE))
+	if (sd->flags & ~SD_DEGENERATE_GROUPS_MASK)
 		return 0;
 
 	return 1;
-- 
2.27.0

