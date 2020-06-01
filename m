Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A8DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF172077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035069;
	bh=dQc44FXRcZQH53kZ/owf42VQFSBXyilgkJ8iIMxNE/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ziNXZf1d0843KludQqu2sQ2TBDOdFeUksOVu7D4VvnNQWnczcRWAqZJ88zgbgP4+Q
	 j0Gp9QQB97DAyDiegFA6d8qzVGrkHNqP+tIDuGfvIBbiblTlCSywz/PkHW6brTcg2U
	 R0gs5yMw+9pLTSLoqi4+jB8dlEfeftZY1h/ctdW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgFASLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgFASKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:10:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72C6206E2;
        Mon,  1 Jun 2020 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035051;
        bh=dQc44FXRcZQH53kZ/owf42VQFSBXyilgkJ8iIMxNE/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czxOs6e6vr4GGkdEblicafH61sw3h6XU8f0A0M55yj5amOU+iZ62WQLVnZO5+or2Z
         YjMowVmW9b6AydF+FSBu7QrmiDR9vJBJLCCSrXwRE946UyEVeXzUb9wcqjzF1LG9Tf
         pDI8SyGAU4s3DATRbh1OH4aLbBRP4oyloUHiT2vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 130/142] qlcnic: fix missing release in qlcnic_83xx_interrupt_test.
Date:   Mon,  1 Jun 2020 19:54:48 +0200
Message-Id: <20200601174051.231753206@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
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


