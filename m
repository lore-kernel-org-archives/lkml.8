Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166E62087E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615608;
	bh=w+yPL/bVXvDTiFWPzUWODEVmw/6jrMVQG1TYGt8QO3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqu80H5W1C8M29djmiGzTZTA88FeDFdLerhyr2+jh4wOh0zwYcp2groeXZP4qZigK
	 q8DiOv/0LXNCsr48vhiyGO06sT0S4zRItN5IypfhW9rIGQcyDKgGU4xwzm7oBCG3w9
	 cg+ZGBz4ygYyvvMmtqx/AUKHjr7kcD4nXmJvSXNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgEDSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732010AbgEDSGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20DB2087E;
        Mon,  4 May 2020 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615604;
        bh=w+yPL/bVXvDTiFWPzUWODEVmw/6jrMVQG1TYGt8QO3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sah/UtS8oGuKUF2WBmfxkf+XAVobMbiRMf3gNRU4fmcdBzY1373TJqQnJe5S1QFx6
         I92d0MAnVZTi7IPgfGUxKrUj0JDTqkEJKnXjtHotfWw0buoPdOVoCX7HbmTY7Ksayc
         HXVzdiOffgez5EW8TupfH3M8+hJ5WoPqGHYZVlGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 5.6 49/73] RDMA/core: Fix race between destroy and release FD object
Date:   Mon,  4 May 2020 19:57:52 +0200
Message-Id: <20200504165509.066749063@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

commit f0abc761bbb9418876cc4d1ebc473e4ea6352e42 upstream.

The call to ->lookup_put() was too early and it caused an unlock of the
read/write protection of the uobject after the FD was put. This allows a
race:

     CPU1                                 CPU2
 rdma_lookup_put_uobject()
   lookup_put_fd_uobject()
     fput()
				   fput()
				     uverbs_uobject_fd_release()
				       WARN_ON(uverbs_try_lock_object(uobj,
					       UVERBS_LOOKUP_WRITE));
   atomic_dec(usecnt)

Fix the code by changing the order, first unlock and call to
->lookup_put() after that.

Fixes: 3832125624b7 ("IB/core: Add support for idr types")
Link: https://lore.kernel.org/r/20200423060122.6182-1-leon@kernel.org
Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/rdma_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -678,7 +678,6 @@ void rdma_lookup_put_uobject(struct ib_u
 			     enum rdma_lookup_mode mode)
 {
 	assert_uverbs_usecnt(uobj, mode);
-	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/*
 	 * In order to unlock an object, either decrease its usecnt for
 	 * read access or zero it in case of exclusive access. See
@@ -695,6 +694,7 @@ void rdma_lookup_put_uobject(struct ib_u
 		break;
 	}
 
+	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }


