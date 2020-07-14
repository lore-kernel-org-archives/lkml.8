Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5898C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5B722B45
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752650;
	bh=WJSu7jjjoQkirFpIXvqr4UHY09mUZiBEYqt0DClml1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y5aSkHRtN50PQBrYbDhLj967KDXSQrQ+OgdU3QViUIgCUDLy5IJxUj7ZgGNHWzIUc
	 zmKoTsSwoTsoZmwaDr9yQQw96dyGETk/fKrYXC4sJCuaxKGvTl5XCDFbE+b6VABQCl
	 3+TR0p5BUMdphwCT0m4DoAh/zDoaCH1/08o7AoXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgGNSup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgGNSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:50:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF5C22B2A;
        Tue, 14 Jul 2020 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752641;
        bh=WJSu7jjjoQkirFpIXvqr4UHY09mUZiBEYqt0DClml1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyqkz618pKNoMivQ5Nw9wSiudcQ8VGpXqe18OWL1+GRXl+MzGYtfkBWe059GmBX7N
         8Hx2GjeYVG9z9mZZUiFeC+Ctt6HTW7Xwk7IDP3VYC/Lu8B5BOwgm626QIQent1uxVS
         HL4f1640dtmBWWKf5mljZk7NqvPolTMaYoittsxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/109] RDMA/siw: Fix reporting vendor_part_id
Date:   Tue, 14 Jul 2020 20:43:59 +0200
Message-Id: <20200714184108.200034373@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamal Heib <kamalheib1@gmail.com>

[ Upstream commit 04340645f69ab7abb6f9052688a60f0213b3f79c ]

Move the initialization of the vendor_part_id to be before calling
ib_register_device(), this is needed because the query_device() callback
is called from the context of ib_register_device() before initializing the
vendor_part_id, so the reported value is wrong.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Link: https://lore.kernel.org/r/20200707130931.444724-1-kamalheib1@gmail.com
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 130b1e31b9780..fb66d67572787 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -66,12 +66,13 @@ static int siw_device_register(struct siw_device *sdev, const char *name)
 	static int dev_id = 1;
 	int rv;
 
+	sdev->vendor_part_id = dev_id++;
+
 	rv = ib_register_device(base_dev, name);
 	if (rv) {
 		pr_warn("siw: device registration error %d\n", rv);
 		return rv;
 	}
-	sdev->vendor_part_id = dev_id++;
 
 	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
 
-- 
2.25.1



