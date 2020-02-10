Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701D208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341202;
	bh=pnJ6H7TyYYyp1B+q916+0lMdWSoHfJ/VUKuCSLuQoRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rNRlpeFv/0rWEYUA7QbBSpo88LoAb4jcf8RrxOOn8mivFVhpT3mQW+cfIPqnDax0b
	 rTOLRK0+2NIhfL/aFj7F9n+3yoGRgo+pY11YFs+jIjS2qFTlPS7Z2elobzvvipoayD
	 ahMfYp0HSYJOADOB+vgoKMcKuSNousHv1PMGQanE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgBJN0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgBJMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:44 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35542051A;
        Mon, 10 Feb 2020 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338203;
        bh=pnJ6H7TyYYyp1B+q916+0lMdWSoHfJ/VUKuCSLuQoRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9IcMdjSp2CuydVzkxrPbPW1EulxfSXoJ1ss4EFnA6pzuzXF4gePB3XB6U/G492Ic
         yy62+weDZtmAlDtpL7bxVb5sFn+u0ASHzxyU9yk6lMcQbWrrXkqz6d8SWK7FGVYYuG
         dlahwgoLcAU/j6T6zrAQjJoGmSXLljelfa6MrZmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 021/309] bnxt_en: Fix logic that disables Bus Master during firmware reset.
Date:   Mon, 10 Feb 2020 04:29:37 -0800
Message-Id: <20200210122408.025809959@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit d407302895d3f3ca3a333c711744a95e0b1b0150 ]

The current logic that calls pci_disable_device() in __bnxt_close_nic()
during firmware reset is flawed.  If firmware is still alive, we're
disabling the device too early, causing some firmware commands to
not reach the firmware.

Fix it by moving the logic to bnxt_reset_close().  If firmware is
in fatal condition, we call pci_disable_device() before we free
any of the rings to prevent DMA corruption of the freed rings.  If
firmware is still alive, we call pci_disable_device() after the
last firmware message has been sent.

Fixes: 3bc7d4a352ef ("bnxt_en: Add BNXT_STATE_IN_FW_RESET state.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9273,10 +9273,6 @@ static void __bnxt_close_nic(struct bnxt
 	bnxt_debug_dev_exit(bp);
 	bnxt_disable_napi(bp);
 	del_timer_sync(&bp->timer);
-	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state) &&
-	    pci_is_enabled(bp->pdev))
-		pci_disable_device(bp->pdev);
-
 	bnxt_free_skbs(bp);
 
 	/* Save ring stats before shutdown */
@@ -10052,8 +10048,15 @@ static void bnxt_fw_reset_close(struct b
 {
 	__bnxt_close_nic(bp, true, false);
 	bnxt_ulp_irq_stop(bp);
+	/* When firmware is fatal state, disable PCI device to prevent
+	 * any potential bad DMAs before freeing kernel memory.
+	 */
+	if (test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state))
+		pci_disable_device(bp->pdev);
 	bnxt_clear_int_mode(bp);
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	if (pci_is_enabled(bp->pdev))
+		pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
 	kfree(bp->ctx);
 	bp->ctx = NULL;


