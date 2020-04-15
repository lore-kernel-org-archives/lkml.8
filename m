Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B40C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F014D2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqKtzwFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392229AbgDOAGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634556AbgDOAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:05:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so567633plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KR6uSQVGwCyM0LnuYfYFDEMfJVon1ni6IuCovgn4/s0=;
        b=rqKtzwFZVZWUOiIrgJExufYVXu3Tq6MqN9fZu+ZH2YWZFYDd36z9cKaQb1z64mO7tH
         MqHd3c/DVdGpEppY6hDK2NUcvYFc9GB0boflgmYFjwRnXpj7C88Raa2vtIKHZltPbaZY
         Yq4XjmwAMnLhc5OAOpmyCEprZER5wgs9TG0NXMxxpAvZslYPLWReI9hEIrUglD3v33nE
         uvdcK2H6ZpBcTwk6YibzffwOAU+UcafvBxlbh/n+dtdh5ojeU1wXawqu+7tuuraTSg2r
         hAMC56p50b97myh5kSGVE5o5KJpXUH8ugjcM1X8zg5XSTobhilOhGVEwO0sF61kP7SMB
         57ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KR6uSQVGwCyM0LnuYfYFDEMfJVon1ni6IuCovgn4/s0=;
        b=IjhZKlYgBZh/GBkvoJpYNEXQvfF/XZWaVbuzd70CA1ytLybHQunDKuGW70zgOTxbWE
         Y9+Xca/0+nfzBZ6fMwDMJAmanixdS7C7S+RHRZyDWzh6QVh9RVQlTTKh1CRoejIuJhqj
         v3w10Y+rpkbq9m4JYzurxNssM7i3Q0VHi1QUgD+tsmmAMaBVTRZc+m3XWKdglUEP/ivD
         sgQ/OXPHuI+yKPGSqdPEQ3GPI8RnrbUQBb8qC6FF0GMlIe6kX4qvh1Zr3XfxUvaZ1/Yh
         EqQrED/g2LJEbthgXEg+DYg9Rz+MrFNFHoGqG7mHpZMQXCnH6jIKIVG/L9hwfcgO4VbY
         UKHA==
X-Gm-Message-State: AGi0PuZzFTzuAiRjA5/JhHUGWKUOH9R8wuXuTbL8C/QN0Ld8WFk51FHn
        2+ntp8bfDO5YxL+stAwPXFHf2cxW+Io=
X-Google-Smtp-Source: APiQypITsrLE30A4dNLnVHx0jF/AXyPl+UHgHDtx9Gu90EvJXODyZih95z0Ar2V67vHkb70mSHKTvg==
X-Received: by 2002:a17:90a:22e9:: with SMTP id s96mr2911139pjc.46.1586909102385;
        Tue, 14 Apr 2020 17:05:02 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z7sm7286945pfz.216.2020.04.14.17.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [patch 6/7] x86/mm: unencrypted non-blocking DMA allocations use
 coherent pools
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141704190.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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
index 1d6104ea8af0..2bf2222819d3 100644
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
