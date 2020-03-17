Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F69D20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442939;
	bh=PwiHKutSpB8ifpl393RjPw0c84tOC8R4SP595+LBHcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUCgaHxQlpG3E14aC8VLrXg2+ABzrJSVl/Vscwx0TRzuj9Lwm5Ay/f+9bxARJw0Ne
	 f1T8xAYlFDEEl7rTbMh/pt9erEtpNLNG6tcj/6INEv4WVYlSsr0/UkAS5f0Jfb+lOE
	 7Z/yExQPa66vG+PadHICXp8/g1aee5fbesZi7eEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCQLCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgCQLCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:02:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68ABF20736;
        Tue, 17 Mar 2020 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442933;
        bh=PwiHKutSpB8ifpl393RjPw0c84tOC8R4SP595+LBHcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aet/bxZpduSP8wObm7vTvJKR18rjKHt5G7NoVaudSPDxTCktrlxeU/pB+AsqmEeTA
         IgVUL62+LL9tpTUou+BMzBD6E1eSi+kO+tDEkfvcvAP1LDaj2y79scT4mX5CrJwIzm
         dxrn6y2wMDNQp5EQGXN6al8NEPNQ4C0KZ2j6xymI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edwin Peer <edwin.peer@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 032/123] bnxt_en: fix error handling when flashing from file
Date:   Tue, 17 Mar 2020 11:54:19 +0100
Message-Id: <20200317103311.171436934@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   24 ++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2005,8 +2005,8 @@ static int bnxt_flash_package_from_file(
 	struct hwrm_nvm_install_update_output *resp = bp->hwrm_cmd_resp_addr;
 	struct hwrm_nvm_install_update_input install = {0};
 	const struct firmware *fw;
-	int rc, hwrm_err = 0;
 	u32 item_len;
+	int rc = 0;
 	u16 index;
 
 	bnxt_hwrm_fw_set_time(bp);
@@ -2050,15 +2050,14 @@ static int bnxt_flash_package_from_file(
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
@@ -2067,20 +2066,19 @@ static int bnxt_flash_package_from_file(
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
 
@@ -2092,7 +2090,7 @@ static int bnxt_flash_package_from_file(
 flash_pkg_exit:
 	mutex_unlock(&bp->hwrm_cmd_lock);
 err_exit:
-	if (hwrm_err == -EACCES)
+	if (rc == -EACCES)
 		bnxt_print_admin_err(bp);
 	return rc;
 }


