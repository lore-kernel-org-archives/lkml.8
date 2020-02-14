Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F0C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834CF20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBNByO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728337AbgBNByM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:12 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9D1B55282AA0079514DC;
        Fri, 14 Feb 2020 09:54:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 09:54:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <huangdaode@huawei.com>, <linuxarm@huawei.com>, <kuba@kernel.org>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 3/3] net: hns3: fix a copying IPv6 address error in hclge_fd_get_flow_tuples()
Date:   Fri, 14 Feb 2020 09:53:43 +0800
Message-ID: <1581645223-23038-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
References: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangbin Huang <huangguangbin2@huawei.com>

The IPv6 address defined in struct in6_addr is specified as
big endian, but there is no specified endian in struct
hclge_fd_rule_tuples, so it  will cause a problem if directly
use memcpy() to copy ipv6 address between these two structures
since this field in struct hclge_fd_rule_tuples is little endian.

This patch fixes this problem by using be32_to_cpu() to convert
endian of IPv6 address of struct in6_addr before copying.

Fixes: d93ed94fbeaf ("net: hns3: add aRFS support for PF")
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 25ac573..492bc94 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6113,6 +6113,9 @@ static int hclge_get_all_rules(struct hnae3_handle *handle,
 static void hclge_fd_get_flow_tuples(const struct flow_keys *fkeys,
 				     struct hclge_fd_rule_tuples *tuples)
 {
+#define flow_ip6_src fkeys->addrs.v6addrs.src.in6_u.u6_addr32
+#define flow_ip6_dst fkeys->addrs.v6addrs.dst.in6_u.u6_addr32
+
 	tuples->ether_proto = be16_to_cpu(fkeys->basic.n_proto);
 	tuples->ip_proto = fkeys->basic.ip_proto;
 	tuples->dst_port = be16_to_cpu(fkeys->ports.dst);
@@ -6121,12 +6124,12 @@ static void hclge_fd_get_flow_tuples(const struct flow_keys *fkeys,
 		tuples->src_ip[3] = be32_to_cpu(fkeys->addrs.v4addrs.src);
 		tuples->dst_ip[3] = be32_to_cpu(fkeys->addrs.v4addrs.dst);
 	} else {
-		memcpy(tuples->src_ip,
-		       fkeys->addrs.v6addrs.src.in6_u.u6_addr32,
-		       sizeof(tuples->src_ip));
-		memcpy(tuples->dst_ip,
-		       fkeys->addrs.v6addrs.dst.in6_u.u6_addr32,
-		       sizeof(tuples->dst_ip));
+		int i;
+
+		for (i = 0; i < IPV6_SIZE; i++) {
+			tuples->src_ip[i] = be32_to_cpu(flow_ip6_src[i]);
+			tuples->dst_ip[i] = be32_to_cpu(flow_ip6_dst[i]);
+		}
 	}
 }
 
-- 
2.7.4

