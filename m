Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6449C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D22071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHZFUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:20:07 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:57094 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHZFUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:20:05 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2020 01:20:02 EDT
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 59B2E485;
        Wed, 26 Aug 2020 13:11:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.70])
        by smtp.263.net (postfix) whith ESMTP id P32155T139860231112448S1598418712200462_;
        Wed, 26 Aug 2020 13:11:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f49bec8a578b978e6412b11cab7573f0>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 14.18.236.70
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yi Li <yili@winhong.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     yilikernel@gmail.com, yili@winhong.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, kuba@kernel.org,
        Li Bing <libing@winhong.com>
Subject: [PATCH] net: hns3: Fix for geneve tx checksum bug
Date:   Wed, 26 Aug 2020 13:11:50 +0800
Message-Id: <20200826051150.2646128-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when skb->encapsulation is 0, skb->ip_summed is CHECKSUM_PARTIAL
and it is udp packet, which has a dest port as the IANA assigned.
the hardware is expected to do the checksum offload, but the
hardware will not do the checksum offload when udp dest port is
6081.

This patch fixes it by doing the checksum in software.

Reported-by: Li Bing <libing@winhong.com>
Signed-off-by: Yi Li <yili@winhong.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 87776ce3539b..7d83c45369c2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -21,6 +21,7 @@
 #include <net/pkt_cls.h>
 #include <net/tcp.h>
 #include <net/vxlan.h>
+#include <net/geneve.h>
 
 #include "hnae3.h"
 #include "hns3_enet.h"
@@ -780,7 +781,7 @@ static int hns3_get_l4_protocol(struct sk_buff *skb, u8 *ol4_proto,
  * and it is udp packet, which has a dest port as the IANA assigned.
  * the hardware is expected to do the checksum offload, but the
  * hardware will not do the checksum offload when udp dest port is
- * 4789.
+ * 4789 or 6081.
  */
 static bool hns3_tunnel_csum_bug(struct sk_buff *skb)
 {
@@ -789,7 +790,8 @@ static bool hns3_tunnel_csum_bug(struct sk_buff *skb)
 	l4.hdr = skb_transport_header(skb);
 
 	if (!(!skb->encapsulation &&
-	      l4.udp->dest == htons(IANA_VXLAN_UDP_PORT)))
+	      (l4.udp->dest == htons(IANA_VXLAN_UDP_PORT) ||
+	      l4.udp->dest == htons(GENEVE_UDP_PORT))))
 		return false;
 
 	skb_checksum_help(skb);
-- 
2.25.3



