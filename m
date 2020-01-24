Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E099C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A8B20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863989;
	bh=+usNTdRjwYvntG+3pkqYcKVDxPiWH6pWpC3z81O3kAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hzBOA7QznVJPlz8bAHlIrbnOyLxVhWACj3yRffFAcDIfYOB8jg2YysPRsmNitApui
	 o0b9M3y3vyptWGtPq5Jj/H+CxQPiIDxOMy659ipunwKQiXdjdnKNtPwIAtCzVFzgUJ
	 osGX8GJBmSnIOzKVEcK6xsQkugM1v96j1nK5sPMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgAXLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgAXLGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:06:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C4E2071A;
        Fri, 24 Jan 2020 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863985;
        bh=+usNTdRjwYvntG+3pkqYcKVDxPiWH6pWpC3z81O3kAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGmEckPjbNqdi7H/l1AqPzNeBbHQrZdQds2N+TznHhr9Nn755E0O74+Se4dmDPKrB
         WRhqDOQEx0CqGZ+7xmbsZFoBLe84htIt4uLBVQH52yYyHsTAjQgt/u8/OO+KSqOMm/
         2WrP+0ObQhLmM/Abr3nBER2oIudYrLPaOfDo/qbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 125/639] RDMA/ocrdma: Fix out of bounds index check in query pkey
Date:   Fri, 24 Jan 2020 10:24:55 +0100
Message-Id: <20200124093102.963229325@linuxfoundation.org>
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

[ Upstream commit b188940796c7be31c1b8c25a9a0e0842c2e7a49e ]

The pkey table size is one element, index should be tested for > 0 instead
of > 1.

Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Signed-off-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c158ca9fde6dc..08271fce0b9e4 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -55,7 +55,7 @@
 
 int ocrdma_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 *pkey)
 {
-	if (index > 1)
+	if (index > 0)
 		return -EINVAL;
 
 	*pkey = 0xffff;
-- 
2.20.1



