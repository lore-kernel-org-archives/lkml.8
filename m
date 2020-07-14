Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD3FC4345F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B79206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737725;
	bh=Nq5QR3iG8Cr3ox2BQ3/zYb67ZQcxz9425Pv2U2LcgGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msXshqKfKKXv72K78QCQbQECCCqeaPZwtVV/QpJlUoOqdS1Isi+sb6B1X481UWpLa
	 PLUDcNMZa9G/k+Az4G4wHJDP5dGwh0VQsMNq7zdJUKz/kCo1wVFA2SE+OQ1A9pl18V
	 GUm+Sv0BazMW+TII/ePDVQYt7cOGbmpfdnpuSlFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgGNOmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgGNOkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B68422519;
        Tue, 14 Jul 2020 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737609;
        bh=Nq5QR3iG8Cr3ox2BQ3/zYb67ZQcxz9425Pv2U2LcgGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuKHWvckfy9lpjPgDd1mtyqs+XKoidp5O77wkJTEDRyQTsKeJmIuUFdCpO+WHm0m0
         Guu2U/Vf0ikN1kCb8Rc3p1cAllXBNN6XMs+HKqWecVQnAeDb28mCgBfnJjGSoF6JGh
         2KxSZbUBi9KIs2JMOOJ/9OEixuDjfD5v7qotilp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 12/12] drm/nouveau/i2c/g94-: increase NV_PMGR_DP_AUXCTL_TRANSACTREQ timeout
Date:   Tue, 14 Jul 2020 10:39:54 -0400
Message-Id: <20200714143954.4035840-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143954.4035840-1-sashal@kernel.org>
References: <20200714143954.4035840-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0156e76d388310a490aeb0f2fbb5b284ded3aecc ]

Tegra TRM says worst-case reply time is 1216us, and this should fix some
spurious timeouts that have been popping up.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c   | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
index c8ab1b5741a3e..db7769cb33eba 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
@@ -118,10 +118,10 @@ g94_i2c_aux_xfer(struct nvkm_i2c_aux *obj, bool retry,
 		if (retries)
 			udelay(400);
 
-		/* transaction request, wait up to 1ms for it to complete */
+		/* transaction request, wait up to 2ms for it to complete */
 		nvkm_wr32(device, 0x00e4e4 + base, 0x00010000 | ctrl);
 
-		timeout = 1000;
+		timeout = 2000;
 		do {
 			ctrl = nvkm_rd32(device, 0x00e4e4 + base);
 			udelay(1);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
index 7ef60895f43a7..edb6148cbca04 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
@@ -118,10 +118,10 @@ gm200_i2c_aux_xfer(struct nvkm_i2c_aux *obj, bool retry,
 		if (retries)
 			udelay(400);
 
-		/* transaction request, wait up to 1ms for it to complete */
+		/* transaction request, wait up to 2ms for it to complete */
 		nvkm_wr32(device, 0x00d954 + base, 0x00010000 | ctrl);
 
-		timeout = 1000;
+		timeout = 2000;
 		do {
 			ctrl = nvkm_rd32(device, 0x00d954 + base);
 			udelay(1);
-- 
2.25.1

