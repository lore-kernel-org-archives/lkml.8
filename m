Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E9A20825
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678946;
	bh=7eBUO9yRTxRtWqOM8/7Dm8BPgRXn/w2CD3hOKUBtd/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkQbUXlD6761egzrhWvFCmMkT307rd+uN9vGjrAKoGfgmjl+iU1ydeRPRiZviooht
	 SzTbbk1N36p9UtmwjF2YyCeMlvaSdrQqD2vI+VfVhGKiVaCuFHzGBLQozuEuwppVVP
	 czgT7smdzUE+nLGnImcme+6B3/CB+VZob1elBaPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgHQPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgHQPfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:35:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6982173E;
        Mon, 17 Aug 2020 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678533;
        bh=7eBUO9yRTxRtWqOM8/7Dm8BPgRXn/w2CD3hOKUBtd/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pXh1iMhj2CjTEWi54eLGNZnZLPe1uihW2sionIPJh6blgQ09TWEZN245vIEkX+cY
         nf/ZqwIFV/KmAWMV4BbCsWjRCiEjTBIIq4KB4Ebka07K1jMFXYoqHnukdMnWrT/b/S
         JWkqV2/3yJQ7FacujB/AO1o5kJ38z+fwHjiLxLAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 368/464] dpaa2-eth: Fix passing zero to PTR_ERR warning
Date:   Mon, 17 Aug 2020 17:15:21 +0200
Message-Id: <20200817143851.400030695@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 02afa9c66bb954c6959877c70d9e128dcf0adce7 ]

Fix smatch warning:

drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:2419
 alloc_channel() warn: passing zero to 'ERR_PTR'

setup_dpcon() should return ERR_PTR(err) instead of zero in error
handling case.

Fixes: d7f5a9d89a55 ("dpaa2-eth: defer probe on object allocate")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 89c43401f2889..a4b2b18009c1d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2207,7 +2207,7 @@ static struct fsl_mc_device *setup_dpcon(struct dpaa2_eth_priv *priv)
 free:
 	fsl_mc_object_free(dpcon);
 
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void free_dpcon(struct dpaa2_eth_priv *priv,
@@ -2231,8 +2231,8 @@ alloc_channel(struct dpaa2_eth_priv *priv)
 		return NULL;
 
 	channel->dpcon = setup_dpcon(priv);
-	if (IS_ERR_OR_NULL(channel->dpcon)) {
-		err = PTR_ERR_OR_ZERO(channel->dpcon);
+	if (IS_ERR(channel->dpcon)) {
+		err = PTR_ERR(channel->dpcon);
 		goto err_setup;
 	}
 
-- 
2.25.1



