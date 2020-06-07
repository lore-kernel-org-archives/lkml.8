Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F092C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D276206A4
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWEwTjyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgFGOLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:11:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbgFGOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591539101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp6BO12ZdY311uANoeiTSpiBXoC9bVPHS+5RWfNAiPw=;
        b=aWEwTjypIXyku/geRCCP71LGFIRv2DGCeTDLsO48bc2T4HbowCD6qxvo1jqG0ko9qcAE3w
        PX2QKc9FopTnNEsRS6vTBHTAfECpdN9ipGZOQ42H85SXtjk4vv0zvtZGYwR3Gv0iwlFNI+
        +MpqWLMTYb9J3V+vXtReLd2ZeE1qXqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-7sViJShFPx-UbmLD6bGYFA-1; Sun, 07 Jun 2020 10:11:39 -0400
X-MC-Unique: 7sViJShFPx-UbmLD6bGYFA-1
Received: by mail-wr1-f72.google.com with SMTP id r5so6065595wrt.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wp6BO12ZdY311uANoeiTSpiBXoC9bVPHS+5RWfNAiPw=;
        b=B8PyxZkrivbneQl8JXIKxrirrJuPRHCwJjz4DUWbDHTlX/zLSBusxobLTYZxgoiqD5
         ZY+JFnfXv4/kbxkpaU7403KA+EVP1orpmXQkm8Pf19LjazvMlXRLnwdXRheoMZPtM73f
         Vk6H5fXVANB5guhOUfx61BQno0JapKm0lUEOPVV+tfHqASr7AC/IJSr9DMxyN6sLRLfP
         5bCpMhnMQrl7hLVp+ZHNjMnUs0l/Qj3q02cCx+z+IGqHpnaiuVYVaopGHNqSfn7GB+WQ
         N7ESmOHg6wF6ChrZp4ZLjHX1fDx/mX/SnZbsJxLn+QxJhTGjq1O2BprOIIKKn8oTzGXk
         zOew==
X-Gm-Message-State: AOAM530E2W3Rxhue/PgnKbyLMwfxcOQipu4oR7GyvPYpRhEP4nxwE5XV
        M6hsqDjUDCsghpgzy5efAilzN6nB0OhQYg3bMzFRXv7dm1Uh56D1pBHb2ZVOlQf71ejk86WKVUQ
        09QZvDiDyC8yDGQeHQLQn7FbQ
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr11194105wmg.63.1591539098285;
        Sun, 07 Jun 2020 07:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFt8FJP6Ka1KJy2iQ809xCaM+/JyNuAYCSvk8oDmutDU4mYkXzFPpUiOv4ag1sD+vroAfCPA==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr11194090wmg.63.1591539098051;
        Sun, 07 Jun 2020 07:11:38 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id o10sm18638815wrq.40.2020.06.07.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:11:37 -0700 (PDT)
Date:   Sun, 7 Jun 2020 10:11:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v5 06/13] vhost: reorder functions
Message-ID: <20200607141057.704085-7-mst@redhat.com>
References: <20200607141057.704085-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607141057.704085-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder functions in the file to not rely on forward
declarations, in preparation to making them static
down the road.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5075505cfe55..3ffcba4e27e9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2299,6 +2299,13 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	return 1;
 }
 
+/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
+void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
+{
+	vq->last_avail_idx -= n;
+}
+EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
+
 /* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
  * A negative code is returned on error. */
 static int fetch_descs(struct vhost_virtqueue *vq)
@@ -2413,26 +2420,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
-/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
-void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
-{
-	vq->last_avail_idx -= n;
-}
-EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
-
-/* After we've used one of their buffers, we tell them about it.  We'll then
- * want to notify the guest, using eventfd. */
-int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
-{
-	struct vring_used_elem heads = {
-		cpu_to_vhost32(vq, head),
-		cpu_to_vhost32(vq, len)
-	};
-
-	return vhost_add_used_n(vq, &heads, 1);
-}
-EXPORT_SYMBOL_GPL(vhost_add_used);
-
 static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 			    struct vring_used_elem *heads,
 			    unsigned count)
@@ -2502,6 +2489,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 }
 EXPORT_SYMBOL_GPL(vhost_add_used_n);
 
+/* After we've used one of their buffers, we tell them about it.  We'll then
+ * want to notify the guest, using eventfd. */
+int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
+{
+	struct vring_used_elem heads = {
+		cpu_to_vhost32(vq, head),
+		cpu_to_vhost32(vq, len)
+	};
+
+	return vhost_add_used_n(vq, &heads, 1);
+}
+EXPORT_SYMBOL_GPL(vhost_add_used);
+
 static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
 	__u16 old, new;
-- 
MST

