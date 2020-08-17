Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445B420578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690588;
	bh=hTnNbtEfCMrvTSqapYGUoZuh/b5VfCS0ngh4R6Hsq2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nZRX0SOcEo3qE7EQ1oPzIwJPY5nGiAk5Jz5pkhA2lDJ3xmxxWpSEJlEZdb6CxztD0
	 39gpqbpZY3Ly2FhwyfMVfqf3tPu/eDeJB5CdTO21leLLAbeSKIDFGQeTIXX13gJFtf
	 P3XsfhplbQkF2WjgCv1EvmWHbnAboamwXpGzrPgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgHQS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgHQPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:50:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC20620885;
        Mon, 17 Aug 2020 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679425;
        bh=hTnNbtEfCMrvTSqapYGUoZuh/b5VfCS0ngh4R6Hsq2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuUVOyvOfyZZPTtALa5uTgPs27vXg47tFVBTwXyPvXu/jDFkrJnw011bzJwPTkcSk
         iP3mrg/kOxKbdtuJEgllgxIYfXiAmGJxaEtejR6qGzd9hY907Q6zW0q6uxcgldd0p9
         /3gpvjTC5FBHQOqvjo2D7PbmyW6BnjhqeI36YgXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Malygin <m.malygin@yadro.com>,
        Sergey Kojushev <s.kojushev@yadro.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 206/393] RDMA/rxe: Prevent access to wr->next ptr afrer wr is posted to send queue
Date:   Mon, 17 Aug 2020 17:14:16 +0200
Message-Id: <20200817143829.614648068@linuxfoundation.org>
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
index 9dd4bd7aea92e..2aaa0b592a2d8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -683,6 +683,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 	unsigned int mask;
 	unsigned int length = 0;
 	int i;
+	struct ib_send_wr *next;
 
 	while (wr) {
 		mask = wr_opcode_mask(wr->opcode, qp);
@@ -699,6 +700,8 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			break;
 		}
 
+		next = wr->next;
+
 		length = 0;
 		for (i = 0; i < wr->num_sge; i++)
 			length += wr->sg_list[i].length;
@@ -709,7 +712,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 			*bad_wr = wr;
 			break;
 		}
-		wr = wr->next;
+		wr = next;
 	}
 
 	rxe_run_task(&qp->req.task, 1);
-- 
2.25.1



