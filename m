Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2EC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA820842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738726;
	bh=KF6s90fhz/KsObcRNEnzvmzeZe4j2swFpwvf26/OvPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qCB+SKaMlVRYU8ejyib3mKdI5az1uDyQoOOcKPyz5W4cCZqvD55lArONSJZqYmqVo
	 foZDHXmQcwuTqzk6YgRar93CrNMdAub6eymrDjUivlvFgNizg7Iw6MxkQET0VQu1I1
	 JhiPCRWpYQwde9v/p9xSPtw20WSSgPJl/8CLdwhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgAKKcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbgAKKcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:32:02 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC29620842;
        Sat, 11 Jan 2020 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738721;
        bh=KF6s90fhz/KsObcRNEnzvmzeZe4j2swFpwvf26/OvPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1juBh8avk2lIfwi4fxcss/G7eq/zXjMh4DLp8wgUREXRlAjbITepDtCN8An/dy/zJ
         auKtun92Wu02q6ZIjSvoT6RnnqTUiJL88Qk2WAqX/vz3s7E1+L+ljdIdk5wDQT8oQ7
         O3PjVZteMnL81axNsPAepATZaLRZ/Of+53YyeHIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 141/165] net: freescale: fec: Fix ethtool -d runtime PM
Date:   Sat, 11 Jan 2020 10:51:00 +0100
Message-Id: <20200111094938.376646085@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit c72a0bc0aa19f49160330a65ab77184b5b7d131b ]

In order to dump the FECs registers the clocks have to be ticking,
otherwise a data abort occurs.  Add calls to runtime PM so they are
enabled and later disabled.

Fixes: e8fcfcd5684a ("net: fec: optimize the clock management to save power")
Reported-by: Chris Healy <Chris.Healy@zii.aero>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2199,8 +2199,14 @@ static void fec_enet_get_regs(struct net
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
+	struct device *dev = &fep->pdev->dev;
 	u32 *buf = (u32 *)regbuf;
 	u32 i, off;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return;
 
 	regs->version = fec_enet_register_version;
 
@@ -2216,6 +2222,9 @@ static void fec_enet_get_regs(struct net
 		off >>= 2;
 		buf[off] = readl(&theregs[off]);
 	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int fec_enet_get_ts_info(struct net_device *ndev,


