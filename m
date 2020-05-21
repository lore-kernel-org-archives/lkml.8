Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD4FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6199207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neCFio8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgEUTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgEUTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:18:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C787C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r18so6496253ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cDun6riWHrfppyodZhT9tzNQ9I1OoUcRmNfRuX6NlzA=;
        b=neCFio8fsozZbRBVm/84ITUMHb/CFdvjZBLjpt5FfSTy4BBPy2Z/lXhegDsu99ZhYl
         jxot/iKjE/Ygmhp6Ug73JuH8eM3VcG7eKu8ViZZkrOiwbOHtjHEJaFbhWLzNZ2kKJI7O
         wCrfUXZXSpRbqAXdYjjDkFOJ3+Vk7yIwCr5HAuIV8He7399bWAyrNcAJvZu2YpapH6Eb
         LmuzR6BF7z3wK19nYe6B5VtKfWYpqYGt4zs0cv68/YMndYIuIpvVxkKHYhRRasAHADft
         2x93J/lJhrEWLOWO4cA9p5K4ZvxuTsh5VztDwT87bua0oKpDvph38SrmXWDPMvDGCwTg
         R3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cDun6riWHrfppyodZhT9tzNQ9I1OoUcRmNfRuX6NlzA=;
        b=uKks2qxN8Njao4+SC+XCv+6PKjRqEJcj809on5Jn7gZj2NOaldRgKi4Z//+e4w2WEh
         EkdwMjKfsGdxu++HFbcRPpSrn8EX6Tr8W67FchSItge09zK1zZcIKWmgw+jAI7RVVngM
         4CRrhqckA6tW4jghAT7o64LoJ2qA16aWPDrtttB1zR66UeS7zIi8evtR+lE9Ztm4+jQi
         bfqA7nFLPVuNFRCUMqP2QlJOJQFROsnK9b3t8Zvcpz6n1/8TnJZJA5vRozi8HnUc1m/1
         UeDrUcjTjfLFN5sgop4o+rUvRlXnybv30CGd0bxfPsrcS6UZ3+tGfZRmJD6kizB6nQhe
         Fchg==
X-Gm-Message-State: AOAM530OKZ3AI9ZiwDtdsqid8939pCZ9fMGd1eRrz/4pT21RfyOWG4Ph
        AI0zQ29DKi3VMT0YOSwiOeyKi5vASriIvFQ=
X-Google-Smtp-Source: ABdhPJxV4Sm0t75K1DlmvgO9gd5a3eCFKUoCZ2J2scs2Ur1nmzVBNWhHmpxZvZOrp5ZG/XvDfTZdhOdkPQjxNXM=
X-Received: by 2002:a25:bb03:: with SMTP id z3mr17221636ybg.6.1590088694660;
 Thu, 21 May 2020 12:18:14 -0700 (PDT)
Date:   Thu, 21 May 2020 12:17:59 -0700
In-Reply-To: <20200521191800.136035-1-saravanak@google.com>
Message-Id: <20200521191800.136035-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3 2/3] driver core: Add state_synced sysfs file for devices
 that support it
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

This can be used to check if a device supports sync_state() callbacks
and therefore keeps resources left on by the bootloader enabled till all
its consumers have probed.

This can also be used to check if sync_state() has been called for a
device or whether it is still trying to keep resources enabled because
they were left enabled by the bootloader and all its consumers haven't
probed yet.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../ABI/testing/sysfs-devices-state_synced    | 24 +++++++++++++++++++
 drivers/base/dd.c                             | 22 +++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced

diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
new file mode 100644
index 000000000000..0c922d7d02fc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-state_synced
@@ -0,0 +1,24 @@
+What:		/sys/devices/.../state_synced
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		The /sys/devices/.../state_synced attribute is only present for
+		devices whose bus types or driver provides the .sync_state()
+		callback. The number read from it (0 or 1) reflects the value
+		of the device's 'state_synced' field. A value of 0 means the
+		.sync_state() callback hasn't been called yet. A value of 1
+		means the .sync_state() callback has been called.
+
+		Generally, if a device has sync_state() support and has some of
+		the resources it provides enabled at the time the kernel starts
+		(Eg: enabled by hardware reset or bootloader or anything that
+		run before the kernel starts), then it'll keep those resources
+		enabled and in a state that's compatible with the state they
+		were in at the start of the kernel. The device will stop doing
+		this only when the sync_state() callback has been called --
+		which happens only when all its consumer devices are registered
+		and have probed successfully. Resources that were left disabled
+		at the time the kernel starts are not affected or limited in
+		any way by sync_state() callbacks.
+
+
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..7c04b88daac3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -463,6 +463,18 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
 		driver_deferred_probe_trigger();
 }
 
+static ssize_t state_synced_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	bool val;
+
+	device_lock(dev);
+	val = dev->state_synced;
+	device_unlock(dev);
+	return sprintf(buf, "%u\n", val);
+}
+static DEVICE_ATTR_RO(state_synced);
+
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
 	int ret = -EPROBE_DEFER;
@@ -536,9 +548,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto dev_groups_failed;
 	}
 
+	if (dev_has_sync_state(dev) &&
+	    device_create_file(dev, &dev_attr_state_synced)) {
+		dev_err(dev, "state_synced sysfs add failed\n");
+		goto dev_sysfs_state_synced_failed;
+	}
+
 	if (test_remove) {
 		test_remove = false;
 
+		device_remove_file(dev, &dev_attr_state_synced);
 		device_remove_groups(dev, drv->dev_groups);
 
 		if (dev->bus->remove)
@@ -568,6 +587,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 	goto done;
 
+dev_sysfs_state_synced_failed:
+	device_remove_groups(dev, drv->dev_groups);
 dev_groups_failed:
 	if (dev->bus->remove)
 		dev->bus->remove(dev);
@@ -1105,6 +1126,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		pm_runtime_put_sync(dev);
 
+		device_remove_file(dev, &dev_attr_state_synced);
 		device_remove_groups(dev, drv->dev_groups);
 
 		if (dev->bus && dev->bus->remove)
-- 
2.27.0.rc0.183.gde8f92d652-goog

