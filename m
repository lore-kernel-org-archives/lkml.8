Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD2820738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920051;
	bh=u6dXuoPiaENmRNqE8B4CVCL/ojOT6YVvOGiNB+YjyjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XehqfXYD9HDVI3GuObiXI9OXbkKAEbcMWus80nCsxQc2DDqBa5l02vEIF3vUcsCxW
	 CjtX+bywxLKRfYyV5gMtA6Hp5jUeDBnJXHRiAplUtsErjdWN1GrbOaMx/B3L9/h/oP
	 KdvmlUezg1/yAx4Lx626VDJaxfXgGd/M37VutT/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgHTKks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbgHTKRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:17:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0B7206DA;
        Thu, 20 Aug 2020 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918629;
        bh=u6dXuoPiaENmRNqE8B4CVCL/ojOT6YVvOGiNB+YjyjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+D1O7dJWMwZmXv9cKHWn7cVHxGbuAVOrdXV9b45KPbdBzSLWOXocC8fM8atT7D6F
         JgBnPdyLP4uqGiyAhN5ZGnRMGAna2YBrbVAWwms7AtfahuWD6btvYLUYfUtOkw81fe
         5lFKEAg7pJKs3h6rG2f3OO76quQVeaSYSeiRPY3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 002/149] net: phy: mdio-bcm-unimac: fix potential NULL dereference in unimac_mdio_probe()
Date:   Thu, 20 Aug 2020 11:21:19 +0200
Message-Id: <20200820092125.808314571@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 297a6961ffb8ff4dc66c9fbf53b924bd1dda05d5 ]

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mdio-bcm-unimac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index 4bde5e728fe0a..fd8692b477c96 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -177,6 +177,8 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -EINVAL;
 
 	/* Just ioremap, as this MDIO block is usually integrated into an
 	 * Ethernet MAC controller register range
-- 
2.25.1



