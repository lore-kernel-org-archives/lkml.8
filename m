Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F77C2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944736;
	bh=LqXoPAKS6pHMH0wXYUQDjax07COwK/Y2Q/NCHGyioSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vWBwSb0Q1si6nERox+TW/IFNNAxY/E5ZM6t1z37sJKvCZcrgpS3LLLzw9Z9qr1WBf
	 kxgLpUGqIBXWV4Ee4Ui3upNO4LCk1gbc0K/4iM62IBipeQajJT4FSQ2FR+MF3n0LHC
	 CtEj2kKdERkBz9VD5B+2xWgdUtlLlQXs/TZ/H250=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392002AbgFWUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390619AbgFWUil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0AF217D9;
        Tue, 23 Jun 2020 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944721;
        bh=LqXoPAKS6pHMH0wXYUQDjax07COwK/Y2Q/NCHGyioSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVT2FVT7PAz6dEJ+BLP/pmC+aG65kVZ18SmdddLnxLLpGh71+iU2+qSQGsZyejf8+
         Ys5e2tJDu0Uj+WkAsn5UOTc/tIGLQO7XKMsQ6pXhJaeqnZvm9ie95W8fPksp+NO2Oy
         oy+0kFI+W5Ee2azMyLiNTBqSxBcBImPj4XE3IEUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/206] PCI: v3-semi: Fix a memory leak in v3_pci_probe() error handling paths
Date:   Tue, 23 Jun 2020 21:56:37 +0200
Message-Id: <20200623195320.356521394@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bca718988b9008d0d5f504e2d318178fc84958c1 ]

If we fails somewhere in 'v3_pci_probe()', we need to free 'host'.

Use the managed version of 'pci_alloc_host_bridge()' to do that easily.
The use of managed resources is already widely used in this driver.

Link: https://lore.kernel.org/r/20200418081637.1585-1-christophe.jaillet@wanadoo.fr
Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d219404bad92b..9a86bb7448acf 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -743,7 +743,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	int ret;
 	LIST_HEAD(res);
 
-	host = pci_alloc_host_bridge(sizeof(*v3));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*v3));
 	if (!host)
 		return -ENOMEM;
 
-- 
2.25.1



