Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2947206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGb8xCng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgFBNHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:07:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgFBNGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Doki9eOY+Vt0bEelnsffrGLeK+qhziALFfS1p6mljA=;
        b=HGb8xCngIiZe/j2BliUuxEjIqDNo4lUe3nBLSmz+sh45Ww7GtTj8Lnm5nh6f4KlkYRLdI9
        99o0ydvdkNNU8ZPxvQv2xbmJQAxLOSKsNjlxqflgoFpCXOtUZYXwtyWqfS0npw9IPQUrPO
        TwIa5l4zlncovlf3wGWZXrVrjash8Os=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-LgtUoKt9PnWpykxAHIZV8g-1; Tue, 02 Jun 2020 09:06:12 -0400
X-MC-Unique: LgtUoKt9PnWpykxAHIZV8g-1
Received: by mail-wr1-f70.google.com with SMTP id n6so1381500wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Doki9eOY+Vt0bEelnsffrGLeK+qhziALFfS1p6mljA=;
        b=qDjm4cSc1v8BM3OOycR/diL1Zlep9XW4/rIMWzP19nTsfN3JqW+ujjoMvLHmKbCkGi
         ohU+HZ5WWOt6J33gp0jHZTIbhqyVEQXehRiuFLR0TK+KmscvfH/IFuXfxMUyi2PgXBwr
         2rHpm7QNFIqaVy71eZ8YUKhoL/DU+uH0sFPPjk22BGSb6RBBnC9vhaotR8H0VJWQ7hWF
         hH4riWfFRw2PdQUW4SoORGVonu0pArvzBREioYYyBo2fD/wsbAwJfwIWGql1dBCde+G1
         lJl7drlAbam0w2cPzpZYBZ5FbC5XgYqJDxS/mIrR+dQhN3ApRIhaibbJjyWnscVNMYgX
         mxTw==
X-Gm-Message-State: AOAM531KoXWzg07q1/BjoXCpCQWLh26Cn4BG4ALeXhKKDiT+r44RLeMS
        AqSfAcZE/lfZkwZDqLjRO0Z+AZbRb/rpUneTQIuPRY6XZpPB7nK67iR38yfXDHkgDY09ZKH6WtL
        U+vbwndALUT46DC3ax0TldL9J
X-Received: by 2002:adf:d852:: with SMTP id k18mr11135188wrl.177.1591103170687;
        Tue, 02 Jun 2020 06:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze7fjrtd3HAxuSDspGJm8TtOVdc3+cTfx7SISy8qbvd/4VQ9hQeFCUsVzEXG1sYbQZL/2f6g==
X-Received: by 2002:adf:d852:: with SMTP id k18mr11135174wrl.177.1591103170498;
        Tue, 02 Jun 2020 06:06:10 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id k14sm3631200wrq.97.2020.06.02.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:10 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 06/13] vhost: reorder functions
Message-ID: <20200602130543.578420-7-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
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
index bd52b44b0d23..b4a6e44d56a8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2256,6 +2256,13 @@ static int fetch_buf(struct vhost_virtqueue *vq)
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
@@ -2370,26 +2377,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
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
@@ -2459,6 +2446,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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

