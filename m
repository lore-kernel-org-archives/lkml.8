Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3987C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3BC2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nsBR7n1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGBINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:13:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:43101 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593677605; x=1625213605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PdW1XZ3MHRJsroDmSJ1DwasAvadWD6be00JFedG1d2Y=;
  b=nsBR7n1GUBTAOxNGU+77aWuJUuHTDrXU5Q1sTl21BeeCqTmv6Pb150jE
   BzI1BP3aDuf2gXe07QBoa86IyMijVMoVxvvX1vZP/sVev2K6SOrtseug2
   KLBcaTVkXjCxWKXyYaANV1GTqC7bJ3rzgHmLX6JosxBTHIS+JunrTaB5h
   G8ebdaI6Iz4Wid5422w0gD9dz3JG8Fr9hWtGDQJB/MmJ43kTO1hiryhJb
   iEu6tpKBcXgAkT4lB7FaAeiV8ecAJPFSwj1IVaPC+/ZzYEQDY/mJf47hU
   2DcmQkv/rPCWWK6U5hDmPUFOCiQ+RYDruKt1TBWMycHxJYhqDljddXaPH
   g==;
IronPort-SDR: P6KVoisUuR8tbsqlDtzu9JPJ2xJa+dGQP/OXGUdIwjGfcU2ziEsaqzD9k7UvXO+9c6W4tp9Gn7
 6nSezd4no5hFvoC3gjiwdvREntrn1EjRB70vHFZAA5OrhR2NRjJyhD4mllUgy5LPDwJkbsc9JX
 WvQ1AdKNLX2jH/Y04stFyk8l9qW3KVkj52w+PHM7G8982sWyAwgj3GKK+iJgdQ22b1Qfto9LW+
 p/1I8uZzzfEJQ8dMd3vswAO382GQUpaK78tJYnS74niAXQoyVXBBXCBX+p1oaAMtkKNMoNjMM0
 twQ=
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="81635220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 01:13:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 01:13:23 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 01:13:00 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@mellanox.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>, <UNGLinuxDriver@microchip.com>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 3/3] bridge: Extend br_fill_ifinfo to return MPR status
Date:   Thu, 2 Jul 2020 10:13:07 +0200
Message-ID: <20200702081307.933471-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702081307.933471-1-horatiu.vultur@microchip.com>
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the function br_fill_ifinfo to return also the MRP
status for each instance on a bridge. It also adds a new filter
RTEXT_FILTER_MRP to return the MRP status only when this is set, not to
interfer with the vlans. The MRP status is return only on the bridge
interfaces.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/rtnetlink.h |  1 +
 net/bridge/br_netlink.c        | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 879e64950a0a2..9b814c92de123 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -778,6 +778,7 @@ enum {
 #define RTEXT_FILTER_BRVLAN	(1 << 1)
 #define RTEXT_FILTER_BRVLAN_COMPRESSED	(1 << 2)
 #define	RTEXT_FILTER_SKIP_STATS	(1 << 3)
+#define RTEXT_FILTER_MRP	(1 << 4)
 
 /* End of information exported to user level */
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 240e260e3461c..c532fa65c9834 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -453,6 +453,28 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		rcu_read_unlock();
 		if (err)
 			goto nla_put_failure;
+
+		nla_nest_end(skb, af);
+	}
+
+	if (filter_mask & RTEXT_FILTER_MRP) {
+		struct nlattr *af;
+		int err;
+
+		if (!br_mrp_enabled(br) || port)
+			goto done;
+
+		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
+		if (!af)
+			goto nla_put_failure;
+
+		rcu_read_lock();
+		err = br_mrp_fill_info(skb, br);
+		rcu_read_unlock();
+
+		if (err)
+			goto nla_put_failure;
+
 		nla_nest_end(skb, af);
 	}
 
@@ -516,7 +538,8 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct net_bridge_port *port = br_port_get_rtnl(dev);
 
 	if (!port && !(filter_mask & RTEXT_FILTER_BRVLAN) &&
-	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED))
+	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED) &&
+	    !(filter_mask & RTEXT_FILTER_MRP))
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-- 
2.27.0

