Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82386C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DE6206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201728;
	bh=EhoT0Yz+iDP1SaE+44UE/uipYQu7dx3tPUNeJ+edfWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qG96xLa9x77WhX3d9uQnFhryo3Z1oMU9s3BIONpAoyczsOFRcnKJB9tCTcn/nf+gU
	 317gEz8kzZ1xNrvfiNBkFhHexlxD5xDT85hUwt6Ds41Tbl8pfi4EbqVbtZfV3/Nv8u
	 W4jpvUhqMv2HmbTrg8fYV+BzqUmW/q+8RGuCAIl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436997AbgAPTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387928AbgAPRAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3911420730;
        Thu, 16 Jan 2020 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194052;
        bh=EhoT0Yz+iDP1SaE+44UE/uipYQu7dx3tPUNeJ+edfWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEOcfIrVRXhWu0ETgDR22z9BhEe59XyS/a2XSJ2M1TBvQITFDJvdgZfePFK4TX3i2
         bo5DTpsti7S0j5e1LQ5acSXWeph8kzdMu+LibBr3eaT2YfLX0Qe5HUEUj0V7vF6Oas
         6he61XMofMvP6nol42PJrKnyfbSXSSxMNnXhGVjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 167/671] iw_cxgb4: use tos when importing the endpoint
Date:   Thu, 16 Jan 2020 11:51:16 -0500
Message-Id: <20200116165940.10720-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Wise <swise@opengridcomputing.com>

[ Upstream commit cb3ba0bde881f0cb7e3945d2a266901e2bd18c92 ]

import_ep() is passed the correct tos, but doesn't use it correctly.

Fixes: ac8e4c69a021 ("cxgb4/iw_cxgb4: TOS support")
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 1b3d014fa1d6..3c8b7eae918c 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2076,7 +2076,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 	} else {
 		pdev = get_real_dev(n->dev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
-					n, pdev, 0);
+					n, pdev, rt_tos2priority(tos));
 		if (!ep->l2t)
 			goto out;
 		ep->mtu = dst_mtu(dst);
-- 
2.20.1

