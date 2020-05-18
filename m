Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70773207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825096;
	bh=t3npKBEsuRcAzaeEdhUZ+UJDeNrUl67D2yV/RLVnfT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcrcH2oquN191DGn9ufKEanAdIlKbakiVQySCRd9rURKz9XXxhiwUJJmiwNe1yXTv
	 CfLf/KB3AUbw8Dd3Izlhk03HzGdgVzf2dPvyPHhAsnpeg/Mqb+sEVoWY7Bn0tWs54P
	 L/KNHTQMD7cVyEVOBusM7O2bVoxc5flXbUHJwJCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgERSEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732828AbgERSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:04:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D5120826;
        Mon, 18 May 2020 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825082;
        bh=t3npKBEsuRcAzaeEdhUZ+UJDeNrUl67D2yV/RLVnfT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6Re43xLf9O6vDUt0y4hcS0WkRzAKz8j3s1kc+RzBV9IYJCGr8j//8RQcnHFZztTC
         cusUG81ljnb+vflAhJ0ZkMT1kyWbWfdNQP1NtECUfP/vwicrtsWiGfsUHDlnpQ6e7e
         JSB5p62c5ZCatLEKOeoh9XTLzUHfAGoPg/sbkoT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 083/194] i40iw: Fix error handling in i40iw_manage_arp_cache()
Date:   Mon, 18 May 2020 19:36:13 +0200
Message-Id: <20200518173538.650112591@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 37e31d2d26a4124506c24e95434e9baf3405a23a ]

The i40iw_arp_table() function can return -EOVERFLOW if
i40iw_alloc_resource() fails so we can't just test for "== -1".

Fixes: 4e9042e647ff ("i40iw: add hw and utils files")
Link: https://lore.kernel.org/r/20200422092211.GA195357@mwanda
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/i40iw/i40iw_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_hw.c b/drivers/infiniband/hw/i40iw/i40iw_hw.c
index 55a1fbf0e670c..ae8b97c306657 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hw.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
@@ -534,7 +534,7 @@ void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
 	int arp_index;
 
 	arp_index = i40iw_arp_table(iwdev, ip_addr, ipv4, mac_addr, action);
-	if (arp_index == -1)
+	if (arp_index < 0)
 		return;
 	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
 	if (!cqp_request)
-- 
2.20.1



