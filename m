Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60256C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32766207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457529;
	bh=dZlD/PVgBp5+oIWi/7pKGG5g4zmRd2QlmRNwA0yf2Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ztF+cwmVusd8xdIq2hwy3M8OkEVWIaB7MOLD72PEZ2YBu0b/wWdpaZykALAVa8ve/
	 sRTm0L2RexHxEKVMeDrjiSQ90GqKbDyiXXOsSlcbVrBz8clUxBxGYxd9t2WwwKJLbK
	 HCGk/TKS7l+t7UefNRx8+apVcTsqLr6wfyNhV654=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHCMZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgHCMZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:25:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7624B204EC;
        Mon,  3 Aug 2020 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457519;
        bh=dZlD/PVgBp5+oIWi/7pKGG5g4zmRd2QlmRNwA0yf2Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPOw17gJh1/ipU/KhETPlzTJBsse3jJ3gjdNDysyhg5/TnO7G7d91lmApBvvjrziV
         nJ37KY01Swd5SSH7wf4rJW6WuqntR2mlMesbgakziAkY0etYZFZP41sXFT/nL2b9OD
         m+WYUtWv3K3TpBDKw31tA/FZaIJ5uUbItKbsoQX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 067/120] octeontx2-pf: cancel reset_task work
Date:   Mon,  3 Aug 2020 14:18:45 +0200
Message-Id: <20200803121906.069395060@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit c0376f473c5cc2ef94f8e1e055d173293cc3698c ]

During driver exit cancel the queued
reset_task work in VF driver.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index f4227517dc8e0..c1c263d1ac2ec 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -617,6 +617,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
 
 	vf = netdev_priv(netdev);
 
+	cancel_work_sync(&vf->reset_task);
 	otx2vf_disable_mbox_intr(vf);
 
 	otx2_detach_resources(&vf->mbox);
-- 
2.25.1



