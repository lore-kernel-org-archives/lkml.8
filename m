Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE9FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BD4207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGTHZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:25:03 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:54148 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTHZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:25:03 -0400
X-QQ-mid: bizesmtp26t1595229856t2mpv0ul
Received: from xr-hulk-k8s-node1933.gh.sankuai (unknown [101.236.11.2])
        by esmtp10.qq.com (ESMTP) with 
        id ; Mon, 20 Jul 2020 15:24:12 +0800 (CST)
X-QQ-SSF: 01100000002000E0ZJ10B00A0000000
X-QQ-FEAT: Me8y4DzRu2RX/O/JFOYvPdOlGujgeCqHlvABdNdCmzjsjIe5hfbTo09jNbvZM
        GH/j9Qq5iPHLdCA2f0U6RAwaJlYRst8mQDcIVR+TPTNi4Tb1OwxK8UmDiIioEcricqVZt1r
        qe87ERixS7WkaSKBJsdn5lI9TQrcrvdpHKSUPzOTbh1jEUDHfSAPHNX9R82rz8Wsjlz95bK
        7E2zuey5YwiWedfsQ1kjtTMb0L0o0i+SoAeO/r+zpeaS6fSQXjY5Ia30JY1yRyOF9AMd/pY
        vDF6t313o0Gtwq3S2dNH0S1RoWifE1k4oF8iA3y2hrsSPm8AFnNdgBiob3j8Uem1Dq/r1uP
        ZE92aptGhSSsqxTSN1BLuhi2Wrfog==
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     corbet@lwn.net
Cc:     w@laoqinren.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: driver-api: update kernel connector
Date:   Mon, 20 Jul 2020 15:24:12 +0800
Message-Id: <1595229852-114071-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes:
1) Fix typo in kernel connector documentation.
	s/cn_netlink_send_multi/cn_netlink_send_mult/
2) update definition of struct cn_msg

Signed-off-by: Wang Long <w@laoqinren.net>
---
 Documentation/driver-api/connector.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/connector.rst b/Documentation/driver-api/connector.rst
index c100c74..23d06819 100644
--- a/Documentation/driver-api/connector.rst
+++ b/Documentation/driver-api/connector.rst
@@ -26,7 +26,7 @@ netlink based networking for inter-process communication in a significantly
 easier way::
 
   int cn_add_callback(struct cb_id *id, char *name, void (*callback) (struct cn_msg *, struct netlink_skb_parms *));
-  void cn_netlink_send_multi(struct cn_msg *msg, u16 len, u32 portid, u32 __group, int gfp_mask);
+  void cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group, int gfp_mask);
   void cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group, int gfp_mask);
 
   struct cb_id
@@ -48,7 +48,8 @@ be dereferenced to `struct cn_msg *`::
 	__u32			seq;
 	__u32			ack;
 
-	__u32			len;	/* Length of the following data */
+	__u16			len;	/* Length of the following data */
+	__u16			flags;
 	__u8			data[0];
   };
 
-- 
1.8.3.1




