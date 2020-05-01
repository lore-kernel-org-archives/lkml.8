Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE8C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B444D208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eYmQvXSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgEASVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729599AbgEASUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:20:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385FC08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:20:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s9so7371828qkm.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9L5E7jU6qZTDlvCOWkCRO/8Kuf781Iwupk1hf9V6HE=;
        b=eYmQvXSg2qYixEnFQmQuL+BJ+s8QgjZuAUWgykXDJtrLFr4P7m0W0/kP4+Y9MPtVGF
         GEtSJxpgWBu1fFkH22lWF08AwssVopEXTWDUEIaIhY1gusdYSK7RSGLQWVyHUcUiscS/
         zC+WOzhPtGtzljjGaHzCeO82gTrSkS/cgxlzAFQnW+Z+1V4rjPNc1V5KavEj8FQOPQJO
         Kn+VMBhPoimubTHqFkT18vbtXQHq2UzpqbTCQon6hutFydkMZzQ4VfcDXSbLuUnRsErB
         sDHwnuX4OpC9+SKhVmRSRGYXmrvVZ7i2dvPleR4e1IM2Qp1itlViF6ePitJ9Y1gWAgkQ
         aagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9L5E7jU6qZTDlvCOWkCRO/8Kuf781Iwupk1hf9V6HE=;
        b=DGebHsSslK7uc5o12u48ZQ59N8LvUFct1ArbNa5iotODxj04oPk0aOa/tN01TZbAZl
         f+9hIgnTw60AmCjcmYEDVFhDYNL8TENRwTI6qjdKAeF3Yfi2fh4OrBoyZf08qcNX24St
         f71Yjb50wAa4UZH+ENqugrYl6hlfRDR7t8O/KHmoZ/Drvg1wnOWaXqVKv3W+4ngrxzm7
         A/vt1M6KFH03nJAApFWBzNY+ZFYgOdFcq5rYWTIzGg0UrAx85MLY/Ndgalfz732lCVZo
         08uBFTNPy6VkQ8wk2AMBlF5/BVuYpzw3USmxCJj9jRRHIe2XZsFTnmXSGf97I5/4bl/8
         tIfg==
X-Gm-Message-State: AGi0PuYJ9M6ifxDItE/try9/1qvhi2+0/6KSP2i5HTVfg6tLA+a/pSoM
        6rP0hl2r5EBxmkCWyEPFwfe1wA==
X-Google-Smtp-Source: APiQypIa020BYepbg1xvIoG68mrjNEDBs6npTd0MXTuT5809Lcttkf/1iLQ1dmFR5/ot2aOBBNAYqg==
X-Received: by 2002:a05:620a:16aa:: with SMTP id s10mr4887237qkj.225.1588357250518;
        Fri, 01 May 2020 11:20:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x24sm3205396qth.80.2020.05.01.11.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUaHI-0006oc-Ly; Fri, 01 May 2020 15:20:48 -0300
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
Subject: [PATCH hmm v2 3/5] drm/amdgpu: remove dead code after hmm_range_fault()
Date:   Fri,  1 May 2020 15:20:46 -0300
Message-Id: <3-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Since amdgpu does not use the snapshot mode of hmm_range_fault() a
successful return already proves that all entries in the pfns are
HMM_PFN_VALID, there is no need to check the return result of
hmm_device_entry_to_page().

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7eb745b8acce0f..41ae7f96f48194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -862,17 +862,13 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 		goto out_free_pfns;
 	}
 
-	for (i = 0; i < ttm->num_pages; i++) {
-		/* FIXME: The pages cannot be touched outside the notifier_lock */
+	/*
+	 * Due to default_flags, all pages are HMM_PFN_VALID or
+	 * hmm_range_fault() fails. FIXME: The pages cannot be touched outside
+	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
+	 */
+	for (i = 0; i < ttm->num_pages; i++)
 		pages[i] = hmm_device_entry_to_page(range, range->pfns[i]);
-		if (unlikely(!pages[i])) {
-			pr_err("Page fault failed for pfn[%lu] = 0x%llx\n",
-			       i, range->pfns[i]);
-			r = -ENOMEM;
-
-			goto out_free_pfns;
-		}
-	}
 
 	gtt->range = range;
 	mmput(mm);
-- 
2.26.2

