Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7C120760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBZgm1P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgGATnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgGATnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:43:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:43:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7so12423830ybk.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X4hxLqM/qKm+bCv7S7D3GJGIZ2XzVLEX41FWfF3jC7c=;
        b=lBZgm1P6WHJDSgG/2B1vBDRvgbNcbnkZlWRZBHUyr3VrjUGW04XIa2o/If35nV8O6h
         8QRkWmkGixC/o0oeE9wNDoJObEtZzKkHqKqc50X2FkNxJWD3yK1aS1jmWYbfItkevgkB
         m30rn0YBjT6L1lqwa41a58YDIdf+iTtsLACQTFytsMYnsbJ2TOpNRLne4yXrcBND5TV7
         BgfZAGOcY2z9bmZfYDMRfd3e69H2qBXzKhxwDnpXl+L0fxsD+elw7kh0n0TcJL4M/Yh5
         SXrE7J/usTq1o8tH72Vy2rLrQ5HwQZ0cCEYjQ7J25NsusovwrpyFrgb58tuJImJxo8D0
         p3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X4hxLqM/qKm+bCv7S7D3GJGIZ2XzVLEX41FWfF3jC7c=;
        b=Z395nKLjeZjt8VCq+341AllDNdo5t58gcZwzCHbQgX1eHmZdI9pka4170Q2siXT/0e
         CuQVYFIwdDgGDWexhvQ7gxpki9hlM6kBZHnsFGk1uwDRcPLJlBbYGO+0GMx9VLMF4SAs
         YigbIBAC4+HVMsIKmmnmxWzOYQ8X+8s2o/y3A3tktVWSi20ySlteO/SALQyFF/RToztE
         HA5mBz3scoUNZgy5HlwUNmO0FdDp5qTB/zMg/5TDp43uXR4PDkbB0KjD3LMuDHX6sCWK
         7XVr5Lk+O8t131wxVZwQOayfz7WdFB8VIMpAyhIQBO7YQQozdOelilpo3ISYFZ7BTcgQ
         W/Fg==
X-Gm-Message-State: AOAM532n6DQQO64BrFWbgfzTjMWFp/RA29f83Za0Nx9/UuwbNcjGtPL+
        aYfcdtsRo5byL5U98CusAho7U+2DAWGwpeQ=
X-Google-Smtp-Source: ABdhPJx4d87m+G9jCW0bB6YjMoQXLEXIVwnwPsr0FaSLqU9NkYA5+nCZyE1qZWD470KW1V9UmtvM+HJGV8upo1o=
X-Received: by 2002:a25:be02:: with SMTP id h2mr45142945ybk.315.1593632586987;
 Wed, 01 Jul 2020 12:43:06 -0700 (PDT)
Date:   Wed,  1 Jul 2020 12:42:57 -0700
In-Reply-To: <20200701194259.3337652-1-saravanak@google.com>
Message-Id: <20200701194259.3337652-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v1 1/3] driver core: Don't do deferred probe in parallel with
 kernel_init thread
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

The current deferred probe implementation can mess up suspend/resume
ordering if deferred probe thread is kicked off in parallel with the
main initcall thread (kernel_init thread) [1].

For example:

Say device-B is a consumer of device-A.

Initcall thread					Deferred probe thread
===============					=====================
1. device-A is added.
2. device-B is added.
3. dpm_list is now [device-A, device-B].
4. driver-A defers probe of device-A.
						5. device-A is moved to
						   end of dpm_list
						6. dpm_list is now
						   [device-B, device-A]
7. driver-B is registereed and probes device-B.
8. dpm_list stays as [device-B, device-A].

The reverse order of dpm_list is used for suspend. So in this case
device-A would incorrectly get suspended before device-B.

Commit 716a7a259690 ("driver core: fw_devlink: Add support for batching
fwnode parsing") kicked off the deferred probe thread early during boot
to run in parallel with the initcall thread and caused suspend/resume
regressions.  This patch removes the parallel run of the deferred probe
thread to avoid the suspend/resume regressions.

[1] - https://lore.kernel.org/lkml/CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com/

Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h | 1 -
 drivers/base/core.c | 1 -
 drivers/base/dd.c   | 5 -----
 3 files changed, 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 95c22c0f9036..40fb069a8a7e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -153,7 +153,6 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
-extern void driver_deferred_probe_force_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c..35cc9896eb9e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1323,7 +1323,6 @@ void fw_devlink_resume(void)
 		goto out;
 
 	device_link_add_missing_supplier_links();
-	driver_deferred_probe_force_trigger();
 out:
 	mutex_unlock(&defer_fw_devlink_lock);
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..48ca81cb8ebc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -164,11 +164,6 @@ static void driver_deferred_probe_trigger(void)
 	if (!driver_deferred_probe_enable)
 		return;
 
-	driver_deferred_probe_force_trigger();
-}
-
-void driver_deferred_probe_force_trigger(void)
-{
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.27.0.212.ge8ba1cc988-goog

