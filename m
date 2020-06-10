Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2EAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CAF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLQSIcIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFJLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:36:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728480AbgFJLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+SD3Vrt7U6HArLpzqOyIxuZrc1fS29Ei8HX5xaDKKOw=;
        b=BLQSIcINYY52GsObUIO7WMtgYTOnoCj01pX8QNWzOvfiPVkfbsO7LRP9DGuE1ORv3IX0Wi
        BQPpfsokyFGRRLkLHnytMFcjL71c9Vf6VBkGjSxZfEI9ElRq4IAsFmj5pUa+ZGUhpKspb0
        S/rqD4mMIcCoc3AXJooa2O4QU/Aho5M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-vCdvY337PLyhHRIuw4i3cw-1; Wed, 10 Jun 2020 07:36:12 -0400
X-MC-Unique: vCdvY337PLyhHRIuw4i3cw-1
Received: by mail-wr1-f71.google.com with SMTP id n6so968738wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+SD3Vrt7U6HArLpzqOyIxuZrc1fS29Ei8HX5xaDKKOw=;
        b=KWVGWKGoYWgHvi34tQ1N7Vv1VjAKLDos136tkNUzyRmSQJANlyRiS0/JGMWpxBEWR0
         NOuKNutY6qkSHIlmbbSfiCyc6IQpZZ3U20wfLzQaoA7Fp7uqgBQOwgv6FlnqKDnp7Uv2
         y7uN3hFJJ9O1yThlWMnOaKtn6JcV7cwSw4V7/j2oeDpS3ij0q6zKFwYHLLsEaRfnczFr
         DOYfW4R875SJCcyGcuEUTbbCJvVTANWLHGFbBlyw1QL/jhpuquiOXk26bVLaasF0Rk0u
         TZr4cKLHSWGFxa3jTM5KwFXkeItjoBWUrzN4Ao6t1okvCYb91DH503j0MyKMWMuUnFUo
         H2RA==
X-Gm-Message-State: AOAM530SmTJL14zOZL022n9wZDCUpbEf5XZtBs4xyLyFJIHLIoLGM35w
        k0OLdX++MNt/MmOLMR7tgBtarC+Mf0I2IKANZ4aPQAHMTSlVesPB6X0dUsE8P8wpBXOhoY7mIgi
        IY+jvAC2mJrItOKQgDbrHqUu3
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr2755085wmi.186.1591788970804;
        Wed, 10 Jun 2020 04:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxemEaCHMgCrHg7/oKSQ4yFnNXg1fLjZ5OHmMHvyeRIUoWRpQOB/0A8RO0HmZnjlr0fN5RKtA==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr2755070wmi.186.1591788970615;
        Wed, 10 Jun 2020 04:36:10 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id a1sm6866225wmd.28.2020.06.10.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:10 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 05/14] vhost: reorder functions
Message-ID: <20200610113515.1497099-6-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
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
 drivers/vhost/vhost.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 28f324fd77df..506208b63126 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2429,19 +2429,6 @@ void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
 }
 EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
 
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
@@ -2511,6 +2498,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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

