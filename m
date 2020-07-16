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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99B5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nx5KryYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgGPFIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPFIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:08:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280B7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:08:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i203so5787585yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/ASv5dAELns8VVIKC04I8VtuZPqEPBD90P+R5xqH+S8=;
        b=nx5KryYWxGY5HdEReewTvGrAt4vEZgN1uDIJMhQ9FCh3mF09JRhkfjlOqs1YPrNxwa
         ivUgcpI92V1THDb7Fxnstt/ZVp8CRQoRk8GwLKf3mSjb1Xgk/6M2e45qJahFMsh5nH57
         yBn3jjz6RwM+CJU5P7kZmgIhHKU07BufDxNmxMGRasG+UjdD0oThKS8KQ9VAJ0I6QFQO
         0E/CDhc9Ox+WNcfP5kwP+HJUVb+ffzTHGdl2AGlGvE099kp45nSRSOgCTHU8g5sEb4Yo
         xHwttBJ75WsgoWCFtHn0FAoEHOeioMMa7cxSlGIQtcg76aYXPRpJYrn9nxjDN2oVUezC
         CDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/ASv5dAELns8VVIKC04I8VtuZPqEPBD90P+R5xqH+S8=;
        b=hkHa87kzjvN10cO1tsr7ZJ8F3ZwFp+CpgsuvYitqcb7UBeoTxrUo4UvKgfiEN14Zdv
         DNrNetTAkfumHmvYl+zmF84502PkkAdaQ8abioWwQXuNDsNqoLrYAKqUkq4ODHqc8wqc
         ZhT6O3sJz9ZRqXn3/wKo9wAvGe5wxtV1JP26KSFcvPJ0poqsx5C9bd7AtSock7qMTrsj
         cXeJHCRwDTlsV9YZmkoThtRCXyEa3XqTAhVEs4o1I7HZ7H1BWhMySOrFWEYpXyHMpsAl
         P0lPBO4Ld0i9sO87Jy+zGDYllsefynj+Y0wB2DBOnCqr0wgkHuDSUHMXush3/c4NQrYR
         MAnw==
X-Gm-Message-State: AOAM533D8PmGbgz7OJLOcQ9uqNAbM5ALwT5C3Zh764bKB/06DIOi8rWv
        XC8mM8YmIS/lvQxHCWTUP0GpySXEnjrtYuc=
X-Google-Smtp-Source: ABdhPJwJwRzkZPs+Oh0TI3mGWF7hNxFBYsX3qVynjwB7JhvM1PAJCRFfBSac4Uw4P3euzGwq0O7N4EN+Nkv7W0U=
X-Received: by 2002:a25:e78f:: with SMTP id e137mr3755515ybh.153.1594876129385;
 Wed, 15 Jul 2020 22:08:49 -0700 (PDT)
Date:   Wed, 15 Jul 2020 22:08:46 -0700
Message-Id: <20200716050846.2047110-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v1] driver core: Fix scheduling while atomic warnings during
 device link deletion
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
earlier and revert the RCU callback code to what it was before
commit 287905e68dd2 ("driver core: Expose device link details in sysfs")

Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Marek and Guenter,

It haven't had a chance to test this yet. Can one of you please test it
and confirm it fixes the issue?

Thanks,
Saravana

 drivers/base/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5373ddd029f6..ccb2ce11f5b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -306,16 +306,10 @@ static struct attribute *devlink_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devlink);
 
-static void devlink_dev_release(struct device *dev)
-{
-	kfree(to_devlink(dev));
-}
-
 static struct class devlink_class = {
 	.name = "devlink",
 	.owner = THIS_MODULE,
 	.dev_groups = devlink_groups,
-	.dev_release = devlink_dev_release,
 };
 
 static int devlink_add_symlinks(struct device *dev,
@@ -737,7 +731,7 @@ static void device_link_free(struct device_link *link)
 
 	put_device(link->consumer);
 	put_device(link->supplier);
-	device_unregister(&link->link_dev);
+	kfree(link);
 }
 
 #ifdef CONFIG_SRCU
@@ -756,6 +750,7 @@ static void __device_link_del(struct kref *kref)
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
 
+	device_unregister(&link->link_dev);
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
 	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
@@ -771,6 +766,7 @@ static void __device_link_del(struct kref *kref)
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
 
+	device_unregister(&link->link_dev);
 	list_del(&link->s_node);
 	list_del(&link->c_node);
 	device_link_free(link);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

