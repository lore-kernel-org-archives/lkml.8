Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD81C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6D622B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596215233;
	bh=I2tAEedcO9VAKEGuMTWWvln8PBMTfYVGS0os66wMkfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qkm92RF9+tL5O9nPxW7jMbnSCqpFwjJDOyiz8qokwDUQFdf+ejxVafOvDV/7CErrj
	 Y7oKLPpPIl+RSyx9GdfudQ9dj4O7269rgat9+d67H1hyTFUKgeHjp4RMfzNXYd3mNa
	 2L2zfETknCbPRxbuAQBPGHO3GeZUWd5Y9fp0BixY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgGaRHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732684AbgGaRHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:07:11 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EF02245C;
        Fri, 31 Jul 2020 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596215231;
        bh=I2tAEedcO9VAKEGuMTWWvln8PBMTfYVGS0os66wMkfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzpsvNgAslere3S82DjTwvt4tab3CYMOiNpoXLvhLB8lRZAaKKuwE2gd8Q2Unnar1
         rW1L8jrg1lAmdNP/L2KZmVwkriP+iGB19V1d1to8r3JHHDA18dKAAHbVnGngJCOSpT
         dNeRXn56qc4/r9Sn4I182ZDXqOKV8N9MDsxH77W8=
Date:   Fri, 31 Jul 2020 12:13:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/2][next] mm: memcontrol: Use the preferred form for passing
 the size of a structure type
Message-ID: <773e013ff2f07fe2a0b47153f14dea054c0c04f1.1596214831.git.gustavoars@kernel.org>
References: <cover.1596214831.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1596214831.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the preferred form for passing the size of a structure type. The
alternative form where the structure type is spelled out hurts
readability and introduces an opportunity for a bug when the object
type is changed but the corresponding object identifier to which the
sizeof operator is applied is not.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bd7f972ceea4..bd0f56785841 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4255,7 +4255,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	new->entries[size - 1].threshold = threshold;
 
 	/* Sort thresholds. Registering of new threshold isn't time-critical */
-	sort(new->entries, size, sizeof(struct mem_cgroup_threshold),
+	sort(new->entries, size, sizeof(*new->entries),
 			compare_thresholds, NULL);
 
 	/* Find current threshold */
-- 
2.27.0

