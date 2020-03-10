Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692A224694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844933;
	bh=Rfaf0UuygPgpO1jfho2w1TZXl6bHsbmNn7hutTOKgwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yMSWmTVfGyZ5vvay893dYTyD1XOD79Nlh55B9u5TQnFI0Pu6383F8Q+7ZiXoAbERC
	 RVQdgyoIwdEU8B2IQl37MhN9LJQLf6jmGy8UVwhEU8dFceSlUsC+HLJmDFCZPkY50k
	 ADnTxPn78nNaIjFO1YCaGxR3/GvufsBxicEfIzPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgCJMzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbgCJMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:55:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954ED24696;
        Tue, 10 Mar 2020 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844928;
        bh=Rfaf0UuygPgpO1jfho2w1TZXl6bHsbmNn7hutTOKgwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVP2nCXlPqXh7EdzMGWOeyIRNNxwV50plEOlsQbAp3r1/tiLZceyWbPC9dVL6UWou
         u0sVENGjTzDBtZczd9iUaHNXFRyZqnHrVfqYu3wViR7PGTXUctRnQkj9YPhyCIyUP/
         pzKCOG3VOHZaxgeyAMhvfr11Fh0tFLjCfQvn4tK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 152/168] RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()
Date:   Tue, 10 Mar 2020 13:39:58 +0100
Message-Id: <20200310123650.898847851@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
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
@@ -1228,6 +1228,7 @@ struct ib_cm_id *ib_cm_insert_listen(str
 			/* Sharing an ib_cm_id with different handlers is not
 			 * supported */
 			spin_unlock_irqrestore(&cm.lock, flags);
+			ib_destroy_cm_id(cm_id);
 			return ERR_PTR(-EINVAL);
 		}
 		atomic_inc(&cm_id_priv->refcount);


