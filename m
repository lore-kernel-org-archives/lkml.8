Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD1C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB83420714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RtzcdxXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEKXcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbgEKXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:32:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB2C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b8so4570539plm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAOM+e7E09UCRtFcyL1Y8ySA2FJMAJp91jYWUtqelFM=;
        b=RtzcdxXFYwWt7VIJQ7CUWLMA2tfuSCdtpRvG/Ov6tYPy8QnIb2q2296TqkDm0D//cW
         HvQBnLISrV+I3ThF6CccbNt/akZafk7uSNnAjBeXcAXBhVy1XwBw5T3GO+LdvZfnVwMc
         duikki0L6PzZSK8MpfextPCShTX3WH/lSw2Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAOM+e7E09UCRtFcyL1Y8ySA2FJMAJp91jYWUtqelFM=;
        b=hmyQjSMYW0bk3TGT4eRBoGJA7SSVNvRmkidVxaLoXA0rkc4BbymndadLQrV3G+/Imy
         OMtZ5+kh5ik81tjgk+2QCglc3OWHotTGXVwhBeBpgTkyvudZjV9yJC4yZfsmYCwubtyy
         nOh92KzKKASERw06UgLmTftnc7uPBsPqYzgq4nlLOQnQuQ+9aj/oum+GtBS/PlMtYCZ2
         4kIg8zRDgLBuXZinW83I/EplFhZiEABFasPyILmM2dtywUkC/XhKyT8DHa8FGkGBx/vv
         wFNGkgFx3vsSlat7/57MpdxIqRP+0U9Y4kw7xeLZMiWqtJDWXIBYnNroy8E4ECsPD6qY
         M6Zw==
X-Gm-Message-State: AOAM530FuXAlTGxvmCk2meL+NFj6EehvBx83DnjgSSfJ1om2WZA4fdFo
        r+hreYc27Fd+sQCGqyQIepNInQ==
X-Google-Smtp-Source: ABdhPJy/VW1Qd7oiv/yX2J8VVrLBLlIqG3FBZdgdp8+t36dyUPXOIQFEjpNmo4hC/cJ26Lq+wRbLsg==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr4207650pla.99.1589239959859;
        Mon, 11 May 2020 16:32:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r31sm9010872pgl.86.2020.05.11.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:32:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v8 09/11] pstore/blk: Support non-block storage devices
Date:   Mon, 11 May 2020 16:32:27 -0700
Message-Id: <20200511233229.27745-10-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511233229.27745-1-keescook@chromium.org>
References: <20200511233229.27745-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WeiXiong Liao <liaoweixiong@allwinnertech.com>

Add support for non-block devices (e.g. MTD). A non-block driver calls
pstore_blk_register_device() to register iself.

In addition, pstore/zone is updated to handle non-block devices,
where an erase must be done before a write. Without this, there is no
way to remove records stored to an MTD.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-11-git-send-email-liaoweixiong@allwinnertech.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/pstore-blk.rst | 17 ++++-
 fs/pstore/blk.c                          | 94 +++++++++++++-----------
 fs/pstore/zone.c                         |  8 +-
 include/linux/pstore_blk.h               | 38 ++++++++++
 include/linux/pstore_zone.h              |  6 ++
 5 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index bef8c7436721..d45341e55e82 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -7,8 +7,8 @@ Introduction
 ------------
 
 pstore block (pstore/blk) is an oops/panic logger that writes its logs to a
-block device before the system crashes. You can get these log files by
-mounting pstore filesystem like::
+block device and non-block device before the system crashes. You can get
+these log files by mounting pstore filesystem like::
 
     mount -t pstore pstore /sys/fs/pstore
 
@@ -24,8 +24,8 @@ Configurations for user determine how pstore/blk works, such as pmsg_size,
 kmsg_size and so on. All of them support both Kconfig and module parameters,
 but module parameters have priority over Kconfig.
 
-Configurations for driver are all about block device, such as total_size
-of block device and read/write operations.
+Configurations for driver are all about block device and non-block device,
+such as total_size of block device and read/write operations.
 
 Configurations for user
 -----------------------
@@ -152,6 +152,15 @@ driver uses ``register_pstore_blk`` to register to pstore/blk.
 .. kernel-doc:: fs/pstore/blk.c
    :identifiers: register_pstore_blk
 
+A non-block device driver uses ``register_pstore_device`` with
+``struct pstore_device_info`` to register to pstore/blk.
+
+.. kernel-doc:: fs/pstore/blk.c
+   :identifiers: register_pstore_device
+
+.. kernel-doc:: include/linux/pstore_blk.h
+   :identifiers: pstore_device_info
+
 Compression and header
 ----------------------
 
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 95436cff8976..a1bd7c1fdfa0 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -105,55 +105,23 @@ struct bdev_info {
 	_##name_;						\
 })
 
-/**
- * struct pstore_device_info - back-end pstore/blk driver structure.
- *
- * @total_size: The total size in bytes pstore/blk can use. It must be greater
- *		than 4096 and be multiple of 4096.
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all backends for compatible.
- * @read:	The general read operation. Both of the function parameters
- *		@size and @offset are relative value to bock device (not the
- *		whole disk).
- *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but the following error number:
- *		-EBUSY means try to write again later.
- *		-ENOMSG means to try next zone.
- * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters are relative
- *		value to storage.
- *		On success, the number of bytes should be returned, others
- *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
- */
-struct pstore_device_info {
-	unsigned long total_size;
-	unsigned int flags;
-	pstore_zone_read_op read;
-	pstore_zone_write_op write;
-	pstore_zone_write_op panic_write;
-};
-
-static int psblk_register_do(struct pstore_device_info *dev)
+static int __register_pstore_device(struct pstore_device_info *dev)
 {
 	int ret;
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (WARN_ON(!mutex_is_locked(&pstore_blk_lock)))
 		return -EINVAL;
 
-	mutex_lock(&pstore_blk_lock);
+	if (!dev || !dev->total_size || !dev->read || !dev->write)
+		return -EINVAL;
 
 	/* someone already registered before */
-	if (pstore_zone_info) {
-		mutex_unlock(&pstore_blk_lock);
+	if (pstore_zone_info)
 		return -EBUSY;
-	}
+
 	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
-	if (!pstore_zone_info) {
-		mutex_unlock(&pstore_blk_lock);
+	if (!pstore_zone_info)
 		return -ENOMEM;
-	}
 
 	/* zero means not limit on which backends to attempt to store. */
 	if (!dev->flags)
@@ -179,6 +147,7 @@ static int psblk_register_do(struct pstore_device_info *dev)
 	pstore_zone_info->max_reason = max_reason;
 	pstore_zone_info->read = dev->read;
 	pstore_zone_info->write = dev->write;
+	pstore_zone_info->erase = dev->erase;
 	pstore_zone_info->panic_write = dev->panic_write;
 	pstore_zone_info->name = KBUILD_MODNAME;
 	pstore_zone_info->owner = THIS_MODULE;
@@ -188,20 +157,51 @@ static int psblk_register_do(struct pstore_device_info *dev)
 		kfree(pstore_zone_info);
 		pstore_zone_info = NULL;
 	}
+	return ret;
+}
+/**
+ * register_pstore_device() - register non-block device to pstore/blk
+ *
+ * @dev: non-block device information
+ *
+ * Return:
+ * * 0		- OK
+ * * Others	- something error.
+ */
+int register_pstore_device(struct pstore_device_info *dev)
+{
+	int ret;
+
+	mutex_lock(&pstore_blk_lock);
+	ret = __register_pstore_device(dev);
 	mutex_unlock(&pstore_blk_lock);
+
 	return ret;
 }
+EXPORT_SYMBOL_GPL(register_pstore_device);
 
-static void psblk_unregister_do(struct pstore_device_info *dev)
+static void __unregister_pstore_device(struct pstore_device_info *dev)
 {
-	mutex_lock(&pstore_blk_lock);
+	WARN_ON(!mutex_is_locked(&pstore_blk_lock));
 	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
 		unregister_pstore_zone(pstore_zone_info);
 		kfree(pstore_zone_info);
 		pstore_zone_info = NULL;
 	}
+}
+
+/**
+ * unregister_pstore_device() - unregister non-block device from pstore/blk
+ *
+ * @dev: non-block device information
+ */
+void unregister_pstore_device(struct pstore_device_info *dev)
+{
+	mutex_lock(&pstore_blk_lock);
+	__unregister_pstore_device(dev);
 	mutex_unlock(&pstore_blk_lock);
 }
+EXPORT_SYMBOL_GPL(unregister_pstore_device);
 
 /**
  * psblk_get_bdev() - open block device
@@ -399,9 +399,10 @@ static int __register_pstore_blk(struct pstore_blk_info *info)
 	dev.flags = info->flags;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
+	dev.erase = NULL;
 	dev.panic_write = info->panic_write ? psblk_blk_panic_write : NULL;
 
-	ret = psblk_register_do(&dev);
+	ret = __register_pstore_device(&dev);
 	if (ret)
 		goto err_put_bdev;
 
@@ -445,7 +446,7 @@ static void __unregister_pstore_blk(unsigned int major)
 
 	WARN_ON(!mutex_is_locked(&pstore_blk_lock));
 	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		psblk_unregister_do(&dev);
+		__unregister_pstore_device(&dev);
 		psblk_put_bdev(psblk_bdev, holder);
 		blkdev_panic_write = NULL;
 		psblk_bdev = NULL;
@@ -484,6 +485,13 @@ static void __exit pstore_blk_exit(void)
 	mutex_lock(&pstore_blk_lock);
 	if (psblk_bdev)
 		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
+	else {
+		struct pstore_device_info dev = { };
+
+		if (pstore_zone_info)
+			dev.read = pstore_zone_info->read;
+		__unregister_pstore_device(&dev);
+	}
 	mutex_unlock(&pstore_blk_lock);
 }
 module_exit(pstore_blk_exit);
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 110a38242f74..bd8e194110fc 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -661,15 +661,21 @@ static inline int psz_kmsg_erase(struct psz_context *cxt,
 	struct psz_buffer *buffer = zone->buffer;
 	struct psz_kmsg_header *hdr =
 		(struct psz_kmsg_header *)buffer->data;
+	size_t size;
 
 	if (unlikely(!psz_ok(zone)))
 		return 0;
+
 	/* this zone is already updated, no need to erase */
 	if (record->count != hdr->counter)
 		return 0;
 
+	size = buffer_datalen(zone) + sizeof(*zone->buffer);
 	atomic_set(&zone->buffer->datalen, 0);
-	return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	if (cxt->pstore_zone_info->erase)
+		return cxt->pstore_zone_info->erase(size, zone->off);
+	else
+		return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
 
 static inline int psz_record_erase(struct psz_context *cxt,
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 0c40774e71e0..61e914522b01 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -49,6 +49,44 @@ struct pstore_blk_info {
 int  register_pstore_blk(struct pstore_blk_info *info);
 void unregister_pstore_blk(unsigned int major);
 
+/**
+ * struct pstore_device_info - back-end pstore/blk driver structure.
+ *
+ * @total_size: The total size in bytes pstore/blk can use. It must be greater
+ *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
+ * @read:	The general read operation. Both of the function parameters
+ *		@size and @offset are relative value to bock device (not the
+ *		whole disk).
+ *		On success, the number of bytes should be returned, others
+ *		means error.
+ * @write:	The same as @read, but the following error number:
+ *		-EBUSY means try to write again later.
+ *		-ENOMSG means to try next zone.
+ * @erase:	The general erase operation for device with special removing
+ *		job. Both of the function parameters @size and @offset are
+ *		relative value to storage.
+ *		Return 0 on success and others on failure.
+ * @panic_write:The write operation only used for panic case. It's optional
+ *		if you do not care panic log. The parameters are relative
+ *		value to storage.
+ *		On success, the number of bytes should be returned, others
+ *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
+ */
+struct pstore_device_info {
+	unsigned long total_size;
+	unsigned int flags;
+	pstore_zone_read_op read;
+	pstore_zone_write_op write;
+	pstore_zone_erase_op erase;
+	pstore_zone_write_op panic_write;
+};
+
+int  register_pstore_device(struct pstore_device_info *dev);
+void unregister_pstore_device(struct pstore_device_info *dev);
+
 /**
  * struct pstore_blk_config - the pstore_blk backend configuration
  *
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index e79a18e41064..1e35eaa33e5e 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -7,6 +7,7 @@
 
 typedef ssize_t (*pstore_zone_read_op)(char *, size_t, loff_t);
 typedef ssize_t (*pstore_zone_write_op)(const char *, size_t, loff_t);
+typedef ssize_t (*pstore_zone_erase_op)(size_t, loff_t);
 /**
  * struct pstore_zone_info - pstore/zone back-end driver structure
  *
@@ -27,6 +28,10 @@ typedef ssize_t (*pstore_zone_write_op)(const char *, size_t, loff_t);
  * @write:	The same as @read, but the following error number:
  *		-EBUSY means try to write again later.
  *		-ENOMSG means to try next zone.
+ * @erase:	The general erase operation for device with special removing
+ *		job. Both of the function parameters @size and @offset are
+ *		relative value to storage.
+ *		Return 0 on success and others on failure.
  * @panic_write:The write operation only used for panic case. It's optional
  *		if you do not care panic log. The parameters are relative
  *		value to storage.
@@ -45,6 +50,7 @@ struct pstore_zone_info {
 	unsigned long ftrace_size;
 	pstore_zone_read_op read;
 	pstore_zone_write_op write;
+	pstore_zone_erase_op erase;
 	pstore_zone_write_op panic_write;
 };
 
-- 
2.20.1

