Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952722077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImqKOFuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgGAJJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:09:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41863 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729496AbgGAJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593594587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FZNvCVnGKUBeexFie5SVEwwTiu463bRAglPRRjFWJY=;
        b=ImqKOFuoUq28Kuyfeg1Mhl1nSgJjY1l/g+xfGOFQ8/NqsDrgV8JgEdF3uoYdgIFeAeZsU2
        iLYADU215vq5jyKjslenFydzfHr2T1zJCLKLFYcOkpEKflEpns6EKfAJxtW0nyQJrGrDCn
        Vvh5OlJwuT3ppA4YwVzxsQA64PpnZoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-TD5H89abOp6-9wr6Ia7gdg-1; Wed, 01 Jul 2020 05:09:45 -0400
X-MC-Unique: TD5H89abOp6-9wr6Ia7gdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8898018A4;
        Wed,  1 Jul 2020 09:09:43 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAB8E71662;
        Wed,  1 Jul 2020 09:09:28 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/5] vhost-vdpa: refine ioctl pre-processing
Date:   Wed,  1 Jul 2020 17:08:35 +0800
Message-Id: <20200701090839.12994-2-jasowang@redhat.com>
In-Reply-To: <20200701090839.12994-1-jasowang@redhat.com>
References: <20200701090839.12994-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

