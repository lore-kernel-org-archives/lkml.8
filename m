Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278532076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNCoiUqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGPVpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgGPVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:45:29 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42123C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:45:29 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 94so4767965qtb.21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ODmmCzqZDIv2YuOBO4n8vLehGaR2w7zZNRYGWbtYqCw=;
        b=aNCoiUqwkD7bKkR7WEuxydX+G/7of13VHiX0UcMLf8cu9XLzvloBPGJLi2Z0Rzxp0U
         KUOtakX3xEZAu2hAgpOsOGDNKJM3Z3pc+Oe9yIuA08XQwgGwAqpRpI99DPAqWTLELnb/
         3m6R+DZYJUf+oO1poMyZ2X4t/5QlSErGf7ACX8odvP8Oy/OAOkbUVNXTuDHx0NC1Y5c1
         st2TmgarP0gtxsW1YvTgVoIrerTNE5Sy1PaWjQtPAIthhK5Ne7HVHA7ug9zlrevxPLv5
         0/quthecFjB7neM+4NLHfQ8bHQFq4fduR9R1oMc+JxHvPnw9zVQmfUJilF4PL9XDe8yH
         tqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ODmmCzqZDIv2YuOBO4n8vLehGaR2w7zZNRYGWbtYqCw=;
        b=SxbuQUA21IGOzI9wtl1dUZ29cJI+Aa+QPsks+KpiCCVjMLl2QGCfRQGll3yvR2z0lx
         1Pv/4k9pTtzHPr6+HmV/FciEtKW/9WcvwrpjZSxVi9WxE3FWvuQsGb700UGHnFZva/2V
         Zmd7weobuNSVTnO0FU6hTwPA34nDJMHHNgwmgCwV+jYql3vXsCC7qv88+W5Wpca+BAsN
         ubuQyKxKjFwH52/waAx21i4c6vJYopMSVzn7V1KTBXGiEB8JR2QG2dsm60b+rbGWv4Dp
         05zZ7w8lNO8Q22wkWv0iIGxGcFzGiGJmt8Gwk8efeiXR+/jVvoaRtw78eeLtE8pKGk6Y
         kAng==
X-Gm-Message-State: AOAM532N/oExY2RuOLfu+cFURPrs3qVvNr8P+o50BwStfd52gJGtaE95
        TA4g3io/ESHEEnx1IkbUyLzWF/aNBm5nI9Y=
X-Google-Smtp-Source: ABdhPJy3MK/fzm79HMtq286yt9YTnIKkXKLABtWVyqFyYsk/1zKtiJVGMLfU2otV8cd51bN91F3NsR+0iJQeG1E=
X-Received: by 2002:a0c:e1c3:: with SMTP id v3mr6020188qvl.209.1594935927047;
 Thu, 16 Jul 2020 14:45:27 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:45:23 -0700
Message-Id: <20200716214523.2924704-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] driver core: Fix sleeping in invalid context during device
 link deletion
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek and Guenter reported that commit 287905e68dd2 ("driver core:
Expose device link details in sysfs") caused sleeping/scheduling while
atomic warnings.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
2 locks held by kworker/0:1/12:
  #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
  #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
Preemption disabled at:
[<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
----- 8< ----- SNIP
[<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
[<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
[<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
[<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
[<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
[<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee921fb0 to 0xee921ff8)

This was caused by the device link device being released in the context
of srcu_invoke_callbacks().  There is no need to wait till the RCU
callback to release the device link device.  So release the device
earlier and move the call_srcu() into the device release code. That way,
the memory will get freed only after the device is released AND the RCU
callback is called.

Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

v1->v2:
- Better fix
- Changed subject
- v1 is this patch https://lore.kernel.org/lkml/20200716050846.2047110-1-saravanak@google.com/

Marek and Guenter,

I reproduced the original issue and tested this fix. Seems to work for
me. Can you confirm?

Thanks,
Saravana

 drivers/base/core.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5373ddd029f6..ec16b97d45ed 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -306,10 +306,34 @@ static struct attribute *devlink_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devlink);
 
+static void device_link_free(struct device_link *link)
+{
+	while (refcount_dec_not_one(&link->rpm_active))
+		pm_runtime_put(link->supplier);
+
+	put_device(link->consumer);
+	put_device(link->supplier);
+	kfree(link);
+}
+
+#ifdef CONFIG_SRCU
+static void __device_link_free_srcu(struct rcu_head *rhead)
+{
+	device_link_free(container_of(rhead, struct device_link, rcu_head));
+}
+
 static void devlink_dev_release(struct device *dev)
 {
-	kfree(to_devlink(dev));
+	struct device_link *link = to_devlink(dev);
+
+	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
 }
+#else
+static void devlink_dev_release(struct device *dev)
+{
+	device_link_free(to_devlink(dev));
+}
+#endif
 
 static struct class devlink_class = {
 	.name = "devlink",
@@ -730,22 +754,7 @@ static void device_link_add_missing_supplier_links(void)
 	mutex_unlock(&wfs_lock);
 }
 
-static void device_link_free(struct device_link *link)
-{
-	while (refcount_dec_not_one(&link->rpm_active))
-		pm_runtime_put(link->supplier);
-
-	put_device(link->consumer);
-	put_device(link->supplier);
-	device_unregister(&link->link_dev);
-}
-
 #ifdef CONFIG_SRCU
-static void __device_link_free_srcu(struct rcu_head *rhead)
-{
-	device_link_free(container_of(rhead, struct device_link, rcu_head));
-}
-
 static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link = container_of(kref, struct device_link, kref);
@@ -758,7 +767,7 @@ static void __device_link_del(struct kref *kref)
 
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
-	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
+	device_unregister(&link->link_dev);
 }
 #else /* !CONFIG_SRCU */
 static void __device_link_del(struct kref *kref)
@@ -773,7 +782,7 @@ static void __device_link_del(struct kref *kref)
 
 	list_del(&link->s_node);
 	list_del(&link->c_node);
-	device_link_free(link);
+	device_unregister(&link->link_dev);
 }
 #endif /* !CONFIG_SRCU */
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

