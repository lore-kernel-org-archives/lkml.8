Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67895204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690180;
	bh=HwaHmUt9yFDxV9f7tvtlwHuf9YjdCfv+ZUog+KE0Z8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBWL/ISmUpzVUyGxGyjNd974qxZq9ljlsZ+jeZMGjj++pkdDip4EusZjbA2PWl372
	 rc89IgwEEwL5XwzzE5LNexNYmLSo/NN0KDi4bBv1dgKEiHfsY3OKyqRSC/t1c9Q4Gl
	 kpQdyHRYeloaPmf1iNvBayylCDn6KF7AWEQWV1So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbgHQStg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbgHQPy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:54:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400E720729;
        Mon, 17 Aug 2020 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679668;
        bh=HwaHmUt9yFDxV9f7tvtlwHuf9YjdCfv+ZUog+KE0Z8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1F8nvbkQ5hoy3YTtZ6tBd1nMfCN2M6ZjbH+lOQBx6fYSLWEKplyMsu8Yl+6M71tT
         F36pULLoN0bmRpnVGnUOXAiY215DqbyNI7RyMJD87TV3k6bc8I58cL4+RxE4hDXKac
         oTLg2iAJJMYXSxJfrqYavYGak2X/8+aCZaKgRWdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Li Heng <liheng40@huawei.com>,
        Parav Pandit <parav@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 252/393] RDMA/core: Fix return error value in _ib_modify_qp() to negative
Date:   Mon, 17 Aug 2020 17:15:02 +0200
Message-Id: <20200817143831.845193427@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Heng <liheng40@huawei.com>

[ Upstream commit 47fda651d5af2506deac57d54887cf55ce26e244 ]

The error codes in _ib_modify_qp() are supposed to be negative errno.

Fixes: 7a5c938b9ed0 ("IB/core: Check for rdma_protocol_ib only after validating port_num")
Link: https://lore.kernel.org/r/1595645787-20375-1-git-send-email-liheng40@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 56a71337112c5..cf45fd704671f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1659,7 +1659,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 		if (!(rdma_protocol_ib(qp->device,
 				       attr->alt_ah_attr.port_num) &&
 		      rdma_protocol_ib(qp->device, port))) {
-			ret = EINVAL;
+			ret = -EINVAL;
 			goto out;
 		}
 	}
-- 
2.25.1



