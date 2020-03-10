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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5053DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565720675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hne+jWLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgCJNck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgCJNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so1415406wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+a3U4jSbxticLykwAuG4RkKwJpCBQwiZh0yEiI3Sz1U=;
        b=Hne+jWLI3BEBXhjTKXTKSXzecGEn9zVZbio6NzdOolzhUuU35a/RSfPB/0hld5jEHd
         /T79833bgefuOdpb++hrCbv9Slc6giSs2BUjwIYeExhy61lYFZ8aAVWLRBUQZBVsJCvn
         jci4iWqnoA9S1xifYoE2AB45AD6pBtBWzu22LUKnbxts0aRBfKVH9P45hPMwFymWtBG2
         VrtTAG4/N/f/WDTyqzwHAM2vr8G91QxbPOlq2q81u2MpKagSYBVxLvt88rpZEtQoHnUU
         5S9LjWWNtEr0nT6WxADFgDg1F4oJn/UoXC6isCff60o9sBUi/E9f0JBsChihYDu3NqvM
         jJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+a3U4jSbxticLykwAuG4RkKwJpCBQwiZh0yEiI3Sz1U=;
        b=kWzPLCG4U0hBAZ2YFWCwCOh6u7cK5OeHhpPwWNwnxvLLq1T7rcDXX+TrTm7sd77Nwf
         viX/mK6XjxLRLV9wCOIgSYnvWt9ZnJKE3mPGZAKmJuzX8CerF2WZ4RIDwSQd6jUu7wuH
         2eNxj18wWNcYC5enLqi79q/UideHdzc5p3x6DNalS9VVm/xl1jR4gyKniYM5HCJy4aDP
         VOH1uZEMnhshDqMmKLeGAmUW7SMx7hYC5dJgK6x7q6xODpbOfG/RdnqdswOa4gJGjoKH
         8PQW3ivLUMgWA8TMeD3LotppTuErbLB+pLPdAimIrTTuHEYr8hAsS7mBpK8q6+XIkmQu
         jUDQ==
X-Gm-Message-State: ANhLgQ12tPJJZY4ZruyHdgmJmc/Bwb0pGkhOPtvwA/IzvLD+UojvW6nG
        uv2hcJ6N/pfgXX6T1bvCiks=
X-Google-Smtp-Source: ADFU+vtU5VeSEld2wS8M/m4RC1/3sWDuFSBxIzBLiQGjnG2YMcxIEjdiLlbMK9QpWLHIcit2kZZzfg==
X-Received: by 2002:a1c:6108:: with SMTP id v8mr2214208wmb.58.1583847099964;
        Tue, 10 Mar 2020 06:31:39 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:39 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Alexey Brodkin <abrodkin@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 05/17] drm/arc: make arcgpu_debugfs_init() return 0.
Date:   Tue, 10 Mar 2020 16:31:09 +0300
Message-Id: <20200310133121.27913-6-wambui.karugax@gmail.com>
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
return value of arcpgu_debugfs_init() and have the latter function return
0 directly.

v2: convert the function to return 0 instead of void to avoid breaking
the build and ensure that this individual patch compiles properly.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arc/arcpgu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index d6a6692db0ac..660b25f9588e 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -139,8 +139,10 @@ static struct drm_info_list arcpgu_debugfs_list[] = {
 
 static int arcpgu_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(arcpgu_debugfs_list,
-		ARRAY_SIZE(arcpgu_debugfs_list), minor->debugfs_root, minor);
+	drm_debugfs_create_files(arcpgu_debugfs_list,
+				 ARRAY_SIZE(arcpgu_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
 #endif
 
-- 
2.25.1

