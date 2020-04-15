Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755322078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951711;
	bh=HwwyHRg0ZPQDirdfAAsga1hDTp9J9Yf9FyLxGAaxAx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrh3YYySzRTvdOEefxlVhsAK5ve/k0eb/A0uu0EGerDtgVb4RnL2nl3dPoKGh72HQ
	 OvD9NrXx8kfQTyp1t/xdOcS6w09uRWFB1eZadUjswEB14fP+hAtKA+XRhg6LYEyWb+
	 o8VsPSdXGSbOPgMccmm9zPZ7NNslVRsuRQZtuV+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897891AbgDOLzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409191AbgDOLpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9942078A;
        Wed, 15 Apr 2020 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951138;
        bh=HwwyHRg0ZPQDirdfAAsga1hDTp9J9Yf9FyLxGAaxAx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVle0SlAED82z7e/aohAGuZYjZpa0N3Ix+BjgpXPTu5/g4MpG8R0ss2fnOdOTYVGw
         vVpnzCltcQxSTAFwAAS+jaXCzLL6Of6CFia+w82cy7kkbZGFUNQh2qr4AVA58LGd+8
         JDVpibHylCsQhhrZBdhzUkUCubBZ4Yu+jDFl9vrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 48/84] drm/nouveau/svm: check for SVM initialized before migrating
Date:   Wed, 15 Apr 2020 07:44:05 -0400
Message-Id: <20200415114442.14166-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

[ Upstream commit 822cab6150d3002952407a8297ff5a0d32bb7b54 ]

When migrating system memory to GPU memory, check that SVM has been
enabled. Even though most errors can be ignored since migration is
a performance optimization, return an error because this is a violation
of the API.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 668d4bd0c118f..25b7055949c45 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -173,6 +173,11 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 	mm = get_task_mm(current);
 	down_read(&mm->mmap_sem);
 
+	if (!cli->svm.svmm) {
+		up_read(&mm->mmap_sem);
+		return -EINVAL;
+	}
+
 	for (addr = args->va_start, end = args->va_start + size; addr < end;) {
 		struct vm_area_struct *vma;
 		unsigned long next;
-- 
2.20.1

