Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344BF22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnTYdDYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgHCVAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729184AbgHCVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
        b=WnTYdDYxPKp6oAPtSzTSvnboND3Bp8Iuo/UmKGuEBfv8Zn5lh0hMwOF3n4cEnWPgB275Ah
        iclfRv4PCCEgDw6ddodkpyDFv3A6Aqucwnl8jc4umvRNe/nUeRpXIc1F5xDGvUTRPC9mmD
        xdkIASkDNccOWYN1Z0n9wA5z3clPknc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-fno5GQIgNQKnkjiW84vZLQ-1; Mon, 03 Aug 2020 17:00:12 -0400
X-MC-Unique: fno5GQIgNQKnkjiW84vZLQ-1
Received: by mail-qt1-f198.google.com with SMTP id m13so8900390qth.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
        b=AqNIjgxFgQeEZushi6BSacU+oTCuB8f/cmtn9/iGedOrpNfAxy/djpcGQ0Ral0ffZw
         G0AWycEAhYjg3RIN16ZuE5fSCut2aW/0YZfSRDX2mhp/Xs8wMXBDCW0J4I7IkUPeO0qb
         A6EJexcTIR0LDqurfQPi6rsB+6Nxn8IsJjnDZgNMXwzi1DVeON3QrJRnHEPcsmYvfioY
         3FTAfuGTGbPLAupYU8n/SifFnr1XmJWLl2MH7C7KcvlvAUXImHVVcfAaTlykkFGZ9wWA
         FMsR4onJxit8GSIRgyK4PaittMByAbZfxQN/MK6aVWCMQLBawYLk9FBJSu8D/U0du2K5
         DzaQ==
X-Gm-Message-State: AOAM532WHngZYEFbtfUKBhwHOnSRncWWxH7kuFf9s0QIKXoMfht/vhkE
        MoSd8zt4a3hcmmITjfNI1NE9reiWTBCJlfKX/7SX0sMx12qmz0CN2BRRfh+fS4G1agZRD31G2B/
        J4KQBFB51Bc8QPe01vjs3Uhbu
X-Received: by 2002:ac8:6f4a:: with SMTP id n10mr19336695qtv.363.1596488411243;
        Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsw+1IlRfJnIjdEoKs3Vv6bLSmRyUcD4mlV2rqAS2EYVV9QWgDpoODTZA6ZKFejWTRYJGpxQ==
X-Received: by 2002:ac8:6f4a:: with SMTP id n10mr19336681qtv.363.1596488411014;
        Mon, 03 Aug 2020 14:00:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id a67sm14259023qkd.40.2020.08.03.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:10 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 19/24] vdpa: make sure set_features in invoked for legacy
Message-ID: <20200803205814.540410-20-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some legacy guests just assume features are 0 after reset.
We detect that config space is accessed before features are
set and set features to 0 automatically.
Note: some legacy guests might not even access config space, if this is
reported in the field we might need to catch a kick to handle these.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa.c  |  1 +
 include/linux/vdpa.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index de211ef3738c..7105265e4793 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -96,6 +96,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->dev.release = vdpa_release_dev;
 	vdev->index = err;
 	vdev->config = config;
+	vdev->features_valid = false;
 
 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 239db794357c..29b8296f1414 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -33,12 +33,14 @@ struct vdpa_notification_area {
  * @dma_dev: the actual device that is performing DMA
  * @config: the configuration ops for this device.
  * @index: device index
+ * @features_valid: were features initialized? for legacy guests
  */
 struct vdpa_device {
 	struct device dev;
 	struct device *dma_dev;
 	const struct vdpa_config_ops *config;
 	unsigned int index;
+	bool features_valid;
 };
 
 /**
@@ -266,4 +268,36 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 {
 	return vdev->dma_dev;
 }
+
+static inline void vdpa_reset(struct vdpa_device *vdev)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	vdev->features_valid = false;
+        ops->set_status(vdev, 0);
+}
+
+static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	vdev->features_valid = true;
+        return ops->set_features(vdev, features);
+}
+
+
+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
+				   void *buf, unsigned int len)
+{
+        const struct vdpa_config_ops *ops = vdev->config;
+
+	/*
+	 * Config accesses aren't supposed to trigger before features are set.
+	 * If it does happen we assume a legacy guest.
+	 */
+	if (!vdev->features_valid)
+		vdpa_set_features(vdev, 0);
+	ops->get_config(vdev, offset, buf, len);
+}
+
 #endif /* _LINUX_VDPA_H */
-- 
MST

