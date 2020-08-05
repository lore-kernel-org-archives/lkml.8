Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70174C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4132C22D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8sCBIB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHERNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:13:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728559AbgHERKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
        b=C8sCBIB8koQQBJs69vWnY1GFSHtyqjROcUyFz6G49daEogKZ0xbfoMUklv+yUpG8pMyLUx
        DjixIMJ9q0hPUEnuoQwbc/VNDftWCInFX9iuOXeaQ5S65neE3GMJWc9c/kdY6oCj6qgy8+
        AwoidGTmEhpR7c1CVJx/e9NnTA39e9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-A56U8EkVM2mbqxCLBLABVQ-1; Wed, 05 Aug 2020 09:44:12 -0400
X-MC-Unique: A56U8EkVM2mbqxCLBLABVQ-1
Received: by mail-wm1-f71.google.com with SMTP id c124so2474737wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXTzwQncFETdoKYzPm5tvIQfmxAfJtNu07ODUBYdb0E=;
        b=Ll8RueJlQQMN8XtN+f/i7TNg4SOeBRv2Ans2GLaeaNtd/+xKy1zanI11hCINsEljfL
         iRmzI8IM9d0iKZ/UTwRDjHmNxVINbllRzPeyT3ywjRwmarV2bqPxv8osVFSHvIvTdPeq
         +FM997J72+dE2pNurXvuVPglp7kuh2YzyNEoJKwXj3zhNUG3ajLmmnyO5F6s3jkTKkup
         E614pkZ3gAt6W7nuj2v7Cre/X1Xq0BlE2DBld/17IVmkRKyEKTcW151gZcnsDSr8ClrK
         9xGY6U0JdeLjT79OS1/PSPENDRv0y71C4uBybAchaA5SIeZrPj5MDEPnRXwotAIcvt/L
         wu3Q==
X-Gm-Message-State: AOAM533FdeK13Pyu1qanIreqNSzl601VpS0yG2d6WiVcx6l2zgirNmMR
        SZNQXg+KeVB8YvvpjEhgxfm+x9BDLnwixYL/2pRaLEmrsw+fQpyYGiRnPXR0khRGcWk5hgUWLHb
        O45pF4O2zxQ+LckENqhg5/6Jv
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr2874752wrn.100.1596635050288;
        Wed, 05 Aug 2020 06:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN15n3nk3moRyvVlKfo0eUXQqSTsa3wGWLzNDiCq5dlFLmjNv9TM2NLycLh5wHgFYsktf9nw==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr2874729wrn.100.1596635049955;
        Wed, 05 Aug 2020 06:44:09 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id l11sm2746431wme.11.2020.08.05.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:09 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 19/38] vdpa: make sure set_features is invoked for legacy
Message-ID: <20200805134226.1106164-20-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
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

