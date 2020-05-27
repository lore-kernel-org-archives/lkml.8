Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40102C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F83A207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtN3o3vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgE0GFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:05:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbgE0GFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590559541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=46MptjPeMcvTvDVV/gp+2I8yZMG2EXUhGIjdvHlnNPM=;
        b=DtN3o3vIB3MX/0aCY3CN9M/nTKRHxr09/k4+3vbi5fXIUbEH7//uwEi7kNm195vexEEAsZ
        7RpCdyi4YLQvHBM6O9p65ETUp3o8SLuAtBjAgWYxlsx1aGHuQ/vEN7P5c4XbiJuVd36Nze
        H3Dk0k7fXVEOe9KICCA4kZ2lQebGYsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-V0kmZE77Pp2N0HvYWNAEFw-1; Wed, 27 May 2020 02:05:38 -0400
X-MC-Unique: V0kmZE77Pp2N0HvYWNAEFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE252107ACCA;
        Wed, 27 May 2020 06:05:37 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-244.pek2.redhat.com [10.72.13.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C835F84648;
        Wed, 27 May 2020 06:05:30 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: fix typos in the comments for __vdpa_alloc_device()
Date:   Wed, 27 May 2020 14:05:28 +0800
Message-Id: <20200527060528.9100-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two typos in the comments for __vdpa_alloc_device().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index ff6562f602e0..de211ef3738c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -63,7 +63,7 @@ static void vdpa_release_dev(struct device *d)
  * @config: the bus operations that is supported by this device
  * @size: size of the parent structure that contains private data
  *
- * Drvier should use vdap_alloc_device() wrapper macro instead of
+ * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
  *
  * Returns an error when parent/config/dma_dev is not set or fail to get
-- 
2.20.1

