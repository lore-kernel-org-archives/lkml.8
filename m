Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6989B2223F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445602;
	bh=mIJ1TUXp7dszAtRrMyJYmXKkKV2repG8ZIcsS6zctIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bBRkCen5NXnPzlLvTPdQV21waBzd+KA1BIOVuG3qdTPXg1zhGDJlVgi/H40CzVmr8
	 Hgw7FHVIkyZ3ClKgwSdrFsJg09HACXiXHRSYv8H3lw/M7xj2zmESd+8pyRcsqAglzb
	 HWLOzZJ3T0GrhDEjMsSrD1B2GNW9uivxS5ELMink=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgFRBYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbgFRBVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94DF621D79;
        Thu, 18 Jun 2020 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443269;
        bh=mIJ1TUXp7dszAtRrMyJYmXKkKV2repG8ZIcsS6zctIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPR9mbNwFyTmtfOJJlhCfO/texBAKbGnoJqJxPDQc+274JU/iJmxluVvUPvP3Fosb
         kac4bE1BuM/LL+FDJ+4VatzcriMrGtzai80ggg+OXmpwm/3P3IBRM1noN7FnxhMPOH
         iDdgtEgqlLvRP6Exd88vNKSXpzKAyHA6/WeV/e1s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 215/266] drm/nouveau/disp/gm200-: fix NV_PDISP_SOR_HDMI2_CTRL(n) selection
Date:   Wed, 17 Jun 2020 21:15:40 -0400
Message-Id: <20200618011631.604574-215-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit a1ef8bad506e4ffa0c57ac5f8cb99ab5cbc3b1fc ]

This is a SOR register, and not indexed by the bound head.

Fixes display not coming up on high-bandwidth HDMI displays under a
number of configurations.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c
index 9b16a08eb4d9..bf6d41fb0c9f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c
@@ -27,10 +27,10 @@ void
 gm200_hdmi_scdc(struct nvkm_ior *ior, int head, u8 scdc)
 {
 	struct nvkm_device *device = ior->disp->engine.subdev.device;
-	const u32 hoff = head * 0x800;
+	const u32 soff = nv50_ior_base(ior);
 	const u32 ctrl = scdc & 0x3;
 
-	nvkm_mask(device, 0x61c5bc + hoff, 0x00000003, ctrl);
+	nvkm_mask(device, 0x61c5bc + soff, 0x00000003, ctrl);
 
 	ior->tmds.high_speed = !!(scdc & 0x2);
 }
-- 
2.25.1

