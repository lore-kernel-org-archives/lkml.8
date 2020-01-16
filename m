Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BB720684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216964;
	bh=Wdqt4q3dgQL4m2vcqrAU819Plg9TCXVFUs4S+PXx47Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OudcnA36vSHEd5EWJyJ+Q1Yo5YbJdqYMx1X7+K2ywHg5iE3Xmw5g6oF8GdHbJWhUJ
	 HEQuJ1COTpLKsHWrJJm1ItlA2mtnFKrf3bUL90QjhYr4fBcc819TXUJiSZlrQa0hDi
	 fnlPVnH87O/ivQ4/mNbfoo/GrUSFKvTCbKabXyCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbgAPXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388399AbgAPXWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D61120684;
        Thu, 16 Jan 2020 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216954;
        bh=Wdqt4q3dgQL4m2vcqrAU819Plg9TCXVFUs4S+PXx47Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1EREG5KEuBgpSG/p6vJhY9uNpR8OlwZFugBOw7nJpx2ug4Ex8m0wFEhmfyWBg3PfA
         C+mz/xKEzv0otHUMmPvG5Dni0lMbp0OgDihqOw8EPXp8Ar1GRr+lFMs4BkV0Ai4h8+
         6BirF6D69zAVdmev1F9yzW0zT0shZ5fP8O4UbWJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 072/203] RDMA/hns: Fix to support 64K page for srq
Date:   Fri, 17 Jan 2020 00:16:29 +0100
Message-Id: <20200116231750.455933921@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

commit 5c7e76fb7cb5071be800c938ebf2c475e140d3f0 upstream.

SRQ's page size configuration of BA and buffer should depend on current
PAGE_SHIFT, or it can't work in scenario of 64K page.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Link: https://lore.kernel.org/r/1571908917-16220-2-git-send-email-liweihang@hisilicon.com
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6088,11 +6088,11 @@ static void hns_roce_v2_write_srqc(struc
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
-		       hr_dev->caps.idx_ba_pg_sz);
+		       hr_dev->caps.idx_ba_pg_sz + PG_SHIFT_OFFSET);
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
-		       hr_dev->caps.idx_buf_pg_sz);
+		       hr_dev->caps.idx_buf_pg_sz + PG_SHIFT_OFFSET);
 
 	srq_context->idx_nxt_blk_addr =
 		cpu_to_le32(mtts_idx[1] >> PAGE_ADDR_SHIFT);


