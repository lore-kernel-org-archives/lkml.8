Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC852075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJtRpaou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgEKXdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728126AbgEKXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:32:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9269FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s11so1782930pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f57mkmMeRTJCb8idtqQpGeSZRnG7x3GSllIy/j0B6ps=;
        b=oJtRpaouFh2xn/BoHj9my+gKng1zvIAso0350ay6tgxJO0+q1s8oy5DdHFY++0HiM/
         ivJd9c/Ul0UqH6avGf2y3YzIYmHAZ64P34jVKAe4J8jBVxp90U5/cFLom0IpYd5+sKLF
         cW5HbuxigR2XNORwYuQXr8hsVIyO8y8O6O5G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f57mkmMeRTJCb8idtqQpGeSZRnG7x3GSllIy/j0B6ps=;
        b=R/k2eAGEoCD0sYO2KEHq6cXn8EWchq47uyXcjIlt8samvJ7XmAaatzPl+lNrSRfvc6
         BiYMmIOYVnL2l6P7KDzGN3/Pc+yNqD7Tb4mdrE6Kp/YGnipkWeLCOzEYqPXR4MSe9r6l
         fLOvV+lTgKbLrSqtaEVlL5sCKJDiDh17UhvjoPdRgbdXVMhcgzmwOikRZS5SCcnoMVro
         9R6vgliPxdyemajc+cx1OQBx9ecydXni8lGI1m1wGlSJ4eUXrc/Se2Gyd1AeveQdbNU8
         2gUQLOW+J38kePylDQV/PR4oz553OE2x6j3fIrSuboyO9s4VMtopFzTp6Ti573nFkcIB
         V/pA==
X-Gm-Message-State: AGi0PualWCVd7jjuqLY9njXbNOqQitedGhfw4p11+7BR0KsH9oVVZpxk
        7Utmzx2VHgHkTBHOHudmJdA+4A==
X-Google-Smtp-Source: APiQypKFYj6kjh3yVfGdOaUuvQtzDiI9MAfZIVYNvL1SGyAtiMuKXOoZS59PFfe8qrOZO9tn2n7Vhg==
X-Received: by 2002:a63:fb4b:: with SMTP id w11mr17189987pgj.123.1589239958065;
        Mon, 11 May 2020 16:32:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ce21sm11013229pjb.51.2020.05.11.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:32:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v8 07/11] pstore/zone: Provide way to skip "broken" zone for MTD devices
Date:   Mon, 11 May 2020 16:32:25 -0700
Message-Id: <20200511233229.27745-8-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511233229.27745-1-keescook@chromium.org>
References: <20200511233229.27745-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WeiXiong Liao <liaoweixiong@allwinnertech.com>

One requirement to support MTD devices in pstore/zone is having a
way to declare certain regions as broken. Add this support to
pstore/zone.

The MTD driver should return -ENOMSG when encountering a bad region,
which tells pstore/zone to skip and try the next one.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-9-git-send-email-liaoweixiong@allwinnertech.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c             | 10 ++++--
 fs/pstore/zone.c            | 65 ++++++++++++++++++++++++++++++-------
 include/linux/pstore_blk.h  |  3 +-
 include/linux/pstore_zone.h | 12 ++++---
 4 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 9f1f0d5b3795..8c78eb9906fb 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -109,9 +109,12 @@ struct bdev_info {
  *		means error.
  * @write:	The same as @read, but the following error number:
  *		-EBUSY means try to write again later.
+ *		-ENOMSG means to try next zone.
  * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters and return value
- *		are the same as @read.
+ *		if you do not care panic log. The parameters are relative
+ *		value to storage.
+ *		On success, the number of bytes should be returned, others
+ *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
  */
 struct pstore_device_info {
 	unsigned long total_size;
@@ -339,6 +342,9 @@ static ssize_t psblk_blk_panic_write(const char *buf, size_t size,
 	/* size and off must align to SECTOR_SIZE for block device */
 	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
 			size >> SECTOR_SHIFT);
+	/* try next zone */
+	if (ret == -ENOMSG)
+		return ret;
 	return ret ? -EIO : size;
 }
 
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index d83b24f3cdd9..110a38242f74 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -249,6 +249,9 @@ static int psz_zone_write(struct pstore_zone *zone,
 
 	return 0;
 dirty:
+	/* no need to mark dirty if going to try next zone */
+	if (wcnt == -ENOMSG)
+		return -ENOMSG;
 	atomic_set(&zone->dirty, true);
 	/* flush dirty zones nicely */
 	if (wcnt == -EBUSY && !is_on_panic())
@@ -391,7 +394,11 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 			return -EINVAL;
 
 		rcnt = info->read((char *)buf, len, zone->off);
-		if (rcnt != len) {
+		if (rcnt == -ENOMSG) {
+			pr_debug("%s with id %lu may be broken, skip\n",
+					zone->name, i);
+			continue;
+		} else if (rcnt != len) {
 			pr_err("read %s with id %lu failed\n", zone->name, i);
 			return (int)rcnt < 0 ? (int)rcnt : -EIO;
 		}
@@ -726,24 +733,58 @@ static void psz_write_kmsg_hdr(struct pstore_zone *zone,
 		hdr->counter = 0;
 }
 
+/*
+ * In case zone is broken, which may occur to MTD device, we try each zones,
+ * start at cxt->kmsg_write_cnt.
+ */
 static inline int notrace psz_kmsg_write_record(struct psz_context *cxt,
 		struct pstore_record *record)
 {
+	int ret = -EBUSY;
 	size_t size, hlen;
 	struct pstore_zone *zone;
-	unsigned int zonenum;
+	unsigned int i;
 
-	zonenum = cxt->kmsg_write_cnt;
-	zone = cxt->kpszs[zonenum];
-	if (unlikely(!zone))
-		return -ENOSPC;
-	cxt->kmsg_write_cnt = (zonenum + 1) % cxt->kmsg_max_cnt;
+	for (i = 0; i < cxt->kmsg_max_cnt; i++) {
+		unsigned int zonenum, len;
+
+		zonenum = (cxt->kmsg_write_cnt + i) % cxt->kmsg_max_cnt;
+		zone = cxt->kpszs[zonenum];
+		if (unlikely(!zone))
+			return -ENOSPC;
+
+		/* avoid destroying old data, allocate a new one */
+		len = zone->buffer_size + sizeof(*zone->buffer);
+		zone->oldbuf = zone->buffer;
+		zone->buffer = kzalloc(len, GFP_KERNEL);
+		if (!zone->buffer) {
+			zone->buffer = zone->oldbuf;
+			return -ENOMEM;
+		}
+		zone->buffer->sig = zone->oldbuf->sig;
+
+		pr_debug("write %s to zone id %d\n", zone->name, zonenum);
+		psz_write_kmsg_hdr(zone, record);
+		hlen = sizeof(struct psz_kmsg_header);
+		size = min_t(size_t, record->size, zone->buffer_size - hlen);
+		ret = psz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
+		if (likely(!ret || ret != -ENOMSG)) {
+			cxt->kmsg_write_cnt = zonenum + 1;
+			cxt->kmsg_write_cnt %= cxt->kmsg_max_cnt;
+			/* no need to try next zone, free last zone buffer */
+			kfree(zone->oldbuf);
+			zone->oldbuf = NULL;
+			return ret;
+		}
 
-	pr_debug("write %s to zone id %d\n", zone->name, zonenum);
-	psz_write_kmsg_hdr(zone, record);
-	hlen = sizeof(struct psz_kmsg_header);
-	size = min_t(size_t, record->size, zone->buffer_size - hlen);
-	return psz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
+		pr_debug("zone %u may be broken, try next dmesg zone\n",
+				zonenum);
+		kfree(zone->buffer);
+		zone->buffer = zone->oldbuf;
+		zone->oldbuf = NULL;
+	}
+
+	return -EBUSY;
 }
 
 static int notrace psz_kmsg_write(struct psz_context *cxt,
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 4501977b1336..ccba8c068752 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -14,7 +14,8 @@
  * @start_sect: start sector to block device
  * @sects: sectors count on buf
  *
- * Return: On success, zero should be returned. Others mean error.
+ * Return: On success, zero should be returned. Others excluding -ENOMSG
+ * mean error. -ENOMSG means to try next zone.
  *
  * Panic write to block device must be aligned to SECTOR_SIZE.
  */
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 6f16b0dd834a..e79a18e41064 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -23,11 +23,15 @@ typedef ssize_t (*pstore_zone_write_op)(const char *, size_t, loff_t);
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
  *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but -EBUSY means try to write again later.
+ *		mean error.
+ * @write:	The same as @read, but the following error number:
+ *		-EBUSY means try to write again later.
+ *		-ENOMSG means to try next zone.
  * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters and return value
- *		are the same as @read.
+ *		if you do not care panic log. The parameters are relative
+ *		value to storage.
+ *		On success, the number of bytes should be returned, others
+ *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
  */
 struct pstore_zone_info {
 	struct module *owner;
-- 
2.20.1

