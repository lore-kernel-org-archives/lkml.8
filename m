Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C85C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98DE20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645512;
	bh=CDK92CjtltPfetDZtqbXhiCGOui1J5dMDllimrK+Xuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHJU+AzGQzD9ZrN17VGbYW1+bS+xcAXVKChj/Yub7Yqq19tWiUaUe/ZgRI+rEiC8i
	 6tY97ORMrLNI1X1RBlnA6dB1TdJ2nIGzCGe+j+lN0gqWZkaVwH+YW2DyIt6Gh+Aub+
	 mB1l7dqXfQA4eAARTcWMqqa0gz8EXNOeiZ8PcsBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgCaJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbgCaJFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:05:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53A921835;
        Tue, 31 Mar 2020 09:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645508;
        bh=CDK92CjtltPfetDZtqbXhiCGOui1J5dMDllimrK+Xuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbdTSjFk82mSI46YGwQ2ZZdbVuq8I0hesd9YBmC/EEO8c/YDEpQlOty/RO4fdzl3n
         UkxpqWj5oO6UR93ETZklGr0HZTqfb+lh092ykWObRZKPfNu2HAralK+GHRH1HhviKO
         Y3eK+5RtvaD54zA4Aq+tzXveu8k3QhWTvcaNqWGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 026/170] net: phy: mdio-mux-bcm-iproc: check clk_prepare_enable() return value
Date:   Tue, 31 Mar 2020 10:57:20 +0200
Message-Id: <20200331085426.866429083@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

[ Upstream commit 872307abbd0d9afd72171929806c2fa33dc34179 ]

Check clk_prepare_enable() return value.

Fixes: 2c7230446bc9 ("net: phy: Add pm support to Broadcom iProc mdio mux driver")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -288,8 +288,13 @@ static int mdio_mux_iproc_suspend(struct
 static int mdio_mux_iproc_resume(struct device *dev)
 {
 	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+	int rc;
 
-	clk_prepare_enable(md->core_clk);
+	rc = clk_prepare_enable(md->core_clk);
+	if (rc) {
+		dev_err(md->dev, "failed to enable core clk\n");
+		return rc;
+	}
 	mdio_mux_iproc_config(md);
 
 	return 0;


