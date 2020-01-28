Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3521739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221052;
	bh=fJFTj+/jb5gP5TA6pEl/juQ2cNZ8ASCeMfuC2X/Tyww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPQDqDXA6VmdC2wl6rivLxkpIsPn+mhU0C/nT1JW0mpjMg6GJOaoBP/Q0p5K6JF7D
	 QNoStiw1cDU+zabpmEHFM7ZpA5QF9syRsBMyVcqI2OYoTf7EpkB7U2hMhF7SiQS5r0
	 GgG9HR0CkKkIrRs+j5B0OUSaUtu8j4QEQjMk3QPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgA1ORb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgA1OR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:17:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C05AA2071E;
        Tue, 28 Jan 2020 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221047;
        bh=fJFTj+/jb5gP5TA6pEl/juQ2cNZ8ASCeMfuC2X/Tyww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cg03wl8GbrNW1/zPellsRdpXkL6fuenT1QdGuYfmkBKd2NS8PleLaTMJ55ovM/Uym
         CIWXWczEtTq9EjciV/0Ll923RJsfJLv++TOSXg86weXUqfNQzNa5+rJBRr7uuwZTuI
         f7L+ypKUM8ggi+CtdXNT482UNi0N2aMdhDfUtdFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 066/271] iw_cxgb4: use tos when importing the endpoint
Date:   Tue, 28 Jan 2020 15:03:35 +0100
Message-Id: <20200128135857.522311682@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 605d50ad123cc..a29fe11d688a5 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2044,7 +2044,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
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



