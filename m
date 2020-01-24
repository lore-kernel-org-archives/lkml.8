Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76389C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDA220718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865318;
	bh=tI8kzxHMvf6+J4m912VloVg5T/1uTatzsQrLbDVcFTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVMAckM3RDrgvOFaADUCmGkNwMsBjIvlU6K7p8njG9pDJzjv+JjUxFpxUHh1dg2PQ
	 qUhgSHUGymIhFbRzDHeGE83I7FH71EERUsZdWe0ThV4DSqQiRjZXvb4IlJLTX2DIom
	 qaG2erwGXJ4CmDVsPXJwJCNLq44KfAJn6wXVlaSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbgAXL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391595AbgAXL2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:28:34 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4AE20704;
        Fri, 24 Jan 2020 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865313;
        bh=tI8kzxHMvf6+J4m912VloVg5T/1uTatzsQrLbDVcFTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZ++jvD+6h2LiG67KSUgoYZpEaJu6xTFAbhWWgwbkXLih84IuPAL7mIKsRWtoXmsu
         cyZ3WqBDraRGpA/t4/EQDwsz4g64viAhAN6lTadf1zVNQd2n9/xgKjZJSj2FIhAoI1
         fVqf16a8lEe/OsalhEd8UwB8e90hXeznY35eQyIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 499/639] cxgb4: smt: Add lock for atomic_dec_and_test
Date:   Fri, 24 Jan 2020 10:31:09 +0100
Message-Id: <20200124093151.278803235@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 4a8937b83892cb69524291cae6cdabad4a8be033 ]

The atomic_dec_and_test() is not safe because it is
outside of locks.
Move the locks of t4_smte_free() to its caller,
cxgb4_smt_release() to protect the atomic decrement.

Fixes: 3bdb376e6944 ("cxgb4: introduce SMT ops to prepare for SMAC rewrite support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/smt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.c b/drivers/net/ethernet/chelsio/cxgb4/smt.c
index 7b2207a2a130f..9b3f4205cb4d4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/smt.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/smt.c
@@ -98,11 +98,9 @@ found_reuse:
 
 static void t4_smte_free(struct smt_entry *e)
 {
-	spin_lock_bh(&e->lock);
 	if (atomic_read(&e->refcnt) == 0) {  /* hasn't been recycled */
 		e->state = SMT_STATE_UNUSED;
 	}
-	spin_unlock_bh(&e->lock);
 }
 
 /**
@@ -112,8 +110,10 @@ static void t4_smte_free(struct smt_entry *e)
  */
 void cxgb4_smt_release(struct smt_entry *e)
 {
+	spin_lock_bh(&e->lock);
 	if (atomic_dec_and_test(&e->refcnt))
 		t4_smte_free(e);
+	spin_unlock_bh(&e->lock);
 }
 EXPORT_SYMBOL(cxgb4_smt_release);
 
-- 
2.20.1



