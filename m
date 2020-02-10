Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A71FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ABB20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339129;
	bh=jPoE6XcnEbE2KOaQgoztjLf0DwFZSq5ltPR9Xwbho0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBfPJcUbJ7m76eYUKstDetdICgHSWR9avfecwvwRSOQYOFwWUwrbPQlWZSJ52s2nO
	 FC/d3QMMqvqVlzq+K7V5xrQlMKQVGi9a9c88+VRP0LsjKgIc++gBgWyaakxtdjTScw
	 fjU6CWH1dcIKgl9R8G9Eb5+Q2YP2y3KDm4xplxsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgBJMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgBJMjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:33 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1251620842;
        Mon, 10 Feb 2020 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338372;
        bh=jPoE6XcnEbE2KOaQgoztjLf0DwFZSq5ltPR9Xwbho0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zY6dMksgqH3PA3W0WUjjr95WStdQ1mxu3I0exCpV29l3Oj6RO/PfG6tmtNEiGb0yR
         JmDwMg6g+GLUoddXOVjmcbDZu43FEgA1/t6a/3KAjyhTQzk3BCsHX9j9WwreQ7queZ
         5+qKzkjQUyRAVEhqTYScNeSGNHzId6POBO7nmd5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.5 026/367] bnxt_en: Fix logic that disables Bus Master during firmware reset.
Date:   Mon, 10 Feb 2020 04:28:59 -0800
Message-Id: <20200210122426.308964111@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -9312,10 +9312,6 @@ static void __bnxt_close_nic(struct bnxt
 	bnxt_debug_dev_exit(bp);
 	bnxt_disable_napi(bp);
 	del_timer_sync(&bp->timer);
-	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state) &&
-	    pci_is_enabled(bp->pdev))
-		pci_disable_device(bp->pdev);
-
 	bnxt_free_skbs(bp);
 
 	/* Save ring stats before shutdown */
@@ -10093,9 +10089,16 @@ static void bnxt_reset(struct bnxt *bp,
 static void bnxt_fw_reset_close(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
+	/* When firmware is fatal state, disable PCI device to prevent
+	 * any potential bad DMAs before freeing kernel memory.
+	 */
+	if (test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state))
+		pci_disable_device(bp->pdev);
 	__bnxt_close_nic(bp, true, false);
 	bnxt_clear_int_mode(bp);
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	if (pci_is_enabled(bp->pdev))
+		pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
 	kfree(bp->ctx);
 	bp->ctx = NULL;


