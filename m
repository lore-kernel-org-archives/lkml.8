Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3500B20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra7efnOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgFEOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgFEOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054EC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:18:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o8so5184158pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=USN5B+36EcRDvKeTHs/GkNSI7LnmTqCKEsfrMETXyQE=;
        b=Ra7efnOLfD0+wUXmYY7DVNDt/rW9NMuVsI1UU+XztgDo+6gMX4GEbUE9hx8dDLpDXy
         8FNlNVgPK/hVwbNyMs969KelxavrGUQAWwp2rsdgzRGrXDxKgUUFRZBuxDp08B2uXDCM
         ZdFejcna1GLfF1h8KoK+qNFR8Uu5Wiwbjlwms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=USN5B+36EcRDvKeTHs/GkNSI7LnmTqCKEsfrMETXyQE=;
        b=mwdnpdFJ6xsG7NSQwTNSvh0cPKYvZk6RlEwhysD65os5/7AUxc2TW2fpAcHfNs5OLI
         4Cu9YL0d4AsPAR55ES0KOfFXCBxZBsYBWG+ik5CMCY8Wje/PCPRgSgCdoTws/8pmgjvB
         vLgruU2hRp6z8ET6D3+mWAwRsOzEuHjV8Qt53Q6P/tNoJmoW3Nz+ZLo+A40wueH0Idgj
         RaW2cXd2i9DElBPs8lae1deJ46s4nz536vMH3ZMmCW2s+aZ49+TuFvddKGP2i2nUKupZ
         wdQ4rFUO5nX67vlmazdk5SpRjjbBzg7MjAGiDjMc5i0gqK9uw8CaekpCiIeL3LxpkRVJ
         qGxw==
X-Gm-Message-State: AOAM533IO0B/4hhgqO4VEqT+Q8zp6HzFEtMuNmS5l3TzkSOYlu9zgELH
        u6nbKM99haPVRSX/mHmTwD8eIb8Mr9gLXw==
X-Google-Smtp-Source: ABdhPJw+cA2osm5Y+j4AMSvnB/mesuJpia/pW9F2HIgjysQk3y1ignos3bJQFnCz+S/rIB2VMgBX9g==
X-Received: by 2002:a63:1f42:: with SMTP id q2mr9422739pgm.357.1591366688871;
        Fri, 05 Jun 2020 07:18:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l25sm6707192pgn.19.2020.06.05.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:18:07 -0700 (PDT)
Date:   Fri, 5 Jun 2020 07:18:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: Fix typo in IS_ENABLED()
Message-ID: <202006050717.A2F9809E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

IS_ENABLED() matches names exactly, so the missing "CONFIG_" prefix
means this code would never be built.

Also fixes a missing newline in pr_warn().

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/lkml/b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 8ed2411c3f39..cf2e1b06e5d4 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
 		 */
-		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
+		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
 		    (unsigned long)_stext % 0x1000000) {
 			if (mmu_psize_defs[MMU_PAGE_16M].shift)
-				pr_warn("Kernel not 16M aligned, "
-					"disabling 16M linear map alignment");
+				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
 			aligned = false;
 		}
 
-- 
2.25.1


-- 
Kees Cook
