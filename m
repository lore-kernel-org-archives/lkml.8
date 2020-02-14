Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742BFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1A220637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700884;
	bh=um7tXFC0D/KcpWdexKmci409GpOx4Ia7CEUr6NupbIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/0BI1ZO6TPJQ1eygwoR5PsfUsV8+6w4Gojru6Z6U7fAT3NWFhnd+kc+dHNV8BRKt
	 CpHLKEialrd6Q2bvk5QfHXy0bpb5YdT/gmmCVtr8utrTEJmKAAYp7IgJUGe9eQPL4F
	 ns7mGtQxqIKdcK8LJqa9HOnX//gY29BbOleoLz1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391462AbgBNQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390959AbgBNQJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 369912468A;
        Fri, 14 Feb 2020 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696594;
        bh=um7tXFC0D/KcpWdexKmci409GpOx4Ia7CEUr6NupbIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+GBDIqHQ74rm+5QGSgxT+VIdtPPSXz7cKXnYuWowodaPidpzGHtzl3XdH9npGfm9
         T0R+crhioUAoHoh7Bq0FxAOpDjfFAjUZ/DCElV/FoeU+11DW6m5B3bGh7ADwYYJ8ed
         FhPL35tbxEPgm7szG4DCx9aTAhCX1GAVXRA1ASEw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 380/459] drm/nouveau/kms/nv50: remove set but not unused variable 'nv_connector'
Date:   Fri, 14 Feb 2020 11:00:30 -0500
Message-Id: <20200214160149.11681-380-sashal@kernel.org>
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
index d735ea7e2d886..6e50c75668b87 100644
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

