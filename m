Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B29C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009FF207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882217;
	bh=d7IbofLkFJ0M00OwoHaWe5uXwyBPGMJBoTGBm7SmEMk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=szoUg5LCNsS26OhYRmJ34myXqzebVXMb8ztkviQEz0eoXT0vP6zY2g33oEBPY7fZB
	 WOp8rWfLFiiZftJYacQmx5KEQK218ZO8LC3RDdvTErbVXsyZOAKYYwqYsH2fp3m6Al
	 m+uEpj2YH3KDJlnTtpxPU+f9OqVGMh6EkCYS70F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgHTAKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgHTACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13954208E4;
        Thu, 20 Aug 2020 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881752;
        bh=d7IbofLkFJ0M00OwoHaWe5uXwyBPGMJBoTGBm7SmEMk=;
        h=From:To:Cc:Subject:Date:From;
        b=jRV1J3fW1UAYFA7zFJwMyD8fCC8qmBS7h5F5ALm5P1AKfMNb/U16ERQG7gvn3EETh
         +l0zVOh9ZJuRzF5SsSm80ejzGbDzWqzZYF1H6va88Aaf5p6pyk/1VqkoQAuoYefna/
         WNDNlzx852bw30kXphVJAMTP4S0s7TXRYuxegins=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 01/22] scsi: ufs: Add DELAY_BEFORE_LPM quirk for Micron devices
Date:   Wed, 19 Aug 2020 20:02:08 -0400
Message-Id: <20200820000229.215333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit c0a18ee0ce78d7957ec1a53be35b1b3beba80668 ]

It is confirmed that Micron device needs DELAY_BEFORE_LPM quirk to have a
delay before VCC is powered off. Sdd Micron vendor ID and this quirk for
Micron devices.

Link: https://lore.kernel.org/r/20200612012625.6615-2-stanley.chu@mediatek.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_quirks.h | 1 +
 drivers/scsi/ufs/ufshcd.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufs_quirks.h b/drivers/scsi/ufs/ufs_quirks.h
index fe6cad9b2a0d2..03985919150b9 100644
--- a/drivers/scsi/ufs/ufs_quirks.h
+++ b/drivers/scsi/ufs/ufs_quirks.h
@@ -12,6 +12,7 @@
 #define UFS_ANY_VENDOR 0xFFFF
 #define UFS_ANY_MODEL  "ANY_MODEL"
 
+#define UFS_VENDOR_MICRON      0x12C
 #define UFS_VENDOR_TOSHIBA     0x198
 #define UFS_VENDOR_SAMSUNG     0x1CE
 #define UFS_VENDOR_SKHYNIX     0x1AD
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2b6853c7375c9..b41b88bcab3d9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -217,6 +217,8 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 
 static struct ufs_dev_fix ufs_fixups[] = {
 	/* UFS cards deviations table */
+	UFS_FIX(UFS_VENDOR_MICRON, UFS_ANY_MODEL,
+		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM),
 	UFS_FIX(UFS_VENDOR_SAMSUNG, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM),
 	UFS_FIX(UFS_VENDOR_SAMSUNG, UFS_ANY_MODEL,
-- 
2.25.1

