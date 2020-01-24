Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8533C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895421734
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859513;
	bh=Ltsya09+w8x7dsyysFBQINaYsAo+nNg0ywQVgB0u/iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4m/xSPlL3plNT9qCUJmEbLEFLGLgUhQy3f/ronfheJKyeaEmFc1Sm/29BJKNLRlg
	 QtFtToWtmmt+BP5nWVDTbrScGIyhFn1NT/ty3ZQN5Iukqu34sIu6Mv8N/Li6pvxBh8
	 FEyfkBZJGEjVkb6W2vEI3W9axdmZ9h6BMm+OhuSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbgAXJvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbgAXJvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:51:50 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99F5206D5;
        Fri, 24 Jan 2020 09:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859509;
        bh=Ltsya09+w8x7dsyysFBQINaYsAo+nNg0ywQVgB0u/iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1WFSiz9ahbLEzAY3HXrZ/xRahF5jY4WVdL9+HBEcfMjvMIMQxAFBceCFpKZuFU0u
         4ImgtG90iglibm2bhhCYHllriWujSirjpJ5L0OEJi8NSYa+vxsr7f84AYKoBaPBY1F
         v6WZUfCm0kF1IGHg2NB6akYaH39h4ZoaD/FmG3bE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 119/343] drm/nouveau/pmu: dont print reply values if exec is false
Date:   Fri, 24 Jan 2020 10:28:57 +0100
Message-Id: <20200124092935.677794757@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 11b28b086a062..7b052879af728 100644
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



