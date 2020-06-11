Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFD6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4B92074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpdQc/yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgFKHZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:25:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:25:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so2169087pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=vewiDiSb1cN3kydqT+BXtXjpJ6GL0Th4yHgmJZ519bc=;
        b=tpdQc/ydcGLOP2OMknw/h0JOLqRFK+EpzRW18q9vdrzjQnf+z2k+sNMwNT5QjbF5/F
         bvOdfkwWF49Lj49PKrC4aiMXWG6O8C9Y4kjrn1G+9GNV6NLlfGX0kMeMqBCya1skey1V
         phEL7SWRJCBra7Pfvnm0BPdM4tGgIYI0dtp00g+YQVhEZaXurhzfe6yGbyTMdMUmYAhc
         eIJx8TDKo8KShNL6aX4r/6xTBX+mWjF0FYfUIgxh0WMWrpsfo/V2PtQE1gdpNRBf+DMV
         7BUbvRal9LSMwakMrDkdA1BiHZG5J+2B8DAjJ3yr79RyorWZXFR5h3morG2JQ1XcKZs+
         G6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=vewiDiSb1cN3kydqT+BXtXjpJ6GL0Th4yHgmJZ519bc=;
        b=a20YuJDtWGryxkwMpVxy+un5wuhQbK6opuFQdtX4rH5dGnwiiP8h7stB5CK1jV7UH/
         bjN8V0QwUa4ElUBYKEQ8LhCrM8FDDJpvGEbvji3if+iNvwESHDo01VF2VrSDtVgIlsxJ
         BcdQD5/grj8EyqC2ipLAeTK/w63npgveqhacvsTf1DG14EQIe8tpsGQ8QcuuxmWxCdvo
         vyb9MufbwokQJ7FCB3MXSS+z9hAGdGBd+tR+2jimEL1+SU1rR6sWuMP32GMmyBTKv+a8
         S4SijrQA8pUfZssoNWHQLZ5rFEVrw617smy+PjGlTv1cojSPgKK13HhONP2byoOoSLLf
         8o/Q==
X-Gm-Message-State: AOAM532VoOKLPAinewhNFf7v92dzVH4xqVyDue/NIgSKqLTURkRSpylM
        eTdTdlwZmR/l5IfeFRDqN4Pf9w==
X-Google-Smtp-Source: ABdhPJz5oiGalV0Wv/ay+vh7ryKRoZ7rmBDmwQrlg8qLzu3l21DNVxpaXrRO9H45unGZuaGGCgjDdQ==
X-Received: by 2002:a05:6a00:7c8:: with SMTP id n8mr5897765pfu.116.1591860358499;
        Thu, 11 Jun 2020 00:25:58 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q65sm2181477pfc.155.2020.06.11.00.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 00:25:57 -0700 (PDT)
Date:   Thu, 11 Jun 2020 00:25:57 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: [patch for-5.8] dma-pool: decouple DMA_REMAP from
 DMA_COHERENT_POOL
Message-ID: <alpine.DEB.2.22.394.2006110025250.13899@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_REMAP is an unnecessary requirement for AMD SEV, which requires 
DMA_COHERENT_POOL, so avoid selecting it when it is otherwise unnecessary.  

The only other requirement for DMA coherent pools is DMA_DIRECT_REMAP, so 
ensure that properly selects the config option when needed.

Fixes: 82fef0ad811f ("x86/mm: unencrypted non-blocking DMA allocations use 
coherent pools")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -73,18 +73,18 @@ config SWIOTLB
 config DMA_NONCOHERENT_MMAP
 	bool
 
+config DMA_COHERENT_POOL
+	bool
+
 config DMA_REMAP
+	bool
 	depends on MMU
 	select GENERIC_ALLOCATOR
 	select DMA_NONCOHERENT_MMAP
-	bool
-
-config DMA_COHERENT_POOL
-	bool
-	select DMA_REMAP
 
 config DMA_DIRECT_REMAP
 	bool
+	select DMA_REMAP
 	select DMA_COHERENT_POOL
 
 config DMA_CMA
