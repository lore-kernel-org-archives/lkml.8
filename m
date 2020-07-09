Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC32076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZF5yd+Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGIKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:03:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:27253 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgGIKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594288905; x=1625824905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT+zkN+mJUyB0ZWqxtGVHHzSd7amrOhD/J3nYFKzHLU=;
  b=ZF5yd+OtJ0TVIoEb5WMjiddXtdRoiv+M75YDKEelkGGB26cCkQZm5vUu
   pa0b5PiiTtGkM5WT+W8XtLbULW752MYb857cLyG/XhkLNxTq7O1gTGUcP
   KFLzTUH/IpUxckWNFZ9rbccJzzSpX7DRZDcx+ta7BbMhLZZtL2rG3NZ6S
   1zAz4L61VcRRxFybFsJnSQViV5MRUoVsW9QR+l3NUuIBUxvmEy+5AxqdE
   DxL9VUBCJ7TmdijXkQQWVqx8fu3kzY8tV1DeWqRjIU83am5P1Z2aj1GtA
   nz5hCU4JU7gv/XjNEY4OzDC2soG64p20rjazbp1nFs6C+HKa6obQP3XUG
   g==;
IronPort-SDR: 59q0g0kyqQ/hk+jzxnIWkufbUygyYSwwPnE6naXzKDijfLx+FKnbxtqtvfTbLw7hyaNTieG3zW
 4DWsnMajDZfDhzkrirZ0PwfHDzwz2gORE2oTrGOtmDU7APj4TFpib3x+qGQCT/rchRHy7SMK87
 Ler8Nm4AFj8MVFjSiHYJJ08bg2MNwIDuwEeNJSwhkl4g7BavFofZoFGwNtklyZDDwYKxNkCezO
 HZn5ImBNBnL5rOVGGlQ6qpO2bZiWyIcEzgGWcioaSEy9m3vwvFwpT97MZwgn0FUbX5h4gZCCXZ
 ty0=
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="86823019"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 03:01:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 03:01:41 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 9 Jul 2020 03:01:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 03/12] bridge: mrp: Extend bridge interface
Date:   Thu, 9 Jul 2020 12:00:31 +0200
Message-ID: <20200709100040.554623-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709100040.554623-1-horatiu.vultur@microchip.com>
References: <20200709100040.554623-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new flag(BR_MRP_LOST_IN_CONT) to the net bridge
ports. This bit will be set when the port lost the continuity of
MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/if_bridge.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index b3a8d3054af0f..6479a38e52fa9 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -49,6 +49,7 @@ struct br_ip_list {
 #define BR_ISOLATED		BIT(16)
 #define BR_MRP_AWARE		BIT(17)
 #define BR_MRP_LOST_CONT	BIT(18)
+#define BR_MRP_LOST_IN_CONT	BIT(19)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
-- 
2.27.0

