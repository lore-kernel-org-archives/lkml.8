Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FEBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0CC2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHGGn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:43:58 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:35138 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgHGGn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:43:58 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 6 Aug 2020 23:43:52 -0700
Received: from ubuntu.eng.vmware.com (unknown [10.20.113.240])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id F1303B2C8A;
        Fri,  7 Aug 2020 02:43:57 -0400 (EDT)
From:   Ronak Doshi <doshir@vmware.com>
To:     <netdev@vger.kernel.org>
CC:     Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vmxnet3: use correct tcp hdr length when packet is encapsulated
Date:   Thu, 6 Aug 2020 23:43:45 -0700
Message-ID: <20200807064345.5156-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: doshir@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Commit dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload
support")' added support for encapsulation offload. However, while
calculating tcp hdr length, it does not take into account if the
packet is encapsulated or not.

This patch fixes this issue by using correct reference for inner
tcp header.

Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload
support")
Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Guolin Yang <gyang@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 3 ++-
 drivers/net/vmxnet3/vmxnet3_int.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index ca395f9679d0..2818015324b8 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -886,7 +886,8 @@ vmxnet3_parse_hdr(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 
 			switch (protocol) {
 			case IPPROTO_TCP:
-				ctx->l4_hdr_size = tcp_hdrlen(skb);
+				ctx->l4_hdr_size = skb->encapsulation ? inner_tcp_hdrlen(skb) :
+						   tcp_hdrlen(skb);
 				break;
 			case IPPROTO_UDP:
 				ctx->l4_hdr_size = sizeof(struct udphdr);
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 5d2b062215a2..f99e3327a7b0 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,12 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.5.0.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.5.1.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01050000
+#define VMXNET3_DRIVER_VERSION_NUM      0x01050100
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.11.0

