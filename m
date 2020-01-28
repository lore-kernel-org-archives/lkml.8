Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3356BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3C324699
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221300;
	bh=/eUgO/y6630nvZMI+yXEuDwopxqJBiSlonyKV60DcfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EGm+/nEpB6rAOvX9dV6wPeGWo0oOwMN7rEFOTZw2Vo1zaU1YGmSDdBJVzAVM0nyxD
	 ErPa1XVQuauvi6i21sULBl0EbcW77S1HPv1Zqb07iaRU2ZwxH3Bo0W2Q49JtB3BJJL
	 Gjvm/mLhimOCPwUWR+Pokus49qvwPMAMtfe4OJ7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgA1OVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbgA1OVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:21:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF57D24686;
        Tue, 28 Jan 2020 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221296;
        bh=/eUgO/y6630nvZMI+yXEuDwopxqJBiSlonyKV60DcfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElmsI3eN3AUNGFr3xbnyyH7hY10oWZ3MsG3LGj7uedSz7egWnMMUJVRcTYDf7yiRX
         eYBfILh26RxPL1U/AVvJ3cHvFJ/LOlOGFCE8vQhx5u6ToMZPEJkLYe+g+wMrF9xkWE
         KE0qr5WC7lI/Aa4d/hy/unqXCX1F6WH0O/WNhfHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <wangxi11@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 167/271] RDMA/hns: Fixs hw access invalid dma memory error
Date:   Tue, 28 Jan 2020 15:05:16 +0100
Message-Id: <20200128135905.012591415@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit ec5bc2cc69b4fc494e04d10fc5226f6f9cf67c56 ]

When smmu is enable, if execute the perftest command and then use 'kill
-9' to exit, follow this operation repeatedly, the kernel will have a high
probability to print the following smmu event:

  arm-smmu-v3 arm-smmu-v3.1.auto: event 0x10 received:
  arm-smmu-v3 arm-smmu-v3.1.auto:  0x00007d0000000010
  arm-smmu-v3 arm-smmu-v3.1.auto:  0x0000020900000080
  arm-smmu-v3 arm-smmu-v3.1.auto:  0x00000000f47cf000
  arm-smmu-v3 arm-smmu-v3.1.auto:  0x00000000f47cf000

This is because the hw will periodically refresh the qpc cache until the
next reset.

This patch fixed it by removing the action that release qpc memory in the
'hns_roce_qp_free' function.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 33cf1035030b5..6f3c0ea99dd05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -241,7 +241,6 @@ void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 	if ((hr_qp->ibqp.qp_type) != IB_QPT_GSI) {
 		hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
-		hns_roce_table_put(hr_dev, &qp_table->qp_table, hr_qp->qpn);
 	}
 }
 
-- 
2.20.1



