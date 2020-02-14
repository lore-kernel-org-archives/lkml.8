Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A8D2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701210;
	bh=sMUNR4yGWZ+2fKyLeI7Zo66jkrR7W2W8hwkVr/geNGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cVrI4J8Lel+s6voivqUGZBIuZ+tQIUsGOWHe4qT61wDBSZr0+bnxLt2quMa0LAmW4
	 x0eZJlzGdujU6H0xW9sOm8QWAGWmCtOAl/6nerwWNXL7ThAxVyUCA+tSdjKwDiPav4
	 rJMCC0izDB7yWvfRoMo7YA0GyJDTRHRt35vn7VII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbgBNR0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390985AbgBNQIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6361B24686;
        Fri, 14 Feb 2020 16:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696511;
        bh=sMUNR4yGWZ+2fKyLeI7Zo66jkrR7W2W8hwkVr/geNGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewyc5AyHOs0I1Ef/SZVT85DU1shbjAgrsGsollM2stsvYhhguPx2ekrbatzmbF8Px
         BQbFqEbaxZI6Ylqp6gAOFHd/taLH0hZ0zVFHsR2GyO9LXpC5dx6ahELmKx49wqU3Ax
         WIp1lN2cKQkEvNttZOjBaSZ1ppJzJyPFOrONARy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 313/459] drm/nouveau/fault/gv100-: fix memory leak on module unload
Date:   Fri, 14 Feb 2020 10:59:23 -0500
Message-Id: <20200214160149.11681-313-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 633cc9beeb6f9b5fa2f17a2a9d0e2790cb6c3de7 ]

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
index ca251560d3e09..bb4a4266897c3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
@@ -146,6 +146,7 @@ nvkm_fault_dtor(struct nvkm_subdev *subdev)
 	struct nvkm_fault *fault = nvkm_fault(subdev);
 	int i;
 
+	nvkm_notify_fini(&fault->nrpfb);
 	nvkm_event_fini(&fault->event);
 
 	for (i = 0; i < fault->buffer_nr; i++) {
-- 
2.20.1

