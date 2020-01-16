Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97281C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DEC2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201520;
	bh=lPmThtofcrZwZNR638UCp8kMHIUg/XfTH7JQtJ2+Yvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhZ/gQydsuTF56xy1ACniduepRooJe86+euSnhEZxY+uDdT55UdAKCIFMzCaUBsVe
	 vWLj1S8N89W80GX0casF3+8cXM/G5E5eUD66MiFNejXqUFmRAkHQjvspRk1D4ZjB7J
	 1Wqdecrb2w64cLQI2MNx0QB57yVM5qsJlRLmPLk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgAPRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388199AbgAPRBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 967142073A;
        Thu, 16 Jan 2020 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194110;
        bh=lPmThtofcrZwZNR638UCp8kMHIUg/XfTH7JQtJ2+Yvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfQ3rxLbuNorHU8JXY9IA/rR3VhT8q3zS0RuV+17snPda4kdw/l6Dcxl/bqTX6gXI
         nn/CGYuXiPQJKmdVkztrEmbRBDdjDOZv9PPbdhEga5y6W8GG9EREPxC+obwI8Ixzsz
         7NkdswVRjWTFOuQSlIrApazajo/vOHPizqwVCm9Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 207/671] net: dsa: fix unintended change of bridge interface STP state
Date:   Thu, 16 Jan 2020 11:51:56 -0500
Message-Id: <20200116165940.10720-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 9c2054a5cf415a9dc32c91ffde78399955deb571 ]

When a DSA port is added to a bridge and brought up, the resulting STP
state programmed into the hardware depends on the order that these
operations are performed.  However, the Linux bridge code believes that
the port is in disabled mode.

If the DSA port is first added to a bridge and then brought up, it will
be in blocking mode.  If it is brought up and then added to the bridge,
it will be in disabled mode.

This difference is caused by DSA always setting the STP mode in
dsa_port_enable() whether or not this port is part of a bridge.  Since
bridge always sets the STP state when the port is added, brought up or
taken down, it is unnecessary for us to manipulate the STP state.

Apparently, this code was copied from Rocker, and the very next day a
similar fix for Rocker was merged but was not propagated to DSA.  See
e47172ab7e41 ("rocker: put port in FORWADING state after leaving bridge")

Fixes: b73adef67765 ("net: dsa: integrate with SWITCHDEV for HW bridging")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/port.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index ed0595459df1..ea7efc86b9d7 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -69,7 +69,6 @@ static void dsa_port_set_state_now(struct dsa_port *dp, u8 state)
 
 int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy)
 {
-	u8 stp_state = dp->bridge_dev ? BR_STATE_BLOCKING : BR_STATE_FORWARDING;
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 	int err;
@@ -80,7 +79,8 @@ int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy)
 			return err;
 	}
 
-	dsa_port_set_state_now(dp, stp_state);
+	if (!dp->bridge_dev)
+		dsa_port_set_state_now(dp, BR_STATE_FORWARDING);
 
 	return 0;
 }
@@ -90,7 +90,8 @@ void dsa_port_disable(struct dsa_port *dp, struct phy_device *phy)
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 
-	dsa_port_set_state_now(dp, BR_STATE_DISABLED);
+	if (!dp->bridge_dev)
+		dsa_port_set_state_now(dp, BR_STATE_DISABLED);
 
 	if (ds->ops->port_disable)
 		ds->ops->port_disable(ds, port, phy);
-- 
2.20.1

