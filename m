Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA998C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42292070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x/JTzjYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgEFVbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:31:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50710 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgEFVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:31:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046LV8NS099833;
        Wed, 6 May 2020 16:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588800668;
        bh=1E4Aar7eIyqkUMWdPEbVw1rTuDiTTWmcpK8rxV5WG2g=;
        h=From:To:Subject:Date;
        b=x/JTzjYIe4Scls675CEJQvpuOinkt2f0uV+O3b4+0TVQYr8gN1+nzMZr6vJCNKAZL
         qpqYN81Yw6kdoGfdGCv3inv8/LNyjAP0NG+BivKHx2YhYdxrL2/wv+h2wc3XceTcWN
         3rr/I3OkXUGsv/H+1OevYMKt6qCt1zo4Wd46E5+o=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046LV8p3056330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 16:31:08 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 16:31:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 16:31:08 -0500
Received: from uda0868495.fios-router.home (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046LV7UB025450;
        Wed, 6 May 2020 16:31:08 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [net PATCH v2] net: hsr: fix incorrect type usage for protocol variable
Date:   Wed, 6 May 2020 17:31:07 -0400
Message-ID: <20200506213107.28291-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following sparse checker warning:-

net/hsr/hsr_slave.c:38:18: warning: incorrect type in assignment (different base types)
net/hsr/hsr_slave.c:38:18:    expected unsigned short [unsigned] [usertype] protocol
net/hsr/hsr_slave.c:38:18:    got restricted __be16 [usertype] h_proto
net/hsr/hsr_slave.c:39:25: warning: restricted __be16 degrades to integer
net/hsr/hsr_slave.c:39:57: warning: restricted __be16 degrades to integer

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 v2 : Added Acked-by from Vinicius Costa Gomes
 net/hsr/hsr_slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index f4b9f7a3ce51..25b6ffba26cd 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -18,7 +18,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
 	struct hsr_port *port;
-	u16 protocol;
+	__be16 protocol;
 
 	if (!skb_mac_header_was_set(skb)) {
 		WARN_ONCE(1, "%s: skb invalid", __func__);
-- 
2.17.1

