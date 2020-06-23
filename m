Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063DB20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947246;
	bh=BW4hUOlgDi92v/7VDicIK2kFtHix7gDg68Er10dW5JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e70Mk+KfFbZ0OCc6LsIz1+DnzbwxckepALzUHP5WJN47BI3c8yyclWS8FNgUcLHPJ
	 Y7WNEX3PmNZVD9Iwzt8P7vs4L500aVIgj+BiA9kPXPdcqsRgC1J2vojQrdXnf3mQCM
	 S6262qtqYPRTq7PbFSmYUicG+i9T3Do9KCCubHuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbgFWVUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390279AbgFWUXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3745420723;
        Tue, 23 Jun 2020 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943799;
        bh=BW4hUOlgDi92v/7VDicIK2kFtHix7gDg68Er10dW5JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqXophpCnLrLEDckTNDnwoaVSiOGHlmPiiUoQbgpNIMCdm9fXNdvROXHhMyawxUXs
         nfHzGBJKFPTEM/Sg0sTcLEeyU3WvbJtk1ZtA7RerGu+2Mtag4/ZZq7D5TdAnMSHSg7
         D/wFBYCb9d7ywwCFRrUVy9p1z4UcF1FwUxPdSwRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 055/314] scsi: cxgb3i: Fix some leaks in init_act_open()
Date:   Tue, 23 Jun 2020 21:54:10 +0200
Message-Id: <20200623195341.438333798@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b6170a49c59c27a10efed26c5a2969403e69aaba ]

There wasn't any clean up done if cxgb3_alloc_atid() failed and also the
original code didn't release "csk->l2t".

Link: https://lore.kernel.org/r/20200521121221.GA247492@mwanda
Fixes: 6f7efaabefeb ("[SCSI] cxgb3i: change cxgb3i to use libcxgbi")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index 524cdbcd29aa4..ec7d01f6e2d58 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -959,6 +959,7 @@ static int init_act_open(struct cxgbi_sock *csk)
 	struct net_device *ndev = cdev->ports[csk->port_id];
 	struct cxgbi_hba *chba = cdev->hbas[csk->port_id];
 	struct sk_buff *skb = NULL;
+	int ret;
 
 	log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_SOCK,
 		"csk 0x%p,%u,0x%lx.\n", csk, csk->state, csk->flags);
@@ -979,16 +980,16 @@ static int init_act_open(struct cxgbi_sock *csk)
 	csk->atid = cxgb3_alloc_atid(t3dev, &t3_client, csk);
 	if (csk->atid < 0) {
 		pr_err("NO atid available.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_sock;
 	}
 	cxgbi_sock_set_flag(csk, CTPF_HAS_ATID);
 	cxgbi_sock_get(csk);
 
 	skb = alloc_wr(sizeof(struct cpl_act_open_req), 0, GFP_KERNEL);
 	if (!skb) {
-		cxgb3_free_atid(t3dev, csk->atid);
-		cxgbi_sock_put(csk);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_atid;
 	}
 	skb->sk = (struct sock *)csk;
 	set_arp_failure_handler(skb, act_open_arp_failure);
@@ -1010,6 +1011,15 @@ static int init_act_open(struct cxgbi_sock *csk)
 	cxgbi_sock_set_state(csk, CTP_ACTIVE_OPEN);
 	send_act_open_req(csk, skb, csk->l2t);
 	return 0;
+
+free_atid:
+	cxgb3_free_atid(t3dev, csk->atid);
+put_sock:
+	cxgbi_sock_put(csk);
+	l2t_release(t3dev, csk->l2t);
+	csk->l2t = NULL;
+
+	return ret;
 }
 
 cxgb3_cpl_handler_func cxgb3i_cpl_handlers[NUM_CPL_CMDS] = {
-- 
2.25.1



