Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A8B2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598552715;
	bh=Z0fq8dm88+dU9bSyD1/ti5vEZonGfauWaztGQMRRjv4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CvRGYJM1OO5f9ZTj9P4DcrgXdgBwVAwaymCSMB6qtUuhynvmQmi/BF0FIHEyzu/P5
	 6dIcNNyBdfHIghjbz2rI8FnJZI7FP0k0dRjJBA14kDsOAkP9OsaPzHEkVOirZcAWIJ
	 isyvBC9mv+gMvz5na33wfffiMPTdpLiJZT93Aeps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH0SZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH0SZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:25:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834FE2087C;
        Thu, 27 Aug 2020 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598552713;
        bh=Z0fq8dm88+dU9bSyD1/ti5vEZonGfauWaztGQMRRjv4=;
        h=From:To:Cc:Subject:Date:From;
        b=IwTyGYXlnbFOhjBVfmnr32F+ohdbcGf6mHx2E6En0fwR5qRBHq9yO91+/S6zv2h0w
         4+NDrFOePMEVUsNYcT3MvpBJoxWD+XLp4nmvr2ulQcvggxIVrcUxRGGgOk39RdthS2
         ksaZ/x2Y9mvHGkvPkj4TIMDEonMo0PEZr+dfXpt8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] mailbox: mediatek: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 20:25:07 +0200
Message-Id: <20200827182507.4938-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case casting to u32
and comparing to 0 would pass the check.

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Fix subject.

Changes since v1:
1. Correct u32->int,
2. Fix left-over '!'.
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 484d4438cd83..5665b6ea8119 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -69,7 +69,7 @@ struct cmdq_task {
 struct cmdq {
 	struct mbox_controller	mbox;
 	void __iomem		*base;
-	u32			irq;
+	int			irq;
 	u32			thread_nr;
 	u32			irq_mask;
 	struct cmdq_thread	*thread;
@@ -525,10 +525,8 @@ static int cmdq_probe(struct platform_device *pdev)
 	}
 
 	cmdq->irq = platform_get_irq(pdev, 0);
-	if (!cmdq->irq) {
-		dev_err(dev, "failed to get irq\n");
-		return -EINVAL;
-	}
+	if (cmdq->irq < 0)
+		return cmdq->irq;
 
 	plat_data = (struct gce_plat *)of_device_get_match_data(dev);
 	if (!plat_data) {
-- 
2.17.1

