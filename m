Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7378206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PJrUZlbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCMRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:55:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37434 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:55:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DHtcD1000914;
        Fri, 13 Mar 2020 12:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584122138;
        bh=Xzf0pl4I+GiIsTovME8OTFIU5DSaFYgw7dndhzZDk6Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PJrUZlbGL0z/dA89SIowavFSWHpkr8OEaozjJWMcSDt9Ck5IPHZg9uuD7yS2FSWI0
         3h4dHbY0S5q4it2px9UosVunbG5PitAXxFvaxrMCVknwbZOsQY7Fxnrbyq7id+wVtA
         Wx6cc+N56QW6hoNW74JPual7hWJzzb+koCOsmSZk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02DHtc5c097272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 12:55:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 12:55:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 12:55:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DHtbQu047050;
        Fri, 13 Mar 2020 12:55:37 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        <devicetree@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v3 02/10] net: ethernet: ti: ale: add support for mac-only mode
Date:   Fri, 13 Mar 2020 19:55:03 +0200
Message-ID: <20200313175511.2155-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313175511.2155-1-grygorii.strashko@ti.com>
References: <20200313175511.2155-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new CPSW ALE version, available on TI K3 AM654/J721E SoCs family,
allows to switch any external port to MAC only mode. When MAC only mode
enabled this port be treated like a MAC port for the host. All traffic
received is only sent to the host. The host must direct traffic to this
port as the lookup engine will not send traffic to the ports with the
p0_maconly bit set and the p0_no_learn also set. If p0_maconly bit is set
and the p0_no_learn is not set, the host can send non-directed packets that
can be sent to the destination of a MacOnly port. It is also possible that
The host can broadcast to all ports including MacOnly ports in this mode.

This patch add ALE supprt for MAC only mode.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 16 ++++++++++++++++
 drivers/net/ethernet/ti/cpsw_ale.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5815225c000c..719e7846127c 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -779,6 +779,22 @@ static struct ale_control_info ale_controls[ALE_NUM_CONTROLS] = {
 		.port_shift	= 0,
 		.bits		= 1,
 	},
+	[ALE_PORT_MACONLY]	= {
+		.name		= "mac_only_port_mode",
+		.offset		= ALE_PORTCTL,
+		.port_offset	= 4,
+		.shift		= 11,
+		.port_shift	= 0,
+		.bits		= 1,
+	},
+	[ALE_PORT_MACONLY_CAF]	= {
+		.name		= "mac_only_port_caf",
+		.offset		= ALE_PORTCTL,
+		.port_offset	= 4,
+		.shift		= 13,
+		.port_shift	= 0,
+		.bits		= 1,
+	},
 	[ALE_PORT_MCAST_LIMIT]	= {
 		.name		= "mcast_limit",
 		.offset		= ALE_PORTCTL,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 70d0955c2652..eaca73c17ae7 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -62,6 +62,8 @@ enum cpsw_ale_control {
 	ALE_PORT_UNKNOWN_MCAST_FLOOD,
 	ALE_PORT_UNKNOWN_REG_MCAST_FLOOD,
 	ALE_PORT_UNTAGGED_EGRESS,
+	ALE_PORT_MACONLY,
+	ALE_PORT_MACONLY_CAF,
 	ALE_PORT_BCAST_LIMIT,
 	ALE_PORT_MCAST_LIMIT,
 	ALE_NUM_CONTROLS,
-- 
2.17.1

