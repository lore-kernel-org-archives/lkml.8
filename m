Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D5C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12370206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="ZxC8300C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgBWTQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:16:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34005 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:16:37 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so3328442pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xhCwhGQIZ68RTJVI13/7fmg0HCbgaGCnJpEMnTMshms=;
        b=ZxC8300Cu9zoGh3oDdVXtzCtCHURfQr9JHTCzwL86vXe0HQ0SrYHWEnyfEfZ0csUX9
         fK4VhEEr1igymLgFdajezB9DBrxi41pEWBms/Ujf7YNkVBpc0v09l94+L+4UjKX0A+Sg
         mlBNqyEziOTQ+j4/aHyXmwrCElNNnTWtF33U8wEYyT4y1CXVkr7BnbpHAtUGaPBGkhpE
         twEh1ASjXZjhHDdLBUs7B8jsOecVBpv7hUg1svtBu+oKQ6grCHCjefOeNHV/bplT4olQ
         PAwQDURWyJA9B1P7SfZOXghU8SaL2/4/o1LZW57qrw0NuTN2jfMZvGmWJVpp5VXoPIGG
         nstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xhCwhGQIZ68RTJVI13/7fmg0HCbgaGCnJpEMnTMshms=;
        b=MwerDskSQGyiU3f2xB5RZjx+hv21giz6/Dx38Yky8zDh+Ks7iIlqoUSCe7kZNNXfZB
         vJhlw9m1wwtEFa/gW6EIuJqYFfOFj1Jd4Jl7oSY1gebQGd1tF5mmrKf6yK0gBBNvF8M8
         bTUOhGHyvIxi73IhE0Lh8UHc3R55/r1xMwM99icFcGBnkPa8e+d+FXKOEHMDtsgMZySL
         nJwYPPAvdu4AIrzsP9fUyMnbV6mjNpSFoH7nk4cu6iqE33KCVkZ/jdXAcB3oxadF5Fbf
         bQ9ofW4RAe6sZKT6TVx0eO1nIrFjzBHvril5F0XmEntHwIgYQVgCLW86L1To1whVC4sa
         nySA==
X-Gm-Message-State: APjAAAVsQeIUfN9XZhcnruX8APhTzHwS2Q8gCCI2Jha3vfhdDllsH43z
        uKdr86tgBRiF8dFFoRqe86NCbHI4NWv3rQ==
X-Google-Smtp-Source: APXvYqy1jlwQX9XeUc0yGutt90sXGehx0w/DGEuJ7JFIjQsAUqrnzBlCvvj6X/ZdLjfganCz7rbWRQ==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr16601022pjc.16.1582485392234;
        Sun, 23 Feb 2020 11:16:32 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id w128sm8199209pgb.55.2020.02.23.11.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 11:16:31 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:46:23 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove exfat_buf_sync()
Message-ID: <20200223191623.GA20122@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exfat_buf_sync() is not called anywhere, hence remove it from
exfat_cache.c and exfat.h

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_cache.c | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index e36d01b6fdc9..1867d47d2394 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -653,7 +653,6 @@ void exfat_buf_lock(struct super_block *sb, sector_t sec);
 void exfat_buf_unlock(struct super_block *sb, sector_t sec);
 void exfat_buf_release(struct super_block *sb, sector_t sec);
 void exfat_buf_release_all(struct super_block *sb);
-void exfat_buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 790ea4df9c00..87d019972050 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -515,22 +515,3 @@ void exfat_buf_release_all(struct super_block *sb)
 
 	mutex_unlock(&b_mutex);
 }
-
-void exfat_buf_sync(struct super_block *sb)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	mutex_lock(&b_mutex);
-
-	bp = p_fs->buf_cache_lru_list.next;
-	while (bp != &p_fs->buf_cache_lru_list) {
-		if ((bp->drv == p_fs->drv) && (bp->flag & DIRTYBIT)) {
-			sync_dirty_buffer(bp->buf_bh);
-			bp->flag &= ~(DIRTYBIT);
-		}
-		bp = bp->next;
-	}
-
-	mutex_unlock(&b_mutex);
-}
-- 
2.17.1

