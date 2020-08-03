Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57950C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D82C20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHCLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:49:02 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:46234 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgHCLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:48:56 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 6D3A3CCBE0C8360DBA6B;
        Mon,  3 Aug 2020 19:48:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 073BmjGR014618;
        Mon, 3 Aug 2020 19:48:45 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020080319485078-4487275 ;
          Mon, 3 Aug 2020 19:48:50 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] virtio_pci_modern: Fix the comment of virtio_pci_find_capability()
Date:   Mon, 3 Aug 2020 19:52:24 +0800
Message-Id: <1596455545-43556-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-08-03 19:48:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-08-03 19:48:46,
        Serialize complete at 2020-08-03 19:48:46
X-MAIL: mse-fl1.zte.com.cn 073BmjGR014618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Fix the comment of virtio_pci_find_capability() by adding missing comment
for the last parameter: bars.

Fixes: 59a5b0f7bf74 ("virtio-pci: alloc only resources actually used.")
Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/virtio/virtio_pci_modern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index db93cedd262f..9bdc6f68221f 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -481,6 +481,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
  * @dev: the pci device
  * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
  * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
+ * @bars: the bitmask of BARs
  *
  * Returns offset of the capability, or 0.
  */
-- 
2.26.1

