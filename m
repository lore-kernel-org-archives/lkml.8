Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175332078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924582;
	bh=oV2LcdZCk6ZdbIA9M+KfefM0sGnlL0ZZljwQtqnpk10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MxHz457K+xJiIFWXo2EVSgmR+WpYh7k8U6QWFTJ1aVKJorz9n6l5moT2Uv9psZM7
	 tzH23y9KcUBhgImgoM7CF7NsZOxjeS1pBPCOL+/syAxez33zAN8p91TUcQxKu6L1BR
	 1AWQ+TuVMiys/A4ee+DKkFVsoh/JaVP3HkHnAWXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgHTLzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbgHTKC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849CC22B40;
        Thu, 20 Aug 2020 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917748;
        bh=oV2LcdZCk6ZdbIA9M+KfefM0sGnlL0ZZljwQtqnpk10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uri7krArmMsScw+W5Y+0roUmB8O0ExduRVx0hgM1P4IMZi0vjpN4QQaUdvWPIDEU6
         Zf/+I5ngUOQnzaAW3N4SVhQBlK5K7QW4dhgHd1FnECoQtfyUHvbeQyIt+rH+PdhEVE
         UG9BUu9t2gPlg1BJEM/AyiabZfEFpbWbYi4UpIbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florinel Iordache <florinel.iordache@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 144/212] fsl/fman: fix dereference null return value
Date:   Thu, 20 Aug 2020 11:21:57 +0200
Message-Id: <20200820091609.618808033@linuxfoundation.org>
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

From: Florinel Iordache <florinel.iordache@nxp.com>

[ Upstream commit 0572054617f32670abab4b4e89a876954d54b704 ]

Check before using returned value to avoid dereferencing null pointer.

Fixes: 18a6c85fcc78 ("fsl/fman: Add FMan Port Support")
Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 9f3bb50a23651..4986f6ba278a3 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1623,6 +1623,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	struct fman_port *port;
 	struct fman *fman;
 	struct device_node *fm_node, *port_node;
+	struct platform_device *fm_pdev;
 	struct resource res;
 	struct resource *dev_res;
 	u32 val;
@@ -1647,8 +1648,14 @@ static int fman_port_probe(struct platform_device *of_dev)
 		goto return_err;
 	}
 
-	fman = dev_get_drvdata(&of_find_device_by_node(fm_node)->dev);
+	fm_pdev = of_find_device_by_node(fm_node);
 	of_node_put(fm_node);
+	if (!fm_pdev) {
+		err = -EINVAL;
+		goto return_err;
+	}
+
+	fman = dev_get_drvdata(&fm_pdev->dev);
 	if (!fman) {
 		err = -EINVAL;
 		goto return_err;
-- 
2.25.1



