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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84074C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5991920675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/oQCe8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgCJNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55883 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgCJNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so1410234wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFRDmL4Zh4eJz0dC2VFAElPsXkXME7WPBS85RGbecwI=;
        b=c/oQCe8Fwz9nXwyCf8btmq+zgbJr99OfSghDbrjSIy1YA5iYiHlMrzRXpgKT5wB1Da
         Fh4ojIBfzPvrB45tV1hrtezRqawIqIMOo4KUd90xbjYGKlAWkLxNG31i48yb4HN26ZlQ
         uqRKUr/wC3o/gZA/Q03sK1qjmx8LbSMEPevwbDDYU/JN++tsOlfWs8MmAG3INlxhYFCE
         v13MEvL8Ez4I0QBv0zOLdUyvg+il0Yy7bxgzXLOv16u6EbHAxVDYoK2DF6++KGPGvsuN
         l5oFRLRTY6oSRH24OEYCypr2WvwU/27akBye883DOVFeRNQFBsgWZ5GtPOUDqG5QWBl3
         DeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFRDmL4Zh4eJz0dC2VFAElPsXkXME7WPBS85RGbecwI=;
        b=MsSnqFGolp5qTPJeThrbhlns5XGzJpEQOP5XhmwokJR185G54rRsQqOAtd/RS0SOPJ
         VEos3vZSSan8njWhomUTsG/OpbTCxyukqVZuTlkunsdHKHbbM98QFrqyDVmzgGJtv2bP
         AGc/fIf7i4B6uGxYkRKLNnrvoA4eKFawMzOj9jA5/cNH2j5xrtc4Kl2UNtOas0NldxG8
         5Jd44NjIG7zW+uOcqfx6aWVrK6mN7jk2mJKQcYE955Wn76fuRq1Z90RD+FGJ1ylRy4VD
         B03ql8Ylb0SkkLTF7sRd940qAvERLaYDspnEn6Yr6COja+b9ASdVR37aMstfjGeIpZSD
         xExA==
X-Gm-Message-State: ANhLgQ2H2rY9bgs4S8rsHhKWeSMw/z+MaRTT0scIbtyiUJ0el7y9NpLe
        fcRbSPFVro65Z1xpldJVZRU=
X-Google-Smtp-Source: ADFU+vt3mTlFHG7wS0s9CIbANX1Q58NQ0KUoueq4y7/GIjZiz/VTOo1JSVj1JmRqRXTDtd5kXJwQBQ==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr2377854wmj.12.1583847102585;
        Tue, 10 Mar 2020 06:31:42 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:41 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 06/17] drm/arm: make hdlcd_debugfs_init() return 0
Date:   Tue, 10 Mar 2020 16:31:10 +0300
Message-Id: <20200310133121.27913-7-wambui.karugax@gmail.com>
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
fails and should return void. Therefore, remove its use as the
return value of hdlcd_debugfs_init() and have the latter function return
0 directly.

v2: make hdlcd_debugfs_init() return 0 instead of void to ensure that
each patch compiles individually.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 2e053815b54a..bd0ad6f46a97 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -226,8 +226,10 @@ static struct drm_info_list hdlcd_debugfs_list[] = {
 
 static int hdlcd_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(hdlcd_debugfs_list,
-		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
+	drm_debugfs_create_files(hdlcd_debugfs_list,
+				 ARRAY_SIZE(hdlcd_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
 #endif
 
-- 
2.25.1

