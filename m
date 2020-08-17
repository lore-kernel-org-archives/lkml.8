Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E741C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4C82311A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678366;
	bh=qjqPb3dOM/LPD8Ih3PTP0yXu8B4/jodgik7nxXEZ9+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gip+erSLmEV5vExtw9i8V6PLtK2jBeP9VZQBrgP1cg1dDI5ktgXfLdmZY/uooL6WO
	 L7VYOLm7TNlIrrCrkuQuzU6deYdC3uZwgD/tcqdz02oXb3cn3n+q+N59FpWB4XW6+B
	 2Mt4BO/Kbf4PKnv4o2F1xTswlTCFpIxukn0lU6kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgHQPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgHQP3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:29:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE90523B16;
        Mon, 17 Aug 2020 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678159;
        bh=qjqPb3dOM/LPD8Ih3PTP0yXu8B4/jodgik7nxXEZ9+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSyG+bFczTP61wAC+2fJ1ugrR8lPtg+BoJ9uWuFqSpXxPuGpEgWDUg+iI28JbcJCD
         BFEDzAK1jHCw6QERiqOR/o5eIi5TpTRX5HoPgbBvH88Og7NvPBDOwTH2yZ7MaBqPIO
         5sewWbmCPET3LAU320XgbEk7/tOJioiWKbOQSeME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Malygin <m.malygin@yadro.com>,
        Sergey Kojushev <s.kojushev@yadro.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 238/464] RDMA/rxe: Prevent access to wr->next ptr afrer wr is posted to send queue
Date:   Mon, 17 Aug 2020 17:13:11 +0200
Message-Id: <20200817143845.200649254@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Malygin <m.malygin@yadro.com>

[ Upstream commit 5f0b2a6093a4d9aab093964c65083fe801ef1e58 ]

rxe_post_send_kernel() iterates over linked list of wr's, until the
wr->next ptr is NULL.  However if we've got an interrupt after last wr is
posted, control may be returned to the code after send completion callback
is executed and wr memory is freed.

As a result, wr->next pointer may contain incorrect value leading to
panic. Store the wr->next on the stack before posting it.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/20200716190340.23453-1-m.malygin@yadro.com
Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
Signed-off-by: Sergey Kojushev <s.kojushev@yadro.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b8a22af724e8b..84fec5fd798d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -684,6 +684,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 	unsigned int mask;
 	unsigned int length = 0;
 	int i;
+	struct ib_send_wr *next;
 
 	while (wr) {
 		mask = wr_opcode_mask(wr->opcode, qp);
@@ -700,6 +701,8 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			break;
 		}
 
+		next = wr->next;
+
 		length = 0;
 		for (i = 0; i < wr->num_sge; i++)
 			length += wr->sg_list[i].length;
@@ -710,7 +713,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			*bad_wr = wr;
 			break;
 		}
-		wr = wr->next;
+		wr = next;
 	}
 
 	rxe_run_task(&qp->req.task, 1);
-- 
2.25.1



