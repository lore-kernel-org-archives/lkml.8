Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43933C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1113D207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925617;
	bh=EhNYEBsIO18rKFOsMQuUzbghBHiFEH9epIhDr3PrwO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dwVvnunkLXM9ZJtDqZUwAqoVlwZC660QkZ/98hZ5eN6ixpIvbmKELpApWuzijXwst
	 K7MYMH3CjdavypDsVSnr/+paFPd17k2L0rpbDzvByKbVVURgMCObyjOEoeP66BXGVw
	 x39tmcA4WHNgH0jx291MdYPpwo78U9ZZv5yMj8to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHTMNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgHTJ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E36B72067C;
        Thu, 20 Aug 2020 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917443;
        bh=EhNYEBsIO18rKFOsMQuUzbghBHiFEH9epIhDr3PrwO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqrV7F2onDiofRtpoVF8W5vZy4Y5dvwkYtqF9aFlgHAlcI3LvrJvCk7atNjB+nL8U
         leSNJuNtuzOvrCpQXzRrsaQxx/nSklQGcXJE0x0DLMK8RMZyi2fnzqNUwsx1cgSP/H
         9yMv1YbsMCXOjPdFIZZK2qpc1309usmP1M4dheYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 004/212] net: phy: mdio-bcm-unimac: fix potential NULL dereference in unimac_mdio_probe()
Date:   Thu, 20 Aug 2020 11:19:37 +0200
Message-Id: <20200820091602.475043350@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index 8c73b2e771ddd..e6ff731d753d9 100644
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



