Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9A8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681124649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846846;
	bh=+hi5aN+D6JGLzjvA6/P2ENZRj0ICH3a32s1Tw3e6BL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=btTU21PvAkwu3J/o2h8zqQNtWJSG8XeuS2RjBPfU6fkCqTDs/rMe0xGq1ZZ1p/tTt
	 noiCymyrDQ3QgDggjECtx6lw4pqDnqTgsnQPFBKiH9tqEdjc2w2SaQXFy09GhkOop8
	 AHSGDop5K2HykvrZ58ImEtsw829DqFNaok8vKPIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgCJN1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgCJMyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04CC2253D;
        Tue, 10 Mar 2020 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844890;
        bh=+hi5aN+D6JGLzjvA6/P2ENZRj0ICH3a32s1Tw3e6BL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJ4qh8O4j679l4zU76/Q8I9PxlKeoauAawMhkv4BNKnM0Wi1D/57aVO7GlmkHzfMS
         /0RSoWp4QI0U9xKXkx//oEOADzj8ubLR2rYaraq98lBpLCfAXLvPD5G+/shG/Pao5Q
         eNiLPsw+6mS+3GDoP7pUH8o4mNFA51sVyQrBp7Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 149/168] RDMA/iwcm: Fix iwcm work deallocation
Date:   Tue, 10 Mar 2020 13:39:55 +0100
Message-Id: <20200310123650.587995345@linuxfoundation.org>
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

From: Bernard Metzler <bmt@zurich.ibm.com>

commit 810dbc69087b08fd53e1cdd6c709f385bc2921ad upstream.

The dealloc_work_entries() function must update the work_free_list pointer
while freeing its entries, since potentially called again on same list. A
second iteration of the work list caused system crash. This happens, if
work allocation fails during cma_iw_listen() and free_cm_id() tries to
free the list again during cleanup.

Fixes: 922a8e9fb2e0 ("RDMA: iWARP Connection Manager.")
Link: https://lore.kernel.org/r/20200302181614.17042-1-bmt@zurich.ibm.com
Reported-by: syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/iwcm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -159,8 +159,10 @@ static void dealloc_work_entries(struct
 {
 	struct list_head *e, *tmp;
 
-	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list)
+	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list) {
+		list_del(e);
 		kfree(list_entry(e, struct iwcm_work, free_list));
+	}
 }
 
 static int alloc_work_entries(struct iwcm_id_private *cm_id_priv, int count)


