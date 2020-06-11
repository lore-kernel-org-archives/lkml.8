Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD39C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A480A2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAyFciqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFKLfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:35:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21294 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728009AbgFKLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591875271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQeTVzMxKn8MhUVbsXHw7bWDPyusaDacrq6kngKNb/s=;
        b=IAyFciqIRCFT+Y3sxrzN1KnvSNsYLnLT7N2IxGhqVOvH0CzMUFbrkg6pq+cc1IpArMFfEe
        3YH5Tlale4b2YVIJk6LUoDJkv7WB+06v3HMDZOSbCvqNcMd7AdID9Kg2E0nDAEZFkaBpR3
        feGdD/piN3RsNRzluX+wH82lRueRzQs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-GOhMdGAMP7O6LeZpHXd62A-1; Thu, 11 Jun 2020 07:34:27 -0400
X-MC-Unique: GOhMdGAMP7O6LeZpHXd62A-1
Received: by mail-wr1-f70.google.com with SMTP id p9so2458551wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQeTVzMxKn8MhUVbsXHw7bWDPyusaDacrq6kngKNb/s=;
        b=pTydj0qBaKLpIryl2itmDOYVODfk42bOl5WideJpxuydC049gD+/1vH/koaAQGkJy2
         voUMSZ2fcXdlcvlAQsuMiWRk7KFPIQ+O6j613m41ho2RM8bfPRkw9ifbH3PFc1wmnrUt
         SUSj7KncfuzA8ZEB+MXva5NYmKSovgv+/bI2+qzlVMlMJ+rnpM2qtQYuDgHe12J/kgNz
         g+mjQdmKATJsuaFIJnCxaT8AGC2CO/XzfcmIUl76wCoZzed19SieEAqC6g6CZmbqlTga
         +/9CQoSjUIC8QLbMaasAp/TezNF3khxMj6J57ojCah2KPK/kE5FSAoEYQRT8rNeHS2tH
         aN/A==
X-Gm-Message-State: AOAM532807+pYiaaUAaa2g35g9A+UxivUa/cwMlPVdxgu7DUI4Ii5lyd
        ouCzAGZ8r8KFhfYnv5zq17BnXda2OhC4enP/z7zwhyp6Tb0lKMcUDFNJxoLdO6JZbHdbra9K43S
        MqIkZejnR0brA4WYj6DCvextI
X-Received: by 2002:adf:f450:: with SMTP id f16mr9149829wrp.307.1591875266440;
        Thu, 11 Jun 2020 04:34:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu4RmLScea2SydO/nk/Zqnhh0evcgLZ860ln0HWt26ptj8Of6uBtznoHEKq49OIRHfJG06rw==
X-Received: by 2002:adf:f450:: with SMTP id f16mr9149807wrp.307.1591875266209;
        Thu, 11 Jun 2020 04:34:26 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id w3sm4155571wmg.44.2020.06.11.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:34:25 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:34:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v8 04/11] vhost: reorder functions
Message-ID: <20200611113404.17810-5-mst@redhat.com>
References: <20200611113404.17810-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611113404.17810-1-mst@redhat.com>
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
index dfcdb36d4227..c38605b01080 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2425,19 +2425,6 @@ void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
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
@@ -2507,6 +2494,19 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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

