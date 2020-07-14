Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB542084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FErJXuvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGNHj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:39:58 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28220 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgGNHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594712370; x=1626248370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDsPDcBsqLSCU8wYG3pcNrGvWrN5XQXdrnUKLu6IKAM=;
  b=FErJXuvgOv0zRyPMRhKP+uLYIMN35JTYrQ9OH3mPiLgOaCO34SXYmu0U
   0suZNij6/Ptgqs9Ps5o6hTDwya3Xy5GyA/qUUVLn9AAZTY6keHcs70nSY
   xBsbpXCk1+Q+po1B2WO2U+17801YyalWztuRcfkxyscy6JcumqggbJOvU
   9fzxdTgDNqPzb6alqjvCR8cFKl8HwYghZgGKiWFRuomYRbP69QGmX/tOU
   bSebiwtOVyPgbKuAe82pWsN6Mnpb+KIfKzSgPtF942R12bYCnQEL7O3ro
   HwmgDTR+jAJN2wkPj2M63Oe9WwjCpCDLh916xzC57oQNQCGYmXkle4iwo
   w==;
IronPort-SDR: Ch/oEyXZGU9eY5u0t9amE25ulO0Xy6flWcCbZzQq2g2T9HHqos96eD1jmHqSpmIBzOr0zm1Vvh
 L7HOSnsqD1LByKs6KSLYT2ITeOT6VX9NcRQD1m3yKiqpHmEIsYNyBupua9Ttu1L3l6s6x3jUjI
 ty6G6pOSE6coX8MokEyGGz905VDo30Cs9knoZ3xedxCVkONBmrxMIfvnE8Vs2DcuhF8bwndEra
 Ov9j54tRr1VgrExb3H23UQI7xiKNtScsMpGcu1gh1OtrLWh8XSNED9gC0CN6PlEoRBAfNaIhKE
 7IY=
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="87494092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2020 00:39:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 00:39:28 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 14 Jul 2020 00:39:26 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 10/12] bridge: uapi: mrp: Extend MRP_INFO attributes for interconnect status
Date:   Tue, 14 Jul 2020 09:34:56 +0200
Message-ID: <20200714073458.1939574-11-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing MRP_INFO to return status of MRP interconnect. In
case there is no MRP interconnect on the node then the role will be
disabled so the other attributes can be ignored.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_bridge.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index d840a3e37a37c..c1227aecd38fd 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -243,6 +243,11 @@ enum {
 	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
 	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
 	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
+	IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_IN_STATE,
+	IFLA_BRIDGE_MRP_INFO_IN_ROLE,
+	IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
+	IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
 	__IFLA_BRIDGE_MRP_INFO_MAX,
 };
 
-- 
2.27.0

