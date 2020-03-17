Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE4C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE3205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442988;
	bh=tZZMnHIqT8ARNbWOY9+ZUdErgifyM5I8DObl5dgItgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOKhYxvVs+gXluGrQijr5bBABiio3sgBx6JX/HdUXzMcKaJSkoQfHQJEzx9bGaR79
	 Hi51wCL4SNGpfY667NDM+ZVJHTJbLoeLajZUedrLtOzzELCrbX/bl75Pskchs9Fqxb
	 VanD9K6ZJAxGHKRbNzflZ2OFj6n8tn+dgpKjbOaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCQLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbgCQLDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:03:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CA2205ED;
        Tue, 17 Mar 2020 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442984;
        bh=tZZMnHIqT8ARNbWOY9+ZUdErgifyM5I8DObl5dgItgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rifxZvQP6X+DtueuVGrlswDpcNXK0jfKpXwpmKaJVfmUQoBplEEWEHbaIhSdoFh47
         WJoPaI/dRaRM/oxrmSNPuoWbJNhSmOWr1tGnIc8zXhOwK2ViCchZT/SusCcswTC7PU
         WfD/0mmE4ENuVlVtFXgya4zCK/pgM4RwytN/gi/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 056/123] net: dsa: Dont instantiate phylink for CPU/DSA ports unless needed
Date:   Tue, 17 Mar 2020 11:54:43 +0100
Message-Id: <20200317103313.418148269@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit a20f997010c4ec76eaa55b8cc047d76dcac69f70 ]

By default, DSA drivers should configure CPU and DSA ports to their
maximum speed. In many configurations this is sufficient to make the
link work.

In some cases it is necessary to configure the link to run slower,
e.g. because of limitations of the SoC it is connected to. Or back to
back PHYs are used and the PHY needs to be driven in order to
establish link. In this case, phylink is used.

Only instantiate phylink if it is required. If there is no PHY, or no
fixed link properties, phylink can upset a link which works in the
default configuration.

Fixes: 0e27921816ad ("net: dsa: Use PHYLINK for the CPU/DSA ports")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/port.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -649,9 +649,14 @@ err_phy_connect:
 int dsa_port_link_register_of(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
+	struct device_node *phy_np;
 
-	if (!ds->ops->adjust_link)
-		return dsa_port_phylink_register(dp);
+	if (!ds->ops->adjust_link) {
+		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
+		if (of_phy_is_fixed_link(dp->dn) || phy_np)
+			return dsa_port_phylink_register(dp);
+		return 0;
+	}
 
 	dev_warn(ds->dev,
 		 "Using legacy PHYLIB callbacks. Please migrate to PHYLINK!\n");
@@ -666,11 +671,12 @@ void dsa_port_link_unregister_of(struct
 {
 	struct dsa_switch *ds = dp->ds;
 
-	if (!ds->ops->adjust_link) {
+	if (!ds->ops->adjust_link && dp->pl) {
 		rtnl_lock();
 		phylink_disconnect_phy(dp->pl);
 		rtnl_unlock();
 		phylink_destroy(dp->pl);
+		dp->pl = NULL;
 		return;
 	}
 


