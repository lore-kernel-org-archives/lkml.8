Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F701C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138A722B45
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837964;
	bh=2yQjdvyRlegxhP3g7Ww09HkpPA50NKlkwbqSSbfz3Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n62W7JZGl808/rWWxNCkeM5d9mMgoVW/9oi4s33LNJqRIJczmcL7FrZ3viP2Aty4e
	 OJqvNIjwy6cjVzh9QghkChe+WTlfEIiNzThwweNTuVHMumWQ6/SIvVKJNqxI+T1u3/
	 49kaDOZaZmYKY34CqXHsnE26IeTqBtMuxxB/e2xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHSLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgHSLqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:46:52 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFCF22B49;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=2yQjdvyRlegxhP3g7Ww09HkpPA50NKlkwbqSSbfz3Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8gwwe9Mb1Pjem3EbtG1gQA62R5MrWxIbVz0rdlyzmoWdbw9/6rNg93zczReSjsZC
         aVD6mSZUdws0YLOPBUmQFdw/LGGQwBl2fSmz49BhUc5yDzrG0Bbk2xo9oWyYzeHH68
         8YVN2k5bqWCSaOhRCqjtx9NnDQ+ABfnfXGbeIZHM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00Euak-5K; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/49] staging: hikey9xx/gpu: add a copy of set_reg() function there
Date:   Wed, 19 Aug 2020 13:45:47 +0200
Message-Id: <a92be25fef54fc7f339417861e2bd8ead90ac5cb.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has a too generic name to export it as a
symbol. Also, we should likely use some other macro instead.

So, for now, just copy it into the Kirin9xx dsi module, in order
for the driver to build.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
index cfb6bfd1c338..cba81ee2639d 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
@@ -37,7 +37,6 @@
 #else
 #include "kirin960_dpe_reg.h"
 #endif
-#include "kirin9xx_drm_dpe_utils.h"
 #include "kirin9xx_drm_drv.h"
 
 #if defined (CONFIG_DRM_HISI_KIRIN970)
@@ -270,6 +269,22 @@ static const struct dsi_phy_range dphy_range_info[] = {
 	{ 1000000,  1500000,   0,    0 }
 };
 
+/*
+ * Except for debug, this is identical to the one defined at
+ * kirin9xx_drm_dpe_utils.h.
+ */
+static void set_reg(char __iomem *addr, uint32_t val, uint8_t bw,
+		    uint8_t bs)
+{
+	u32 mask = (1UL << bw) - 1UL;
+	u32 tmp = 0;
+
+	tmp = inp32(addr);
+	tmp &= ~(mask << bs);
+
+	outp32(addr, tmp | ((val & mask) << bs));
+}
+
 void dsi_set_output_client(struct drm_device *dev)
 {
 	struct drm_connector_list_iter conn_iter;
-- 
2.26.2

