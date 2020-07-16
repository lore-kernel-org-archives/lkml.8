Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35793C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF1C2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGPHXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:23:43 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59996 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728041AbgGPHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:41 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 16 Jul 2020 10:23:36 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06G7Nahe006468;
        Thu, 16 Jul 2020 10:23:36 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06G7NaAE005420;
        Thu, 16 Jul 2020 10:23:36 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06G7Nata005419;
        Thu, 16 Jul 2020 10:23:36 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com,
        Eli Cohen <eli@mellanox.com>, Parav Pandit <parav@mellanox.com>
Subject: [PATCH vhost next 05/10] vhost: Fix documentation
Date:   Thu, 16 Jul 2020 10:23:22 +0300
Message-Id: <20200716072327.5359-6-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200716072327.5359-1-eli@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix documentation to match actual function prototypes.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vhost/iotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 1f0ca6e44410..0d4213a54a88 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_free);
  * vhost_iotlb_itree_first - return the first overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte in IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
  * vhost_iotlb_itree_first - return the next overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)
-- 
2.27.0

