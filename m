Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B219C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89862071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iqVybj+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGOXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:46:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB400C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:46:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so2811042pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5jorZC1TkH3ISm4S95AAjWEBEpsvo8bCA396VWT6Ds=;
        b=iqVybj+NsR/y+uI9GLbCm957UqnhBLZOXRPv8IVn2eHO98vAKndW8AkW3UE0GbuyB+
         8XRPwqdUAwz5b7Agz2a5r20JI0fB/uSSlhQBQftNGJAwlxnmY2FHRUXDe3nDoZZAPF2Q
         jN4LDK+FdcNo1yUVKL7gfSqRgv5mGGr/emRL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5jorZC1TkH3ISm4S95AAjWEBEpsvo8bCA396VWT6Ds=;
        b=bzNPNpKbAkYGHp3xl3O+kuvuUGTV39FYAkESURHIIHcMYHCEtgBU1vVqeP4jC9gBgp
         m1JFvw809PfNmA7gyNWYPU5Dw+syinT5aSc2vdJycewdRJABg5CScNuBJHthFpbjynyQ
         3YBuCyTo99VO7mlkyrmStL+PsrRg/I6z+puCuUW/KLd32MFZoP5+V7ExHiBOgMyY5W0U
         Qk97qDWdctpS22+kXSPgBg4XhErQpTMZ63iuk+h9a35W9/E/meGb7FLz48OKxZN4ZX52
         knMMh3qYqcOkTakkR5+Nvbb6YWWGKv46vSLXdfGkywfbALXEKX/BJgTp+MxwSB335na6
         1CxQ==
X-Gm-Message-State: AOAM531dz/tjvVTdZsI/N0EVzu+TARdvZ5x/0A+0vMF9chtQ4wT284Zo
        8Ggv42PWC0GjoL/GHfuYOg6Chg==
X-Google-Smtp-Source: ABdhPJwFl2N0BOA5livG8Sss2jFK57hegzDrN7WQsB/aTtqUX8jnsaqbVioZt9UU0BW5sS75mSkbyA==
X-Received: by 2002:a63:84c3:: with SMTP id k186mr1803546pgd.394.1594856793107;
        Wed, 15 Jul 2020 16:46:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id a19sm3010706pfn.136.2020.07.15.16.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 16:46:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rohit Kumar <rohitkr@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: debugfs: Don't sleep while atomic for fast_io regmaps
Date:   Wed, 15 Jul 2020 16:46:15 -0700
Message-Id: <20200715164611.1.I35b3533e8a80efde0cec1cc70f71e1e74b2fa0da@changeid>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a regmap has "fast_io" set then its lock function uses a spinlock.
That doesn't work so well with the functions:
* regmap_cache_only_write_file()
* regmap_cache_bypass_write_file()

Both of the above functions have the pattern:
1. Lock the regmap.
2. Call:
   debugfs_write_file_bool()
     copy_from_user()
       __might_fault()
         __might_sleep()

Let's reorder things a bit so that we do all of our sleepable
functions before we grab the lock.

Fixes: d3dc5430d68f ("regmap: debugfs: Allow writes to cache state settings")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/regmap/regmap-debugfs.c | 52 ++++++++++++++++------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 089e5dc7144a..f58baff2be0a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -463,29 +463,31 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 {
 	struct regmap *map = container_of(file->private_data,
 					  struct regmap, cache_only);
-	ssize_t result;
-	bool was_enabled, require_sync = false;
+	bool new_val, require_sync = false;
 	int err;
 
-	map->lock(map->lock_arg);
+	err = kstrtobool_from_user(user_buf, count, &new_val);
+	/* Ignore malforned data like debugfs_write_file_bool() */
+	if (err)
+		return count;
 
-	was_enabled = map->cache_only;
+	err = debugfs_file_get(file->f_path.dentry);
+	if (err)
+		return err;
 
-	result = debugfs_write_file_bool(file, user_buf, count, ppos);
-	if (result < 0) {
-		map->unlock(map->lock_arg);
-		return result;
-	}
+	map->lock(map->lock_arg);
 
-	if (map->cache_only && !was_enabled) {
+	if (new_val && !map->cache_only) {
 		dev_warn(map->dev, "debugfs cache_only=Y forced\n");
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
-	} else if (!map->cache_only && was_enabled) {
+	} else if (!new_val && map->cache_only) {
 		dev_warn(map->dev, "debugfs cache_only=N forced: syncing cache\n");
 		require_sync = true;
 	}
+	map->cache_only = new_val;
 
 	map->unlock(map->lock_arg);
+	debugfs_file_put(file->f_path.dentry);
 
 	if (require_sync) {
 		err = regcache_sync(map);
@@ -493,7 +495,7 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 			dev_err(map->dev, "Failed to sync cache %d\n", err);
 	}
 
-	return result;
+	return count;
 }
 
 static const struct file_operations regmap_cache_only_fops = {
@@ -508,28 +510,32 @@ static ssize_t regmap_cache_bypass_write_file(struct file *file,
 {
 	struct regmap *map = container_of(file->private_data,
 					  struct regmap, cache_bypass);
-	ssize_t result;
-	bool was_enabled;
+	bool new_val;
+	int err;
 
-	map->lock(map->lock_arg);
+	err = kstrtobool_from_user(user_buf, count, &new_val);
+	/* Ignore malforned data like debugfs_write_file_bool() */
+	if (err)
+		return count;
 
-	was_enabled = map->cache_bypass;
+	err = debugfs_file_get(file->f_path.dentry);
+	if (err)
+		return err;
 
-	result = debugfs_write_file_bool(file, user_buf, count, ppos);
-	if (result < 0)
-		goto out;
+	map->lock(map->lock_arg);
 
-	if (map->cache_bypass && !was_enabled) {
+	if (new_val && !map->cache_bypass) {
 		dev_warn(map->dev, "debugfs cache_bypass=Y forced\n");
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
-	} else if (!map->cache_bypass && was_enabled) {
+	} else if (!new_val && map->cache_bypass) {
 		dev_warn(map->dev, "debugfs cache_bypass=N forced\n");
 	}
+	map->cache_bypass = new_val;
 
-out:
 	map->unlock(map->lock_arg);
+	debugfs_file_put(file->f_path.dentry);
 
-	return result;
+	return count;
 }
 
 static const struct file_operations regmap_cache_bypass_fops = {
-- 
2.28.0.rc0.105.gf9edc3c819-goog

