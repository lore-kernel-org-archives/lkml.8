Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C3DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC626208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645560;
	bh=bSQM1Dtvif4FaNcL9hMzSAR+D8lrIbIInjKk3q1hPjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7dbTnX664P1+0l3bxU6hoHPKf4TPh1l396cqqneOKG0oz6kSUKXQ0xQRSw/I/pLW
	 LoRWd4L1vbDVFiQ5gbef/hndj/+mtQg4EWPJtxZVtZzB63Wi2KbU1VJK8L60JJUMBB
	 vhiZjAnCLUhWrjLkxy4smEeDn4FfwGpp69bsDNjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgCaJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731075AbgCaJFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11E420675;
        Tue, 31 Mar 2020 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645552;
        bh=bSQM1Dtvif4FaNcL9hMzSAR+D8lrIbIInjKk3q1hPjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvPb5AEmD/DqgaiKAzeiA61knVoVDmZKStxmVzkY8JMA9K8Pmq28xyQBfgknqOYxk
         NuVgpdlTIVi5/xZ9pkak5LDOo87TnbCXsZwBhFQNxGSKpCj9QOSDeoEmyNwNNkrAI3
         ESMnt3YKlW37+Nmub1Lqa8T1/SfeiOQi6HOK9rWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 088/170] RDMA/odp: Fix leaking the tgid for implicit ODP
Date:   Tue, 31 Mar 2020 10:58:22 +0200
Message-Id: <20200331085433.639637797@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit 0f9826f4753f74f935e18c2a640484ecbd941346 upstream.

The tgid used to be part of ib_umem_free_notifier(), when it was reworked
it got moved to release, but it should have been unconditional as all umem
alloc paths get the tgid.

As is, creating an implicit ODP will leak the tgid reference.

Link: https://lore.kernel.org/r/20200304181607.GA22412@ziepe.ca
Cc: stable@kernel.org
Fixes: f25a546e6529 ("RDMA/odp: Use mmu_interval_notifier_insert()")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/umem_odp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -290,8 +290,8 @@ void ib_umem_odp_release(struct ib_umem_
 		mmu_interval_notifier_remove(&umem_odp->notifier);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->page_list);
-		put_pid(umem_odp->tgid);
 	}
+	put_pid(umem_odp->tgid);
 	kfree(umem_odp);
 }
 EXPORT_SYMBOL(ib_umem_odp_release);


