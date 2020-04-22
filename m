Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9CC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8213A20706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJU8eX+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDVAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgDVAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:21:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58BC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l78so727556qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEPIJxk11M+bwls0ktX3yeu2tCbVhvYKkshsYLxwJ44=;
        b=PJU8eX+3xC4GFafdKdc5DzhySnCpoyt7nJs8v67HgDINaqKjejFlIyZkRz1SMGAhw7
         s7uCk6tfphwUwyiPpH9jqN9ymuNDMYIObXz70LxBi9HaysQdWxohkFGXN0RvWIlTxp/O
         tk8seckt54OXGh2bDVptRn4OT4fWVGdecI9gba+EmxFSinr4oBL1z6hGl1wB3yCT077w
         vbR/HQjg0rmYIXBXC6owWBUrSADfN+E7jMfKwzS6l5twx5JuWUw+KuKPdYjUryqiun37
         eUhKmuvUjIJxADNxWm6SAsdm2PXKSRXA+mhtSiWZ4LdaaJW+8+0i0QIXND3fe1+0a2J9
         rdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEPIJxk11M+bwls0ktX3yeu2tCbVhvYKkshsYLxwJ44=;
        b=YnsAeo1nxvVK0WHWb3BzCsL5ljt8gUaPOXO7+hFmg6oTIMDTAQ6008snkiyEcH/5Qk
         1m/gogTx96mvrizrxIg+cc4Zh1903Xjl15RGuYbW5HmSMf2/gMnptZBdGvMGm+ZH515b
         cvhuj++CCiq7VQZJwDNfvdUa++F0tZI/5Oyj2ODBWIery0613I42Im9VhQ1+EDffXlYQ
         tMUBUm31+bcpMDR4BxSTq8/LnkyFgQkHBUN84ckUFpGct/HndUCDiRxF4mSNdblEDLlX
         vWSqJvxfSggecshaIiVyhQIKxKuTLINMYvK7q2DyS9sq37vPlJVw709Xkw+56VcQyzqL
         Hz3A==
X-Gm-Message-State: AGi0PubrEvtnQRnf/+Kehdwzf1EYrniJmeEloNZ6GuUlyKE38axQUs6J
        vGUqlNNcxJjSrwtQzGed4bGnFQ==
X-Google-Smtp-Source: APiQypKNqeVCSfFJPwxNHCrvjHy0VYH6Avw8SVeDX8eOa+urgHv9P1i8eAZ64MakyRhzM6BfopRBjw==
X-Received: by 2002:a37:8781:: with SMTP id j123mr24068830qkd.308.1587514908014;
        Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u27sm2859237qtc.73.2020.04.21.17.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jR398-0000BE-Gp; Tue, 21 Apr 2020 21:21:46 -0300
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
Subject: [PATCH hmm 3/5] drm/amdgpu: remove dead code after hmm_range_fault()
Date:   Tue, 21 Apr 2020 21:21:44 -0300
Message-Id: <3-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
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

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index efc1329a019127..bff8e64701a547 100644
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
2.26.0

