Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E74C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D2421473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMyPYklo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgIGWwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgIGWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:52:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=X//KQJI+2rxTvx9HYo5PyD3EKrrYMxBIJ9G0Zyy/Erk=; b=VMyPYkloriTZMlh/n+Oypp2fPa
        SdjPqr0odppjLDJCDTXXWbBIuo2J9DH4nYVtR3455fZk+1dlRlwnl+YM0JuOFTmmW80Pcl0rcfZdG
        tP2YhRN5g+/1LOVnf942aZWjWA1vKNMYlrZJ7+SCGmy11fZgGfTbu0f7gNZHPEL2hwpdUtjkRCpvz
        CViWoxJrNJLkgGk+OyusMFK+/VtpT9jAkQSliran4EGSn/WlVqvhMNSr3BRr8Wfz2A8KPrloEdPYf
        IHqH2D8/Ux3tZA0jPhkheWTW1+EoOsbK5xGNpy6Km7f5Nge19f2n4jOCMbKTVeZe35n+863DYcaTS
        Law6ANbw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFQ0E-0003Ku-6R; Mon, 07 Sep 2020 22:52:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/aspeed: fix Kconfig warning & subsequent build errors
Date:   Mon,  7 Sep 2020 15:52:38 -0700
Message-Id: <20200907225238.4790-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported build errors (undefined references)
that didn't make much sense. After reproducing them, there is also
a Kconfig warning that is the root cause of the build errors, so
fix that Kconfig problem.

Fixes this Kconfig warning:
WARNING: unmet direct dependencies detected for CMA
  Depends on [n]: MMU [=n]
  Selected by [m]:
  - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]

and these dependent build errors:
(.text+0x10c8c): undefined reference to `start_isolate_page_range'
microblaze-linux-ld: (.text+0x10f14): undefined reference to `test_pages_isolated'
microblaze-linux-ld: (.text+0x10fd0): undefined reference to `undo_isolate_page_range'

Fixes: 76356a966e33 ("drm: aspeed: Clean up Kconfig options")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-mm@kvack.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
---
Feel free to fix the Kconfig warning some other way...

 drivers/gpu/drm/aspeed/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-59-rc3.orig/drivers/gpu/drm/aspeed/Kconfig
+++ lnx-59-rc3/drivers/gpu/drm/aspeed/Kconfig
@@ -3,6 +3,7 @@ config DRM_ASPEED_GFX
 	tristate "ASPEED BMC Display Controller"
 	depends on DRM && OF
 	depends on (COMPILE_TEST || ARCH_ASPEED)
+	depends on MMU
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS
