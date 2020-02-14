Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173C0246F3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697723;
	bh=IEqL5xJdvkCDBxzC/BErSDTVMFN7oI3hvjjONr0p9Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQRcRtZZhm7BOpTq9+WvALh9ZRgBQeWJm0cUnrtHaM5CIpXWVYMgiaJmiKsqkAvax
	 o0OuelyEiVrxfhEl/8vqGBJFefkgM+PPjf4Rq/kNC+WPoaPwK3gmkj4HJTcFeoFsyK
	 o48m7+15/mHS5/Fy7vpIUlyuorteqcj5WZ3qqos0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406431AbgBNQ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406371AbgBNQ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:26:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F1D24700;
        Fri, 14 Feb 2020 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697576;
        bh=IEqL5xJdvkCDBxzC/BErSDTVMFN7oI3hvjjONr0p9Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8Wotf24Kiku2rlbig6Yt3sPhKvRFhlYm4P9Gns9jzaeEQyCImN1KocFfwSOmIWAE
         le5aNpHvfw3yrXjDhjAd1uhqHUaytUawtGwWU10mnO1fU+PRJGkR/g9Hhc74MsmvzM
         PNEHz/xhVW3UUfxuBE59Ne2FTZXOU+L3SBReDWZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 090/100] drm/nouveau/disp/nv50-: prevent oops when no channel method map provided
Date:   Fri, 14 Feb 2020 11:24:14 -0500
Message-Id: <20200214162425.21071-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0e6176c6d286316e9431b4f695940cfac4ffe6c2 ]

The implementations for most channel types contains a map of methods to
priv registers in order to provide debugging info when a disp exception
has been raised.

This info is missing from the implementation of PIO channels as they're
rather simplistic already, however, if an exception is raised by one of
them, we'd end up triggering a NULL-pointer deref.  Not ideal...

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206299
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
index 01803c0679b68..d012df9fb9df0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
@@ -72,6 +72,8 @@ nv50_disp_chan_mthd(struct nv50_disp_chan *chan, int debug)
 
 	if (debug > subdev->debug)
 		return;
+	if (!mthd)
+		return;
 
 	for (i = 0; (list = mthd->data[i].mthd) != NULL; i++) {
 		u32 base = chan->head * mthd->addr;
-- 
2.20.1

