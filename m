Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A75C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E2120776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731174;
	bh=QyNy5j1CsOPfr/0z9kGW7RPnvW+TmRubAO7gJnwE054=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgJTE8levqZB7yFSQJf7x5wnhGFmaV1MbPZg452HWxJqIMGlYK3m/pRkAD2UQcnze
	 LHzptsQaYVdmZqoSVydgzxB2JQQsz1TolPHY1+KQfwsUuPhF+LmXCBHRbdsecoJHU8
	 2Xp3Tc125UkE6GT2W3o1C4LAG2NzLYd6JA+KsALc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXM0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgDXMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0FC2087E;
        Fri, 24 Apr 2020 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731099;
        bh=QyNy5j1CsOPfr/0z9kGW7RPnvW+TmRubAO7gJnwE054=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ns+9SCFDClEBGTtQ4RNbJnyXxlrnIezbxWphd33X1YhAKfXb0nBAmA6211NyxdXyR
         gWRw1U3s/qW64E6lBDqy0aVFnHUQ6Q/qiuVQCCUZcMGIYDXWkOFxjC8jLAXvTlCeh2
         O+DDaoyaGZqDRSzFybaLu2S2jSxqrLNBrvgRBWn0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/13] net/cxgb4: Check the return from t4_query_params properly
Date:   Fri, 24 Apr 2020 08:24:43 -0400
Message-Id: <20200424122447.10882-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122447.10882-1-sashal@kernel.org>
References: <20200424122447.10882-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit c799fca8baf18d1bbbbad6c3b736eefbde8bdb90 ]

Positive return values are also failures that don't set val,
although this probably can't happen. Fixes gcc 10 warning:

drivers/net/ethernet/chelsio/cxgb4/t4_hw.c: In function ‘t4_phy_fw_ver’:
drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:3747:14: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3747 |  *phy_fw_ver = val;

Fixes: 01b6961410b7 ("cxgb4: Add PHY firmware support for T420-BT cards")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index b4b435276a18d..62bc2af9cde70 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3400,7 +3400,7 @@ int t4_phy_fw_ver(struct adapter *adap, int *phy_fw_ver)
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_VERSION));
 	ret = t4_query_params(adap, adap->mbox, adap->pf, 0, 1,
 			      &param, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 	*phy_fw_ver = val;
 	return 0;
-- 
2.20.1

