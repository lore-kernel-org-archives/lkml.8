Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18CA21582
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954571;
	bh=nN+IJegSL42QeskS1HcfIWBL6TRx5iItWQggENvdjR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nN9AiR/GOiZ52uXBytUZQObhZML9rkRQJcMhrjnsUcX2w4a9d1bQqndIghNME2ddE
	 iyB1nkMIkuoRiRm+hKr3l4pI+6hTSk9U/CmBp12mjX+Jq1ndRlOfsbHt0XdH08Nocj
	 xQ6TgldKLrgmiwG2IxZ0qw0vcUH2v1hXJ1ZgvZJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898186AbgDOMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897529AbgDOLnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24A42078A;
        Wed, 15 Apr 2020 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951020;
        bh=nN+IJegSL42QeskS1HcfIWBL6TRx5iItWQggENvdjR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2x8BKWl+ub0Z+bOXDfSzIi+UQQmhoMDEEsc8Vm9MA9lp5jPjsOlIoh5G3oifC2ty
         +E5tsJAbYoP8UQPgeTED0OnvT18zaHGGkftTz6yVyiNTK9mRg832ZhD/pPM85oGpRW
         fCOYz7OfOzYbXPzZz359JEbyv2Nn4i8MilBC9TDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 061/106] net: dsa: mt7530: fix null pointer dereferencing in port5 setup
Date:   Wed, 15 Apr 2020 07:41:41 -0400
Message-Id: <20200415114226.13103-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhong Guo <gch981213@gmail.com>

[ Upstream commit 0452800f6db4ed0a42ffb15867c0acfd68829f6a ]

The 2nd gmac of mediatek soc ethernet may not be connected to a PHY
and a phy-handle isn't always available.
Unfortunately, mt7530 dsa driver assumes that the 2nd gmac is always
connected to switch port 5 and setup mt7530 according to phy address
of 2nd gmac node, causing null pointer dereferencing when phy-handle
isn't defined in dts.
This commit fix this setup code by checking return value of
of_parse_phandle before using it.

Fixes: 38f790a80560 ("net: dsa: mt7530: Add support for port 5")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: René van Dorst <opensource@vdorst.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 60a8a68567baa..936b9b65accab 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1355,6 +1355,9 @@ mt7530_setup(struct dsa_switch *ds)
 				continue;
 
 			phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
+			if (!phy_node)
+				continue;
+
 			if (phy_node->parent == priv->dev->of_node->parent) {
 				ret = of_get_phy_mode(mac_np, &interface);
 				if (ret && ret != -ENODEV)
-- 
2.20.1

