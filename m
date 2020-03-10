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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C328324649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsgViamH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgCJNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55877 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgCJNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so1409952wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXUXpfsdCjWegFjK6o49/yfS5Hf4azfEJHKKYm1M5aw=;
        b=dsgViamHkuqL5E/qu4DHG2LJlKsYVc627GdlasOH5Z89EYsnD5i5Nw17QW4E9KKkqo
         XbsZ4XCLuBtfssOPNBC3TZqU8fw9oWFxQQG9FlqUaiowl9Sa1lm6xk3pQcZi1jGcy+Sv
         lF1h5ynuNO3P7z4/azbtL6hvN5dT37YcyjWyeK5gXNMjTdLYbVpLHRRMeGXtVr5OGqVP
         VaeuDz5Mp6azujkEkxS0J94Ko7p55X5bQpmLFUR8/upcFDTOaTJFOyc08XiE7w1lJUo5
         xD2q3LkyLcdtEd59fgCfa816rmpnvqjms+dukHMz2+IG1Oe3B0PmuW8xw8h8FbJr18JI
         RJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXUXpfsdCjWegFjK6o49/yfS5Hf4azfEJHKKYm1M5aw=;
        b=MC/aRtxTCH6KWP04QMUc8tRYo0jGiF9MoHxDT5qE5h9ubgYwxbZfzlCvF81SGk6L6d
         bgievh8PoXJUPgaKiJCm/ufWHyesGgoHRCk9AF+d7nhBPwyPRoLWN710wdUAduI9s685
         98nF+roMLYhEtd92dHfZSEVDhUlVh7BAS8NbfAbS9yOf4h6qdVFb9c9LQzso6KA0rQuq
         OegQtUJduZe5gswRdmo9wZLMIudG6D77vWBoVOG5LFwdarc/kU2vpoIuNOaANr3+K/jC
         4yv/LCeGbQDn/3BtzyY6nYkANap1ud/4DqjBU3jJL6Fw3jhrzm3vZdlksldO/rczSTCE
         XAJg==
X-Gm-Message-State: ANhLgQ2wZHSVXdXF650mw1b/smshm6QWNYyOUriAnMwrWH/jfsjNl3QM
        yL+bWhsbJGmQNzFM04z5GUI=
X-Google-Smtp-Source: ADFU+vt6mBL4lirRwCfawoFlTde/BBVc6SCRegcT2K0roRx4Tto3ds4ertE+WbaEScxvCAapXCTVaA==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr2236302wmb.181.1583847097802;
        Tue, 10 Mar 2020 06:31:37 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:37 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, eric@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 04/17] drm/vc4: remove check of return value of drm_debugfs functions
Date:   Tue, 10 Mar 2020 16:31:08 +0300
Message-Id: <20200310133121.27913-5-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove unnecessary check and
error handling for the return value of drm_debugfs_create_files()
in vc4_debugfs_init().

v2: remove conversion of vc4_debugfs_init() to void to enable individual
compilation and avoid build issues and breakage.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_debugfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index b61b2d3407b5..1835f12337ec 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -30,11 +30,8 @@ vc4_debugfs_init(struct drm_minor *minor)
 			    minor->debugfs_root, &vc4->load_tracker_enabled);
 
 	list_for_each_entry(entry, &vc4->debugfs_list, link) {
-		int ret = drm_debugfs_create_files(&entry->info, 1,
-						   minor->debugfs_root, minor);
-
-		if (ret)
-			return ret;
+		drm_debugfs_create_files(&entry->info, 1,
+					 minor->debugfs_root, minor);
 	}
 
 	return 0;
-- 
2.25.1

