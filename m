Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EECC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00A320675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS5iW+1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgCJNcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgCJNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:32:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r15so10836193wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8OGniJ9ezEM9gt13c3po2v7CvB5QI80dkjRxl/nZ7iA=;
        b=jS5iW+1Jof6k6J0551eCvEtxb5WxKQelGzXk2ev4iY+BuOC4Dw2up4/qy07IXyW8/i
         CdB9TlYia0CSKrj2j3Mg+IrkZS7fP6Jaly4fjJJJH9zNni9EIDYZDmO1pq+R1zkFuMQT
         2uw4deG9mOFaXb6reHgBkjA+IV6NN5lasmPYQXpZ/dTK+Ayn8tv6XtRWM4Yrj4ooZ9Ek
         qd8PTW1VVJcl4YHsNiYvD2A5zpplma/yH/Jzar4nywwLnVMwoi0153p1qWdjsYfLOEex
         xDcBhACS0V1cgnmYrO5vJ3QVnZ0jHprKwH/CKvLU258gbgFyTvqVBRh60uC0/s8wa71X
         +3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8OGniJ9ezEM9gt13c3po2v7CvB5QI80dkjRxl/nZ7iA=;
        b=Ad+rLwHsBAYEmQhZzm8BE9twb5qtA4tG2mJ6XvabpOzs8t6w8wfl2amqF1cO5yM8fT
         409Bu6O+3kdadfctXTUVjAiiNjoRYDFhNdHBcA7xBDQFAOTK5PQQ70nGqXEvxRBk0pe4
         4G48uTXQpOxO5EyvadEJGeUVLapmA9nnPBQeqMWYAJJbR8VABmHiU9yjqQQtHXmoREyb
         05R2tuoFg+exidBusHrep9nwzCWDqp/mGTFl2hz4AERl5N01A/zca8yoGpGH8g/eD1/r
         /e9H/VrXOCoXE9B2JPwaPySaEO/Q1FZEP7SQGXLzevUwfiio8ceTBkX4IYPV7KhMETqN
         y1+A==
X-Gm-Message-State: ANhLgQ14a3LODAKfmKnepUBRnRPzhVn5AEkIe/F/rHhAff9ZYjvLUGgT
        bd0EZg2VIOX/Q1pUOJvJ1u0=
X-Google-Smtp-Source: ADFU+vspL/LCXzLaAIfKTgG0AZR6jwCAVdsIr799rs+CFgH0CQns365BUM6DqkgKpyIMWOMCb3N53A==
X-Received: by 2002:adf:e487:: with SMTP id i7mr9937328wrm.151.1583847118180;
        Tue, 10 Mar 2020 06:31:58 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:57 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 12/17] drm/pl111: make pl111_debugfs_init return 0
Date:   Tue, 10 Mar 2020 16:31:16 +0300
Message-Id: <20200310133121.27913-13-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail) drm_debugfs_create_files()
should return void. Therefore, remove its use as the return value in
pl111_debugfs_init(), and have the function return 0 directly.

v2: have pl111_debugfs_init() return 0 instead of void to avoid build
breakage for individual compilation.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_debugfs.c b/drivers/gpu/drm/pl111/pl111_debugfs.c
index 3c8e82016854..5595b19c91ce 100644
--- a/drivers/gpu/drm/pl111/pl111_debugfs.c
+++ b/drivers/gpu/drm/pl111/pl111_debugfs.c
@@ -54,7 +54,9 @@ static const struct drm_info_list pl111_debugfs_list[] = {
 int
 pl111_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(pl111_debugfs_list,
-					ARRAY_SIZE(pl111_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(pl111_debugfs_list,
+				 ARRAY_SIZE(pl111_debugfs_list),
+				 minor->debugfs_root, minor);
+
+	return 0;
 }
-- 
2.25.1

