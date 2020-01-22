Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0315CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20AA24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699600;
	bh=iR1U0/WnRAGvGxdyyz4HUMNeZ8ZDG2l7f4/0G42mBxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qmU+Fgfo93Rt71YK67zMk6PtkQpA6MbGGHiWqVya4OezSzN3gzbNqdsgsFRENBwG
	 I5ZZeudKXSeJKAq2d6d+FGnFzAy7iH1R3988W2FSqhFv+Gygtlyn/ryygJoy9LF7hn
	 2zhNAnphDiklO6GKL/mnI/fKrvIymZ1vAFlBVwio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgAVN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgAVN0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:26:37 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E2F2467B;
        Wed, 22 Jan 2020 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699597;
        bh=iR1U0/WnRAGvGxdyyz4HUMNeZ8ZDG2l7f4/0G42mBxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP8uBXw/zBMdSJWOzjtEZDJEKqIrIVMVsuLrWBusagTVt1ufo++syL4iTiRZ8OeZ+
         OQexnLjxaMhZy1uHLbxwYgsuDpOtDbv7U7a73GstSjSNJh8DzvawdWJCSRAAcCUYke
         GOxyqfQJi8rvTKI9F1tpmiQ4s68X2VyFPLaawhO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 154/222] net: dsa: sja1105: Dont error out on disabled ports with no phy-mode
Date:   Wed, 22 Jan 2020 10:29:00 +0100
Message-Id: <20200122092844.746801953@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 27afe0d34e9121a3d61cc0af9b17c2542dadde24 ]

The sja1105_parse_ports_node function was tested only on device trees
where all ports were enabled. Fix this check so that the driver
continues to probe only with the ports where status is not "disabled",
as expected.

Fixes: 8aa9ebccae87 ("net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -619,7 +619,7 @@ static int sja1105_parse_ports_node(stru
 	struct device *dev = &priv->spidev->dev;
 	struct device_node *child;
 
-	for_each_child_of_node(ports_node, child) {
+	for_each_available_child_of_node(ports_node, child) {
 		struct device_node *phy_node;
 		int phy_mode;
 		u32 index;


