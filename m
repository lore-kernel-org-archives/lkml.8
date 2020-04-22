Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E873C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34F20575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eoFRErMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDVAVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDVAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:21:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919FC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l25so762266qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AJD6Oyv0KkjbAk8YeqvLT90vRQu+LIvDFZSopXsRbA=;
        b=eoFRErMA4gp+OK9MtuQ4K4bjXWkeBBeQPbFumCt3H5LHNkqaTX6DBvgor6rkgnO1M7
         rT91T1rPd+vUOAuTDV3NLDyP9NSb9xUHfuPuy1IbETv5fwpEBXwKwar5O8GmjdAlhT1f
         EvU1RP/AaSISFodw/P7iQGUHxtiRd4g80nJIOANv8h9J5b8JidJW1h1FPkCoaZFW2ORG
         wSaif0wopRKyY4vU/o1KkYbu9U/APRXAoQ94U4hSff0L7IxLBX6DYBR7aagLMjZCu1TV
         Wi64MfEMrxnx21mOo5TUh76Znt2Ow3oyfXWzQh+PxqT1pTzAI+rGR4eUGUNVXiIu6XsH
         MOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AJD6Oyv0KkjbAk8YeqvLT90vRQu+LIvDFZSopXsRbA=;
        b=IOXI7EzRC2J1sP2QHBDEnH0wKyg2ew7XVlWqQSB/3v3HuXwGT6WRwNzQ/UDoStf8/n
         92Bk8Nkmbu4nvzu2ZmLEql7lQs4V1A86lATPFBZcEfwpU7QA5b9x1DsJF/f4So3c64l8
         8rKr7QmdV/1+zR6Z/6uJr+Td8A0zMoWN1p465UpADk8Ho1ix/z+AhDU3ZtgoEpffxFr/
         V06a0KXFjsBJU/58HoLaHMdvu4XpvhitaX/Bwo6/gLEHJvKovlLTMVU8u/r4zRUjdlCr
         A1ZOpgTGko4sjA1MP/JbbgbUpeTh1jVFjoRskCdfZX6LKAgE98g2V9WXHL3tO0bDxSvD
         pkUA==
X-Gm-Message-State: AGi0PuaUd0+UJf95KjJujJ6XX1ueRJ4k6AOcEi6oCVHKg4igSxEvlFaE
        44SQeqicXNSRxNPoB0A8NuB9Hg==
X-Google-Smtp-Source: APiQypL7V4/8cAx/9ZlxeBiNsXj+Qtd7NYDaEN35jT+/a0xFMxv1zWFbIOqW9KBRUrqtUtHkDyTw4A==
X-Received: by 2002:a05:620a:249:: with SMTP id q9mr9360042qkn.389.1587514907240;
        Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 18sm2866823qks.98.2020.04.21.17.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 17:21:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jR398-0000Az-C2; Tue, 21 Apr 2020 21:21:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
Subject: [PATCH hmm 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
Date:   Tue, 21 Apr 2020 21:21:42 -0300
Message-Id: <1-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
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
2.26.0

