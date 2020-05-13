Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA50C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17524206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okP+8glW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgEMBeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMBeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:34:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3416C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 18:34:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so17918387ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u2R6uh0TUyIu2nWEYyjL6Nl0urUWpNEVjVf1H4GcML0=;
        b=okP+8glWZ24cEbndDhuAl3Tuv+Jt/bb2AhNhMJoZ75GxX+l7+KjGZHf2vslB7bIsal
         Xx7zy08TTvc1CuKSZFmygbuhiQTqASiNK1dz3ARREXqPu+f5RajQQcNkwR267BSdBsk5
         vFrALBlWsngapC7A593EE1sTx3W6sGmu0OKJhPg2a5PE3ASYLXAqcGIkQLLjUfoK1wKg
         amoiCFy5hzzuBaxaBTwJOHkPbI6cOPU4e+gh/xvX35gtakzTMthmmqRqB8NMkx/HYhIP
         bMJwOYeXAVor5ofeJO3eqEfVnK5MX4X8WYZWEDh6NpKi8+e+XMt3aRsMEYVxLB3D3Bln
         ONgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u2R6uh0TUyIu2nWEYyjL6Nl0urUWpNEVjVf1H4GcML0=;
        b=WcvkqWbQmmBIW1JLBTGHqUVyjGMzaEx3AdxOWB+9D1hgzX6WLqqvI19jX3igif4pII
         UhEhP/gD7Di+p9rI/ZY7lnhSbAWiyLuKvUZ0gcSzEMRvb/z8x++Yi+wOHZuJ1HyCwusa
         29LX4eJ/hFvzNbqjRSJW87TycpLf/EIwaecaT4I9t4Sn6w4k7fQU3PDYAej4ZvLn96Z8
         SpsAVgBrXFpdvGqNmtRT0Xv1nxTowhFQ22/iEp514a24N5p7ZClrMaHQCu17V+6ZtHTY
         UFfErlUR9z8IfhnH8DnY99l2Jk2YduR9TkhibMZZwszTpeDrnl5SR+uhvOZjfZKKAJwX
         +LVg==
X-Gm-Message-State: AGi0PuaNXS/npA+MsYyMeRcP+WB7VFuXkmIdnRIxnbFuadnKQA+xoaLe
        P+HRLvc4Z3Yvk9YOlYoKqCBc8cHexVGF9uk=
X-Google-Smtp-Source: APiQypIlrERinGpziyimv7ST/mRamxZl/nRYvZaUdKBqsaRDjKaHUnpV2q/7vt/f/aSbV3nSAWo8kRuXKFW0288=
X-Received: by 2002:a25:37c8:: with SMTP id e191mr40492234yba.388.1589333662255;
 Tue, 12 May 2020 18:34:22 -0700 (PDT)
Date:   Tue, 12 May 2020 18:34:15 -0700
Message-Id: <20200513013415.148858-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v1] driver core: Add state_synced sysfs file for devices that
 support it
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
 drivers/base/dd.c                             | 16 +++++++++++++
 2 files changed, 40 insertions(+)
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
index 48ca81cb8ebc..72599436ae84 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -458,6 +458,13 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
 		driver_deferred_probe_trigger();
 }
 
+static ssize_t state_synced_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", dev->state_synced);
+}
+static DEVICE_ATTR_RO(state_synced);
+
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
 	int ret = -EPROBE_DEFER;
@@ -531,9 +538,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
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
@@ -563,6 +577,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 	goto done;
 
+dev_sysfs_state_synced_failed:
+	device_remove_groups(dev, drv->dev_groups);
 dev_groups_failed:
 	if (dev->bus->remove)
 		dev->bus->remove(dev);
-- 
2.26.2.645.ge9eca65c58-goog

