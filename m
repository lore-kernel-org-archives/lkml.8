Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0299AC4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C435920409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565736;
	bh=mH63WqY6iqTQFRbb7BCVuLKv9l/wXRtMK2ais8FKfrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M4WwGIns8tUv8tgaN1IpEG/PAv+IM1hBZPsNEgs82EJkPlmRSoS8H085SPizTgId4
	 n8zwspdQGmRuCxuorSDxXQP7HFKbB7PszsWbJtRBWwjeocYNjSqz9KrW1Aw3u1LIwR
	 /a2KYrK2J1WTbL+P5zt4EYibyFx52uDW028DydPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCRUx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgCRUxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F0620B1F;
        Wed, 18 Mar 2020 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564833;
        bh=mH63WqY6iqTQFRbb7BCVuLKv9l/wXRtMK2ais8FKfrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNjykw4TNnG8wkJTwADTPiUJyiRnBfYJhVycWa9gvLFoeMsXh5+jHCfhXgfKALmqj
         3qivIufs64MXtEGe0QDfGYl9f7ScSulHR6NGD6/pfxAxlVAjREm4jtOo5giVlQMMoq
         dvbFkq85GgmQu7gCTUdjTpkiRXC/T6hQazSWft9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edwin Peer <edwin.peer@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/73] bnxt_en: fix error handling when flashing from file
Date:   Wed, 18 Mar 2020 16:52:37 -0400
Message-Id: <20200318205337.16279-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edwin Peer <edwin.peer@broadcom.com>

[ Upstream commit 22630e28f9c2b55abd217869cc0696def89f2284 ]

After bnxt_hwrm_do_send_message() was updated to return standard error
codes in a recent commit, a regression in bnxt_flash_package_from_file()
was introduced.  The return value does not properly reflect all
possible firmware errors when calling firmware to flash the package.

Fix it by consolidating all errors in one local variable rc instead
of having 2 variables for different errors.

Fixes: d4f1420d3656 ("bnxt_en: Convert error code in firmware message response to standard code.")
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ece70f61c89a2..cfa647d5b44db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2005,8 +2005,8 @@ static int bnxt_flash_package_from_file(struct net_device *dev,
 	struct hwrm_nvm_install_update_output *resp = bp->hwrm_cmd_resp_addr;
 	struct hwrm_nvm_install_update_input install = {0};
 	const struct firmware *fw;
-	int rc, hwrm_err = 0;
 	u32 item_len;
+	int rc = 0;
 	u16 index;
 
 	bnxt_hwrm_fw_set_time(bp);
@@ -2050,15 +2050,14 @@ static int bnxt_flash_package_from_file(struct net_device *dev,
 			memcpy(kmem, fw->data, fw->size);
 			modify.host_src_addr = cpu_to_le64(dma_handle);
 
-			hwrm_err = hwrm_send_message(bp, &modify,
-						     sizeof(modify),
-						     FLASH_PACKAGE_TIMEOUT);
+			rc = hwrm_send_message(bp, &modify, sizeof(modify),
+					       FLASH_PACKAGE_TIMEOUT);
 			dma_free_coherent(&bp->pdev->dev, fw->size, kmem,
 					  dma_handle);
 		}
 	}
 	release_firmware(fw);
-	if (rc || hwrm_err)
+	if (rc)
 		goto err_exit;
 
 	if ((install_type & 0xffff) == 0)
@@ -2067,20 +2066,19 @@ static int bnxt_flash_package_from_file(struct net_device *dev,
 	install.install_type = cpu_to_le32(install_type);
 
 	mutex_lock(&bp->hwrm_cmd_lock);
-	hwrm_err = _hwrm_send_message(bp, &install, sizeof(install),
-				      INSTALL_PACKAGE_TIMEOUT);
-	if (hwrm_err) {
+	rc = _hwrm_send_message(bp, &install, sizeof(install),
+				INSTALL_PACKAGE_TIMEOUT);
+	if (rc) {
 		u8 error_code = ((struct hwrm_err_output *)resp)->cmd_err;
 
 		if (resp->error_code && error_code ==
 		    NVM_INSTALL_UPDATE_CMD_ERR_CODE_FRAG_ERR) {
 			install.flags |= cpu_to_le16(
 			       NVM_INSTALL_UPDATE_REQ_FLAGS_ALLOWED_TO_DEFRAG);
-			hwrm_err = _hwrm_send_message(bp, &install,
-						      sizeof(install),
-						      INSTALL_PACKAGE_TIMEOUT);
+			rc = _hwrm_send_message(bp, &install, sizeof(install),
+						INSTALL_PACKAGE_TIMEOUT);
 		}
-		if (hwrm_err)
+		if (rc)
 			goto flash_pkg_exit;
 	}
 
@@ -2092,7 +2090,7 @@ static int bnxt_flash_package_from_file(struct net_device *dev,
 flash_pkg_exit:
 	mutex_unlock(&bp->hwrm_cmd_lock);
 err_exit:
-	if (hwrm_err == -EACCES)
+	if (rc == -EACCES)
 		bnxt_print_admin_err(bp);
 	return rc;
 }
-- 
2.20.1

