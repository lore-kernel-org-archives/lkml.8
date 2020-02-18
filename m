Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EAC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1092464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeBfRQwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgBRR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:29:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50784 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:29:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3634434wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJCUVuOG5tbGj7Unp2+2ZA6RrFKuCTBt0CDjnpp8ebg=;
        b=DeBfRQwO7WmsMiUEWqqu0pisiFiytN1kRE3ovxPWxXPUPasgOx5xW0HDHV087Z6J3S
         90y+ekqox/Isc0OFu5EzaPyiwh8IISlBzER96+R1SLct3516OZigGU2J7Rfo1WKjP/qJ
         ypaMSnbmhb0U9z87AkcGaI/sqVW6XaIEU14eExHOKin9KMDwgoN+oim2AHWeTkSjtEzm
         NRkMDcoffXeWOMvX9IrfT2xMdxPp3hOQBHbPsOhXirwSVICOu9ji2al0z1UW3xIV3uRI
         hfsgnfE6oKqjlPkAh5+fce+Ejladdoq8D0dPQSH4w2O8fjin8DV+dLlpDA8/fvoaM2CZ
         EQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJCUVuOG5tbGj7Unp2+2ZA6RrFKuCTBt0CDjnpp8ebg=;
        b=rVkYWJDc3+oDJG48XCYg0CP8MiXk20eGfNJafX5q9Cdpz7lD4onVUwNk3W5C31fWsm
         m2vy2DxYJ4AUY/tRa5vBDAx191g7HVcqAlSbjlCvKY+T3guNKvZuIiv5cwYZSQ1bmm2H
         W9s/nqA1VOVOsA13R0E61kR7HqUMcjwLe8NjJ/Szt3tohMDh3VTaJgprDdrgOfrd6o+s
         DDAdb5xNx6P1K8EjMP2XJXvkswYuNx8mIvFm0uTUVLfVE9ugS1JgaATastRe3aTFAf7A
         A8T8tEhrY4WWdR2qtnds7ZxYL2t5T4XfUFkuJVoZ+g/4KkpsDbCxx4SEORmqxWhQj53p
         +PeA==
X-Gm-Message-State: APjAAAWbWtm6J9oFlm7MeB+LVONCBaPM7qDnvTbDh8FLMma5jE9rrGGH
        Kew4YqAwcp2O7dojF34Nr9E/fgQMtNOQtg==
X-Google-Smtp-Source: APXvYqw3tIG1R2etYvj88Ogz3GtK578NDQwQLSkwGjFUdFIVtKGsq/kiEFl+t5zzQIAd9aNUeEIu8Q==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr4165934wmj.43.1582046941333;
        Tue, 18 Feb 2020 09:29:01 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:29:00 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     eric@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/vc4: remove check of return value of drm_debugfs functions
Date:   Tue, 18 Feb 2020 20:28:19 +0300
Message-Id: <20200218172821.18378-8-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary check and error handling for the return value of
drm_debugfs_create_files in vc4_debugfs_init.

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
2.25.0

