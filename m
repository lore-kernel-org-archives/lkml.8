Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62393207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247984;
	bh=wyUmRUsPYRl4dMRgSC9ZhWOnX0sOGZSmvmHTCT53zTI=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=1Pj4p4l1jY1UVTjY0e+r6VGgY3Yd8LFovahQwHZSyUdDaVXJ2Frj7sqP9kl1QN6LN
	 ZKS9TTJrLuq/tEdY2SBJMr57V8d04Ym7+nNyJDzG2kFPdteXodsQUAKFTihPiNW7vN
	 EFY8VxihAkStG7HFUROjb0pkKmKFnR49J5beGdHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHLP7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHLP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:00 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830002177B;
        Wed, 12 Aug 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247819;
        bh=wyUmRUsPYRl4dMRgSC9ZhWOnX0sOGZSmvmHTCT53zTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJ87HLCuC7FbjosrWbFp6CnMbAmGQy2WOfO56ptSRJblhAZ+8h9F/JkoYfe2nM2l6
         d9LigmwububQ2DoDEpuMY46VbRA/ljX8tG4rn0LpuMSilOaKBk7lcuT+tnMMcmTICn
         CfkZK6CyuBTaAeiObOhwLCTHmMWy+Bu/Q7tAUPKg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7Z-005t5q-LF; Wed, 12 Aug 2020 17:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 07/44] staging: spmi: hisi-spmi-controller: add debug when values are read/write
Date:   Wed, 12 Aug 2020 17:56:17 +0200
Message-Id: <655d5e9addf8d435d5a8705ee07faf38799374a8.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is interesting to be able to check if the driver is doing
the right thing. So, add some debug macros to allow checking it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index cacd28150b49..e996114bc717 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -41,7 +41,6 @@
 #define SPMI_APB_SPMI_CMD_EN				BIT(31)
 #define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
 #define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
-
 #define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
 #define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
 
@@ -135,10 +134,11 @@ static int spmi_controller_wait_for_done(struct spmi_controller_dev *ctrl_dev,
 }
 
 static int spmi_read_cmd(struct spmi_controller *ctrl,
-			 u8 opc, u8 sid, u16 addr, u8 *buf, size_t bc)
+			 u8 opc, u8 sid, u16 addr, u8 *__buf, size_t bc)
 {
 	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
 	unsigned long flags;
+	u8 *buf = __buf;
 	u32 cmd, data;
 	int rc;
 	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
@@ -197,13 +197,18 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 	if (rc)
 		dev_err(spmi_controller->dev, "spmi read wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
 			opc, sid, addr, bc + 1);
+	else
+		dev_dbg(spmi_controller->dev, "%s: id:%d addr:0x%x, read value: %*ph\n",
+			__func__, sid, addr, (int)bc, __buf);
+
 	return rc;
 }
 
 static int spmi_write_cmd(struct spmi_controller *ctrl,
-			  u8 opc, u8 sid, u16 addr, const u8 *buf, size_t bc)
+			  u8 opc, u8 sid, u16 addr, const u8 *__buf, size_t bc)
 {
 	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
+	const u8 *buf = __buf;
 	unsigned long flags;
 	u32 cmd, data;
 	int rc;
@@ -263,6 +268,9 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 	if (rc)
 		dev_err(spmi_controller->dev, "spmi write wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
 			opc, sid, addr, bc);
+	else
+		dev_dbg(spmi_controller->dev, "%s: id:%d addr:0x%x, wrote value: %*ph\n",
+			__func__, sid, addr, (int)bc, __buf);
 
 	return rc;
 }
@@ -275,6 +283,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	dev_info(&pdev->dev, "HISI SPMI probe\n");
+
 	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*spmi_controller));
 	if (!ctrl) {
 		dev_err(&pdev->dev, "can not allocate spmi_controller data\n");
-- 
2.26.2

