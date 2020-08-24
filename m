Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D390720738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261862;
	bh=d7IbofLkFJ0M00OwoHaWe5uXwyBPGMJBoTGBm7SmEMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9ypMr39LPWdcGx4LO3uUaHzeECQzYR3aBUrP42DFlgrmca2xp5lcfMN9zs2q0OBt
	 r/GikTPjDNltqz1kwJWRTWxdXwkRTHpsWGpUqq9mPK/wy01e+Y24LG7BOTHjZAkLys
	 2K3irnQmeV+3i4fLmChz7WE7bPo4M4GQATTCEmUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgHXIrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbgHXIrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9131204FD;
        Mon, 24 Aug 2020 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258854;
        bh=d7IbofLkFJ0M00OwoHaWe5uXwyBPGMJBoTGBm7SmEMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTayScb0KM4atCqLNusxAJ3Umm3pD5X0OXOEqSDsmTaPlr3ajw4dLfcWldOAwIoNq
         uD37uRpXRoMoPm2JnHJlCPSsdp4gmu9TqvpM3vA/MYXgjqhGK5vBdzbaTGNxdHfnFl
         m/W3qt5v+EhSJRs+8uxBvjyryY6T/bcm+NmZ5ehE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/107] scsi: ufs: Add DELAY_BEFORE_LPM quirk for Micron devices
Date:   Mon, 24 Aug 2020 10:30:07 +0200
Message-Id: <20200824082407.174877391@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



