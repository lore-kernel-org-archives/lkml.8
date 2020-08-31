Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D258C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59D32083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EqIaQ4ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgHaWKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgHaWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:10:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CBEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:10:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v77so9211646ybi.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uaixvdEt///jx9E992ybmsW/Q911rUHff+CmpNlVaVg=;
        b=EqIaQ4uaB9IzdrHcVmHMsh+9xHzwZLuUvpz2/5ektus9a8jF+/dnVREgxErAF2M42V
         J3+1dEdbzknvjDBZ37Y5NkfuTotveQkA9s9z/Ow4MWZsMAzFwYtOFgKDjxOyFcHqPwoD
         9prijvzXSE/bku9EGbP6Llt9zK85OwoY+wgd7T7gT4eS6M9mVvMn/7OEPHgZXYHKqXSW
         Kk5pWf/Ks/3JU3OGfE+yhFuwaTKAWu1NOz3JzhI2Pr+kCQYcm/mqDLRZEbwDSEo6n7EA
         Q60Fh7tnTPvY5JO4KXA7sSHhJfVDv6gPtO6NASt/XsIH13DKBV5wgarI8n5QlED0xsaK
         7nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uaixvdEt///jx9E992ybmsW/Q911rUHff+CmpNlVaVg=;
        b=f3V4M9mDnxCQswWAmRm17CChWvXNc0O/1CEbqOkra0jwiX/b9Wj1zwSt/NjrsxcGc+
         Ak20saIqXJo/DlS/cgeSHLZtJ19u048hjICAq8+Mt92RSIQMQ1JKJ9Y/SDOoc6T+kep6
         7wNc2Dc+90BZ2/p+mzynNlQIPfbdtYlpEus00tYFUy8xMjBzK2YRJwSfrMvMLZCrZI0s
         I+xhHBGonFH7vG+uSSPe6TbZs/KMip6Nf9MfHqSOgYwIcXYOyua7rRK0ehz4k91xYWGh
         tcIrWO141wisd1M9txT5h6GPTOYVhnEprkLyF/xwL10QGkMHqXiTQmhGcXOKhV7+GAF5
         qH4Q==
X-Gm-Message-State: AOAM533LxkqXwlG7wnJOR3b37a2gaWg2QiHJETzzS7/QHkNKLt4W82PM
        8ATV+4G5tZp6VLm8UVbep9la7B5IRbvpv6w=
X-Google-Smtp-Source: ABdhPJyTCYzv8xRRNv/sQlgl59JWBwupRCPHVhDmEmg1seLtMr4LIIh3PNu7OSCUF7gBCizXKPZIEQ32+iEpZSY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:11:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:c088:: with SMTP id
 c130mr5612544ybf.356.1598911812347; Mon, 31 Aug 2020 15:10:12 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:10:07 -0700
Message-Id: <20200831221007.1506441-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v1] driver core: Fix device_pm_lock() locking for device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Dong Aisheng <dongas86@gmail.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes two issues:

1. The lockdep warning reported by Dong Aisheng <dongas86@gmail.com> [1].

It is a warning about a cycle (dpm_list_mtx --> kn->active#3 --> fw_lock)
that was introduced when device-link devices were added to expose device
link information in sysfs.

The patch that "introduced" this cycle can't be reverted because it's fixes
a real SRCU issue and also ensures that the device-link device is deleted
as soon as the device-link is deleted. This is important to avoid sysfs
name collisions if the device-link is create again immediately (this can
happen a lot with deferred probing).

2. device_link_drop_managed() is not grabbing device_pm_lock().

When device_link_del() calls __device_link_del() (device_link_del() ->
device_link_put_kref() kref_put() -> __device_link_del()) it grabs the
device_pm_lock().

However, when device_link_drop_managed() calls __device_link_del()
(device_link_drop_managed() -> kref_put() -> __device_link_del()) it
doesn't grab device_pm_lock(). There's nothing special about managed
device-links that remove the need for grabbing device_pm_lock(). So, this
patch makes sure device_pm_lock() is always held when deleting managed
links.

And thanks to Stephen Boyd for helping me understand the lockdep splat.

Fixes: 843e600b8a2b ("driver core: Fix sleeping in invalid context during device link deletion")
Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
[1] - https://lore.kernel.org/lkml/CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com/
Reported-by: Dong Aisheng <dongas86@gmail.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Rafael,

A bigger question I had is why we need to grab device_pm_lock() around
device_link_del() in the first place. I understand the need to grab it
during device_link_add() -- it's because we are checking the supplier is
in the dpm_list and because we are reordering devices on the dpm_list.

But during deletion, we don't need to do either one of those.  So, why
do we even need to grab the device_pm_lock() in the first place. The
device_links_write_lock() that we already grab before deleting a device
link seems like it'd be sufficient. If you agree we don't need to grab
device_pm_lock() during deletion, then I can change this patch to just
delete that locking.

-Saravana

 drivers/base/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6f620aa9408..de1935e21d97 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -766,8 +766,10 @@ static void __device_link_del(struct kref *kref)
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
 
+	device_pm_lock();
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
+	device_pm_unlock();
 	device_unregister(&link->link_dev);
 }
 #else /* !CONFIG_SRCU */
@@ -781,8 +783,10 @@ static void __device_link_del(struct kref *kref)
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
 
+	device_pm_lock();
 	list_del(&link->s_node);
 	list_del(&link->c_node);
+	device_pm_unlock();
 	device_unregister(&link->link_dev);
 }
 #endif /* !CONFIG_SRCU */
@@ -807,9 +811,7 @@ static void device_link_put_kref(struct device_link *link)
 void device_link_del(struct device_link *link)
 {
 	device_links_write_lock();
-	device_pm_lock();
 	device_link_put_kref(link);
-	device_pm_unlock();
 	device_links_write_unlock();
 }
 EXPORT_SYMBOL_GPL(device_link_del);
@@ -830,7 +832,6 @@ void device_link_remove(void *consumer, struct device *supplier)
 		return;
 
 	device_links_write_lock();
-	device_pm_lock();
 
 	list_for_each_entry(link, &supplier->links.consumers, s_node) {
 		if (link->consumer == consumer) {
@@ -839,7 +840,6 @@ void device_link_remove(void *consumer, struct device *supplier)
 		}
 	}
 
-	device_pm_unlock();
 	device_links_write_unlock();
 }
 EXPORT_SYMBOL_GPL(device_link_remove);
-- 
2.28.0.402.g5ffc5be6b7-goog

