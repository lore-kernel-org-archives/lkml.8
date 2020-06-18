Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB3C21655
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBqtHZY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgFRF5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:57:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgFRF5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592459863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FZNvCVnGKUBeexFie5SVEwwTiu463bRAglPRRjFWJY=;
        b=ZBqtHZY8CdptN06R5D5qMDclr5M46cuyYb7Z7BQK/pibX05gWzpUjXSpQ3hTK3eqSKt8o8
        bpxPwappVRPxVZ99Gnfz34pem+BcMPRV2j/AYuxoav8c1/J+vXaLL0gcyqoP1Vs2LavhIq
        t85g5mYLLnhu7RyPI0yjtT97RT4VNfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-oQGRz-gfNWWRPapu6wyxVg-1; Thu, 18 Jun 2020 01:57:41 -0400
X-MC-Unique: oQGRz-gfNWWRPapu6wyxVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 586091902EA0;
        Thu, 18 Jun 2020 05:57:39 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD8E15C1D6;
        Thu, 18 Jun 2020 05:57:28 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH RFC 1/5] vhost-vdpa: refine ioctl pre-processing
Date:   Thu, 18 Jun 2020 13:56:22 +0800
Message-Id: <20200618055626.25660-2-jasowang@redhat.com>
In-Reply-To: <20200618055626.25660-1-jasowang@redhat.com>
References: <20200618055626.25660-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use 'switch' to make the codes more easier to be extended.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 77a0c9fb6cc3..db4c9cb44c61 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -353,15 +353,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	idx = array_index_nospec(idx, v->nvqs);
 	vq = &v->vqs[idx];
 
-	if (cmd == VHOST_VDPA_SET_VRING_ENABLE) {
+	switch (cmd) {
+	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
-	}
-
-	if (cmd == VHOST_GET_VRING_BASE)
+	case VHOST_GET_VRING_BASE:
 		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
+		break;
+	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
 	if (r)
-- 
2.20.1

