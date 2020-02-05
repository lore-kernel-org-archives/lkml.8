Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543A21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlQQmLxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEQeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:34:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbgBEQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580920458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtgAS5As/BKnCnMXPh5ZN6N7pDDP1MdfMF5L3R2Z8to=;
        b=LlQQmLxrOXr4/EoDZ4kVklkiMzKsXJ8SDFA3pVMiwuPTwM4NzJGvG8Q+qNVevh028D/OFN
        +6UxCTib85Q1ZH0RsyLONj7o3QPVLH8biHqRU12m8XzP2xfQW7iPo3KtGm90tMZlQ6Py4s
        1tke98g+gZMtg9Xayev1QHZqC6Ln490=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-no6_VzNIMpKlFtwPkyLWog-1; Wed, 05 Feb 2020 11:34:14 -0500
X-MC-Unique: no6_VzNIMpKlFtwPkyLWog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A8DA1085929;
        Wed,  5 Feb 2020 16:34:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02A21001B08;
        Wed,  5 Feb 2020 16:34:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>
Subject: [PATCH v1 1/3] virtio-balloon: Fix memory leak when unloading while hinting is in progress
Date:   Wed,  5 Feb 2020 17:34:00 +0100
Message-Id: <20200205163402.42627-2-david@redhat.com>
In-Reply-To: <20200205163402.42627-1-david@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unloading the driver while hinting is in progress, we will not
release the free page blocks back to MM, resulting in a memory leak.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Liang Li <liang.z.li@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 8e400ece9273..abef2306c899 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -968,6 +968,10 @@ static void remove_common(struct virtio_balloon *vb)
 		leak_balloon(vb, vb->num_pages);
 	update_balloon_size(vb);
=20
+	/* There might be free pages that are being reported: release them. */
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		return_free_pages_to_mm(vb, ULONG_MAX);
+
 	/* Now we reset the device so we can clean up the queues. */
 	vb->vdev->config->reset(vb->vdev);
=20
--=20
2.24.1

