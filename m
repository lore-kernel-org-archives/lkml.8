Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA20C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CDE208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyQ7OotS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGATnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgGATnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:43:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:43:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 94so17221566qtb.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RNo7BV5Oou7hkj/VlWeebNh0BIZznccS6eLAmKTw21I=;
        b=WyQ7OotSF738GXLwDI0AZXkknc4DpNr5GZpPUpTN9wSe1Ok6OG3iUT7SifouDzp7iL
         OOCxXZMScXvO1Zgu9VgQ6KZxYoaTXixClsluL3heSghrh0LQ5hXs6+lesForYZ4YESlh
         6GIP1CxlNj9GrtDWx4yJ4RhgFJC2+asg3ZoSe1G8myKawONTWcsyHOtl+zrMWsJebDmL
         l6/CjTmnJGwzugUbbCqalTl6E6UhpcKaKGLtklTMpEF5EIcTTCho3qfiSRFEgb7iQTAK
         2lOVYSGCJ5IWLsz6qqKtrIqEYeA/0gBVN6+b25I+ikykR7A3nKiQ+e1AJNmLEoDeCjZs
         HHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RNo7BV5Oou7hkj/VlWeebNh0BIZznccS6eLAmKTw21I=;
        b=kyJpIb5ArSavm+dQEtQfjNLfdr3ovwsrQExzKRqSBIxqqagl5D91aJxsKrlS+GEV/k
         RjW9QCwG6eIqRiB0KpMmAXyftw0qmaHXrDsb9EwG1Q01xRDD3WbRUdcACY/pmdpCDdjV
         wCfiDNPOFNy6n1pPnRp3SOPQ68Kwu0ka9gpz7ePVua96rJuy/cIrI/uYFzJLjq78LMl9
         2qRQMrBlptcTiW41BvtvYRcytrOJvC+TjfQJPu6rQZFX3X6CZM06hpOM0nCRfdy+ahGg
         5QEnJ7FBssFfZpit3CtdRZFTJ0Kaf/lCBMbJugK0jY5ciiYenfUOKpZzIW22Eyo3Scld
         wLRA==
X-Gm-Message-State: AOAM531w3wvv6mMGek87ue5OqMAi2+Hg5oBZkcKG25z87jgvY6FPZHpT
        A+cAGVzOu0y2TKaZcIf/lvXM430eJtut9VY=
X-Google-Smtp-Source: ABdhPJw1ENNKo02v+Etu3anTvX9igMA3mFZCj36ThlNIJPiDecxKWeubGSH+NOUsFiu70H72Ou/MGTidiUp3VIE=
X-Received: by 2002:a0c:d687:: with SMTP id k7mr19362642qvi.42.1593632592297;
 Wed, 01 Jul 2020 12:43:12 -0700 (PDT)
Date:   Wed,  1 Jul 2020 12:42:59 -0700
In-Reply-To: <20200701194259.3337652-1-saravanak@google.com>
Message-Id: <20200701194259.3337652-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v1 3/3] driver core: Avoid deferred probe due to fw_devlink_pause/resume()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the earlier patch in this series, all devices that deferred probe
due to fw_devlink_pause() will have their probes delayed till the
deferred probe thread is kicked off during late_initcall. This will also
affect all their consumers.

This delayed probing in unnecessary. So this patch just keeps track of
the devices that had their probe deferred due to fw_devlink_pause() and
attempts to probe them once during fw_devlink_resume().

Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 21 +++++++++++++++++++++
 include/linux/device.h |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d1d2cdc3a8d8..05d414e9e8a4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -50,6 +50,7 @@ static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static unsigned int defer_fw_devlink_count;
+static LIST_HEAD(deferred_fw_devlink);
 static DEFINE_MUTEX(defer_fw_devlink_lock);
 static bool fw_devlink_is_permissive(void);
 
@@ -1244,6 +1245,12 @@ static void fw_devlink_link_device(struct device *dev)
 			fw_ret = -EAGAIN;
 	} else {
 		fw_ret = -ENODEV;
+		/*
+		 * defer_hook is not used to add device to deferred_sync list
+		 * until device is bound. Since deferred fw devlink also blocks
+		 * probing, same list hook can be used for deferred_fw_devlink.
+		 */
+		list_add_tail(&dev->links.defer_hook, &deferred_fw_devlink);
 	}
 
 	if (fw_ret == -ENODEV)
@@ -1312,6 +1319,9 @@ void fw_devlink_pause(void)
  */
 void fw_devlink_resume(void)
 {
+	struct device *dev, *tmp;
+	LIST_HEAD(probe_list);
+
 	mutex_lock(&defer_fw_devlink_lock);
 	if (!defer_fw_devlink_count) {
 		WARN(true, "Unmatched fw_devlink pause/resume!");
@@ -1323,8 +1333,19 @@ void fw_devlink_resume(void)
 		goto out;
 
 	device_link_add_missing_supplier_links();
+	list_splice_tail_init(&deferred_fw_devlink, &probe_list);
 out:
 	mutex_unlock(&defer_fw_devlink_lock);
+
+	/*
+	 * bus_probe_device() can cause new devices to get added and they'll
+	 * try to grab defer_fw_devlink_lock. So, this needs to be done outside
+	 * the defer_fw_devlink_lock.
+	 */
+	list_for_each_entry_safe(dev, tmp, &probe_list, links.defer_hook) {
+		list_del_init(&dev->links.defer_hook);
+		bus_probe_device(dev);
+	}
 }
 /* Device links support end. */
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 9bb2bc7bb8e3..5efed864b387 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -433,7 +433,8 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
- * @defer_hook: Hook to global list of devices that have deferred sync_state.
+ * @defer_hook: Hook to global list of devices that have deferred sync_state or
+ *		deferred fw_devlink.
  * @need_for_probe: If needs_suppliers is on a list, this indicates if the
  *		    suppliers are needed for probe or not.
  * @status: Driver status information.
-- 
2.27.0.212.ge8ba1cc988-goog

