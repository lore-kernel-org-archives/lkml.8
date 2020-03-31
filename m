Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F5C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B664F208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646039;
	bh=CDK92CjtltPfetDZtqbXhiCGOui1J5dMDllimrK+Xuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2RPd8yynG6ZEMi7bJR3g4pizNmr/0Q3G59AMvGeDcC69lnHqNF+lEZ2W7BisTz8dQ
	 dCrjIlfylrP/gGoHBWZg43Kf4UXu35jVs02RGDg9it3UVxo/j64aHyelRFuN/pYwvu
	 3stkHx4pJItgijOnb0iImWuSqN/TL+xRCLKkE0n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgCaJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:13:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2ED12072E;
        Tue, 31 Mar 2020 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646036;
        bh=CDK92CjtltPfetDZtqbXhiCGOui1J5dMDllimrK+Xuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vd6eAGTGIuozNdjQqmfgeXI/gVZFIEM4111pO9wr7oTXOvfV4I9iDjwH+ga3A5P8h
         6O9cKs8OG1a/dMWCNPHulLUzfgLQ3ydAX+orF6kIZYFBpwziYJAhmub7hvdj7C9qjE
         d/h7BfKZy1KRrxcJUm8TgzT1mqjmBIaZA++i7fvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 025/155] net: phy: mdio-mux-bcm-iproc: check clk_prepare_enable() return value
Date:   Tue, 31 Mar 2020 10:57:45 +0200
Message-Id: <20200331085421.203011207@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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


