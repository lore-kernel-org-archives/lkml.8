Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5070C52D4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D90520801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811927;
	bh=t/3OO/Z5qwKOOusAvvBnwxg/E0dLIpIMxH436hfRD4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+3FyHpmmF08ejHwQ3GFTalPy9BbHAOOlXeM1gLs1Vn9ShHRVwiqqiVBEK9VJk1ke
	 A+24hfqwXmWnikAH4dpC5jn4M5hEHpHG+m+2f909s/ZZCiEvhQGuzAAdW5rOddaN2l
	 EBriZTBwBoQzFiRxaTvFRNRkaJ4GZrnkR6X3hWJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgB0N6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732501AbgB0N6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:58:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FC220578;
        Thu, 27 Feb 2020 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811922;
        bh=t/3OO/Z5qwKOOusAvvBnwxg/E0dLIpIMxH436hfRD4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecTKHdqTmdGMmbk+86ZKQnL32qeJidjZrCo58DCUxBTXxLrlz6kzrAzA6zhvTpLm+
         9ov0vzlsauhlcQGQhm4Fywt88Lou3TNzC+VwdLZux9l75ASycc97a7eN2fhhSdF33i
         7AIoxdbeDP8UtFAuQCaARfOsX2/l2RlJ8KhYYUzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 116/237] drm/nouveau/secboot/gm20b: initialize pointer in gm20b_secboot_new()
Date:   Thu, 27 Feb 2020 14:35:30 +0100
Message-Id: <20200227132305.381679201@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3613a9bea95a1470dd42e4ed1cc7d86ebe0a2dc0 ]

We accidentally set "psb" which is a no-op instead of "*psb" so it
generates a static checker warning.  We should probably set it before
the first error return so that it's always initialized.

Fixes: 923f1bd27bf1 ("drm/nouveau/secboot/gm20b: add secure boot support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c
index 30491d132d59c..fbd10a67c6c6a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c
@@ -108,6 +108,7 @@ gm20b_secboot_new(struct nvkm_device *device, int index,
 	struct gm200_secboot *gsb;
 	struct nvkm_acr *acr;
 
+	*psb = NULL;
 	acr = acr_r352_new(BIT(NVKM_SECBOOT_FALCON_FECS) |
 			   BIT(NVKM_SECBOOT_FALCON_PMU));
 	if (IS_ERR(acr))
@@ -116,10 +117,8 @@ gm20b_secboot_new(struct nvkm_device *device, int index,
 	acr->optional_falcons = BIT(NVKM_SECBOOT_FALCON_PMU);
 
 	gsb = kzalloc(sizeof(*gsb), GFP_KERNEL);
-	if (!gsb) {
-		psb = NULL;
+	if (!gsb)
 		return -ENOMEM;
-	}
 	*psb = &gsb->base;
 
 	ret = nvkm_secboot_ctor(&gm20b_secboot, acr, device, index, &gsb->base);
-- 
2.20.1



