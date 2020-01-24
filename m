Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4452071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864148;
	bh=+tH/XPHTQ24ltfvmKgNUIgkxxg1P3lqLg9hnLypw3ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRDqpxDKinobrfY7dXLk2O2G6lianFsY7d1Htdcqx+5vxygmebxtugVDcaV9xGaZ9
	 eBgw3xt765iyRHlD0Tjk1gbBc536l9V0C4gfFymNCOJffPLu2aeotjRd/zcNKVXUlf
	 bedSYDoUAXVEQXkpCYb0SjJqJUtdQDPgzPOTfMco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgAXLJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgAXLJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:09:04 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F9E214AF;
        Fri, 24 Jan 2020 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864144;
        bh=+tH/XPHTQ24ltfvmKgNUIgkxxg1P3lqLg9hnLypw3ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLzu7oUON2BB8FzZQP/BDWgIhmGtvi6RxsMwiberr/+jzS/U2PYXKplgLdl7UebLn
         q8Z+00nmsLrOAM2qVV3ILXymXA09OLoFVa/2galLRNcM27HNrHM5mp7Cq4skU0zEV+
         mSQFAbqS0aRouvhaXQtTdXHhHPL7Q/VTi1SMRbOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 184/639] iw_cxgb4: use tos when finding ipv6 routes
Date:   Fri, 24 Jan 2020 10:25:54 +0100
Message-Id: <20200124093110.195764116@linuxfoundation.org>
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

From: Steve Wise <swise@opengridcomputing.com>

[ Upstream commit c8a7eb554a83214c3d8ee5cb322da8c72810d2dc ]

When IPv6 support was added, the correct tos was not passed to
cxgb_find_route6(). This potentially results in the wrong route entry.

Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 3c8b7eae918c5..16145b0a14583 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2166,7 +2166,8 @@ static int c4iw_reconnect(struct c4iw_ep *ep)
 					   laddr6->sin6_addr.s6_addr,
 					   raddr6->sin6_addr.s6_addr,
 					   laddr6->sin6_port,
-					   raddr6->sin6_port, 0,
+					   raddr6->sin6_port,
+					   ep->com.cm_id->tos,
 					   raddr6->sin6_scope_id);
 		iptype = 6;
 		ra = (__u8 *)&raddr6->sin6_addr;
@@ -3326,7 +3327,7 @@ int c4iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 					   laddr6->sin6_addr.s6_addr,
 					   raddr6->sin6_addr.s6_addr,
 					   laddr6->sin6_port,
-					   raddr6->sin6_port, 0,
+					   raddr6->sin6_port, cm_id->tos,
 					   raddr6->sin6_scope_id);
 	}
 	if (!ep->dst) {
-- 
2.20.1



