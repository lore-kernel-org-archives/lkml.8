Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D811C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D73D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826260;
	bh=phbduZygKDjvLEczF+LMzOvnJFb1dJQEvGrvC6l95N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TtWXg+BA+GfGGRbqRh+nfmCZQzib6R0y/1l80Tym20JXDTQ/2oxfRRuQs4V7QYGyz
	 QnBpQCV3eAVRhJuVVMEniFSUCZQDzEUQtVyDwcCGYtxpx4zS1vMMU1iX/CBsCRpChT
	 qbo0AnCksp0sbOxlMB2DZbdGr76TNS8Ai1lhvHoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgERSYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgERRsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D0220671;
        Mon, 18 May 2020 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824087;
        bh=phbduZygKDjvLEczF+LMzOvnJFb1dJQEvGrvC6l95N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqCFAw2zj5oSzlho0mFOV4uwkJ6beJjdA+23EqV2lbRpbJDSdtnrlmM9YDlkIfz2/
         TUfX7f4sCdY+lksJD3kVYWdE5dXF4fcZpNIetnmMHAV6TEx3mFZrFTlSjMDvQeoLEQ
         rrWL9OpExZMDmRpHtESw3xxUr3udwMnaYk09+YWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/114] i40iw: Fix error handling in i40iw_manage_arp_cache()
Date:   Mon, 18 May 2020 19:36:38 +0200
Message-Id: <20200518173515.055877898@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
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
index 476867a3f584f..4ded9411fb325 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hw.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
@@ -483,7 +483,7 @@ void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
 	int arp_index;
 
 	arp_index = i40iw_arp_table(iwdev, ip_addr, ipv4, mac_addr, action);
-	if (arp_index == -1)
+	if (arp_index < 0)
 		return;
 	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
 	if (!cqp_request)
-- 
2.20.1



