Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A288C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0980C2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCrjBrfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgFHMxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:53:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729315AbgFHMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YC9C1bg85UqEARLoLzVVH0wVxPzUMhgdZVeMnCOVW8I=;
        b=KCrjBrfLVNFyNFezKDnDkNlxulhi047ODlNDYk3hoAhno1+yytKWqCvVWob51+RzPc9zyq
        t8x/s5HATbM1TmuKZSNzson8lFZq4BwyPsogvLGJKOCnUsD8bndSeVtHlusxBG2Y0l2spQ
        7ctfkpKPkXS6V9XB7u8xFXPFhQyj/YM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-QsDDDPbyOvGiw2YlXDrFRA-1; Mon, 08 Jun 2020 08:53:03 -0400
X-MC-Unique: QsDDDPbyOvGiw2YlXDrFRA-1
Received: by mail-wm1-f72.google.com with SMTP id y15so913669wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YC9C1bg85UqEARLoLzVVH0wVxPzUMhgdZVeMnCOVW8I=;
        b=K8FVkij+DA/eix06ph77xRDHhSTwmeEmFtb97EAItE3rarn335kmZSQZiQpInnsnHX
         7BitXdp70jqhD1pAuS7vuEyEcjysrUQLdSEWIZg6ZsbLXPqSXN9TCRyoee8pbTwifQpo
         2vd7rK+zt7fsnye6SJXHaF1TPmrPZ8XmfIMCHVdtC7TCqO584FR4FVyszx2pbqWRj9H0
         x8nPH0yvOwMN828t5EbE2x+6OTfcIsljz+WJr4Gbs5tecHVuEAnlsoV6s/AqY+HUMvu5
         phjjAO4TzNCeVtI7kiEIYi37XmFLXwE6H/2SdEkhfaxjE6N8pxSc9Q9WXlGVZcMP580P
         Y7aA==
X-Gm-Message-State: AOAM530riRguz+ljKEHzRY4a5lOGJ6R5cTzmW+xSFfqUrDYknWT44yM9
        H5EXkew/XX7J7/azo4rX7Bb27/EEq0rLMmftER+FtkX3JBmG11SpZLwlIV8ThA1VbHBMC8wE/kR
        s/ym3ELRmjmq3h4MjPGEU531w
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr15634968wmb.61.1591620782175;
        Mon, 08 Jun 2020 05:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycvWcSZ9pgrB8OOPKZQyruJy8vStQkFo1WrrMhroFInHbRmdrcF8cq2oRf/qnvmhPPXJjLnQ==
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr15634952wmb.61.1591620781966;
        Mon, 08 Jun 2020 05:53:01 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id r12sm23319300wrc.22.2020.06.08.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:53:01 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:53:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v6 04/11] vhost: reorder functions
Message-ID: <20200608125238.728563-5-mst@redhat.com>
References: <20200608125238.728563-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125238.728563-1-mst@redhat.com>
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
 drivers/vhost/vhost.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 41d6b132c234..334529ebecab 100644
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

