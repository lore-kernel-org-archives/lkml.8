Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7159C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36632467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847372;
	bh=OMmxkevDUNxaHHi6hTgeEqTy7B/zjT98vwhasWl1utg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwr/fF3NiwrWOPWDCDKymk7ixfvtphc08TORNrS7YVSBijz9C+oOBIYig8o43xYGg
	 CyWo3E0SnMQm8aEPpHJ6xpoWBHdpZzqxf7rY0DSfxFreunzDITtjzIR6QkFvHq20KV
	 uMsQLw9TSVRXADD1vKV/a0CmHpQ1HzybUV9fdXZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCJMnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgCJMnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005B424691;
        Tue, 10 Mar 2020 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844191;
        bh=OMmxkevDUNxaHHi6hTgeEqTy7B/zjT98vwhasWl1utg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0w3e82rfEnuwP+c1Is1jEa/tTgynjyofzrglH+DthztRhV2rOcw/jfkXMgAUQMB5Q
         ZpysTWRCcBYwF1hdNYjE0/mWLkyhkx/XfkAEIlweCJgWyETkDyryFhRfSa3oR88XTA
         iQo0/k2f2JFV6U1hCvxPk7ufvyLgxp4FfwcxgKy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 65/72] RDMA/iwcm: Fix iwcm work deallocation
Date:   Tue, 10 Mar 2020 13:39:18 +0100
Message-Id: <20200310123617.779350871@linuxfoundation.org>
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
@@ -125,8 +125,10 @@ static void dealloc_work_entries(struct
 {
 	struct list_head *e, *tmp;
 
-	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list)
+	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list) {
+		list_del(e);
 		kfree(list_entry(e, struct iwcm_work, free_list));
+	}
 }
 
 static int alloc_work_entries(struct iwcm_id_private *cm_id_priv, int count)


