Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F06C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A9120672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930699;
	bh=HKNX47HOPaaC2LDnjTvPIhIC71Ef+dbq7dsQNWQ4TvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5arZn86gDSiTwJbwhXxInR4MIVTpes7QzWZ7JCmnfizOo20xDwR7LN+kgWken1BE
	 n8YbboYeJWTqv7KNewk2kVnXzT5fGR3WQ6wwHX9PF7vTJjR+8pNXpG6KJclAd5GIdN
	 1f+sqTQhcMPCxsVWEUA7hB502LNmgZJBz1SEe28U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHHXf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgHHXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:35:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093C22073E;
        Sat,  8 Aug 2020 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929754;
        bh=HKNX47HOPaaC2LDnjTvPIhIC71Ef+dbq7dsQNWQ4TvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/T7mQ6a0Z5VlZFIlqF+RzjgbqJW1wGRR/HybBV/c5h9o87qKskb1NPNy2aXRUTsk
         0OlfkPxEOopFvE012Qd5YlQpOVRwZLTd29rhyD6pLezRPOuFK89jzcMTF84Vx2Ik26
         5rmiSSxngbWseUt2OrAGT2PJOUL7+gapsDQQT6bY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.8 09/72] sched: correct SD_flags returned by tl->sd_flags()
Date:   Sat,  8 Aug 2020 19:34:38 -0400
Message-Id: <20200808233542.3617339-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <iwtbavbm@gmail.com>

[ Upstream commit 9b1b234bb86bcdcdb142e900d39b599185465dbb ]

During sched domain init, we check whether non-topological SD_flags are
returned by tl->sd_flags(), if found, fire a waning and correct the
violation, but the code failed to correct the violation. Correct this.

Fixes: 143e1e28cb40 ("sched: Rework sched_domain topology definition")
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba81187bb7af1..9079d865a9357 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1328,7 +1328,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd_flags = (*tl->sd_flags)();
 	if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
 			"wrong sd_flags in topology description\n"))
-		sd_flags &= ~TOPOLOGY_SD_FLAGS;
+		sd_flags &= TOPOLOGY_SD_FLAGS;
 
 	/* Apply detected topology flags */
 	sd_flags |= dflags;
-- 
2.25.1

