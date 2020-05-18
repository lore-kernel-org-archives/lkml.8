Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71211207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824968;
	bh=qm2ebLQpPuB5UzhypP58ZpTegmhnDmthwg66hFvVqtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uI5o1lPjZicraoP6b1uhZitZVCFA1N5uKU+wu6iwNf4AZGn5cA5hc8y6w6U6zHlLu
	 r9l81MqDne7cRJxyzEagMK1QNTruDy/V7LxGdB4FrxpJy1r1CdeeZxTPsZsaHys/5Z
	 Enj/DCenv4Kj2ZGDSVCP912C6UuoqIfZg244Vcgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgERSCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbgERSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:02:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F012083E;
        Mon, 18 May 2020 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824963;
        bh=qm2ebLQpPuB5UzhypP58ZpTegmhnDmthwg66hFvVqtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01YVOSIbLwlSsdPU3RhCKEW70grVLvQTrKvAl8bhotoUdxcQcAGIdXVVdmHk1azRQ
         uzOn7JX/ob0pnJNIk4Mq81q2/qMGWX9JPke0hnpImyHH5XDUaCQdb9dLgwF6SW/KAo
         GCCjbRTytEhE8TtRMmneD4xPXdM18hspfLKOfAg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 073/194] IB/hfi1: Fix another case where pq is left on waitlist
Date:   Mon, 18 May 2020 19:36:03 +0200
Message-Id: <20200518173537.863949543@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit fa8dac3968635dec8518a13ac78d662f2aa88e4d ]

The commit noted below fixed a case where a pq is left on the sdma wait
list.

It however missed another case.

user_sdma_send_pkts() has two calls from hfi1_user_sdma_process_request().

If the first one fails as indicated by -EBUSY, the pq will be placed on
the waitlist as by design.

If the second call then succeeds, the pq is still on the waitlist setting
up a race with the interrupt handler if a subsequent request uses a
different SDMA engine

Fix by deleting the first call.

The use of pcount and the intent to send a short burst of packets followed
by the larger balance of packets was never correctly implemented, because
the two calls always send pcount packets no matter what.  A subsequent
patch will correct that issue.

Fixes: 9a293d1e21a6 ("IB/hfi1: Ensure pq is not left on waitlist")
Link: https://lore.kernel.org/r/20200504130917.175613.43231.stgit@awfm-01.aw.intel.com
Cc: <stable@vger.kernel.org>
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 13e4203497b33..a92346e88628b 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -589,10 +589,6 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 
 	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
 	pq->state = SDMA_PKT_Q_ACTIVE;
-	/* Send the first N packets in the request to buy us some time */
-	ret = user_sdma_send_pkts(req, pcount);
-	if (unlikely(ret < 0 && ret != -EBUSY))
-		goto free_req;
 
 	/*
 	 * This is a somewhat blocking send implementation.
-- 
2.20.1



