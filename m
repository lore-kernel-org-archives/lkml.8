Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27109C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F168F2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOKqWQDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFRF6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:58:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47068 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgFRF6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592459879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOnTc1Tc1olhU8CFMkkyzlIlNq+Dlnu6nonibpkABRc=;
        b=WOKqWQDcEOMCnWItP4rbU+X/c9xE5OAQ9fvf69XRPbznHunUJ3LWj5SioKYhJWXv4U/cS8
        Cw3dI+V541sCD7sK2SUgKO9qeZt8S4fISLd4tw+3WBMxsr3M1xoqbK9NkDSJ6SgyRHjdRd
        FXYWxYnJjeSh2AaRBIKO0LTc36qbcFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-ZecySBeiOemJyhK2xF4QCw-1; Thu, 18 Jun 2020 01:57:55 -0400
X-MC-Unique: ZecySBeiOemJyhK2xF4QCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FD58005AD;
        Thu, 18 Jun 2020 05:57:53 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACAC5C1D6;
        Thu, 18 Jun 2020 05:57:45 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH RFC 3/5] vhost-vdpa: support get/set backend features
Date:   Thu, 18 Jun 2020 13:56:24 +0800
Message-Id: <20200618055626.25660-4-jasowang@redhat.com>
In-Reply-To: <20200618055626.25660-1-jasowang@redhat.com>
References: <20200618055626.25660-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes userspace can get and set backend features to
vhost-vdpa.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index db4c9cb44c61..453057421f80 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -55,6 +55,10 @@ enum {
 		(1ULL << VIRTIO_NET_F_SPEED_DUPLEX),
 };
 
+enum {
+	VHOST_VDPA_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
+};
+
 /* Currently, only network backend w/o multiqueue is supported. */
 #define VHOST_VDPA_VQ_MAX	2
 
@@ -340,6 +344,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
+	u64 __user *featurep = argp;
+	u64 features;
 	u32 idx;
 	long r;
 
@@ -362,6 +368,18 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_GET_VRING_BASE:
 		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
 		break;
+	case VHOST_GET_BACKEND_FEATURES:
+		features = VHOST_VDPA_BACKEND_FEATURES;
+		if (copy_to_user(featurep, &features, sizeof(features)))
+			return -EFAULT;
+		return 0;
+	case VHOST_SET_BACKEND_FEATURES:
+		if (copy_from_user(&features, featurep, sizeof(features)))
+			return -EFAULT;
+		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
+			return -EOPNOTSUPP;
+		vhost_set_backend_features(&v->vdev, features);
+		return 0;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.20.1

