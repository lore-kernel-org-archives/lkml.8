Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73732C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C6B21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glMUQ8wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBEQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:34:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726359AbgBEQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580920461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcRyPB3D16FS1hVzLFRfsL6mac9y5ECi0rwpQjWwHMc=;
        b=glMUQ8wRYstOwtkmh9gjNAAGRhE0s7JSIXCq+xEJcPm96Wk25rGa8PwpO6acfWnrB4k3dW
        PDZ35ZnMI5H0mLVt77OYeAt4O6/NnHN5vWXQVGAAswpeY0/fcNzw7wFRCnY4kB7Hfl0LDL
        0llhwz2yMg/xC7lCCSHUNB2uNHPnNds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-vcLuwmAEPOubLDhojSHGcg-1; Wed, 05 Feb 2020 11:34:16 -0500
X-MC-Unique: vcLuwmAEPOubLDhojSHGcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706BA8018B7;
        Wed,  5 Feb 2020 16:34:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA5D91001B08;
        Wed,  5 Feb 2020 16:34:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>
Subject: [PATCH v1 2/3] virtio_balloon: Fix memory leaks on errors in virtballoon_probe()
Date:   Wed,  5 Feb 2020 17:34:01 +0100
Message-Id: <20200205163402.42627-3-david@redhat.com>
In-Reply-To: <20200205163402.42627-1-david@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to put the inode and unmount the kernfs used for compaction.

Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Liang Li <liang.z.li@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index abef2306c899..7e5d84caeb94 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -901,8 +901,7 @@ static int virtballoon_probe(struct virtio_device *vd=
ev)
 	vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
 	if (IS_ERR(vb->vb_dev_info.inode)) {
 		err =3D PTR_ERR(vb->vb_dev_info.inode);
-		kern_unmount(balloon_mnt);
-		goto out_del_vqs;
+		goto out_kern_unmount;
 	}
 	vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
 #endif
@@ -913,13 +912,13 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
 		 */
 		if (virtqueue_get_vring_size(vb->free_page_vq) < 2) {
 			err =3D -ENOSPC;
-			goto out_del_vqs;
+			goto out_iput;
 		}
 		vb->balloon_wq =3D alloc_workqueue("balloon-wq",
 					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 		if (!vb->balloon_wq) {
 			err =3D -ENOMEM;
-			goto out_del_vqs;
+			goto out_iput;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
 		vb->cmd_id_received_cache =3D VIRTIO_BALLOON_CMD_ID_STOP;
@@ -953,6 +952,12 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
 out_del_balloon_wq:
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
+out_iput:
+#ifdef CONFIG_BALLOON_COMPACTION
+	iput(vb->vb_dev_info.inode);
+out_kern_unmount:
+	kern_unmount(balloon_mnt);
+#endif
 out_del_vqs:
 	vdev->config->del_vqs(vdev);
 out_free_vb:
--=20
2.24.1

