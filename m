Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA66C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D478208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F4zt2FGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgEASUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729502AbgEASUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:20:51 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:20:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 71so8560677qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/v1SRW7RLO2DyhUWTLyIJTwDXoWoQz0FjZx07fCIeIw=;
        b=F4zt2FGzsxpHPLdvktVhW3BfaN6xiFRDbuZkmSco75064Myp5HCFf0VMtoTpyF+HiZ
         gRl5jFZA8gibhRyeT6gHVetVqNOQYZUID/RV5pJBKFoOYZa/OvYCZnOIqlLaMbKFSpll
         EAszPsPRiX5trtB1G4f3CckG+aiuyg2V/qlwfz9x20qzG5Mvo6FMMrPDEHY4s7Gr6gh9
         WFyg9Gen7dOr5u6UFXc4Vh8MfWWjJlXbMAECTzKUl1RU3ZMLRbM+iO6qYAj6lWWH3TIF
         tN+zdQYygGrKyLOsgvh/lQT43tb+NndC7zvYZoUsjb0indx6hqFAlW7CKJkjXoZ/HE/q
         mwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v1SRW7RLO2DyhUWTLyIJTwDXoWoQz0FjZx07fCIeIw=;
        b=Q96AdCnkWyXY5BHkYY/WzYmsTZFCSvLrKbAZNMGcAF7dmJzwuZGPVZ4gBGenzHKSYI
         sLbCKll8en4+WWihBVrjCjf5uemj7QqOH85xjbOS469MTnhq0PhubYW8v5TjGspK/9bo
         TWUBvmO0HxsjQRoxMFImipzmsWLUHYRLvJcofEBB1DZwsWle3JLw/JbjmdqJhPzDKU1Y
         uh055lhMrrtHvss7JeQ8y1Powp2NpQsP+CnjLy4GSQHhK6/nRewoRnOMHqo4TvXXRyDW
         8JuYtmGZ2CPIsAPuffahQfqbGq5gWDhvXdWG2jElps7fjOlQPviDGK8mCcg6HIJcBtV5
         Na/w==
X-Gm-Message-State: AGi0PuYau/9FO0Gu0KePu5clSEvP92jw494URpFyvmqLxf8PkWT6nlLp
        lS6dArKsIHEZRvdQl9+MnxVHfw==
X-Google-Smtp-Source: APiQypKho3FfU0G2u2X5Z/Op83RdkxxNU65dMGVqf/F76QTq7UpcGGr2GdyYCLdwVfV5qiEQbT1o3A==
X-Received: by 2002:ac8:40c8:: with SMTP id f8mr5141557qtm.280.1588357249992;
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n10sm3107746qkk.105.2020.05.01.11.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUaHI-0006oO-GN; Fri, 01 May 2020 15:20:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
Date:   Fri,  1 May 2020 15:20:44 -0300
Message-Id: <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

There is no reason for a user to select this or not directly - it should
be selected by drivers that are going to use the feature, similar to how
CONFIG_HMM_MIRROR works.

Currently all drivers provide a feature kconfig that will disable use of
DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
they don't want the overhead.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/powerpc/Kconfig            | 2 +-
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 mm/Kconfig                      | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a926008..8de52aefdc74cc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -455,7 +455,7 @@ config PPC_TRANSACTIONAL_MEM
 config PPC_UV
 	bool "Ultravisor support"
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	depends on DEVICE_PRIVATE
+	select DEVICE_PRIVATE
 	default n
 	help
 	  This option paravirtualizes the kernel to run in POWER platforms that
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index d6e4ae1ef7053a..af5793f3e7c2cf 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -86,10 +86,10 @@ config DRM_NOUVEAU_BACKLIGHT
 
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
-	depends on DEVICE_PRIVATE
 	depends on DRM_NOUVEAU
 	depends on MMU
 	depends on STAGING
+	select DEVICE_PRIVATE
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	default n
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c358c..7ca36bf5f5058e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -805,15 +805,10 @@ config HMM_MIRROR
 	depends on MMU
 
 config DEVICE_PRIVATE
-	bool "Unaddressable device memory (GPU memory, ...)"
+	bool
 	depends on ZONE_DEVICE
 	select DEV_PAGEMAP_OPS
 
-	help
-	  Allows creation of struct pages to represent unaddressable device
-	  memory; i.e., memory that is only accessible from the device (or
-	  group of devices). You likely also want to select HMM_MIRROR.
-
 config FRAME_VECTOR
 	bool
 
-- 
2.26.2

