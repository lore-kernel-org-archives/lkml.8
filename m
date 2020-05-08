Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386E4C54E4B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0204B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GaJEM+QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgEHGkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727911AbgEHGkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3681C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:40:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so310334plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQ8iuBnrPJHtPbltoUb8KoZQTLwe64a2ZrGNzrFbN1I=;
        b=GaJEM+QY8qeX6iTk/8QSQyP55GWYmf6/2sp1oEr6L36PlTBaTfiKGUKHh76UKP9YOT
         Lq8h9ORdnvJfe925f9PETouF0qRc2Whtrm+R06i/DjzxFPZzOVXV8k9lb2/4JHg30Aao
         RK9ZH9d/rVzz2ito56sVCfV6x7tEqvPQwpXRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQ8iuBnrPJHtPbltoUb8KoZQTLwe64a2ZrGNzrFbN1I=;
        b=Bclz9n66lnOE843PV8Mgd1PUrHKODNhIdZ74GoynX1y7TGI2c1PUKgqVkp3dpxX6tU
         zSu9ZgPs1wkN6VKTDYCA/IVPhP9MAWMN8M95/TepumlXBmW8rga+ZEBfiMeDvhqV0lXs
         aLDT3F/DceNNx1pOVhl+aPjLoXPEQn8U6Dk1w46LlTkey4whqm4fFjCfY4VuOrNvc6G8
         d+z/IVlVNqY6jbmJPIbIqYGbD3jjlFKFCoXbgym88RBoqLN1FAlsOHJX9MgeB7j0NCu2
         UHiInTh8+JNyXLhrpDvnMYf7Aj/1PZadngFQyXL4dtVoy5aoXjbZtIb2Qb93mVehC30R
         U5IQ==
X-Gm-Message-State: AGi0PuaXfsUsVL7/UcCvRXN+VfauJCfnk35Hx5Ev09XbM3Qy/OmusOpm
        XZiuChMQDv4nZ7BHuh7if/OMig==
X-Google-Smtp-Source: APiQypLEkdWrSxjkfGa8qfOkq3bs8pd0jxnbvVxesOUsSNXi5FlPbxh2hBRWPWjPDWCTaONqPSAZ/w==
X-Received: by 2002:a17:90a:24e7:: with SMTP id i94mr4691725pje.117.1588920022384;
        Thu, 07 May 2020 23:40:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm1487715pjr.17.2020.05.07.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:40:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] pstore/blk: Support non-block storage devices
Date:   Thu,  7 May 2020 23:40:03 -0700
Message-Id: <20200508064004.57898-12-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508064004.57898-1-keescook@chromium.org>
References: <20200508064004.57898-1-keescook@chromium.org>
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
 Documentation/admin-guide/pstore-blk.rst | 17 ++++++--
 fs/pstore/blk.c                          | 52 +++++++++---------------
 fs/pstore/zone.c                         |  8 +++-
 include/linux/pstore_blk.h               | 37 +++++++++++++++++
 include/linux/pstore_zone.h              |  6 +++
 5 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 484a1502fb49..2f3602397715 100644
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
@@ -152,6 +152,15 @@ driver uses ``psblk_register_blkdev`` to register to pstore/blk.
 .. kernel-doc:: fs/pstore/blk.c
    :identifiers: psblk_register_blkdev
 
+A non-block device driver uses ``psblk_register_device`` with
+``struct psblk_device`` to register to pstore/blk.
+
+.. kernel-doc:: fs/pstore/blk.c
+   :identifiers: psblk_register_device
+
+.. kernel-doc:: include/linux/pstore_blk.h
+   :identifiers: psblk_device
+
 Compression and header
 ----------------------
 
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index c6d99d5dcd7f..a736555e1ed3 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -98,36 +98,15 @@ static struct bdev_info {
 })
 
 /**
- * struct psblk_device - back-end pstore/blk driver structure.
+ * psblk_register_device() - register non-block device to pstore/blk
  *
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
+ * @dev: non-block device information
+ *
+ * Return:
+ * * 0		- OK
+ * * Others	- something error.
  */
-struct psblk_device {
-	unsigned long total_size;
-	unsigned int flags;
-	psz_read_op read;
-	psz_write_op write;
-	psz_write_op panic_write;
-};
-
-static int psblk_register_do(struct psblk_device *dev)
+int psblk_register_device(struct psblk_device *dev)
 {
 	int ret;
 
@@ -170,6 +149,7 @@ static int psblk_register_do(struct psblk_device *dev)
 	pstore_zone_info->max_reason = max_reason;
 	pstore_zone_info->read = dev->read;
 	pstore_zone_info->write = dev->write;
+	pstore_zone_info->erase = dev->erase;
 	pstore_zone_info->panic_write = dev->panic_write;
 	pstore_zone_info->name = MODNAME;
 	pstore_zone_info->owner = THIS_MODULE;
@@ -182,8 +162,14 @@ static int psblk_register_do(struct psblk_device *dev)
 	mutex_unlock(&psz_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(psblk_register_device);
 
-static void psblk_unregister_do(struct psblk_device *dev)
+/**
+ * psblk_unregister_blkdev() - unregister block device from pstore/blk
+ *
+ * @dev: non-block device information
+ */
+void psblk_unregister_device(struct psblk_device *dev)
 {
 	mutex_lock(&psz_lock);
 	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
@@ -193,6 +179,7 @@ static void psblk_unregister_do(struct psblk_device *dev)
 	}
 	mutex_unlock(&psz_lock);
 }
+EXPORT_SYMBOL_GPL(psblk_unregister_device);
 
 /**
  * psblk_get_bdev() - open block device
@@ -406,11 +393,12 @@ int psblk_register_blkdev(unsigned int major, unsigned int flags,
 
 	dev.total_size = psblk_bdev_size(bdev);
 	dev.flags = flags;
-	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
+	dev.erase = NULL;
+	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 
-	ret = psblk_register_do(&dev);
+	ret = psblk_register_device(&dev);
 	if (ret)
 		goto err_put_bdev;
 
@@ -436,7 +424,7 @@ void psblk_unregister_blkdev(unsigned int major)
 	void *holder = blkdev;
 
 	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		psblk_unregister_do(&dev);
+		psblk_unregister_device(&dev);
 		psblk_put_bdev(psblk_bdev, holder);
 		blkdev_panic_write = NULL;
 		psblk_bdev = NULL;
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 43d44d016039..df5ce54eb7ea 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -652,15 +652,21 @@ static inline int psz_oops_erase(struct psz_context *cxt,
 	struct psz_buffer *buffer = zone->buffer;
 	struct psz_oops_header *hdr =
 		(struct psz_oops_header *)buffer->data;
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
index dd5213044e21..43242e343dad 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -7,6 +7,41 @@
 #include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
+/**
+ * struct psblk_device - back-end pstore/blk driver structure.
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
+struct psblk_device {
+	unsigned long total_size;
+	unsigned int flags;
+	psz_read_op read;
+	psz_write_op write;
+	psz_erase_op erase;
+	psz_write_op panic_write;
+};
+
 /**
  * typedef psblk_panic_write_op - panic write operation to block device
  *
@@ -22,6 +57,8 @@
 typedef int (*psblk_panic_write_op)(const char *buf, sector_t start_sect,
 		sector_t sects);
 
+int psblk_register_device(struct psblk_device *dev);
+void psblk_unregister_device(struct psblk_device *dev);
 int  psblk_register_blkdev(unsigned int major, unsigned int flags,
 		psblk_panic_write_op panic_write);
 void psblk_unregister_blkdev(unsigned int major);
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index ddb3dfea4ea6..2c031a25ee5f 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -7,6 +7,7 @@
 
 typedef ssize_t (*psz_read_op)(char *, size_t, loff_t);
 typedef ssize_t (*psz_write_op)(const char *, size_t, loff_t);
+typedef ssize_t (*psz_erase_op)(size_t, loff_t);
 /**
  * struct pstore_zone_info - pstore/zone back-end driver structure
  *
@@ -27,6 +28,10 @@ typedef ssize_t (*psz_write_op)(const char *, size_t, loff_t);
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
 	psz_read_op read;
 	psz_write_op write;
+	psz_erase_op erase;
 	psz_write_op panic_write;
 };
 
-- 
2.20.1

