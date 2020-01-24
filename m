Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58087C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CD5206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864974;
	bh=psMnxsfn8st93Lmgk+dsmBJVMPRDym1N2y1BmnOAGfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NALcnIAY1rY5bXqDAfFbmNQKu+L4Tz0Qm2j3fDpyt5/pYvZdxRNeT82peq1rWZzeO
	 oLWECSCuQLrYuh/6W//5gCwA3gl1+3d2vvPGeAcrm+3tdfXlHkWRago2ARVam1lklM
	 7LwF4pPlqut7paG77EJDOSn4xd4TMJy91RFQzu/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbgAXLWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391011AbgAXLWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:22:42 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA86206D4;
        Fri, 24 Jan 2020 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864962;
        bh=psMnxsfn8st93Lmgk+dsmBJVMPRDym1N2y1BmnOAGfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlmYif0EDiO50gnulqWKXH+FsA9tASuPn/Q3StHKOK1bnTv4jLrWT23NCp17WZfG1
         N73/nowpFNVfteZu6q39joewuPRzSDh5H9buQe2MVUxiqttragTM2IAWcMbH2iwVXo
         /4t6JAGT4786R87UId6QhXMa0KwFGnwzcixhVcc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 401/639] net: hns3: fix a memory leak issue for hclge_map_unmap_ring_to_vf_vector
Date:   Fri, 24 Jan 2020 10:29:31 +0100
Message-Id: <20200124093137.178644422@linuxfoundation.org>
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

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 49f971bd308571fe466687227130a7082b662d0e ]

When hclge_bind_ring_with_vector() fails,
hclge_map_unmap_ring_to_vf_vector() returns the error
directly, so nobody will free the memory allocated by
hclge_get_ring_chain_from_mbx().

So hclge_free_vector_ring_chain() should be called no matter
hclge_bind_ring_with_vector() fails or not.

Fixes: 84e095d64ed9 ("net: hns3: Change PF to add ring-vect binding & resetQ to mailbox")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index e08e82020402a..997ca79ed892b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -181,12 +181,10 @@ static int hclge_map_unmap_ring_to_vf_vector(struct hclge_vport *vport, bool en,
 		return ret;
 
 	ret = hclge_bind_ring_with_vector(vport, vector_id, en, &ring_chain);
-	if (ret)
-		return ret;
 
 	hclge_free_vector_ring_chain(&ring_chain);
 
-	return 0;
+	return ret;
 }
 
 static int hclge_set_vf_promisc_mode(struct hclge_vport *vport,
-- 
2.20.1



