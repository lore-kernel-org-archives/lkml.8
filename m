Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD020784
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7dku9eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgDHVVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:21 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53463 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgDHVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:13 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so365575pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tzxcVfYqDaPeZReasS8qD6qKEgdprHW9+s9O1hZTsQc=;
        b=S7dku9eUTelk+NIxd5md2NkDK5b3imi2QHWeyDBBDDcrvmjt27DpHCsqUREtsSeeU4
         LWtIXun2WRrvnU5+Mi+QDZ44E/PUo8yGraQxVZo+cw/gxAdVMVwxRGnzOrMTqqJjwG0q
         VmVYnfi+iIbuIo40rVQ2ZNnDI8pS3GVoxmWJEPMYkLvQe6jkBzm8XBD+lcpu1LxJU96P
         LKKbcKRTVIKRLRoN3CUUqXj0kj7QZFow/wHeGm4TMuTQLz5xwerblJaOAdMaSwPayqSW
         pwitgq51n5deonLMg1acLi5p4zxUKVEFyHZqIrb6PosYqToOkl/NrAAnKhXQUgMrTa27
         CfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tzxcVfYqDaPeZReasS8qD6qKEgdprHW9+s9O1hZTsQc=;
        b=paRYwcFatJJgZALh2sLs0FG3l7cFc42CWG2IdKQdekTMSvb7jGMNHNarxz9usucrto
         sIBrR6hRRr1B3GUhG9WBbCOVZDU8qk1qTX10Rydmnhsn2iHeebSeaZK14ul4bbCRRwCN
         xQd1qiZa3Yp5jpaMF9Qnn8Q1ucfDDAyAn1cxH+aYjvlZ52MFVTjvT64xQ4GqfxI0B9Ob
         21mMXXHDwEgvRwbawtu+JUE8te4eSYpD7dS0KyVyubyKf4C3Gub+pxikpN9NOGDj1jYp
         hgknHlfloI/6QQxpR18lyu6uJubpJE1CWFp2mu8qlkSLgDyigFG/yBrr2Pp1JDc2gDJC
         Xydg==
X-Gm-Message-State: AGi0Puba1bCfPOUGt4O3XizaYELH9Xbg/Ibq9HaQtkx2gAXRV0OxPXxM
        gZBHHYNQ38UxTH1pUpW4QS7FAA==
X-Google-Smtp-Source: APiQypLzuioXyKB2rsVHdIo/cg8MndRznC5d3+Fj5BV7jR+NxJO7bpFagBpEzVoX2RqVkHvT6AeBnQ==
X-Received: by 2002:a17:90a:a4c9:: with SMTP id l9mr1907410pjw.44.1586380871617;
        Wed, 08 Apr 2020 14:21:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d23sm17523800pfq.210.2020.04.08.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:11 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 5/6] x86/mm: unencrypted non-blocking DMA allocations use
 coherent pools
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081420220.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_AMD_MEM_ENCRYPT is enabled and a device requires unencrypted
DMA, all non-blocking allocations must originate from the atomic DMA
coherent pools.

Select CONFIG_DMA_COHERENT_POOL for CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8d078642b4be..b7c9e78a5374 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1520,6 +1520,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DMA_COHERENT_POOL
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
