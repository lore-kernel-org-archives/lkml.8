Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208DC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2294216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YnEKZmtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgEASU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEASUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:20:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:20:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v26so8614758qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOiT8FHsMfb+oRC0pzOL8LtbK6cf6y0BAjxvZNjz6Ac=;
        b=YnEKZmtBx1YbYzGPbPdBGbnMbt0OXJjFaApiGvDrsGv6ZgQeTiXlfNGWihSUgqnU2P
         acVdTRVOtrG1eElDWSELNea95hFLWSFZgKAJy+jW8AXS/KdOvgGlVkx0+AwK++ef+Jt/
         fJuDxRG/AWmp5aOHTYtXf2qoZtAj4VOzPGFCk/gR8Ca0wrDCyWOqhcuDCUU1RgedWtNE
         J5mY1cdflLcFJL12S9MfXScHeWZjg98YCscUinNY0SNzrN/luyl28N3Ur9WH9Hr4YznZ
         WBushfQW045XKA0g/Rp6CFxaPq5yD4jBBrUzXNkNpApR2ubGmsZKFBpZ4P+EJajaofml
         PLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOiT8FHsMfb+oRC0pzOL8LtbK6cf6y0BAjxvZNjz6Ac=;
        b=PHwJtMAnrjTu8QTVmJY+Lt4y7B3Ej+FIFducrqNyfGm3/ir0X2HziwF+5kzL1Ztqu8
         2SpvVc0x0dWh+8/VfGvZUHdsucwTutHP7Bo2BBQoZ0EAi5cjaNlQ9XAhJdZdf30ZQJJD
         hzpmeX7MjVUq01BIWR40Y1ik2bifX55MUr0RPqrvkr77MBgs4CLzsexwhYQfUbi2xyAn
         IMISOGghuOVXTzhXogIUCgXkroCkYC320xzE87kchhV2mFGWw/h40pnlgrDuHXfUUYVE
         dZj9CD9OkN8g/0aYiAwLoAjIB40yBbirZHm/fIbThvS2gSpTsOG6tigoaJLkI4DsLGgZ
         hQ7A==
X-Gm-Message-State: AGi0PuZnOtv2YaagZbYNNMqY1cscyTDtZXK54XX1JpRTemzLhxW7PPVn
        W9ROwin+a20ESZJmqTrIOS2oBg==
X-Google-Smtp-Source: APiQypJgulEZ/YatjwuslK7tHEqoq3+2iy5CM5yhNPH1hyfVPJpK8CW6XH0j4J2yKeXBw/W+QKk6yA==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr4601056qtm.99.1588357251210;
        Fri, 01 May 2020 11:20:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 70sm3240374qkh.67.2020.05.01.11.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUaHI-0006ol-NA; Fri, 01 May 2020 15:20:48 -0300
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
Subject: [PATCH hmm v2 4/5] mm/hmm: remove HMM_PFN_SPECIAL
Date:   Fri,  1 May 2020 15:20:47 -0300
Message-Id: <4-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is just an alias for HMM_PFN_ERROR, nothing cares that the error was
because of a special page vs any other error case.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
 drivers/gpu/drm/nouveau/nouveau_svm.c   | 1 -
 include/linux/hmm.h                     | 8 --------
 mm/hmm.c                                | 2 +-
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 41ae7f96f48194..76b4a4fa39ed04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -775,7 +775,6 @@ static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
 static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
 	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
 	0, /* HMM_PFN_NONE */
-	0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
 };
 
 /**
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index c68e9317cf0740..cf0d9bd61bebf9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -379,7 +379,6 @@ static const u64
 nouveau_svm_pfn_values[HMM_PFN_VALUE_MAX] = {
 	[HMM_PFN_ERROR  ] = ~NVIF_VMM_PFNMAP_V0_V,
 	[HMM_PFN_NONE   ] =  NVIF_VMM_PFNMAP_V0_NONE,
-	[HMM_PFN_SPECIAL] = ~NVIF_VMM_PFNMAP_V0_V,
 };
 
 /* Issue fault replay for GPU to retry accesses that faulted previously. */
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 0df27dd03d53d7..81c302c884c0e3 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -44,10 +44,6 @@ enum hmm_pfn_flag_e {
  * Flags:
  * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
  * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
- * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
- *      result of vmf_insert_pfn() or vm_insert_page(). Therefore, it should not
- *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
- *      set and the pfn value is undefined.
  *
  * Driver provides values for none entry, error entry, and special entry.
  * Driver can alias (i.e., use same value) error and special, but
@@ -56,12 +52,10 @@ enum hmm_pfn_flag_e {
  * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
  * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
  * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table entry,
- * hmm_range.values[HMM_PFN_SPECIAL] if CPU page table entry is a special one
  */
 enum hmm_pfn_value_e {
 	HMM_PFN_ERROR,
 	HMM_PFN_NONE,
-	HMM_PFN_SPECIAL,
 	HMM_PFN_VALUE_MAX
 };
 
@@ -110,8 +104,6 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
 		return NULL;
 	if (entry == range->values[HMM_PFN_ERROR])
 		return NULL;
-	if (entry == range->values[HMM_PFN_SPECIAL])
-		return NULL;
 	if (!(entry & range->flags[HMM_PFN_VALID]))
 		return NULL;
 	return pfn_to_page(entry >> range->pfn_shift);
diff --git a/mm/hmm.c b/mm/hmm.c
index f06bcac948a79b..2e975eedb14f89 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -301,7 +301,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
-		*pfn = range->values[HMM_PFN_SPECIAL];
+		*pfn = range->values[HMM_PFN_ERROR];
 		return 0;
 	}
 
-- 
2.26.2

