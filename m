Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACBD21534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447135;
	bh=mIJ1TUXp7dszAtRrMyJYmXKkKV2repG8ZIcsS6zctIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmITCj/iboCbX5sEAmyiA8uP2G0x5+8zjB7RJEtD92xYH7XXdnvTPKE1mgUuGmSiE
	 NvYQF/PyNO7uBuvNT29IGW4Mfkf4Rn67Ohf+MqeiEg0Zdk9IuG+6g5ztlAVc2JUqKg
	 AkXed2pQy3aciQBFgByv3JUtTtuqZkxhGxUkg9w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgFRBRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgFRBOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EDD821D7B;
        Thu, 18 Jun 2020 01:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442891;
        bh=mIJ1TUXp7dszAtRrMyJYmXKkKV2repG8ZIcsS6zctIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTWvIGZS2MrSC/X735ehRXNLIFjta010kH1iqXTcfcAa+a1r8PrJAHl67pd6KKcit
         ei2LC2C/0TcGnR7ZroLmOJh5QlZVzTE72K3wbtFQ3CxbusFsxRXAz9Ro5dGjR28V7m
         rT+MVcTWdQXzFd8QKrfgKRyVE55duCm4cU/+H1fY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 314/388] drm/nouveau/disp/gm200-: fix NV_PDISP_SOR_HDMI2_CTRL(n) selection
Date:   Wed, 17 Jun 2020 21:06:51 -0400
Message-Id: <20200618010805.600873-314-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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

