Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF44C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B3520857
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="he9usAea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGMWzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGMWzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:55:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F3C08C5DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:16 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so11387174qtr.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsatskZeu6cROzCdokNou7WazNDARulkKT+Df6GvP/E=;
        b=he9usAeaaAWYBNYbwqBs57KtvsMI8J2WQf55xuXlU8oSJyWCF2IdPgt/yKkmTsfzjO
         yTCyDKME1sqmwOx7tmm+X629+8z+0VkZlU06Ltb1qrh+15GJcr+5EoBEpoW/9Qei6E/8
         I04ExgRm46UjR3xyYnaBur78tmPWJi+3sdNJx4jUWKfOiwsAP/+ffAxGR7VgD/GfhKlv
         OAaZ0Iz57cKe8j1NvKOfV6YF57tPi+UKa/wgrI391aASyfypLXF3TaPgXyny7k71dPcr
         LEHOC97z4rbnZCu67PQmeC5vLTIqgdWyBlAi0wsa9EN283JNABDYmimPPaQVRcZmqxlK
         XMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsatskZeu6cROzCdokNou7WazNDARulkKT+Df6GvP/E=;
        b=Sa7aXHi3ToJdfbYDEQeFMV7aRRr4dNBsQT9loUK62mS3pJwP8mAf6aXRWcDPb6P8Ab
         BZ1FMlAARi/aCt343NJK8UyHOXBT4SNn2lTlRK75oavu6zXKFIYTxREELV9wjpfk8hcQ
         2GJtH7R3Mc+D6SUoo3QWU5dfZYj/N6CyTGXKVzAwfigDdQAf/D6mNEtoV+/mnIOQBPrW
         7Gk0iKY6ihZ0AMOtKp8cDfU4kjNSuVc92r24OothEFGQ4Ub5fJ53WSdAgFhO5Be/CIxf
         UWYPkrJmz9HQhQ92ETkMPRgIq/pzIOYXpgLE8KlB1q0b5pKRRnLERLj3U977LGmOyfET
         Ln6A==
X-Gm-Message-State: AOAM530ruxnnMDSctjTTKVrxorGq6Khg9/CP6BtWxjlgLPydkW769Gy8
        pLaqf+wt5fwcUVr9ti/p+TY2yA==
X-Google-Smtp-Source: ABdhPJwEhNUhM0Sdref5tidyi4ZWkR4rO2FHbelarbgx64sfy4MEmxKm6XdqIsIIguOYsf0aC+fozQ==
X-Received: by 2002:ac8:311d:: with SMTP id g29mr1789673qtb.54.1594680915659;
        Mon, 13 Jul 2020 15:55:15 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id f54sm22405752qte.76.2020.07.13.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:55:15 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] drm/msm: reset devfreq freq_table/max_state before devfreq_add_device
Date:   Mon, 13 Jul 2020 18:53:41 -0400
Message-Id: <20200713225345.20556-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713225345.20556-1-jonathan@marek.ca>
References: <20200713225345.20556-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These never get set back to 0 when probing fails, so an attempt to probe
again results in broken behavior. Fix the problem by setting thse to zero
before they are used.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index a22d30622306..aa9775ab52f0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -93,7 +93,11 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
 	/*
 	 * Don't set the freq_table or max_state and let devfreq build the table
 	 * from OPP
+	 * After a deferred probe, these may have be left to non-zero values,
+	 * so set them back to zero before creating the devfreq device
 	 */
+	msm_devfreq_profile.freq_table = NULL;
+	msm_devfreq_profile.max_state = 0;
 
 	gpu->devfreq.devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
 			&msm_devfreq_profile, DEVFREQ_GOV_SIMPLE_ONDEMAND,
-- 
2.26.1

