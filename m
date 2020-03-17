Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D65C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E97206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCQGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:22:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:53584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgCQGWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:22:40 -0400
IronPort-SDR: kYrrwdzL0L6S7C72DeR3nlhyu3whj4NhoYeJfoZ8SmEtmZQ8SXc/SSPYpU6riLDb/UOoiHrJ31
 hzilha/CGHOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 23:22:40 -0700
IronPort-SDR: J4plOpkVXSuwaaBljT4MbkXKzSRokxtbrXEyAQmoKdgfD1VpMJRlCTjgR2hXAtYqyGJgzqr5jM
 qcSWtvEG4b7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="445390322"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2020 23:22:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 3/6] intel_th: msu: Make stopping the trace optional
Date:   Tue, 17 Mar 2020 08:22:12 +0200
Message-Id: <20200317062215.15598-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
References: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
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
 drivers/hwtracing/intel_th/msu.c              | 37 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

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
index 6e118b790d83..45916b48bcf0 100644
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
 
@@ -2050,11 +2061,35 @@ win_switch_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_WO(win_switch);
 
+static ssize_t stop_on_full_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", msc->stop_on_full);
+}
+
+static ssize_t stop_on_full_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtobool(buf, &msc->stop_on_full);
+
+	return ret ? ret : size;
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

