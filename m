Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F445C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537B020702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946970;
	bh=BqB/9KVj8We+s1sje/PIaux8HMU7k4aVnS/tkl1/wkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCyVyLM7jsguEgQMlTNa6TQRoLsGd53jDqA47yrCx4/ostdQcML/zxYE5mp3Nd/jX
	 Sr1DE35rStNyrIZcoB99ixTTwH9JSve3ITlIH0RIjjiejFrqk9QnUJ+kVul84su2Wr
	 LJIdkbvHs89y/2vaIdu2aEkp2vKtmCdmj9LC5NQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390827AbgFWU2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390805AbgFWU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:27:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F872064B;
        Tue, 23 Jun 2020 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944072;
        bh=BqB/9KVj8We+s1sje/PIaux8HMU7k4aVnS/tkl1/wkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHxAVjI/pUCRUgHY6oYPAx99IAUtI3J9iBIY9ZxcavU6Bt3G8cK6g2QssQN5DkxLW
         b/1rYxhbn/AlfFcsgIPaNrVkz/d9Z/Vm0r41hO3tsRP0dhCj2KjxnA4Klc/0fJCTO3
         SXwkbRDAVWHZvAaM6pXkzPWko5HumcRvBhdpU2Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 160/314] RDMA/hns: Bugfix for querying qkey
Date:   Tue, 23 Jun 2020 21:55:55 +0200
Message-Id: <20200623195346.502831653@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 349be276509455ac2f19fa4051ed773082c6a27e ]

The qkey queried through the query ud qp verb is a fixed value and it
should be read from qp context.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Link: https://lore.kernel.org/r/1588931159-56875-2-git-send-email-liweihang@huawei.com
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4540b00ccee94..9a8053bd01e22 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4564,7 +4564,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->path_mig_state = IB_MIG_ARMED;
 	qp_attr->ah_attr.type   = RDMA_AH_ATTR_TYPE_ROCE;
 	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
-		qp_attr->qkey = V2_QKEY_VAL;
+		qp_attr->qkey = le32_to_cpu(context.qkey_xrcd);
 
 	qp_attr->rq_psn = roce_get_field(context.byte_108_rx_reqepsn,
 					 V2_QPC_BYTE_108_RX_REQ_EPSN_M,
-- 
2.25.1



