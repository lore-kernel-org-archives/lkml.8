Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF582C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AA220663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615960;
	bh=p2lFW4EGbbv2BXqjl+0zAIJRmb6LhRC1mQBNqnySme8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2decAHa1pACdoQTxuSQyduHPAVQSMY+2ulRTB4bT6tThad9hQECAQwMKQ4GwpmArR
	 0TZHoWgGLwTJ6NTFFCi8Ev8osLGvSSJOPHFbFGmXdcSPzWBcdwMSh/T9DGo1JxOe98
	 dHEH9JqClMS2cdzxX+NqgWP38XYqmy6v5HMQPPs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgEDSMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbgEDSCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:02:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B042073E;
        Mon,  4 May 2020 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615350;
        bh=p2lFW4EGbbv2BXqjl+0zAIJRmb6LhRC1mQBNqnySme8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSfU3DU7UjLo0og3FYFxcHVbK3iJ57zarWUdNdORXo4KbJh3RfbUYfFeD1LlBVF+p
         TzeFkBG3kUtILzB3iUzbuecWG6zTLtnfJNTzF4oJ8qNaXpdPAUAfPNjwl1ifWWRKKU
         PNGhd2gnz7bna8hUr3e08eVM3O9Jyh4usQcRvwKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 4.19 20/37] RDMA/core: Fix race between destroy and release FD object
Date:   Mon,  4 May 2020 19:57:33 +0200
Message-Id: <20200504165450.549963642@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165448.264746645@linuxfoundation.org>
References: <20200504165448.264746645@linuxfoundation.org>
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
@@ -697,7 +697,6 @@ void rdma_lookup_put_uobject(struct ib_u
 			     enum rdma_lookup_mode mode)
 {
 	assert_uverbs_usecnt(uobj, mode);
-	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/*
 	 * In order to unlock an object, either decrease its usecnt for
 	 * read access or zero it in case of exclusive access. See
@@ -714,6 +713,7 @@ void rdma_lookup_put_uobject(struct ib_u
 		break;
 	}
 
+	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }


