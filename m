Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073DAC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24AF20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="noxHwO+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCYIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:50:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgCYIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id w25so1568192wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9l8X4L1wYo/Bu0UrNNDh9XednyRebzGgXHXi0wzQ5Y=;
        b=noxHwO+a8RZLmm/H8YM/X17fO+M9jPDojcTFnZOiHMbgM/KRXHq1P8x5uREIDIg+SF
         FJyG78kJ4A5V4zmcF+8XgOwEhYXMObeC4vPtnUF7+ljYjlpl95BLgqYwdnKo7LCZ8362
         fMrAcLF/+AhFLB+9Ql5EHtE/GKDJZXntL3Cm0Fgxi3F+SNCgAiwDGW5z4M1CYEjP9Uxi
         Z8jEBZkhvqnKXX4DDLrzBKiiOwzJT1EtV4rC3gHx55rli4aHT1xZ+pElPKaPXE9NCBYU
         BFaWMwcEO9q3+pth4qAcHgPBkcBnhbSgfQwOqFk6y6PBvVj8rSNNH0OVsNx727FxypaK
         3njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9l8X4L1wYo/Bu0UrNNDh9XednyRebzGgXHXi0wzQ5Y=;
        b=M+NL4oUpEhrLq7Gg2J6N07ASiR54P5C+A66xfaJSyD+xFn4fNtmMV2mUc6LQkVgnZx
         FX34oqeziH+dg195HBPFKrNwHnzzcDfGSG5DmTc+Uc3l5Gjq4yLvjdf6gTQTXsftaDxE
         1RLcXTResq7GC3KR7MORUwVpuTyjisg3ylDWsadGDF9iiSkFE6sCds3nMm7WpqkeDnqb
         L9t2wgj0LAk8uBoIRYUKPX1OCFNusrXYnZzp6s6LtWPliJBNtcLqcA32dJbB/bCb+jMa
         bJR8o/W5k3qE+JdCel/+uvBpdqiQdd/RJVSmS2bnOR4fD0o/DqApQEERY8Zfm/XVRcrr
         gN2w==
X-Gm-Message-State: ANhLgQ03Oxpz7GgrlolrKiSbQihqS0W/hXfxQ/byfyQRuNFKklYoEmAv
        b3TAXoiS87ffEcIgePgUVoXzTQ==
X-Google-Smtp-Source: ADFU+vt+uw4hhT5gVLqrLThJ7Bn9/HL7QfI6wZ3InIgG/WW9t5QAx3AdZg1AILOEFxruKjtvkGDmDw==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr2427074wmf.4.1585126238688;
        Wed, 25 Mar 2020 01:50:38 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 7/8] drm/fourcc: amlogic: Add modifier definitions for the Scatter layout
Date:   Wed, 25 Mar 2020 09:50:24 +0100
Message-Id: <20200325085025.30631-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325085025.30631-1-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

This introduces the Scatter Memory layout, means the header contains IOMMU
references to the compressed frames content to optimize memory access
and layout.

In this mode, only the header memory address is needed, thus the content
memory organization is tied to the current producer execution and cannot
be saved/dumped neither transferrable between Amlogic SoCs supporting this
modifier.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 84edc5d69613..b49f1d45e1b4 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -840,6 +840,19 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
 
+/*
+ * Amlogic FBC Scatter Memory layout
+ *
+ * Indicates the header contains IOMMU references to the compressed
+ * frames content to optimize memory access and layout.
+ *
+ * In this mode, only the header memory address is needed, thus the
+ * content memory organization is tied to the current producer
+ * execution and cannot be saved/dumped neither transferrable between
+ * Amlogic SoCs supporting this modifier.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER	(2ULL << 0)
+
 /*
  * Amlogic FBC Layout Options
  */
@@ -852,7 +865,8 @@ extern "C" {
  * memory.
  *
  * This mode reduces body layout to 3072 bytes per 64x32 superblock with
- * the basic layout.
+ * the basic layout and 3200 bytes per 64x32 superblock combined with
+ * the scatter layout.
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING	(1ULL << 8)
 
-- 
2.22.0

