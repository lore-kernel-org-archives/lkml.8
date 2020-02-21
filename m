Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D2C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A3206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274644;
	bh=mHCqROaKJ7SzNg5MXZjS44KD2tpZdsshpaEXfJi5wlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ng5+ud9Y/1q1yeVnxlVSDAIYQFUOfs4FDfzpbbZvD/yykIDxndFKxGGpajG/WFCew
	 T1ZS5C8r4OHkuNO0v1ckI5A6BRSIQn7ftwBVTwVzAbUKlGcXAjNvBh3hPIskhTBQb5
	 vOdX7o9YEg8Kn1PgSLBL48ckzl0h+xkNHfJwH1fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgBUIoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgBUHwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:52:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80FFC24653;
        Fri, 21 Feb 2020 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271570;
        bh=mHCqROaKJ7SzNg5MXZjS44KD2tpZdsshpaEXfJi5wlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj2iPiwNZDUdmdGV5ao2uFr5TpjivoV1MmR/WI0o0Ej0syh0pdKMPIIpebFD6h5IL
         mlYh3cVdHvnn/bQpykq0WzYMiv5+l5hWS4KsyVszVhhZ50b1osZSpSjnBME0P/DKYV
         TkeV/ZEGazrTblcWo3dmoIXwD+k8V+M1zj4JYYOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 216/399] RDMA/hns: Avoid printing address of mtt page
Date:   Fri, 21 Feb 2020 08:39:01 +0100
Message-Id: <20200221072424.003409153@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

[ Upstream commit eca44507c3e908b7362696a4d6a11d90371334c6 ]

Address of a page shouldn't be printed in case of security issues.

Link: https://lore.kernel.org/r/1578313276-29080-2-git-send-email-liweihang@huawei.com
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 9ad19170c3f97..95765560c1cfb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1064,8 +1064,8 @@ int hns_roce_ib_umem_write_mtt(struct hns_roce_dev *hr_dev,
 		if (!(npage % (1 << (mtt->page_shift - PAGE_SHIFT)))) {
 			if (page_addr & ((1 << mtt->page_shift) - 1)) {
 				dev_err(dev,
-					"page_addr 0x%llx is not page_shift %d alignment!\n",
-					page_addr, mtt->page_shift);
+					"page_addr is not page_shift %d alignment!\n",
+					mtt->page_shift);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.20.1



