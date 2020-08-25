Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F7C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KweAufsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHYNFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbgHYNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598360752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=44/rFMQFZre8hi2KWPAM7jK3g3yR2EVE42MjQnT9WTk=;
        b=KweAufsre1k/TllWCOCDsoBTaGiIJ2m6Zr8blKjeIIELmZoiIX97N098d/97NbshhSRDfP
        3iPAWNkA8y5f2AhDzurbUg9Gm3+/YxoEZDH9xfCu6Q1O1W3qZL//FihY6SJ3BaF2qFPBmb
        g7ZbjkidSNudAxYBLHTolQRNzBpztaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-uof_C0V9OaSdF-Gh1snzxw-1; Tue, 25 Aug 2020 09:05:50 -0400
X-MC-Unique: uof_C0V9OaSdF-Gh1snzxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21FBD84639C;
        Tue, 25 Aug 2020 13:05:49 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 053F960C0F;
        Tue, 25 Aug 2020 13:05:44 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH] vhost-iotlb: fix vhost_iotlb_itree_next() documentation
Date:   Tue, 25 Aug 2020 15:05:43 +0200
Message-Id: <20200825130543.43308-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains trivial changes for the vhost_iotlb_itree_next()
documentation, fixing the function name and the description of
first argument (@map).

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/iotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 1f0ca6e44410..34aec4ba331e 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -159,8 +159,8 @@ vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
 EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
 
 /**
- * vhost_iotlb_itree_first - return the next overlapped range
- * @iotlb: the IOTLB
+ * vhost_iotlb_itree_next - return the next overlapped range
+ * @map: the starting map node
  * @start: start of IOVA range
  * @end: end of IOVA range
  */
-- 
2.26.2

