Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03D4206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbKNDZZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHKC5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:57:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgHKC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597114640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F/gKVte+U3xgCt6SAHir9krIN3/3rbwfcTsHlgshxXU=;
        b=UbKNDZZnBuGSEKZxYJUIcDNWqB9X5abQbkcq4/Ngy/0NlDhJcHOkiah17CwSAY54tzNWnw
        X2LhVGqgdDK7w3LOXUmKEDeNwqUPGASw0L4EzIE+65Hx7TOvjmYvEZbjsJpuuBQRRZD+EO
        0GHxRTEpxkc2DIZTyowRH1+qaHP6uAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-LKIgnedcOQ64KV0l3WMBMw-1; Mon, 10 Aug 2020 22:57:18 -0400
X-MC-Unique: LKIgnedcOQ64KV0l3WMBMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C60800465;
        Tue, 11 Aug 2020 02:57:17 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB01719D7B;
        Tue, 11 Aug 2020 02:57:12 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com
Subject: [PATCH 1/2] MAINTAINERS: add a dedicated entry for vDPA
Date:   Tue, 11 Aug 2020 10:57:09 +0800
Message-Id: <20200811025710.7775-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vDPA is an independent subsystem, so use a dedicated entry for that.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698cc7e23..314398f0e276 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18173,13 +18173,19 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
 F:	drivers/net/virtio_net.c
-F:	drivers/vdpa/
 F:	drivers/virtio/
-F:	include/linux/vdpa.h
 F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/
 
+VDPA CORE AND DRIVERS
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/vdpa/
+F:	include/linux/vdpa.h
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
-- 
2.20.1

