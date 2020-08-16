Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44391C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C962065D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee6estnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHPHcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgHPHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:32:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49BC061756
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 00:32:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so10120961qtm.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFZnS/H//cCqZ9Tw8SLrqXxLr+Us0XncDMx+0csqM/0=;
        b=Ee6estnCpmTZM2d8Ec7sUyucvgxufFBgzRNx4J7Ya3/fM1RgwV5Y1m5mIRvKjao3xn
         LC5fdc9me6r5H0/jPNtc1VKFoRbCF7l1lJzHFKX4Jrwb9lHeHnzqF4eBB7dSp4OdfG4v
         3w9+he6p2XM3o9yEHqUKW3zS9RsC9Jx060V287sDr976ZAJ2h57evfVm3wCQLuKiOuti
         N3bjHm2Mf6Vy8J/ajzy712FVyXVnLMNjm+ibmv+bNnYb6WF7mM65UO6dyoJvBeFGeIeK
         BK95Y5hWfbg1ZLDSveIMjaHqTuWaS26kA7odMQK2XdZ+G/GhNtJ+Y6MhgrnvBWaN/c63
         QbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFZnS/H//cCqZ9Tw8SLrqXxLr+Us0XncDMx+0csqM/0=;
        b=d6eRZjab0QH55Fo2jME1WcBLKnkLQCwTXBI4/8ustxewUZekXnMDtX1L33EP6jCaQ6
         0l/RvDQauepHS5qSL89W4eIL63XZpMCijFslng1MFocj9suF1UyB4Nv/ywjf3IUWR0No
         G0WwAbKcAb5372ol2wIjiQ966bLTKGhEp3k2NQigdPCn1nzgCMjumtqrTEtbLTEGaQbP
         6pwcvUx/P9N5CkrTJPE7/ovlAwu77kuw0As3HIoMD4m+sp7NQfNLMwvHj1sgTTEsJe0q
         N1galbYiB92JmN+s+pW4e8GqloZQnAWyO5wtxRqFN9z5ywsY/jdaUpVPv9xQ1DCwVU3p
         FMHg==
X-Gm-Message-State: AOAM533onzNt2+gaGi+jki4WAZvpmGSksiB4ALQEuHMyzNzhWuiGxHs1
        C9fOPhSRNaHYVBB1Txsk1OU=
X-Google-Smtp-Source: ABdhPJwR4kKG/SUUTDLLLFXMrlH6ZZa/0RcpTycMvCDMqdZva0Aq7jclXCddTQ5uuGc9JUMM2Ji4Mw==
X-Received: by 2002:ac8:604f:: with SMTP id k15mr8921302qtm.338.1597563139833;
        Sun, 16 Aug 2020 00:32:19 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:4032:a79a:238d:9f7a])
        by smtp.googlemail.com with ESMTPSA id 2sm13231609qki.46.2020.08.16.00.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 00:32:19 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Rodrigo.Siqueira@amd.com,
        wenjing.liu@amd.com, Bhawanpreet.Lakha@amd.com,
        abdoulaye.berthe@amd.com, hersenxs.wu@amd.com,
        jinlong.zhang@amd.com, aric.cyr@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH] drm/amd/display: should check error using DC_OK
Date:   Sun, 16 Aug 2020 03:32:12 -0400
Message-Id: <20200816073214.980424-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core_link_read_dpcd returns only DC_OK(1) and DC_ERROR_UNEXPECTED(-1),
the caller should check error using DC_OK instead of checking against 0

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5cb7b834e459..a60a457fcc8f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4376,9 +4376,9 @@ bool dc_link_get_backlight_level_nits(struct dc_link *link,
 			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
+	if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
 			dpcd_backlight_get.raw,
-			sizeof(union dpcd_source_backlight_get)))
+			sizeof(union dpcd_source_backlight_get)) != DC_OK)
 		return false;
 
 	*backlight_millinits_avg =
@@ -4417,9 +4417,9 @@ bool dc_link_read_default_bl_aux(struct dc_link *link, uint32_t *backlight_milli
 		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+	if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
 		(uint8_t *) backlight_millinits,
-		sizeof(uint32_t)))
+		sizeof(uint32_t)) != DC_OK)
 		return false;
 
 	return true;
-- 
2.25.1

