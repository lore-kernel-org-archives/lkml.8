Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C3DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA8E24692
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220575;
	bh=cdS438oyPWqFatWtdHTGGlYeR61YSDdTm3C57FtzmrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NL+8sT3EOs7GPkj1U8nrJVxQgGRK8amli8Bi90PsAms3R5SYD5hgSpHjzZhqN6qNK
	 LQ/6yRq/0kbijYq8pM1BPmB27wVLJmvEDZTJwkjiDiiDamSG8MZNYNaWaXDyNbMzKB
	 HYkEgO+5nP7bAfl7aR8c8qL/L7E1jyG3DrP2jvOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgA1OJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgA1OJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:09:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6534F24690;
        Tue, 28 Jan 2020 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220571;
        bh=cdS438oyPWqFatWtdHTGGlYeR61YSDdTm3C57FtzmrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsAJov1xJSIWtBf2ONRBREH5DDmrHGZgIA64fxt4Nl612fvSrBrpwXk9z74eu0xof
         qox2JTHw0gnP3GoZExuFMGnMcmjYqCUN0GLWUyqlpgvoW1UcGyR3bBneVokevQut4D
         G6Fx6dnB9pR5lg90LeFHLoZvQF+A28EW6aidyawU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 060/183] net: sh_eth: fix a missing check of of_get_phy_mode
Date:   Tue, 28 Jan 2020 15:04:39 +0100
Message-Id: <20200128135835.939492536@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 035a14e71f27eefa50087963b94cbdb3580d08bf ]

of_get_phy_mode may fail and return a negative error code;
the fix checks the return value of of_get_phy_mode and
returns NULL of it fails.

Fixes: b356e978e92f ("sh_eth: add device tree support")
Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 2d9f4ed9a65ed..8413f93f5cd94 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3040,12 +3040,16 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct sh_eth_plat_data *pdata;
 	const char *mac_addr;
+	int ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-	pdata->phy_interface = of_get_phy_mode(np);
+	ret = of_get_phy_mode(np);
+	if (ret < 0)
+		return NULL;
+	pdata->phy_interface = ret;
 
 	mac_addr = of_get_mac_address(np);
 	if (mac_addr)
-- 
2.20.1



