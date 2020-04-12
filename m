Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF3C2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7232072D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMSPD8CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDLJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:14:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:14:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so3187788pff.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=645bKxd6X1AK15EMEGsJ7MidT4FGWFCl1Q2sCxk51Hw=;
        b=TMSPD8CYaHf7z6vnobwe1NUr51t3OGXC3jJqBgNK0ek99bzjymh+t+itHap5mPGdvO
         dEV030oIbRbLZUcxgqdVkoHQ1iMhLoIDaZJLlvjyo0Xmv7P2whFtTMiTw+SBRB2m5nwC
         Bo+3/NZZu6ao2zUKzLLawbkYiHyk3r0ry9RWUZqylg9sUTK03m5mWuZmIM67CyQqaEiM
         lw8V8ji0/5Q1E2kWdfUgl+X011Q7IiOlsrmG16/EbSeDSSEsTTVZDeEYxtjh47/GF1m4
         hPFLnQfQiCmhiJxW8ts5Pz/EJ+Tl9sdjzZwmKr/6aZKl9oEkuaNxQOWwcfkUrl3Vnoc1
         hUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=645bKxd6X1AK15EMEGsJ7MidT4FGWFCl1Q2sCxk51Hw=;
        b=YdAyKAcQl7AUotTP18SZzpBMrmu+pl19r99UUKI1I/UaIiD4YR/Bl9a7xDLVq2ctq9
         k2q0Jn32h3BoIZcOtK7D3opS+6kpyDoXZNZz1OkIPI2wtculkw3gpX4QC1NF/xcsbmqC
         c6eWZl5GlbW33VKIDqSm9eU8vjoGvbL6XGyxHE1Xzu4nfqVmTiB3vKHLlkDoxJlpqG8e
         RROftEbJdJZDi7bRVKz1ANN7GbxDK7S1p9eyVzRy0arIoJOOcrm41Ack/NNdGlHZqs/G
         9SAN2KIRCQbL4ypOssHVHr77/gdaavasKyJruTPscTHqyWODETPSUk3S29sOMYdsqAGA
         phDQ==
X-Gm-Message-State: AGi0PuahZHdgof2OouqSJclWK8YJn2k7np9qvr8vlbMKDBZQTFFD+QcY
        LZACNMpMeHyRGZJqP5O7wOE=
X-Google-Smtp-Source: APiQypLw91cgexxg9C84CDs1cpXXDV8EOUaWLEkb+LJ78u7NE1KoHRVkvqkzLQjUZyTJyWXYCdRlYg==
X-Received: by 2002:a62:7d11:: with SMTP id y17mr12652324pfc.127.1586682889135;
        Sun, 12 Apr 2020 02:14:49 -0700 (PDT)
Received: from open-light-1.localdomain ([66.98.113.28])
        by smtp.gmail.com with ESMTPSA id a9sm5408165pgv.18.2020.04.12.02.14.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 02:14:48 -0700 (PDT)
From:   liliangleo <liliang.opensource@gmail.com>
X-Google-Original-From: liliangleo <liliangleo@didiglobal.com>
Date:   Sun, 12 Apr 2020 05:09:22 -0400
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 3/4] mm: add sys fs configuration for page reporting
Message-ID: <20200412090919.GA19580@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add 'delay_millisecs', 'mini_order', 'batch_size',
in '/sys/kernel/mm/page_report/'. Usage:

"delay_millisecs":
Time delay interval between page free and work start to run.

"mini_order":
Only pages with order equal or greater than mini_order will be
reported.

"batch_size"
Wake up the worker only when free pages total size are greater
than 'batch_size'.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: liliangleo <liliangleo@didiglobal.com>
---
 mm/page_reporting.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/page_reporting.h |   4 +-
 2 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index dc7a22a4b752..cc6a42596560 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -7,15 +7,19 @@
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
+#include <linux/kobject.h>
 
 #include "page_reporting.h"
 #include "internal.h"
 
-#define PAGE_REPORTING_DELAY	(2 * HZ)
 #define MAX_SCAN_NUM 1024
 
 unsigned long page_report_batch_size  __read_mostly = 4 * 1024 * 1024UL;
 
+static unsigned long page_report_delay_millisecs __read_mostly = 2000;
+
+unsigned int page_report_mini_order __read_mostly = 8;
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
 enum {
@@ -48,7 +52,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	schedule_delayed_work(&prdev->work,
+			      msecs_to_jiffies(page_report_delay_millisecs));
 }
 
 /* notify prdev of free page reporting request */
@@ -260,7 +265,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << page_report_mini_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -270,7 +275,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = page_report_mini_order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
@@ -337,7 +342,8 @@ static void page_reporting_process(struct work_struct *work)
 	 */
 	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state == PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		schedule_delayed_work(&prdev->work,
+				msecs_to_jiffies(page_report_delay_millisecs));
 }
 
 static DEFINE_MUTEX(page_reporting_mutex);
@@ -393,3 +399,131 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 	mutex_unlock(&page_reporting_mutex);
 }
 EXPORT_SYMBOL_GPL(page_reporting_unregister);
+
+static ssize_t batch_size_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", page_report_batch_size);
+}
+
+static ssize_t batch_size_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long size;
+	int err;
+
+	err = kstrtoul(buf, 10, &size);
+	if (err || size >= UINT_MAX)
+		return -EINVAL;
+
+	page_report_batch_size = size;
+
+	return count;
+}
+
+static struct kobj_attribute batch_size_attr =
+	__ATTR(batch_size, 0644, batch_size_show, batch_size_store);
+
+static ssize_t delay_millisecs_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", page_report_delay_millisecs);
+}
+
+static ssize_t delay_millisecs_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long msecs;
+	int err;
+
+	err = kstrtoul(buf, 10, &msecs);
+	if (err || msecs >= UINT_MAX)
+		return -EINVAL;
+
+	page_report_delay_millisecs = msecs;
+
+	return count;
+}
+
+static struct kobj_attribute wake_delay_millisecs_attr =
+	__ATTR(delay_millisecs, 0644, delay_millisecs_show,
+		delay_millisecs_store);
+
+static ssize_t mini_order_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", page_report_mini_order);
+}
+
+static ssize_t mini_order_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned int order;
+	int err;
+
+	err = kstrtouint(buf, 10, &order);
+	if (err || order >= MAX_ORDER)
+		return -EINVAL;
+
+	if (page_report_mini_order != order) {
+		mutex_lock(&page_reporting_mutex);
+		page_report_mini_order = order;
+		mutex_unlock(&page_reporting_mutex);
+	}
+
+	return count;
+}
+
+static struct kobj_attribute mini_order_attr =
+	__ATTR(mini_order, 0644, mini_order_show, mini_order_store);
+
+static struct attribute *page_report_attr[] = {
+	&mini_order_attr.attr,
+	&wake_delay_millisecs_attr.attr,
+	&batch_size_attr.attr,
+	NULL,
+};
+
+static struct attribute_group page_report_attr_group = {
+	.attrs = page_report_attr,
+};
+
+static int __init page_report_init_sysfs(struct kobject **page_report_kobj)
+{
+	int err;
+
+	*page_report_kobj = kobject_create_and_add("page_report", mm_kobj);
+	if (unlikely(!*page_report_kobj)) {
+		pr_err("page_report: failed to create page_report kobject\n");
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(*page_report_kobj, &page_report_attr_group);
+	if (err) {
+		pr_err("page_report: failed to register page_report group\n");
+		goto delete_obj;
+	}
+
+	return 0;
+
+delete_obj:
+	kobject_put(*page_report_kobj);
+	return err;
+}
+
+static int __init page_report_init(void)
+{
+	int err;
+	struct kobject *page_report_kobj;
+
+	msecs_to_jiffies(page_report_delay_millisecs);
+	err = page_report_init_sysfs(&page_report_kobj);
+	if (err)
+		return err;
+
+	return 0;
+}
+subsys_initcall(page_report_init);
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index f18c85ecdfe0..5e52777c934d 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -10,7 +10,7 @@
 #include <asm/pgtable.h>
 #include <linux/scatterlist.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
+extern unsigned int page_report_mini_order;
 
 extern unsigned long page_report_batch_size;
 
@@ -42,7 +42,7 @@ static inline void page_reporting_notify_free(unsigned int order)
 		return;
 
 	/* Determine if we have crossed reporting threshold */
-	if (order < PAGE_REPORTING_MIN_ORDER)
+	if (order < page_report_mini_order)
 		return;
 
 	batch_size += (1 << order) << PAGE_SHIFT;
-- 
2.14.1

