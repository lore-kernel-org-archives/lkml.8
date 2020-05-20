Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB12C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2405C2081A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNNAVtaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgETDsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgETDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:48:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE90C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so621875ybn.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BiH7ch5fHybcnoIDBLcuc4z5e2hLWJngfJgPQOT+vX4=;
        b=hNNAVtaMBVXW5HxIH1NLIoMs3K2lqDkT1olTcYH3WuSYtQ5Aa7ZU1oolWkmMxB5b9U
         zj+vd1KZKxhW4e/MXNG2Y4UfZ0gz1rpJv7I5QmRYdTMw9PH6sX3Q56X1wM3FVM6Piu2o
         TVLMNVBj9J6XUGUOkQnItXlHYZAdm6NKwIgcZqUUz/6fc7dt59nKs4h5iI1hZTkULolx
         SDUWvUpBrTDVGKNwnKhXpfb1/LWRueEX16CiZJpQiCva2p679WZapsF9tLLCbJkmFw98
         x2SnaGlcgAQRptFsHERfPtyN4bAdxKZC7DcI+K+qWqKQv+TNzL2UdWFAcue8y8TUjfNJ
         Erzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiH7ch5fHybcnoIDBLcuc4z5e2hLWJngfJgPQOT+vX4=;
        b=pZ32SuLwuASYh2LVLKEO5x2g91PGTpxzIAdG5PYa5tgTepFyCYX3dvL1DRB/TVHyh/
         qgvK5HznZD7iZwU9GfijgJrmStU3dCp8btH5XzP3t6GZ4GE7XrWPG/JSkJyOo71z3h85
         qA+xHPjY2+pbO7qQOnncWarqlfOlXf9Ai1eP4y6NOzTozpqC36wTPV3AK1HOeOFkpNgS
         EAJxMtDBiuTXYCAfV+eXGyYpNfYpka2s0c27AUQwCla7jJ5xJvP/yGvSPYjFaHJR9jyI
         A2hBu9mxIh0BQ1PTOk9ro84hT7Rs/E/YidFx8udhi3RpFC7OlvEXsMkMVB1lzD2HoeGL
         AY9Q==
X-Gm-Message-State: AOAM531MCG5Tvmc4dqRKSs9+PzgUc8nTfqn8aF6+er6S+20Pof34FrsT
        g8dWXmKTfeEKTLDVLpebPU5f28FT9zrrMg0=
X-Google-Smtp-Source: ABdhPJx8QBCtvuhyVUSSQyOMhYVO+SzLCZO/nGk/HsZuwYNI0MZWl7pkaJ3nG6b+AGZvqN8N3gpHJtX6Kk8O7qg=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr4576712ybt.73.1589946518755;
 Tue, 19 May 2020 20:48:38 -0700 (PDT)
Date:   Tue, 19 May 2020 20:48:24 -0700
In-Reply-To: <20200520034824.79049-1-saravanak@google.com>
Message-Id: <20200520034824.79049-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200520034824.79049-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 4/4] driver core: Add waiting_for_supplier sysfs file for devices
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would be useful to check if a device is not probing because it's
waiting for a supplier to be added and then linked to before it can
probe.

To reduce sysfs clutter, this file is added only if it can ever be 1.
So, if fw_devlink is disabled or set to permissive, this file is not
added. Also, this file is removed once the device probes as it's no
longer relevant.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../sysfs-devices-waiting_for_supplier        | 17 ++++++++++++
 drivers/base/core.c                           | 26 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-waiting_for_supplier

diff --git a/Documentation/ABI/testing/sysfs-devices-waiting_for_supplier b/Documentation/ABI/testing/sysfs-devices-waiting_for_supplier
new file mode 100644
index 000000000000..59d073d20db6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-waiting_for_supplier
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../waiting_for_supplier
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		The /sys/devices/.../waiting_for_supplier attribute is only
+		present when fw_devlink kernel command line option is enabled
+		and is set to something stricter than "permissive".  It is
+		removed once a device probes successfully (because the
+		information is no longer relevant). The number read from it (0
+		or 1) reflects whether the device is waiting for one or more
+		suppliers to be added and then linked to using device links
+		before the device can probe.
+
+		A value of 0 means the device is not waiting for any suppliers
+		to be added before it can probe.  A value of 1 means the device
+		is waiting for one or more suppliers to be added before it can
+		probe.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3304ea1a2604..83a3e0b62ce3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1031,6 +1031,22 @@ static void device_link_drop_managed(struct device_link *link)
 	kref_put(&link->kref, __device_link_del);
 }
 
+static ssize_t waiting_for_supplier_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	bool val;
+
+	device_lock(dev);
+	mutex_lock(&wfs_lock);
+	val = !list_empty(&dev->links.needs_suppliers)
+	      && dev->links.need_for_probe;
+	mutex_unlock(&wfs_lock);
+	device_unlock(dev);
+	return sprintf(buf, "%u\n", val);
+}
+static DEVICE_ATTR_RO(waiting_for_supplier);
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
@@ -1055,6 +1071,7 @@ void device_links_driver_bound(struct device *dev)
 	mutex_lock(&wfs_lock);
 	list_del_init(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
 
@@ -2124,8 +2141,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
+	if (fw_devlink_flags && !fw_devlink_is_permissive()) {
+		error = device_create_file(dev, &dev_attr_waiting_for_supplier);
+		if (error)
+			goto err_remove_dev_online;
+	}
+
 	return 0;
 
+ err_remove_dev_online:
+	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -2143,6 +2168,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
 
-- 
2.26.2.761.g0e0b3e54be-goog

