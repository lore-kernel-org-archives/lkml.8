Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B3C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6620722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXJTQiFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCYJIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:08:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51636 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:08:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so1470153wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIUdQLhj5Pc75TUvcZ0tOKDsdZmwm019gn6D+9JuS6w=;
        b=mXJTQiFObD2+7P3KfspCMe5UXynkuywXffCR5WsPA8tjfynSlKOm0NBB3QjoP6LDzq
         Wz0zHDBmyOJbKrtLWVHfevcqnJJEFvjZyMSjaa/Bn8/dwCNTCI8Wmcv7xZqpHp0erP0u
         vn1QTutDwin4d0cZ+3DAgpaV22CxUd0RoPJrkS1a1U70332X0oYJhY0GBJSNfyXe+hlU
         rXbU1C31crfr3PwWko2cM42XvdDtdDIquSQ6LO2rE7OKT7danHk5SaA/zJDjBXPB3eHy
         kM1rAVSFPSgfQth+b0e3N0nHfM/MQ4PUK5DOT+TpsVpjPGDG3S54I3jUhfUeghNys21x
         Eomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIUdQLhj5Pc75TUvcZ0tOKDsdZmwm019gn6D+9JuS6w=;
        b=Rm8bJmYAbZdjVNAYYP+Il7OGcAAqItPti+/brX+vPOiHXIjs2K/bsmjhN+r1DglQFT
         RLtJIOVhnhGlKCswhV1+e3dNjJSw/t50Q4JDop6JPwk3yqApTAEexkWy+EW0Yeibssrv
         rypQRbFfT4V9rH/m0d9QTUBkIIDzixg1g+s1HmWwN5/pxsMTnkUjsEF+QVZKKSdUxnks
         Sf+bZWimsktL0jcBzUvwrhnBFNr0VkCGeh9VQtwV3kJ4/TjeFg7F6bOmB0RXIY9edkor
         9L4c5ptC2Pz9TfxfkMa29KHjOIIw6AgYRdBdlW718l087cZ4e14C8bRtBcf/Y83r2QUu
         rlEQ==
X-Gm-Message-State: ANhLgQ3CjqZHy8PAlMOm4s7PiY5abAlm/e0j+QSveuEGoecwRRSfThc4
        rfPLer93GoekRQeSm5kEGy4=
X-Google-Smtp-Source: ADFU+vs4zpchGXsW1LwA3DrZsQ+YXxDctXvUmSKUptU1A50v2mdge/WrAGiWh+lvWepXYhaN5jIHDw==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr2387027wmk.101.1585127315630;
        Wed, 25 Mar 2020 02:08:35 -0700 (PDT)
Received: from wasp.lan (250.128.208.46.dyn.plus.net. [46.208.128.250])
        by smtp.googlemail.com with ESMTPSA id 127sm8565048wmd.38.2020.03.25.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:08:34 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx-request@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bigbeeshane@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        mripard@kernel.org, airlied@linux.ie, David1.Zhou@amd.com
Subject: [PATCH v4 0/3] AMDGPU / RADEON / DRM Fix mapping of user pages
Date:   Wed, 25 Mar 2020 09:07:38 +0000
Message-Id: <20200325090741.21957-1-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to fix a bug in amdgpu / radeon drm that results in
a crash when dma_map_sg combines elemnets within a scatterlist table. 

There are 2 shortfalls in the current kernel.

1) AMDGPU / RADEON assumes that the requested and created scatterlist
   table lengths using from dma_map_sg are equal. This may not be the
   case using the newer dma-iommu implementation

2) drm_prime does not fetch the length of the scatterlist
   via the correct dma macro, this can use the incorrect length
   being used (>0) in places where dma_map_sg has updated the table
   elements.

   The sg_dma_len macro is representative of the length of the sg item
   after dma_map_sg

Example Crash :
> [drm:amdgpu_ttm_backend_bind [amdgpu]] *ERROR* failed to pin userptr

This happens in OpenCL applications, causing them to crash or hang, on
either amdgpu-pro or ROCm OpenCL implementations

I have verified this fixes the above on kernel 5.5 and 5.5rc using an
AMD Vega 64 GPU

Shane Francis (3):
  drm/prime: use dma length macro when mapping sg to arrays
  drm/amdgpu: fix scatter-gather mapping with user pages
  drm/radeon: fix scatter-gather mapping with user pages

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/drm_prime.c             | 2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.26.0

