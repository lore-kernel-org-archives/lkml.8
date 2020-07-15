Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F417C433F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB102071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ot1YDljs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgGOJcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgGOJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E5C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so4889796wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PiTITbm2Lxqlt8bG5B7tvFplfBvl1yIo6Kmzl56a8E=;
        b=ot1YDljse6ITmipQNFdp/KcP8xZbzbxOBK4qefcNjgnfHxNw60L2lro5mVv0rW9trB
         xr2Npa1kR2uT7uymOuPRZNgM2ZhGFlMSbV0mo3Kgzya3FmBYENGlsCqMUYUQgp1d9tvr
         /P8dABajdryamvwlrBC+ByuqqP+zC6hXna+N5dwZL1CFNdhB3gD4golA6UMyTdyuNmv0
         0ZlgVVU6O5mQfZbJm3f0Ky3AsQphpOiLi455stO9nHMXi4mJSLcGSN6Rf0yi1F/4c8pH
         DQnX4W7hWsD9tMc5lpqioldm4TvV3YYEVULshS4NijjO70jTD/tcHlIWD+pWrJ0VZ0AY
         LL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PiTITbm2Lxqlt8bG5B7tvFplfBvl1yIo6Kmzl56a8E=;
        b=bYyMGAp8nhridBq32+4+XpazCduSetE4k1E9Y2k0pC/cdwnXkFtcXWbqeZDHvkNBDA
         mg7C5MhyyI3bZwJysgBw8mRUTBjo5zPehypTw8YfFQUmTKCTb3UrWG5aLlOy3EWBVzLp
         u7h2i0tjR1hgRt4rimSpjjEGHFyLpQSYz2ESN1IUU0TZemOs4GL43Hpt3RaCFHyR0YmN
         o/GCPw9Z9x6aJXJzlzRtbYi9AYlpJPuBgeNz+1+hcX+IgImnH6ruxRLGf/D8HSTqNPlW
         cpsPXfxiBjTw2sYkaEpb2yQ5ivTWMgVSYNegL1eSByajG9gfuXQWcaRLy+1f/7MvmNck
         AvAw==
X-Gm-Message-State: AOAM530dMz/lbOHFaLcKVSPs1QM4xks75W5UK8W0NzDVfvxzpo6zae7b
        5i4JjeT50GPTCuulFGij0VfVqyzcClE=
X-Google-Smtp-Source: ABdhPJzLcC4/hBG4W1UXFYDrQ8+TkBT6n/tQXy5dSXrQ+pSmxaZ5D+Fy9bfnLvg14NXYp0de96+xHg==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr7879408wme.139.1594805536549;
        Wed, 15 Jul 2020 02:32:16 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/8] usb: mtu3: mtu3_trace: Function headers are not suitable for kerneldoc
Date:   Wed, 15 Jul 2020 10:32:04 +0100
Message-Id: <20200715093209.3165641-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715093209.3165641-1-lee.jones@linaro.org>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc headers should only be used to document functions and data
structures.

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog

v2: Removed unrelated reference to build warning

 drivers/usb/mtu3/mtu3_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_trace.c b/drivers/usb/mtu3/mtu3_trace.c
index 4f5e7857ec312..155eae126e5e2 100644
--- a/drivers/usb/mtu3/mtu3_trace.c
+++ b/drivers/usb/mtu3/mtu3_trace.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * mtu3_trace.c - trace support
  *
  * Copyright (C) 2019 MediaTek Inc.
-- 
2.25.1

