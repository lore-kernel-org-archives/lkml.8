Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A25CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C78820776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035543;
	bh=dQc44FXRcZQH53kZ/owf42VQFSBXyilgkJ8iIMxNE/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aHBdG4ksRiwdXpVdwnbaIM8PeaSFSMTn4OO0kIL/HrODDHrmfOsrifCHAQf4Sms0X
	 AsqfRDRXYp5dSihgbM8iaJ2G5AeN+CZ2cdL1kcSCaXeFtjRgwHxj+dzV2mp9c/lhFc
	 kH8uZwHI60N+XWSGsMIYSo0Y9TpToN4myAIjyuCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgFASTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbgFASRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09252087D;
        Mon,  1 Jun 2020 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035453;
        bh=dQc44FXRcZQH53kZ/owf42VQFSBXyilgkJ8iIMxNE/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0EyUjvcUnHhIs9O/qt7ylbcW9WrRQ4TLUAg2TvTXRueons+FJH9Z5/Wc7L6rX7x/
         pWYREG+RkmQhba6um+iarTwNNIVCKC+aXyv7lKLedpAQRIyLteF5UWEQ+RV8G0tQcB
         87Gw0V1b1goHzGVfImpKYtjWrLubAhKn+DDVJy3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 165/177] qlcnic: fix missing release in qlcnic_83xx_interrupt_test.
Date:   Mon,  1 Jun 2020 19:55:03 +0200
Message-Id: <20200601174101.941932302@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit 15c973858903009e995b2037683de29dfe968621 upstream.

In function qlcnic_83xx_interrupt_test(), function
qlcnic_83xx_diag_alloc_res() is not handled by function
qlcnic_83xx_diag_free_res() after a call of the function
qlcnic_alloc_mbx_args() failed. Fix this issue by adding
a jump target "fail_mbx_args", and jump to this new target
when qlcnic_alloc_mbx_args() failed.

Fixes: b6b4316c8b2f ("qlcnic: Handle qlcnic_alloc_mbx_args() failure")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -3651,7 +3651,7 @@ int qlcnic_83xx_interrupt_test(struct ne
 	ahw->diag_cnt = 0;
 	ret = qlcnic_alloc_mbx_args(&cmd, adapter, QLCNIC_CMD_INTRPT_TEST);
 	if (ret)
-		goto fail_diag_irq;
+		goto fail_mbx_args;
 
 	if (adapter->flags & QLCNIC_MSIX_ENABLED)
 		intrpt_id = ahw->intr_tbl[0].id;
@@ -3681,6 +3681,8 @@ int qlcnic_83xx_interrupt_test(struct ne
 
 done:
 	qlcnic_free_mbx_args(&cmd);
+
+fail_mbx_args:
 	qlcnic_83xx_diag_free_res(netdev, drv_sds_rings);
 
 fail_diag_irq:


