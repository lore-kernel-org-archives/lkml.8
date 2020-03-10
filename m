Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED39C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0720675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg7L82DW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgCJNbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39097 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgCJNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so10835299wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGZgsH+padUygQ4Cia7cE9IFr+EvRgTaa32npdrtzWc=;
        b=dg7L82DWEiw0rdSwNr2DyRTaCTid+TPApdVxlafYq4AipWASzO9UjWBGoMzbQJU6Zn
         FcVLsljOgCFtV5tGCTDxvDcuENshSrjaqclQu4DLXYnyd8VwAbcmXaWptQDIIYRw0Mvk
         GfnIfAsgFE5LdRwk/p4NdBb6D+Uq0KG6pshRkMgRIvf6pPtcA8H2C1Ld55MdENrIXKZu
         mkPa1OnuzhVbyD5tQK6tLNKfwzIiV3aSe9+2HBqE759pdILSJw5zeVMxsZck4Utc0qZ+
         C6UhWibz+kjEltkkuyRd9QtNDvhPDu8h1CTszvI2gctrxNmY3IxCfDWcM8Y3KUJM5hWP
         6ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGZgsH+padUygQ4Cia7cE9IFr+EvRgTaa32npdrtzWc=;
        b=b2SI+1kQ67yITQ4b8NHt6pTbKnH/xBZ09U2DIhSADVw2aHl3hB5o17VPx/J88AtYQo
         kIXO01KX8/FvYU+hHW9PWk9wDxO8KWhiLFEkCwhngD5kCNkG4nwG1y4gtRhFGsUze48d
         yMVqc8EI0E6K8CZ4tU9E+MtDS59K3c0aBCiw4Xgklk6uJYjixCwa3YuWMawGnhxygVvR
         Ll7IeAA96LnQ0kPgTAaBB4T2ZvQ0EbCy9PuGeLrSFb8b2cz4UYDpYRYxPP/917AksTu6
         FBcBRhQ0EtsplViF5jVOQsK4pFwgOWqrcvFrTjB4xcSglpwI0tsJq8LOqElMLwId8m1u
         GYJg==
X-Gm-Message-State: ANhLgQ0lc96i0wOzsFKEHHOClgGoiYION52DLRElUfWh3atZIhgf05IH
        kMp71yDfiIwkRe2IHbqCB9Y=
X-Google-Smtp-Source: ADFU+vuTm8NKlxrWVPle4ZIU7qSC/syjzXhDqkYplHXSPQAFccyI2BA7t9nw37f8vOWSAuPKPa5K7Q==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr28701764wrn.128.1583847105552;
        Tue, 10 Mar 2020 06:31:45 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:44 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, etnaviv@lists.freedesktop.org
Subject: [PATCH v2 07/17] drm/etnaviv: remove check for return value of drm_debugfs_create_files()
Date:   Tue, 10 Mar 2020 16:31:11 +0300
Message-Id: <20200310133121.27913-8-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and only returns 0. Therefore, remove the unnecessary check of its
return value and error handling in etnaviv_debugfs_init() and have the
function return 0 directly.

v2: have etnaviv_debugfs_init() return 0 instead of void to ensure
individual compilation and avoid build breakage.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6b43c1c94e8f..a65d30a48a9d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -233,19 +233,11 @@ static struct drm_info_list etnaviv_debugfs_list[] = {
 
 static int etnaviv_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
-	int ret;
-
-	ret = drm_debugfs_create_files(etnaviv_debugfs_list,
-			ARRAY_SIZE(etnaviv_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(etnaviv_debugfs_list,
+				 ARRAY_SIZE(etnaviv_debugfs_list),
+				 minor->debugfs_root, minor);
 
-	if (ret) {
-		dev_err(dev->dev, "could not install etnaviv_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.25.1

