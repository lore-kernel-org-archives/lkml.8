Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14326C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6F320730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098583;
	bh=xpwDsCfS3zIF5dfKKclGV4PJdtCcREpav8/rEli1pbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smzYl78b/+FUmpB7GaugsUq3SCDPCQsievIB3DnyTBrA6k655T2rBYms8pJDXu+ez
	 uBHHq8x4krV1MjdjaaKRZzraaaGugU0n9eFFoH8haaU5I789LecpAzyRZn+sb0OtYi
	 oOHj0+TdnnN0uS6IL0NzN3qkIv5pNizSVwrO4Cks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgD1S3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgD1S32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B210E20BED;
        Tue, 28 Apr 2020 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098568;
        bh=xpwDsCfS3zIF5dfKKclGV4PJdtCcREpav8/rEli1pbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzjwOx6ENaAiVYc9v72TqI+bfWic41RF806QnpMF/82R2UoKL0x6RADAkcKmqhIjz
         PaJ90vXNQtKX4cFrVvYRUunx2tt0HpSNlpxR4kQo0dlNdTYg8x8IaMfDCUsfrx0tsp
         k9rwchKFZMDJTy55R7+5OUnp5je+NzVVUYIQFPTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 074/167] net: ethernet: ixp4xx: Add error handling in ixp4xx_eth_probe()
Date:   Tue, 28 Apr 2020 20:24:10 +0200
Message-Id: <20200428182234.302058926@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit 6ed79cec3ced6e346a10a70120fcee5f03591bab ]

The function ixp4xx_eth_probe() does not perform sufficient error
checking after executing devm_ioremap_resource(), which can result
in crashes if a critical error path is encountered.

Fixes: f458ac479777 ("ARM/net: ixp4xx: Pass ethernet physical base as resource")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1387,6 +1387,8 @@ static int ixp4xx_eth_probe(struct platf
 		return -ENODEV;
 	regs_phys = res->start;
 	port->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(port->regs))
+		return PTR_ERR(port->regs);
 
 	switch (port->id) {
 	case IXP4XX_ETH_NPEA:


