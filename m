Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D197C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602F220792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acPfkpj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgFKTUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgFKTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:20:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE557C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so2933807pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lhV8nqMz2laEO7u8yeQgJHEMBabnXS8HLs+yCx8wYRg=;
        b=acPfkpj5/yf9SgDo/GgAHtc3dF88Ku0aHGKDg+7QAde4yPirke3PsVjTLGiw8CNyf5
         rG2TeN3/YsFrowdQObRuyE5KZUNGYQVgTkHLC5YVK8hbZFVPU41QPkfdZek2TuIS8jYr
         ha+G7dTRNoOt34arFuaABOYl6byG3HiaAuYlznexIvZnxhEGlzwcKiZRIkAfeiQ90QJd
         XVezjcdXyBaGIsvdXilWU970/byi5P9BHFgT2xwISkH5IxvDu8aL50gDfuG5xWuMAcp9
         ELWXt3Nr8CCIuG0NFyi1OsB8GLXXelexcGBOZV9WWFbayorCcW+7+9CT1EypI2M0tCut
         Ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lhV8nqMz2laEO7u8yeQgJHEMBabnXS8HLs+yCx8wYRg=;
        b=kJx7RJ29zcMD1gKWO+zz/6mukb6Afj+r62Sz20RSS7KE5Wx7yR8S07/sdYY1qTSvYl
         DcIvUhtQxDLlgRgoogye4fWFH/ZhPsbpONM/b4Uq6wz5OlkLwDbHbm349P2JHiA77lLM
         qKVi97G2RAnVa7uhrPq+NuA90sdLVKP8NuCPnycLxgRs4Gz2rAi1Vx51tR2eStnp0cws
         8ftEwDPqNf8PLttUyQRIZDmhANHCYArfYOvYa+54lUSorlqdHVvL2OniN8avI0qxJ1xp
         gz+/34kNCeEqdxqvLcl4aGXKxwgHP0F309iYbkJeVujGETHk9PovrwiidmV4KaPSa/PO
         5gEg==
X-Gm-Message-State: AOAM533COevcWhZKoQdIFnIph/VAdzbBzyO2rVDLUJMOEcCiermLojZi
        smkbDD/q2ewHfHNekKK4E+O9OQ==
X-Google-Smtp-Source: ABdhPJyh//Vnh2AOGbnU3pCU/jktEq7WXa1uG41bJSj6sWvqbsCFopBl8iIs0tjZMjC2tSJ5wleAQQ==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr3450720pge.131.1591903233130;
        Thu, 11 Jun 2020 12:20:33 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z24sm3714630pfk.29.2020.06.11.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch for-5.8 4/4] dma-direct: add missing set_memory_decrypted()
 for coherent mapping
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111220010.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a coherent mapping is created in dma_direct_alloc_pages(), it needs
to be decrypted if the device requires unencrypted DMA before returning.

Fixes: 3acac065508f ("dma-mapping: merge the generic remapping helpers
into dma-direct")
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -195,6 +195,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
+		if (force_dma_unencrypted(dev)) {
+			err = set_memory_decrypted((unsigned long)ret,
+						   1 << get_order(size));
+			if (err)
+				goto out_free_pages;
+		}
 		memset(ret, 0, size);
 		goto done;
 	}
