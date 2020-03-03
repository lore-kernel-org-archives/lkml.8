Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DC42072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258497;
	bh=XAUzqqs/iFZqXjyiC3BTwxXkC+Ct1BC8ORsE7GURgB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QgflnBvPcQ7D34oB7qr8EIU+E6fwW/mwogyEEPI64qqoKPlqNOJeC7DMyhmEU0t9X
	 f/XA4OIOKJ+a5kofqqD6eCjtyTptncQV/tUUfCTvB0Ln0s7cCDmyaYwfKcHj7sp15c
	 PGL9UCyY1DxE7H4w1LLYKxqxvTWS4EYaxu8zdiqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbgCCSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387993AbgCCSBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:01:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F0220656;
        Tue,  3 Mar 2020 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258494;
        bh=XAUzqqs/iFZqXjyiC3BTwxXkC+Ct1BC8ORsE7GURgB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qH6xqAfXt2U+ESdD4kWkiIX5GjB6L957BWb2GXwtk0HFFLSl3SRqfAdgEHaIB+MWp
         7X3b2PAoCIYUCHtooujlUdWpi7pjpsG7z5DNdHOfVCQFd7UT8X9pcmE9oVT7APkYQB
         mNJBEac/pSibUBSH+kU/9aDwd0uGCL/s5XupZDBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 31/87] net: phy: restore mdio regs in the iproc mdio driver
Date:   Tue,  3 Mar 2020 18:43:22 +0100
Message-Id: <20200303174353.492704851@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

commit 6f08e98d62799e53c89dbf2c9a49d77e20ca648c upstream.

The mii management register in iproc mdio block
does not have a retention register so it is lost on suspend.
Save and restore value of register while resuming from suspend.

Fixes: bb1a619735b4 ("net: phy: Initialize mdio clock at probe function")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-bcm-iproc.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/net/phy/mdio-bcm-iproc.c
+++ b/drivers/net/phy/mdio-bcm-iproc.c
@@ -188,6 +188,23 @@ static int iproc_mdio_remove(struct plat
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int iproc_mdio_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iproc_mdio_priv *priv = platform_get_drvdata(pdev);
+
+	/* restore the mii clock configuration */
+	iproc_mdio_config_clk(priv->base);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iproc_mdio_pm_ops = {
+	.resume = iproc_mdio_resume
+};
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id iproc_mdio_of_match[] = {
 	{ .compatible = "brcm,iproc-mdio", },
 	{ /* sentinel */ },
@@ -198,6 +215,9 @@ static struct platform_driver iproc_mdio
 	.driver = {
 		.name = "iproc-mdio",
 		.of_match_table = iproc_mdio_of_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &iproc_mdio_pm_ops,
+#endif
 	},
 	.probe = iproc_mdio_probe,
 	.remove = iproc_mdio_remove,


