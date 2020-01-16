Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C26C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1511120684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217538;
	bh=WRjlCgNu/uE4O1KWlacDgI1xqWnzUJ01Fk6dmsIz/io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygdcASQNZOBiRg3BLR6p0NB+/ST+XujjTeuLCzcAoBAA3YLywpcKNWRl+yl6BVEFE
	 Nl169ZkeXY1LizG1hJiPhE3gvDCpDfmp/iLev/6cmW1uwoWV9E1JpVpxd+Vp0mqtcN
	 cjE4SMQ3aX+EtBJykj4DFgDj6A12bSRIsNR6x17I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbgAPXcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404031AbgAPXcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EE1206D9;
        Thu, 16 Jan 2020 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217534;
        bh=WRjlCgNu/uE4O1KWlacDgI1xqWnzUJ01Fk6dmsIz/io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUkcX+BtgEGd2/mH+9u6HS/8BTnrM+AlExGiWG2uV5u4P9BvM3ERQ/YU3534cJSw2
         thUuDaFtEym2wRNPoF/J1+en1ZmOif1JpBfp5X13n2f8bIZE1OCJ0uJCwV/TKwvcVh
         Tefzzxq20djyL8p0VuBxbNOLmUEvUYWHbsv0akTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 38/71] NFSv4.x: Drop the slot if nfs4_delegreturn_prepare waits for layoutreturn
Date:   Fri, 17 Jan 2020 00:18:36 +0100
Message-Id: <20200116231715.107343302@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 5326de9e94bedcf7366e7e7625d4deb8c1f1ca8a upstream.

If nfs4_delegreturn_prepare needs to wait for a layoutreturn to complete
then make sure we drop the sequence slot if we hold it.

Fixes: 1c5bd76d17cc ("pNFS: Enable layoutreturn operation for return-on-close")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5797,8 +5797,10 @@ static void nfs4_delegreturn_prepare(str
 
 	d_data = (struct nfs4_delegreturndata *)data;
 
-	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task))
+	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task)) {
+		nfs4_sequence_done(task, &d_data->res.seq_res);
 		return;
+	}
 
 	nfs4_setup_sequence(d_data->res.server->nfs_client,
 			&d_data->args.seq_args,


