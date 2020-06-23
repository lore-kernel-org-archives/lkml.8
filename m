Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F60C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C632064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944094;
	bh=kTaG2TbKFzCkFEHKs1RFuqYWzCHqvb5XBD/80p7YBsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4Yf0hQtPGcoa13ieVhTsdgiGXjdDtl9kloHN5pFh+fnmZMaKOmeKkLpg6a14dCWw
	 vzCYC+V3elb/OSpnBIhWfOLjqPr3C2vcmI/epR8geZMKi2e17DR+Hhh2UFeUgDhm+R
	 AejR/kLWmT26FUghybtDLnQ3eRM2JEfo/li7PgjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbgFWU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390830AbgFWU2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A863D2078A;
        Tue, 23 Jun 2020 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944082;
        bh=kTaG2TbKFzCkFEHKs1RFuqYWzCHqvb5XBD/80p7YBsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xODU8gejNNBrREVhXAr717vlI4EeiRPg+thdn5rJD/3c5d4EP4Uzi5wvIAvBgyuQu
         8Wj/vdRpaTycZwIcoYL31HTny0K/iOkebXeffWDa9BrKRvNfHKLflge+pTwf/uyy6L
         LIzE9s7rrvP0pYlDDNg5KE+roCVDrFXgG1AZJxjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/314] pinctrl: rockchip: fix memleak in rockchip_dt_node_to_map
Date:   Tue, 23 Jun 2020 21:55:30 +0200
Message-Id: <20200623195345.311921678@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

[ Upstream commit d7faa8ffb6be57bf8233a4b5a636d76b83c51ce7 ]

In function rockchip_dt_node_to_map, a new_map variable is
allocated by:

new_map = devm_kcalloc(pctldev->dev, map_num, sizeof(*new_map),
		       GFP_KERNEL);

This uses devres and attaches new_map to the pinctrl driver.
This cause a leak since new_map is not released when the probed
driver is removed. Fix it by using kcalloc to allocate new_map
and free it in `rockchip_dt_free_map`

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20200506100903.15420-1-dafna.hirschfeld@collabora.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index dc0bbf198cbcf..1bd8840e11a6e 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -506,8 +506,8 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	map_num += grp->npins;
-	new_map = devm_kcalloc(pctldev->dev, map_num, sizeof(*new_map),
-								GFP_KERNEL);
+
+	new_map = kcalloc(map_num, sizeof(*new_map), GFP_KERNEL);
 	if (!new_map)
 		return -ENOMEM;
 
@@ -517,7 +517,7 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* create mux map */
 	parent = of_get_parent(np);
 	if (!parent) {
-		devm_kfree(pctldev->dev, new_map);
+		kfree(new_map);
 		return -EINVAL;
 	}
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
@@ -544,6 +544,7 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 static void rockchip_dt_free_map(struct pinctrl_dev *pctldev,
 				    struct pinctrl_map *map, unsigned num_maps)
 {
+	kfree(map);
 }
 
 static const struct pinctrl_ops rockchip_pctrl_ops = {
-- 
2.25.1



