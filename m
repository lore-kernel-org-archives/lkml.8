Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CCC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE12067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="w9VPh/OO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBSQRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:17:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33632 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgBSQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:17:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so344927pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Uy6UkLvPHbCZFb2G0DtVigJYqThbQGxt+hlDRaLD/UQ=;
        b=w9VPh/OOAHC9E9VFvJmLCc/TOWjFbMLZG1/5InWeEHD12l9q868DkpMO5zp7aoG3Ha
         rszRtkBZZ5YvkgDWq3I9I+TKWpkOBkJbH2dyzleehHPl+tXyCnhmcAQ8GdDYPCsX0nSO
         ZdlC3OWMAKxUDr7JqoZTIiAK9fJYvsTuJZgDIRnQW8+IahJPxoZ9aIDV9X2GtgVj8CBa
         0FYDDKTDVdMjznxuYVbmNFha/uLnvYZOJNjezDkmBc2FqnR00jfaiuHWH/6gr5teT1Ne
         JWW1G7ryfir6R68jKsNaYllh/u/FfKaevs/5VdkjFX9P0ajKwxdINyWCHjDXmhJkx32v
         zk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Uy6UkLvPHbCZFb2G0DtVigJYqThbQGxt+hlDRaLD/UQ=;
        b=HGgjJ0oOQCkhg/7KBBfFhwwtNaFINKY8jxQfsVkXFiWpVjYSXz3fwfmftA3SosczED
         KwngiO2i/TknXcQ4CFcIhXJPTuuThj8+wgNOnZ1Y8nRYKHgB9rKZUtGf0KcarAZoTOXY
         ueOA9DIu3DPHcuv1/nVTSGsi4RkNG0u9X512ESSQNK4Z3+xLBDBnnKrkeE5efpbePPWC
         zhpKNVnj+knDgiCKkCgv1fRO0l6O/BwQG4F81qCT6kazNJWnscaVqjcvffEte+Jcaa5M
         fhPJvlA8yLFxMnBGMLzbaie1mv+oIAcMZSyOz1OCM5Tqf/85PpCv14cCDxO10Y+owZG5
         fekQ==
X-Gm-Message-State: APjAAAUyffnwzDlW0q5jGJR2E5igD+FyPouZKIQm0eT3soP60BLeFh7T
        IoNl6rGO0y7EDSANhxo0gm5cLw==
X-Google-Smtp-Source: APXvYqy9Eoe+mM9PUgWeyNvkRF6huxYBxkkZz6VqXZpZ/IPHOjItmusPH6NY1cjPY/WVTZmf/9xFLQ==
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr29739694pgi.419.1582129069058;
        Wed, 19 Feb 2020 08:17:49 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id b42sm298534pjc.27.2020.02.19.08.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 08:17:48 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:47:38 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove exfat_fat_sync()
Message-ID: <20200219161738.GA22282@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exfat_fat_sync() is not called anywhere, hence remove it from
exfat_cache.c and exfat.h

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_cache.c | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c4ef6c2de329..e36d01b6fdc9 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -647,7 +647,6 @@ s32 exfat_fat_write(struct super_block *sb, u32 loc, u32 content);
 u8 *exfat_fat_getblk(struct super_block *sb, sector_t sec);
 void exfat_fat_modify(struct super_block *sb, sector_t sec);
 void exfat_fat_release_all(struct super_block *sb);
-void exfat_fat_sync(struct super_block *sb);
 u8 *exfat_buf_getblk(struct super_block *sb, sector_t sec);
 void exfat_buf_modify(struct super_block *sb, sector_t sec);
 void exfat_buf_lock(struct super_block *sb, sector_t sec);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 3fd5604058a9..790ea4df9c00 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -341,25 +341,6 @@ void exfat_fat_release_all(struct super_block *sb)
 	mutex_unlock(&f_mutex);
 }
 
-void exfat_fat_sync(struct super_block *sb)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	mutex_lock(&f_mutex);
-
-	bp = p_fs->FAT_cache_lru_list.next;
-	while (bp != &p_fs->FAT_cache_lru_list) {
-		if ((bp->drv == p_fs->drv) && (bp->flag & DIRTYBIT)) {
-			sync_dirty_buffer(bp->buf_bh);
-			bp->flag &= ~(DIRTYBIT);
-		}
-		bp = bp->next;
-	}
-
-	mutex_unlock(&f_mutex);
-}
-
 static struct buf_cache_t *buf_cache_find(struct super_block *sb, sector_t sec)
 {
 	s32 off;
-- 
2.17.1

