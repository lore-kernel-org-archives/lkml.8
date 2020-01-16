Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A00C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC147206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218416;
	bh=KDv9/903esDZ2Zd4v1or1l8x4BzyIxvvyXJ7g4xgGB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aFGHI5u6zvcg5EzoYDOZQhHYy6/xHpDn8A+Vz/2QA0puw8XXi6ZqgcVf2HwzFqAHh
	 A1kpCVCz/qMKUM85eVlj2L5IW3agaImef3wO1/4cWYl7sI2zO++BwzorLLNJvXCMsQ
	 UI1l2Sx1+uCEA9cNKyy0AbTcU2tt2yLHwJsot2fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392075AbgAPXqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390830AbgAPXV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABFA7206D9;
        Thu, 16 Jan 2020 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216889;
        bh=KDv9/903esDZ2Zd4v1or1l8x4BzyIxvvyXJ7g4xgGB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUCXoGEqzhx39krgEgOoQ5YVuTaGEyit5UhJsazSKw7Enmgyy3n2Sq1HNuRPKxsbm
         i3s/2R1laMV3V6DrABJDku5LGm2ber6upQb0551nhF83qOLKHTyhDQjHNK24wxS444
         ly9YPApgDGYF9k/LbvtwhpP/Wfmlv+UOxikuKHDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 061/203] RDMA/hns: Prevent undefined behavior in hns_roce_set_user_sq_size()
Date:   Fri, 17 Jan 2020 00:16:18 +0100
Message-Id: <20200116231749.365403904@linuxfoundation.org>
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

From: Jason Gunthorpe <jgg@mellanox.com>

commit 515f60004ed985d2b2f03659365752e0b6142986 upstream.

The "ucmd->log_sq_bb_count" variable is a user controlled variable in the
0-255 range.  If we shift more than then number of bits in an int then
it's undefined behavior (it shift wraps), and potentially the int could
become negative.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Link: https://lore.kernel.org/r/20190608092514.GC28890@mwanda
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hns/hns_roce_qp.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -332,9 +332,8 @@ static int check_sq_size_with_integrity(
 	u8 max_sq_stride = ilog2(roundup_sq_stride);
 
 	/* Sanity check SQ size before proceeding */
-	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
-	     ucmd->log_sq_stride > max_sq_stride ||
-	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
+	if (ucmd->log_sq_stride > max_sq_stride ||
+	    ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
 		ibdev_err(&hr_dev->ib_dev, "check SQ size error!\n");
 		return -EINVAL;
 	}
@@ -358,13 +357,16 @@ static int hns_roce_set_user_sq_size(str
 	u32 max_cnt;
 	int ret;
 
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &hr_qp->sq.wqe_cnt) ||
+	    hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes)
+		return -EINVAL;
+
 	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
 	if (ret) {
 		ibdev_err(&hr_dev->ib_dev, "Sanity check sq size failed\n");
 		return ret;
 	}
 
-	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 
 	max_cnt = max(1U, cap->max_send_sge);


