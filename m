Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DDC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABCE20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646208;
	bh=IyginMYVJzvpy3Q5tHbEtrGdrQCTHoh7Rbw5CtAfmw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mcu7bGL/XIdkd8NzP9dCuDOixnw6wUUyk47Sf7HqLmr98mVUdRVnoOenhKEo2DeMw
	 ZuBEwAPZW8vy5AXpgPeB1D6FskDl2b5Cch8dCPTwvuzzwN+qIRzvZ5cKTO9VK4Ee5n
	 Ifhd4CDRqJQ2pDwZqHYT4U+0BLqdD88NbJm1512E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbgCaJQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbgCaJQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:16:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E942072E;
        Tue, 31 Mar 2020 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646203;
        bh=IyginMYVJzvpy3Q5tHbEtrGdrQCTHoh7Rbw5CtAfmw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm9RacMPYdRDeI9+Vz6G4ms4RhxmhUpYYumulDpGPArF9/qlFMIvU18mOU77Z8Seh
         5PZn0uI1q3AG/IQnw/KgJ2C9TTpcrQJhZ+c4Znt30pJ763bwVJDTcVIDIfTmH2cwFU
         j5O264E4sZ7g3t1++uXMhhgSUfGDT54zLLOHy2IA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 115/155] RDMA/mlx5: Block delay drop to unprivileged users
Date:   Tue, 31 Mar 2020 10:59:15 +0200
Message-Id: <20200331085431.397025815@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

commit ba80013fba656b9830ef45cd40a6a1e44707f47a upstream.

It has been discovered that this feature can globally block the RX port,
so it should be allowed for highly privileged users only.

Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
Link: https://lore.kernel.org/r/20200322124906.1173790-1-leon@kernel.org
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6132,6 +6132,10 @@ struct ib_wq *mlx5_ib_create_wq(struct i
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);
 
+	if (!capable(CAP_SYS_RAWIO) &&
+	    init_attr->create_flags & IB_WQ_FLAGS_DELAY_DROP)
+		return ERR_PTR(-EPERM);
+
 	dev = to_mdev(pd->device);
 	switch (init_attr->wq_type) {
 	case IB_WQT_RQ:


