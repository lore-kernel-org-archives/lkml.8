Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23504C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891B24695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845410;
	bh=CiNs7x12jeNg7k3CSqr4Z8cmvULNQgLBwO9qaZVo5KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hs1ePvAEBsEwnDynkrFdCaFeu4D6dC7+7J4ur3gH7zvncycleEUCeCFaioAl6TU+I
	 Mb78rPq2+9yVKPOHjf9HD/jHVltkwaxuzN5dDwoci5Ph3O+bUzTgdozeQvi8OHvcJh
	 qz1jE40/pfHXMQcls6IiebDkBuVJcHoaWOoPmz1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgCJND2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgCJNDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC8124694;
        Tue, 10 Mar 2020 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845400;
        bh=CiNs7x12jeNg7k3CSqr4Z8cmvULNQgLBwO9qaZVo5KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7m1DZa2VNlPDBhAmvxDelZNX6jOOw5BPUacLrhB4hds1gyxb7SzaCqmM7JC4T7sB
         Mb4PdxozNx5r3MJXtsgfdmHqYb6n9A4QFhj8U3tVJ3UxjLodx787NAESvKo1jptIGb
         wEiOV+seiIPNZ5Moeo2cxzh3OTeSMJMRpn+/HGXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 170/189] IB/hfi1, qib: Ensure RCU is locked when accessing list
Date:   Tue, 10 Mar 2020 13:40:07 +0100
Message-Id: <20200310123657.080773613@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Dalessandro <dennis.dalessandro@intel.com>

commit 817a68a6584aa08e323c64283fec5ded7be84759 upstream.

The packet handling function, specifically the iteration of the qp list
for mad packet processing misses locking RCU before running through the
list. Not only is this incorrect, but the list_for_each_entry_rcu() call
can not be called with a conditional check for lock dependency. Remedy
this by invoking the rcu lock and unlock around the critical section.

This brings MAD packet processing in line with what is done for non-MAD
packets.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Link: https://lore.kernel.org/r/20200225195445.140896.41873.stgit@awfm-01.aw.intel.com
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
 drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -515,10 +515,11 @@ static inline void hfi1_handle_packet(st
 				       opa_get_lid(packet->dlid, 9B));
 		if (!mcast)
 			goto drop;
+		rcu_read_lock();
 		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
 			packet->qp = p->qp;
 			if (hfi1_do_pkey_check(packet))
-				goto drop;
+				goto unlock_drop;
 			spin_lock_irqsave(&packet->qp->r_lock, flags);
 			packet_handler = qp_ok(packet);
 			if (likely(packet_handler))
@@ -527,6 +528,7 @@ static inline void hfi1_handle_packet(st
 				ibp->rvp.n_pkt_drops++;
 			spin_unlock_irqrestore(&packet->qp->r_lock, flags);
 		}
+		rcu_read_unlock();
 		/*
 		 * Notify rvt_multicast_detach() if it is waiting for us
 		 * to finish.
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -329,8 +329,10 @@ void qib_ib_rcv(struct qib_ctxtdata *rcd
 		if (mcast == NULL)
 			goto drop;
 		this_cpu_inc(ibp->pmastats->n_multicast_rcv);
+		rcu_read_lock();
 		list_for_each_entry_rcu(p, &mcast->qp_list, list)
 			qib_qp_rcv(rcd, hdr, 1, data, tlen, p->qp);
+		rcu_read_unlock();
 		/*
 		 * Notify rvt_multicast_detach() if it is waiting for us
 		 * to finish.


