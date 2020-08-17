Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACEFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F362067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgHQLa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:30:59 -0400
Received: from foss.arm.com ([217.140.110.172]:53582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbgHQLac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4316C106F;
        Mon, 17 Aug 2020 04:30:32 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F5423F66B;
        Mon, 17 Aug 2020 04:30:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 13/17] sched/topology: Mark SD_SERIALIZE as SDF_NEEDS_GROUPS
Date:   Mon, 17 Aug 2020 12:29:59 +0100
Message-Id: <20200817113003.20802-14-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There would be no point in preserving a sched_domain with a single group
just because it has this flag set. Add it to SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 9043d18ce418..6eb302528659 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -112,11 +112,12 @@ SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
  * Only a single load balancing instance
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE. Could be set from a
- * different level upwards, but it doesn't change that if a domain has this flag
- * set, then all of its parents need to have it too (otherwise the serialization
- * doesn't make sense).
+ *                different level upwards, but it doesn't change that if a
+ *                domain has this flag set, then all of its parents need to have
+ *                it too (otherwise the serialization doesn't make sense).
+ * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
-SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT)
+SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Place busy tasks earlier in the domain
-- 
2.27.0

