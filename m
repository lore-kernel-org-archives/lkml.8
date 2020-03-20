Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB7C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA720722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OZA7F/0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCTJxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:53:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39084 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbgCTJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:53:52 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B22AB405DD;
        Fri, 20 Mar 2020 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584698032; bh=4+HvQGiA8FWnUSDj7nvWYYz5tzaFq+FB1nKqZ26AjLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OZA7F/0SEVrv5G+XgdxJ8e9Fx2RXYJjG8hD/wexZuKwVRS13v2OkgcUFUUbXQOYfQ
         N3iTn+RQPSvGiyrsPAnfn8Q1BD+/2qWXU7p0ENfNOn171ZKUyN9dVrqKCmoAaYFL4T
         lPHOsDriUyld+4Gr1IgDiwLLFbndEMwukeHUJcb4UhXVNcI5d0YjL7imc4G/MMhHLr
         spMpfEJFAIZMPdFbfKKvB01bC551cKevjdi8GU/zSjIQX1Vmw9nsg0Gd59BAoncBBT
         4J8/CnsLoV6hDdMO4wNoVyUdIxPCAau4bHfRebBcAZ56lkHDYXX05AuFjOSLLpUsty
         oiREoGcyv8Pcw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0BE75A0063;
        Fri, 20 Mar 2020 09:53:49 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: phy: xpcs: Set Link down if AutoNeg is enabled and did not finish
Date:   Fri, 20 Mar 2020 10:53:36 +0100
Message-Id: <fb3e98d6db03eb44e8b111afa2cdd84a8936d8e6.1584697754.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1584697754.git.Jose.Abreu@synopsys.com>
References: <cover.1584697754.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1584697754.git.Jose.Abreu@synopsys.com>
References: <cover.1584697754.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set XPCS Link as down when AutoNeg is enabled but it didn't finish with
success.

Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/phy/mdio-xpcs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-xpcs.c b/drivers/net/phy/mdio-xpcs.c
index 54976047dcb9..f10d86b85fbd 100644
--- a/drivers/net/phy/mdio-xpcs.c
+++ b/drivers/net/phy/mdio-xpcs.c
@@ -617,10 +617,12 @@ static int xpcs_get_state(struct mdio_xpcs_args *xpcs,
 		return xpcs_config(xpcs, state);
 	}
 
-	if (state->link && state->an_enabled && xpcs_aneg_done(xpcs, state)) {
+	if (state->an_enabled && xpcs_aneg_done(xpcs, state)) {
 		state->an_complete = true;
 		xpcs_read_lpa(xpcs, state);
 		xpcs_resolve_lpa(xpcs, state);
+	} else if (state->an_enabled) {
+		state->link = 0;
 	} else if (state->link) {
 		xpcs_resolve_pma(xpcs, state);
 	}
-- 
2.7.4

