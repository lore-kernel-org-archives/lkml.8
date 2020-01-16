Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D329C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F3721582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193934;
	bh=PLDBIh757ifk7THB4hs9CKcE47ZrZpHVvq1miCA2JYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pSvHf0KfodsR0Ynjm7MGDb0L5nAi1i53Zu6DoHalqLXRYhX6VIk8MURAYXRQve/Rr
	 217RLga5oMinujCLBbQu0AEc6gTh8Rh7QHYsFP2hrJ1aNEggH7Ho31z7JwY1cxBuJ2
	 g+W0rShmcmg6sM2k1aj8XkPqEoqaCwsgb8pohM8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgAPQ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbgAPQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F2621D56;
        Thu, 16 Jan 2020 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193855;
        bh=PLDBIh757ifk7THB4hs9CKcE47ZrZpHVvq1miCA2JYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJg5vSlVnxBLvvocwEyeG52Io+ThR/paqUFg71GYTRyVgxiDsqZjlOKJ6VdDUBFnQ
         +igobd8wM6v3tCo7GXleYM6zgSbDn6PhRBJuDSDay8sqBUlNNn9RGtWOTLtFVZOBnw
         C0btU5ME4ff4J8t02bdkd1yXf7g5DsErC5Coeca0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 105/671] drm/etnaviv: fix some off by one bugs
Date:   Thu, 16 Jan 2020 11:45:36 -0500
Message-Id: <20200116165502.8838-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f5fd9fd4000984f19db689282054953981a50534 ]

The ->nr_signal is the supposed to be the number of elements in the
->signal array.  There was one place where it was 5 but it was supposed
to be 4.  That looks like a copy and paste bug.  There were also two
checks that were off by one.

Fixes: 9e2c2e273012 ("drm/etnaviv: add infrastructure to query perf counter")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 9980d81a26e3..4227a4006c34 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -113,7 +113,7 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 		.name = "PE",
 		.profile_read = VIVS_MC_PROFILE_PE_READ,
 		.profile_config = VIVS_MC_PROFILE_CONFIG0,
-		.nr_signals = 5,
+		.nr_signals = 4,
 		.signal = (const struct etnaviv_pm_signal[]) {
 			{
 				"PIXEL_COUNT_KILLED_BY_COLOR_PIPE",
@@ -435,7 +435,7 @@ int etnaviv_pm_query_sig(struct etnaviv_gpu *gpu,
 
 	dom = meta->domains + signal->domain;
 
-	if (signal->iter > dom->nr_signals)
+	if (signal->iter >= dom->nr_signals)
 		return -EINVAL;
 
 	sig = &dom->signal[signal->iter];
@@ -461,7 +461,7 @@ int etnaviv_pm_req_validate(const struct drm_etnaviv_gem_submit_pmr *r,
 
 	dom = meta->domains + r->domain;
 
-	if (r->signal > dom->nr_signals)
+	if (r->signal >= dom->nr_signals)
 		return -EINVAL;
 
 	return 0;
-- 
2.20.1

