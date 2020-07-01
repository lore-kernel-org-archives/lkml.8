Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F947C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5185D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBudUZCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgGATnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgGATnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:43:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31153C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:43:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g16so1320848pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3dAQpY+DzMdkCcRTUFylYp5SGB/8UdN06tL6dHz3kik=;
        b=MBudUZCwkQ21tay95GQxVcTZLbvQyYGcJf9dDPood6k9PCFiAXIbQ/qFPvk1lHnCBw
         HrkdKqbVkCQJihhe6frlGhkEuePZT2JM6IOAXOTy41F5p7D2Sd+Ed/LgQUoa2MpEM9f/
         2uCq7DNGcI2d4rFm7zoZyvP9vEXJmidgF+OwGzq4sfU8q6YaaLsdHKpXZ+VJFGnviwJN
         vG9JHQnN10SFFrvyITfJYQjfeC06v+Lmjovlyd7AKsz0Nhm8RJEivwzHVUmjwUINbsEc
         wZzXPGMCm0zb9ETbFr8Wq3cZCjSx6NymcHx5zimfJ4fk2cwHOYX8fPoP4plkgH7v9Hti
         kj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3dAQpY+DzMdkCcRTUFylYp5SGB/8UdN06tL6dHz3kik=;
        b=U697u0uD9E0XOlxIWjzp4nwDFxLFOUqcw9i4YxWyPZF7D+MevzAGPe/HW4CHDILnpG
         yIcIpDDfEKxLYR5W0fVSAQHDGRjvsTvPoYtnVIm7nTCKkyG3Sxkm58WQGem09q3+osYU
         YZSzB8s/PUf8j0ENFGrTC+xrrLbj79RbJ/ff4hd1kyg8/VcrMhJx9HZMGhN7ZdPwe9pQ
         /c02EPhuPD+6kprxKucp/g1Ev99N9z9I3IlcK8yLxQY5tzjcxMDv80Tp7a+6zGyVv4kY
         9SwJoQBIqHOo5AcMndpUjEx9w9WJJizxPYyvqC0bqnFzBPYIuLhj+usoPJWU2TXAzxa4
         miHw==
X-Gm-Message-State: AOAM533gxGE+7cvH29D/eRjZaQNuRtkilCgyQ7XTISDRRXcrQlnYbSI3
        1vvCZSQQjK8OoqsiMDWsPFeBgZUKE9s75Fc=
X-Google-Smtp-Source: ABdhPJwN2kFKFMLh/Opfzspf37t0xyJtV0OsBDMWp99J3KlhbJuQ6N78CSbOZ0yhMhj6MNLm4XNR36o6FZSRZiU=
X-Received: by 2002:aa7:8298:: with SMTP id s24mr26645673pfm.21.1593632589672;
 Wed, 01 Jul 2020 12:43:09 -0700 (PDT)
Date:   Wed,  1 Jul 2020 12:42:58 -0700
In-Reply-To: <20200701194259.3337652-1-saravanak@google.com>
Message-Id: <20200701194259.3337652-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v1 2/3] driver core: Rename dev_links_info.defer_sync to defer_hook
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defer_sync field is used as a hook to add the device to the
deferred_sync list. Rename it so that it's more meaningful for the next
patch that'll also use this field as a hook to a deferred_fw_devlink
list.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 22 +++++++++++-----------
 include/linux/device.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 35cc9896eb9e..d1d2cdc3a8d8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -754,11 +754,11 @@ static void __device_links_queue_sync_state(struct device *dev,
 	 */
 	dev->state_synced = true;
 
-	if (WARN_ON(!list_empty(&dev->links.defer_sync)))
+	if (WARN_ON(!list_empty(&dev->links.defer_hook)))
 		return;
 
 	get_device(dev);
-	list_add_tail(&dev->links.defer_sync, list);
+	list_add_tail(&dev->links.defer_hook, list);
 }
 
 /**
@@ -776,8 +776,8 @@ static void device_links_flush_sync_list(struct list_head *list,
 {
 	struct device *dev, *tmp;
 
-	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
-		list_del_init(&dev->links.defer_sync);
+	list_for_each_entry_safe(dev, tmp, list, links.defer_hook) {
+		list_del_init(&dev->links.defer_hook);
 
 		if (dev != dont_lock_dev)
 			device_lock(dev);
@@ -815,12 +815,12 @@ void device_links_supplier_sync_state_resume(void)
 	if (defer_sync_state_count)
 		goto out;
 
-	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
+	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_hook) {
 		/*
 		 * Delete from deferred_sync list before queuing it to
-		 * sync_list because defer_sync is used for both lists.
+		 * sync_list because defer_hook is used for both lists.
 		 */
-		list_del_init(&dev->links.defer_sync);
+		list_del_init(&dev->links.defer_hook);
 		__device_links_queue_sync_state(dev, &sync_list);
 	}
 out:
@@ -838,8 +838,8 @@ late_initcall(sync_state_resume_initcall);
 
 static void __device_links_supplier_defer_sync(struct device *sup)
 {
-	if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(sup))
-		list_add_tail(&sup->links.defer_sync, &deferred_sync);
+	if (list_empty(&sup->links.defer_hook) && dev_has_sync_state(sup))
+		list_add_tail(&sup->links.defer_hook, &deferred_sync);
 }
 
 static void device_link_drop_managed(struct device_link *link)
@@ -1052,7 +1052,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
-	list_del_init(&dev->links.defer_sync);
+	list_del_init(&dev->links.defer_hook);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -2171,7 +2171,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
-	INIT_LIST_HEAD(&dev->links.defer_sync);
+	INIT_LIST_HEAD(&dev->links.defer_hook);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..9bb2bc7bb8e3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -433,7 +433,7 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
- * @defer_sync: Hook to global list of devices that have deferred sync_state.
+ * @defer_hook: Hook to global list of devices that have deferred sync_state.
  * @need_for_probe: If needs_suppliers is on a list, this indicates if the
  *		    suppliers are needed for probe or not.
  * @status: Driver status information.
@@ -442,7 +442,7 @@ struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	struct list_head needs_suppliers;
-	struct list_head defer_sync;
+	struct list_head defer_hook;
 	bool need_for_probe;
 	enum dl_dev_state status;
 };
-- 
2.27.0.212.ge8ba1cc988-goog

