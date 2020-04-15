Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE12206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953414;
	bh=Lk6ebpaBji/nxzIYQ5JNX9Gi0XyEraR7whY8U2kyI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZKrpxxiWgso9ExxsSZsuBJpP7G5tnDxH9da4b2462721VpHytQThHifNL90jnFsu
	 /bBeoiuAMX91GqDSMH7fA18JH3BipLMqTPrKUvdJ/Xroo1yI5nID7vRsTdcIP85j1f
	 8Yn2DUz7S1oS5Mb8tnW+2gHv4S4PZXUifU/M0NmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbgDOMX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409224AbgDOLpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E2220768;
        Wed, 15 Apr 2020 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951150;
        bh=Lk6ebpaBji/nxzIYQ5JNX9Gi0XyEraR7whY8U2kyI+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is+AYgwFou1uKyCz8zwfkCF0fNn458pu56Pn+v3JO7Kh4fyQ2FFfN8FBskVSReSOv
         7Da5De2YobvYIxblLC/ke1uPF+cwRv2ML6cKNzS2mZDO1IOxsUb7D3J7PDvTCXBoHd
         fOYvcpDSJ1crtb3XPOT9yd316LNBZQaPe74Wd0ro=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 57/84] net: dsa: bcm_sf2: Ensure correct sub-node is parsed
Date:   Wed, 15 Apr 2020 07:44:14 -0400
Message-Id: <20200415114442.14166-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit afa3b592953bfaecfb4f2f335ec5f935cff56804 ]

When the bcm_sf2 was converted into a proper platform device driver and
used the new dsa_register_switch() interface, we would still be parsing
the legacy DSA node that contained all the port information since the
platform firmware has intentionally maintained backward and forward
compatibility to client programs. Ensure that we do parse the correct
node, which is "ports" per the revised DSA binding.

Fixes: d9338023fb8e ("net: dsa: bcm_sf2: Make it a real platform device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 4878400584c23..9502db66092eb 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1053,6 +1053,7 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	const struct bcm_sf2_of_data *data;
 	struct b53_platform_data *pdata;
 	struct dsa_switch_ops *ops;
+	struct device_node *ports;
 	struct bcm_sf2_priv *priv;
 	struct b53_device *dev;
 	struct dsa_switch *ds;
@@ -1115,7 +1116,11 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	set_bit(0, priv->cfp.used);
 	set_bit(0, priv->cfp.unique);
 
-	bcm_sf2_identify_ports(priv, dn->child);
+	ports = of_find_node_by_name(dn, "ports");
+	if (ports) {
+		bcm_sf2_identify_ports(priv, ports);
+		of_node_put(ports);
+	}
 
 	priv->irq0 = irq_of_parse_and_map(dn, 0);
 	priv->irq1 = irq_of_parse_and_map(dn, 1);
-- 
2.20.1

