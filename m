Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC541C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999322075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863963;
	bh=pleHYfFuolpnnq+6nCW1//6E9yDhm2FdQf3zhWHjvc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1R/ALkUy3kJMfhIYxcJ1Z8YHeTR9SbIDG2TuVNtcMyCqMR3q3XEHqH/PmzzrtFoUv
	 bo2/A4ZY2Ev80Qh6eZWKdQpr8XLpoUJFF+8gng4lvh0BT3T8YyA/UEDoltoOzHxRuy
	 8tnlv+c62LNF+immkox9zbprBwp6KX/z9jnrimcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbgAXLGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732644AbgAXLGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:06:00 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E4120663;
        Fri, 24 Jan 2020 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863960;
        bh=pleHYfFuolpnnq+6nCW1//6E9yDhm2FdQf3zhWHjvc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJHWKjVyGXa+7etEqOUI4UCK+NBNZesprVUAJsdYu1qauZHLfMrakKUU+1lby+WfU
         K5PSzz4YXgBkWGvVimCVhBPjg2U/FvKto2GUqyEPBuIId9gDyq+afvp+OptldzvJi9
         Y0i9gol889VMqYYSPn8BAjHp/SwNTn9ChKGBE15Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <galpress@amazon.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/639] IB/usnic: Fix out of bounds index check in query pkey
Date:   Fri, 24 Jan 2020 10:24:54 +0100
Message-Id: <20200124093102.835711596@linuxfoundation.org>
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

From: Gal Pressman <galpress@amazon.com>

[ Upstream commit 4959d5da5737dd804255c75b8cea0a2929ce279a ]

The pkey table size is one element, index should be tested for > 0 instead
of > 1.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Gal Pressman <galpress@amazon.com>
Acked-by: Parvi Kaustubhi <pkaustub@cisco.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 3db232429630e..e611f133aa97b 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -447,7 +447,7 @@ struct net_device *usnic_get_netdev(struct ib_device *device, u8 port_num)
 int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
 				u16 *pkey)
 {
-	if (index > 1)
+	if (index > 0)
 		return -EINVAL;
 
 	*pkey = 0xffff;
-- 
2.20.1



