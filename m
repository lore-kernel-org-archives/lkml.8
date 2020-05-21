Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54009C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3328120759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngssxZJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgEUTST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgEUTSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:18:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474BDC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y8so6515336ybn.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8AoDHRtqjpHM7RXqHjckQScwqkfTWJXIb0Sz86kUaw8=;
        b=ngssxZJLnJraOpT5Lw/LZ3zvG2x3kyYvYQHi4mRBdBaWQHr+m+VLF3JEHsPFRqrl+A
         /JjViJI0RMayw6SO8seyst71AqmaibRn1lPRjlVG5eCcoIdS+cL9xY76E5rvzLYDvTX1
         yHwJgpd2Bck/6k7YaTXttOl9hoCy42MlfIYv2hTKbelXVzLg4A/hsQ1cJ5n4uOH0NEWd
         oGp6HYojOoyUm883RsA+VMbJhwxBGuD1169hdWFtgCsAsagsiVsp61jKWlWIi45NUwWo
         ZDZgv9drgiK1J36yZBRxnqsF88Wa6G6kW2ie0zvPi4IJXrVY5rFflT62E9QF9OZW2Yan
         TtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8AoDHRtqjpHM7RXqHjckQScwqkfTWJXIb0Sz86kUaw8=;
        b=D0oDuaD4+5RzPziedznU9TgfTNsqfutuKlF2cItzLh8W30CyaPlc0tJLFZrtChhd6N
         AlZe5F2np3/fNAmSZ4aQofFF3VmketRObt4M2npJhzjJvF/bxoH/E90lBjap1Xk7StXN
         yr3e+R/jp1hytGbgugqCaMLb5sp2L8P+HOGjm87Zg1a6ZzfABlYCX31APextxcuLeV/i
         NbSa0xU3tCwB2s3kHtaiFR+o++ECmYgJYum/dBaRwwqlC2Nq5Q2hBiIv4MzeCDR0bkeW
         noRfSTtYDAoIDrls/pNYhNx1fBVIIE6DNWwuQqZO586Pv/1848X76+emG8QB4syoKnLb
         ad3Q==
X-Gm-Message-State: AOAM532vftRJrMCVZhEwgITE/MYPVgSj7Rx3agr2Il27vJu/FmDKIIRu
        7+SURklFGfHwSLgvgyZoiHoHTQe+1i8dcSs=
X-Google-Smtp-Source: ABdhPJz2D7dwdjIfQNhYasaFiNubC34GbKXbp81rOQcG11mQkye1YK5IQftHeaSU8MVkrRFLWqpizIMlfsyCAYs=
X-Received: by 2002:a25:14d6:: with SMTP id 205mr18129325ybu.113.1590088697511;
 Thu, 21 May 2020 12:18:17 -0700 (PDT)
Date:   Thu, 21 May 2020 12:18:00 -0700
In-Reply-To: <20200521191800.136035-1-saravanak@google.com>
Message-Id: <20200521191800.136035-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3 3/3] driver core: Add waiting_for_supplier sysfs file for devices
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
index 81c8ef088d3a..dfd4e94ef790 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1033,6 +1033,22 @@ static void device_link_drop_managed(struct device_link *link)
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
@@ -1057,6 +1073,7 @@ void device_links_driver_bound(struct device *dev)
 	mutex_lock(&wfs_lock);
 	list_del_init(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
 
@@ -2126,8 +2143,16 @@ static int device_add_attrs(struct device *dev)
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
@@ -2145,6 +2170,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

