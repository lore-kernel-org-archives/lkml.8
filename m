Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE32C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8652E20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stnQuEF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFKTUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgFKTUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:20:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258BC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so3081643pfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2l2eSdBqJum9TFb5iBYuRa8B8B3NX05NjbHxGSSWmGQ=;
        b=stnQuEF9g7MtyvCfbMgM4BZG5iEAgUHNwC3emgxuLm1ip4odsE+X2eQ+B/CMZNnSLX
         h+E+21nnmJwDZLgetRoLzam+qDmI2n0Yt34BqilXHoA6SsR2XQEKy9wsQq6X9sYE6B+z
         8gnM/lzQ+/kH9Z9QQW9vyRUCgWW7Ov80VsWbasgZtmjGolYPnredfhVJYxqKMgK3WU8G
         mD7kyMPrDvxDxlhx7XxOzxsqnaRfGODeN4mRAeKAk5e/u7yEu7JFYqZqT2t6eGYCQeVO
         fUuxbdATffVa1AiHSlH5YnK9xERQotMeX0fy9zMSsKsAUxTToCn9bppApI0lPwyKKUD+
         UIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2l2eSdBqJum9TFb5iBYuRa8B8B3NX05NjbHxGSSWmGQ=;
        b=jThDO8/h9/vVkXr4nGekat6CNB5/7900p0OQIYiANqw7RUk27hOj1OdvR7HFk5gAZ5
         fVN0XSdpXBHUyJrw60F5HDgpL+QpaO6z3SaMBELa0xzzaX3kkDIflYOgYaqDFJYpXp8C
         /E/skaV3KuflUtaE616kQNDF79X7XgTKzvp5FJUu7jw/2XKIDz1mV9qbklkephWcTS3S
         U33rFlqLWGeQXtYrrE+pOVIDGiSV4wx1h8iLCFzHFv/y4FMQ2nidPDIxUhFQ6bnFRpQW
         DUmoeoNmoZwrABG8A8OWZz091pYtdW2shhJ30V1Ue0vcTrPgZlJtkPleyk+WE4JCYbo2
         DdYg==
X-Gm-Message-State: AOAM531EEAYsvkk3JRpTPGKT4Mur96D8H2HKPvWRF621E9OQUOPVLYOT
        sORXursmUtNZdxDI3io2feRsiw==
X-Google-Smtp-Source: ABdhPJxCPQOAO1kCYZxtbBLMJ5hveXXIZvFmxHaQU+0QJHM1hHDZlqDf+gP5tqaibcIDGdX1Tru62w==
X-Received: by 2002:a63:1624:: with SMTP id w36mr8043260pgl.144.1591903230513;
        Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u61sm3468710pjb.7.2020.06.11.12.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch for-5.8 2/4] dma-direct: re-encrypt memory if dma_direct_alloc_pages()
 fails
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111219200.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If arch_dma_set_uncached() fails after memory has been decrypted, it needs
to be re-encrypted before freeing.

Fixes: fa7e2247c572 ("dma-direct: make uncached_kernel_address more
general")
Cc: stable@vger.kernel.org # 5.7
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -220,7 +220,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);
 		if (IS_ERR(ret))
-			goto out_free_pages;
+			goto out_encrypt_pages;
 	}
 done:
 	if (force_dma_unencrypted(dev))
@@ -228,6 +228,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	else
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
+out_encrypt_pages:
+	if (force_dma_unencrypted(dev))
+		set_memory_encrypted((unsigned long)page_address(page),
+				     1 << get_order(size));
 out_free_pages:
 	dma_free_contiguous(dev, page, size);
 	return NULL;
