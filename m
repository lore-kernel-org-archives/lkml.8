Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8680C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE60206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216954;
	bh=q1yHEwC/VEMhllPl963JJu1jJfwfh43IvmmgiSrS8ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOWjV8kwu4TXyLMI8xOoCWLjf2qOCjqkQVhJcuSz6gTYQUX5SeGLj5/C2PzSnwf5F
	 rC29TFJdzH0GiWYx2kxJpfSOTdDD9sqt/Hdyix0Yrd35lJzhkGDH5mSyx9BJUWXRt2
	 0oCKa3VjQYeplYJAA+nIOnch0FQLCRayArJkekZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbgAPXWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbgAPXWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7792082F;
        Thu, 16 Jan 2020 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216942;
        bh=q1yHEwC/VEMhllPl963JJu1jJfwfh43IvmmgiSrS8ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+tVr2A/0Aptjzm2Yvs/A/lXllk9AODbxfVBBlEMR++Yl4tm1/DLIYjR/UQC1J0hz
         s5p+9xGfGNW58v8OgPRnZcT5kq7j9tVONBK44I6IXMBao7W23NDrJ8A9ru5BprhxNV
         GfT2RLvvouOQi/0bSSlnkYfJl9/JhjJQkzcSL0vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 5.4 067/203] RDMA/hns: Release qp resources when failed to destroy qp
Date:   Fri, 17 Jan 2020 00:16:24 +0100
Message-Id: <20200116231749.970453172@linuxfoundation.org>
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

From: Yangyang Li <liyangyang20@huawei.com>

commit d302c6e3a6895608a5856bc708c47bda1770b24d upstream.

Even if no response from hardware, we should make sure that qp related
resources are released to avoid memory leaks.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Link: https://lore.kernel.org/r/1570584110-3659-1-git-send-email-liweihang@hisilicon.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4650,16 +4650,14 @@ static int hns_roce_v2_destroy_qp_common
 {
 	struct hns_roce_cq *send_cq, *recv_cq;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int ret;
+	int ret = 0;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
-		if (ret) {
+		if (ret)
 			ibdev_err(ibdev, "modify QP to Reset failed.\n");
-			return ret;
-		}
 	}
 
 	send_cq = to_hr_cq(hr_qp->ibqp.send_cq);
@@ -4715,7 +4713,7 @@ static int hns_roce_v2_destroy_qp_common
 		kfree(hr_qp->rq_inl_buf.wqe_list);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
@@ -4725,11 +4723,9 @@ static int hns_roce_v2_destroy_qp(struct
 	int ret;
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
-	if (ret) {
+	if (ret)
 		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
 			  hr_qp->qpn, ret);
-		return ret;
-	}
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
 		kfree(hr_to_hr_sqp(hr_qp));


