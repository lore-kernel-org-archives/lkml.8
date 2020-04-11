Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F4C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A32021744
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607209;
	bh=KgQI/IEdw7z0FxlePfn7h13qgfWjmrpXaevxOhYSAlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NAOr2NfClBvbopQAXie7MlHKrGUdXrqpxZ3HHSuUX8niqoi2gqgn78QwD2ZOkgquw
	 ELyfrY48bRiQKXUKXwkLejaGJ6418g9924CrCAku2TNRNCb7HHQGmztc/ByMdOnzfr
	 rODnLEfoI2bYzTSKo4dF//KDZHL+aMrkFFcGN4f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDKMNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbgDKMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501AE2173E;
        Sat, 11 Apr 2020 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607201;
        bh=KgQI/IEdw7z0FxlePfn7h13qgfWjmrpXaevxOhYSAlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyfYb+YYS/Wu2MGop3/EqDwt8f/CnP3ZyKPz2Y/yDLLjkQatLWXEJ9svp38KrMJP/
         1tZNahDvEtz3hqjDruOhSPaVgyukp+694OLiCPz4+qEOvKTwnSM+vzafNEHX6JpWz5
         VbE/mc0lduML7Vgc49AD00GCtZTCZvp3DorfJOCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/38] net: dsa: bcm_sf2: Ensure correct sub-node is parsed
Date:   Sat, 11 Apr 2020 14:09:00 +0200
Message-Id: <20200411115439.585127343@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1112,6 +1112,7 @@ static int bcm_sf2_sw_probe(struct platf
 	const struct bcm_sf2_of_data *data;
 	struct b53_platform_data *pdata;
 	struct dsa_switch_ops *ops;
+	struct device_node *ports;
 	struct bcm_sf2_priv *priv;
 	struct b53_device *dev;
 	struct dsa_switch *ds;
@@ -1174,7 +1175,11 @@ static int bcm_sf2_sw_probe(struct platf
 	 */
 	set_bit(0, priv->cfp.used);
 
-	bcm_sf2_identify_ports(priv, dn->child);
+	ports = of_find_node_by_name(dn, "ports");
+	if (ports) {
+		bcm_sf2_identify_ports(priv, ports);
+		of_node_put(ports);
+	}
 
 	priv->irq0 = irq_of_parse_and_map(dn, 0);
 	priv->irq1 = irq_of_parse_and_map(dn, 1);


