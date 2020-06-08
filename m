Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FF920775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659219;
	bh=P3J1uhq5KaE5PWts86ExAV3RvdYcRyFqVg7BLWLL3Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0ymFHEW3zuPLcjPJTz4JfEfACZ9XO/UgNcjReHS4Cvfo3DEzvxlmj6CzQVMukUSo
	 HJ35xI5lPnz6AOofF2nXLA+RqFmvsqF15nWxnZIctbmHdq4DVMKW+7AlBPswUzhpun
	 9xTfte+UtZ24RbxAWXxD99c8QvTM6UvpG7sOm7k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbgFHXdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgFHX1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9109E20814;
        Mon,  8 Jun 2020 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658837;
        bh=P3J1uhq5KaE5PWts86ExAV3RvdYcRyFqVg7BLWLL3Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzgqSheZdAVZJ/IhXNMxYgtGCzzP+9Ee7F/YdLxznIGkUuoN0/W9Enhc32TJrctoC
         fTS61AUgjgutK3Y/mQeIV8e4XsHWweNS8Xc9c8Hr1JvHcLm/1GyjbBlUaurfWNeaQy
         Izcieq05U/FTURdh2WLGCe0prbHT7AQbJzKQdNbA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 27/50] net: lpc-enet: fix error return code in lpc_mii_init()
Date:   Mon,  8 Jun 2020 19:26:17 -0400
Message-Id: <20200608232640.3370262-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 88ec7cb22ddde725ed4ce15991f0bd9dd817fd85 ]

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: b7370112f519 ("lpc32xx: Added ethernet driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/nxp/lpc_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 9fcaf1910633..9b98ec3dcb82 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -845,7 +845,8 @@ static int lpc_mii_init(struct netdata_local *pldat)
 	if (mdiobus_register(pldat->mii_bus))
 		goto err_out_unregister_bus;
 
-	if (lpc_mii_probe(pldat->ndev) != 0)
+	err = lpc_mii_probe(pldat->ndev);
+	if (err)
 		goto err_out_unregister_bus;
 
 	return 0;
-- 
2.25.1

