Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50233C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D6B20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dffHTmwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgDHVVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41367 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgDHVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id m13so3908312pgd.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=V7GX9LZ+AhHUH4bwOJQnuEHVk4dK2rfBwPONnldpnt4=;
        b=dffHTmwO0tVlcdXkvNhhaUt0+yiOfFJR8UKtqG72G0vg0UBgDxhDLrmfswe6Iu9nro
         OfM3598qThzw8CALPlmFLzz+mSr/EBMPtRh/q1725AB+6isUxT1WCFp6PJLsWke3q+Kp
         tDM9ZsJ8mbLZxaWQYBx+cW4UcLHE4z83i53ZfZoSiJaxfA3sJF0R/Ld+ARI2r6t8zldi
         ishSudG5ynA3yXMXRidbNmBLcfEd9PtkLwcxLPHAy+6RWBgIPU66jJQ/ocN6oHM1J4Um
         RWd5EQGsLGa7csSIaQWNG1pqksJpqR8oRNonJEmljmQDqD6U1f4z3WyweSQs2WPUueI+
         Ljyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=V7GX9LZ+AhHUH4bwOJQnuEHVk4dK2rfBwPONnldpnt4=;
        b=anE4/X83Ti/D/7vzbN+q1Q4NkxMtcdOcK0T7XqWz2fbtcttFLR+86IWUkqPXpWNXB2
         MP0xb3bOBM9123XJjEJV/YcAc5LQSV6XjOUlNUg2Zpn5UaOcKdy5OxJhmItmOWPJNsNA
         6u1IGiK0bW45StOy/rP4wejzLsTPUrajocbX7M880BXHJRwDSf8sy17Nd+/QWst/yNYw
         bGLxLhqAMQZ6QKIhC3lhMB478v9HWB2X0AY2n2S01jCwcP+CSlYH/rL6XnBJJ233BK6S
         kst5eq0poHPak6aR30XetvCrR4rZXEMKUP2BfycgCXax276VzKmckFc93+RNF1fW9R8/
         EhQw==
X-Gm-Message-State: AGi0PuaqXuYYvxzUIc/gak0GOIMcbWy3LMU0WNflUndkMY3rBtnlU/7d
        K89mjl/A1nItIFn9dqBuXy93dQ==
X-Google-Smtp-Source: APiQypJCa8TsaplVYhS9P0JzzjDY+IiLIaAE7LUfGVUKFymlGGpsyHJbOAOUCHLqZ/940cF64leUPQ==
X-Received: by 2002:a62:1cf:: with SMTP id 198mr9933881pfb.246.1586380873275;
        Wed, 08 Apr 2020 14:21:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q19sm2013938pgt.29.2020.04.08.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:12 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 6/6] dma-pool: scale the default DMA coherent pool size with
 memory capacity
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081420360.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AMD memory encryption is enabled, some devices may use more than
256KB/sec from the atomic pools.  It would be more appropriate to scale
the default size based on memory capacity unless the coherent_pool
option is used on the kernel command line.

This provides a slight optimization on initial expansion and is deemed
appropriate due to the increased reliance on the atomic pools.  Note that
the default size of 128KB per pool will normally be larger than the
single coherent pool implementation since there are now up to three
coherent pools (DMA, DMA32, and kernel).

Alternatively, this could be done only when CONFIG_AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6685ab89cfa7..42bac953548c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -18,8 +18,8 @@ static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+/* Size can be defined by the coherent_pool command line */
+static size_t atomic_pool_size;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -132,6 +132,16 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	/*
+	 * If coherent_pool was not used on the command line, default the pool
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
+	 */
+	if (!atomic_pool_size) {
+		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
+					SZ_128K;
+		atomic_pool_size = min_t(size_t, atomic_pool_size,
+					 1 << (PAGE_SHIFT + MAX_ORDER-1));
+	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
