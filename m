Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB70C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF202072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCSIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:51:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:2359 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSIv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:51:59 -0400
IronPort-SDR: YmLmf6ykIB8WQHNGLedlNcHzBYh7Lh2XEG3g2NjT1W96NaALHm23uon80pOXB7yKQ3/DNtPtxy
 TNdlaud7J15w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 01:51:59 -0700
IronPort-SDR: +8YDU/zzO+lLhjX8QApI5YBGHyR/BDlez/PXZWrZDpJTfl1IFgzq/vnE4GAJoiF3A8622FYXzi
 WKbixO89kubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="238862974"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 01:51:57 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] intel_th: msu: Make stopping the trace optional
Date:   Thu, 19 Mar 2020 10:51:52 +0200
Message-Id: <20200319085152.52183-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318102615.GC2126918@kroah.com>
References: <20200318102615.GC2126918@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some use cases prefer to keep collecting the trace data into the last
available window while the other windows are being offloaded instead of
stopping the trace. In this scenario, the window switch happens
automatically when the next window becomes available again.

Add an option to allow this and a sysfs attribute to enable it.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../testing/sysfs-bus-intel_th-devices-msc    |  8 ++++
 drivers/hwtracing/intel_th/msu.c              | 38 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
index 456cb62b384c..7fd2601c2831 100644
--- a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
+++ b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
@@ -40,3 +40,11 @@ Description:	(RW) Trigger window switch for the MSC's buffer, in
 		triggering a window switch for the buffer. Returns an error in any
 		other operating mode or attempts to write something other than "1".
 
+What:		/sys/bus/intel_th/devices/<intel_th_id>-msc<msc-id>/stop_on_full
+Date:		March 2020
+KernelVersion:	5.7
+Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+Description:	(RW) Configure whether trace stops when the last available window
+		becomes full (1/y/Y) or wraps around and continues until the next
+		window becomes available again (0/n/N).
+
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 6e118b790d83..db04086122dc 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -138,6 +138,7 @@ struct msc {
 	struct list_head	win_list;
 	struct sg_table		single_sgt;
 	struct msc_window	*cur_win;
+	struct msc_window	*switch_on_unlock;
 	unsigned long		nr_pages;
 	unsigned long		single_sz;
 	unsigned int		single_wrap : 1;
@@ -154,6 +155,8 @@ struct msc {
 
 	struct list_head	iter_list;
 
+	bool			stop_on_full;
+
 	/* config */
 	unsigned int		enabled : 1,
 				wrap	: 1,
@@ -1717,6 +1720,10 @@ void intel_th_msc_window_unlock(struct device *dev, struct sg_table *sgt)
 		return;
 
 	msc_win_set_lockout(win, WIN_LOCKED, WIN_READY);
+	if (msc->switch_on_unlock == win) {
+		msc->switch_on_unlock = NULL;
+		msc_win_switch(msc);
+	}
 }
 EXPORT_SYMBOL_GPL(intel_th_msc_window_unlock);
 
@@ -1757,7 +1764,11 @@ static irqreturn_t intel_th_msc_interrupt(struct intel_th_device *thdev)
 
 	/* next window: if READY, proceed, if LOCKED, stop the trace */
 	if (msc_win_set_lockout(next_win, WIN_READY, WIN_INUSE)) {
-		schedule_work(&msc->work);
+		if (msc->stop_on_full)
+			schedule_work(&msc->work);
+		else
+			msc->switch_on_unlock = next_win;
+
 		return IRQ_HANDLED;
 	}
 
@@ -2050,11 +2061,36 @@ win_switch_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_WO(win_switch);
 
+static ssize_t stop_on_full_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", msc->stop_on_full);
+}
+
+static ssize_t stop_on_full_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = kstrtobool(buf, &msc->stop_on_full);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(stop_on_full);
+
 static struct attribute *msc_output_attrs[] = {
 	&dev_attr_wrap.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_nr_pages.attr,
 	&dev_attr_win_switch.attr,
+	&dev_attr_stop_on_full.attr,
 	NULL,
 };
 
-- 
2.25.1

