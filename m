Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3381C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B982D24686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844199;
	bh=xVHPfJwgpy+80zOCWhcXFojkR2XjvT3blf7cFg0/OCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3CyTfO/gNj8WJNE3NDm53HJhmeEF4U578eBbLFef48WVQjIa9oEL8seS5UWQyJ+l
	 kiY4ILV91UMaS4iBGo7YRJk/2unYk5nSJT/20hH1YbN6GE8ZkNrWMv2Yrl+sM5hN+j
	 6G9ThJCSEm4rVqQdczb77HFqndErlC/tRvslUoME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCJMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbgCJMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7541C24695;
        Tue, 10 Mar 2020 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844193;
        bh=xVHPfJwgpy+80zOCWhcXFojkR2XjvT3blf7cFg0/OCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3JbL3tvElCQbi5loQhUGTFb2oiGBgOYrEXep0qqalU49bnm0uxb5ZcwF5wi39f+R
         XXJXT7w1B+RfYaKXB/0PtUTO18kVdvze90POLWD41AmF3664hKghBi2wIQWX/ALx2u
         /uWFqvRLKk924QmYkPPMx2iuX1ai3tx8k2UYl81U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 66/72] RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()
Date:   Tue, 10 Mar 2020 13:39:19 +0100
Message-Id: <20200310123617.989713862@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit c14dfddbd869bf0c2bafb7ef260c41d9cebbcfec upstream.

The algorithm pre-allocates a cm_id since allocation cannot be done while
holding the cm.lock spinlock, however it doesn't free it on one error
path, leading to a memory leak.

Fixes: 067b171b8679 ("IB/cm: Share listening CM IDs")
Link: https://lore.kernel.org/r/20200221152023.GA8680@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1073,6 +1073,7 @@ struct ib_cm_id *ib_cm_insert_listen(str
 			/* Sharing an ib_cm_id with different handlers is not
 			 * supported */
 			spin_unlock_irqrestore(&cm.lock, flags);
+			ib_destroy_cm_id(cm_id);
 			return ERR_PTR(-EINVAL);
 		}
 		atomic_inc(&cm_id_priv->refcount);


