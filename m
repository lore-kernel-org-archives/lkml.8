Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A172071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262170;
	bh=leVTurjUD+8+YlGK6i8qakCakA8BGvB6rJ0efjYly1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsdeLGpb6N27DsiY+qaoPcbSetIzHsomZi6MNABvMcHuwwKmF5uT4/qYBN1l/GtKG
	 qPJIDIMaAwHBfloLn9G3d4FacxZ4Pg2W7CXuUuYhxm7pdVAUIwYX8BzlnPlIarvB5F
	 etH6iVbto+blnjIbRWkABtpLAnDEX/6dG8GnTp1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgHXIoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbgHXIoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129B222BEA;
        Mon, 24 Aug 2020 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258678;
        bh=leVTurjUD+8+YlGK6i8qakCakA8BGvB6rJ0efjYly1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/jw55ELGsEnuuK/kVItbUaMTE4BWPCRqPVCG1qHVJc/y26qp3NycTHd6QyA5Jg4b
         thx0ng0llowlaeU8YHQenDzcMynOEGYbQf1jXnY5zDyZoFgY302SgFALIWRPG1eLrq
         Bs9nm3yc+WSqMg5dLZRmBVWosfwHeYj65uHixcbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 105/124] RDMA/bnxt_re: Do not add user qps to flushlist
Date:   Mon, 24 Aug 2020 10:30:39 +0200
Message-Id: <20200824082414.574698115@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit a812f2d60a9fb7818f9c81f967180317b52545c0 ]

Driver shall add only the kernel qps to the flush list for clean up.
During async error events from the HW, driver is adding qps to this list
without checking if the qp is kernel qp or not.

Add a check to avoid user qp addition to the flush list.

Fixes: 942c9b6ca8de ("RDMA/bnxt_re: Avoid Hard lockup during error CQE processing")
Fixes: c50866e2853a ("bnxt_re: fix the regression due to changes in alloc_pbl")
Link: https://lore.kernel.org/r/1596689148-4023-1-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b12fbc857f942..5c41e13496a02 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -811,7 +811,8 @@ static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 	struct ib_event event;
 	unsigned int flags;
 
-	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR &&
+	    rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
 		bnxt_qplib_add_flush_qp(&qp->qplib_qp);
 		bnxt_re_unlock_cqs(qp, flags);
-- 
2.25.1



