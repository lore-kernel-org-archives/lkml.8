Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970AEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A5246DB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195535;
	bh=GsLx3ylHwcKDm38Tz7iGZPcINyNQlX8kvooHKto/2bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFFn496CHRaQCjeubxF3LAsuyO6xik0dN6E0RzC/CB/ACZdp+vq7eL2VZhX1F2uJN
	 q201/Q9dpVoD7voasOdceJVtY6mWCC6Eif0sDB9bbY5yiRuaQQJI84R2XCKahi34yL
	 sZlShxSa+ZT9okWl/SQ7f2kJ/sO3BJPwMdhE4N38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391976AbgAPRZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391903AbgAPRZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDC9246AB;
        Thu, 16 Jan 2020 17:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195513;
        bh=GsLx3ylHwcKDm38Tz7iGZPcINyNQlX8kvooHKto/2bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9jQTU0Ore94CYfTxrcPcC4y9OBqqnMuRKF1ML+xqi+FeY3uhmpt8UzDdJQKlL9eb
         Eg7jVsgnrItTRO4zWcszP8OrEZOPhZ3Al+iznfzBTTpWBbog9U94ALb8K2eYx2GCKw
         +wSEkMdc6IIK8Yu/hz/Nxa9O4jNc+GsWS5uRqgMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 112/371] drm/nouveau/pmu: don't print reply values if exec is false
Date:   Thu, 16 Jan 2020 12:19:44 -0500
Message-Id: <20200116172403.18149-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1d03fc36ec9834465a08c275c8d563e07f6f6bf ]

Currently the uninitialized values in the array reply are printed out
when exec is false and nvkm_pmu_send has not updated the array. Avoid
confusion by only dumping out these values if they have been actually
updated.

Detected by CoverityScan, CID#1271291 ("Uninitialized scaler variable")
Fixes: ebb58dc2ef8c ("drm/nouveau/pmu: rename from pwr (no binary change)")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
index 11b28b086a06..7b052879af72 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
@@ -88,10 +88,10 @@ nvkm_memx_fini(struct nvkm_memx **pmemx, bool exec)
 	if (exec) {
 		nvkm_pmu_send(pmu, reply, PROC_MEMX, MEMX_MSG_EXEC,
 			      memx->base, finish);
+		nvkm_debug(subdev, "Exec took %uns, PMU_IN %08x\n",
+			   reply[0], reply[1]);
 	}
 
-	nvkm_debug(subdev, "Exec took %uns, PMU_IN %08x\n",
-		   reply[0], reply[1]);
 	kfree(memx);
 	return 0;
 }
-- 
2.20.1

