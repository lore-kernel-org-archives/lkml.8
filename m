Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE033C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856B920848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702803;
	bh=ps/Ytm66ViZbio9cASrGrz8rEcZC/M/vTrgGiL1IpXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgWm44tShR2V+xzqosq5vnBRXXqQZaKGpqnUUWRvqKv3GWBVOHGnEJwWhWB6mU/Xa
	 IXHE86Q4sI83ZQPOG/Bmw/ehtSMerMBY2WaXB3TWKJBrEV1Lfq3i8SjGfBK313/CHF
	 IvrN5oS8SaCt3I1E9g25jENcjlzISxVFLdXx8+zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbgBNRxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbgBNP6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BDD2067D;
        Fri, 14 Feb 2020 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695901;
        bh=ps/Ytm66ViZbio9cASrGrz8rEcZC/M/vTrgGiL1IpXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWEtXBTrXwj8t2PEyDS3ltY62vNM/C5a9gyMy3X4Ccr1WkdHjTSfly0uKVWyZtD9H
         KQVP+hkLfaRwZ0DL9te5DP9MPp1Ckj2CbJE6FiyWhUyb7H+YK9KdmhpOXZlRY2hHdr
         +B7m15/AY6ObrBQFdj6pJjeMMcJw4GXwlu0fQ6tI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 442/542] drm/nouveau/kms/nv50: remove set but not unused variable 'nv_connector'
Date:   Fri, 14 Feb 2020 10:47:14 -0500
Message-Id: <20200214154854.6746-442-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 39496368ba96b40b1dca07315418e473998eef15 ]

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function nv50_pior_enable:
drivers/gpu/drm/nouveau/dispnv50/disp.c:1672:28: warning:
 variable nv_connector set but not used [-Wunused-but-set-variable]

commit ac2d9275f371 ("drm/nouveau/kms/nv50-: Store the
bpc we're using in nv50_head_atom") left behind this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 63425e2460189..5b3b0db51d596 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1673,7 +1673,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
-	struct nouveau_connector *nv_connector;
 	struct nv50_head_atom *asyh = nv50_head_atom(nv_crtc->base.state);
 	struct nv50_core *core = nv50_disp(encoder->dev)->core;
 	u8 owner = 1 << nv_crtc->index;
@@ -1681,7 +1680,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
 
 	nv50_outp_acquire(nv_encoder);
 
-	nv_connector = nouveau_encoder_connector_get(nv_encoder);
 	switch (asyh->or.bpc) {
 	case 10: asyh->or.depth = 0x6; break;
 	case  8: asyh->or.depth = 0x5; break;
-- 
2.20.1

