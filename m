Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C6C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5B2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954612;
	bh=Fb5r/XOVrXihGT7UJi2/W3a1v9RW/SP/vpu9XGfwCTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xJSCEO0Us7f/FawFE5DEfB8OAyevqC4dZ+hrrjJibml5h364uC2vxVM1qQhdgBKCp
	 zS0+cdJ23PDDGrpGXXlQMuFAgsdUyvOYW0VX9aYfC4MERQLYuWWJ9pK14/cZW0ApVg
	 sxfQy+mARo+I56t69Cjsy2hpllBd44O5+70cIoiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370114AbgDOMna (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897525AbgDOLng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CB5214D8;
        Wed, 15 Apr 2020 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951016;
        bh=Fb5r/XOVrXihGT7UJi2/W3a1v9RW/SP/vpu9XGfwCTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrfhAswdFdRPrOeVnMC+if+q4g93y/skOG10cO9RU1WQ04KSItNMudk0jWrjpe+8Y
         NCUiSnK0qTWqbAJlk0fjSvR+nyKO791IpMPfoU8OYOvqMaTbmg9n7DODpAj9yFFkKF
         kY43z6wivEFK7xy7RrU5irsPvYOVsi4JhnBv2/pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 058/106] net: qualcomm: rmnet: Allow configuration updates to existing devices
Date:   Wed, 15 Apr 2020 07:41:38 -0400
Message-Id: <20200415114226.13103-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 2abb5792387eb188b12051337d5dcd2cba615cb0 ]

This allows the changelink operation to succeed if the mux_id was
specified as an argument. Note that the mux_id must match the
existing mux_id of the rmnet device or should be an unused mux_id.

Fixes: 1dc49e9d164c ("net: rmnet: do not allow to change mux id if mux id is duplicated")
Reported-and-tested-by: Alex Elder <elder@linaro.org>
Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index fbf4cbcf1a654..02cdbb22d3355 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -279,7 +279,6 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
 	struct net_device *real_dev;
-	struct rmnet_endpoint *ep;
 	struct rmnet_port *port;
 	u16 mux_id;
 
@@ -294,19 +293,27 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	if (data[IFLA_RMNET_MUX_ID]) {
 		mux_id = nla_get_u16(data[IFLA_RMNET_MUX_ID]);
-		if (rmnet_get_endpoint(port, mux_id)) {
-			NL_SET_ERR_MSG_MOD(extack, "MUX ID already exists");
-			return -EINVAL;
-		}
-		ep = rmnet_get_endpoint(port, priv->mux_id);
-		if (!ep)
-			return -ENODEV;
 
-		hlist_del_init_rcu(&ep->hlnode);
-		hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
+		if (mux_id != priv->mux_id) {
+			struct rmnet_endpoint *ep;
+
+			ep = rmnet_get_endpoint(port, priv->mux_id);
+			if (!ep)
+				return -ENODEV;
 
-		ep->mux_id = mux_id;
-		priv->mux_id = mux_id;
+			if (rmnet_get_endpoint(port, mux_id)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "MUX ID already exists");
+				return -EINVAL;
+			}
+
+			hlist_del_init_rcu(&ep->hlnode);
+			hlist_add_head_rcu(&ep->hlnode,
+					   &port->muxed_ep[mux_id]);
+
+			ep->mux_id = mux_id;
+			priv->mux_id = mux_id;
+		}
 	}
 
 	if (data[IFLA_RMNET_FLAGS]) {
-- 
2.20.1

