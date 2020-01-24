Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB99C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AD02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865567;
	bh=kYOTZMMPUzAsJV4PFZKe+9p7J/Cyp2HCN9vnXUCCBRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KeE7HcRMJ67rrofZiAKlOJ3TCdpStlXDb+euYCnf2O6/r+EyJ6HhHaXegvMAd/h8Q
	 boSkVrTLE/8Vg0mOGpTB/r27PN6ThnMoVA1INB73/17kXgf1QtiVAiZXqdwXWufye1
	 mzgMOMj0ERNBXtccM3KrsXnCO7SdWdcFJ6cAX8gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbgAXLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404467AbgAXLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:32:41 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A91FE20718;
        Fri, 24 Jan 2020 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865560;
        bh=kYOTZMMPUzAsJV4PFZKe+9p7J/Cyp2HCN9vnXUCCBRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXdkge8p/HwhH4HXYZ0HNPey6KInBsY3ftpzzUdImDN6G2C8RyWqIfD/2NxpGlpI4
         jKvTXhjJCXRSZeC6yEptikYpyVVrHTTJZPoTUG9S9oqkc5my9BeXUaiETQWzuAswwl
         O7CXAxLA5P58IppV8R1I8KB6n1y05u4h9XP4COkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 563/639] RDMA/cma: Fix false error message
Date:   Fri, 24 Jan 2020 10:32:13 +0100
Message-Id: <20200124093159.879798109@linuxfoundation.org>
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

From: Håkon Bugge <haakon.bugge@oracle.com>

[ Upstream commit a6e4d254c19b541a58caced322111084b27a7788 ]

In addr_handler(), assuming status == 0 and the device already has been
acquired (id_priv->cma_dev != NULL), we get the following incorrect
"error" message:

RDMA CM: ADDR_ERROR: failed to resolve IP. status 0

Fixes: 498683c6a7ee ("IB/cma: Add debug messages to error flows")
Link: https://lore.kernel.org/r/20190902092731.1055757-1-haakon.bugge@oracle.com
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 319bfef00a4a8..e16872e0724ff 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2889,7 +2889,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		if (status)
 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
 					     status);
-	} else {
+	} else if (status) {
 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
 	}
 
-- 
2.20.1



