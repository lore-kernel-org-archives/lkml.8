Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C449C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1DD208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3xlM0hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIJXkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgIJXkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:40:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C227C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:40:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so5207084pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsPqYI0Xk9lZxniNhN2IoKCPFdu2xrsy8oXUS2ehoKA=;
        b=A3xlM0hhvu+68XAlTl2i3uxHCOR7aSTETxAXYuIVXhIYG237ovu0HYlkIQk2YlIUzx
         7P6GCvpW8dzhMVjavAfsN49f245vSfRvQUfGD1H0i8sfQAZsZ6XK61RvGVRCSsah95ko
         wTsH+Nm0vrYbJ8KVOjwu4gqQnVnsP8sVAHYmxXsZ0dY+6LsUvG4pZG0lf+rEyCaohPNq
         jNSySLUk9/S9wRLD3r3Qtplj7tTNM2qyXR/ztAIro0C0jPbt1YHfLxAtPwhpMa9jnnKE
         VH29ila9uOhDvKKWXFq/4RTlrFMSJ4MDPJbMS8a6m9hs+jiC3Y+GX4x0qqQ6iztqDSNR
         TI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsPqYI0Xk9lZxniNhN2IoKCPFdu2xrsy8oXUS2ehoKA=;
        b=MEvUKhDeladQmoAr6Ho2/7a9RRODvy8gvRc2eUk2isX3RJPK3YJSi+9V7lTMn97/aJ
         7b/lz0sXhFdpht1Y4k0zv5KOVP6a9j4DW+Lvc7HiPegaunnqjcm3OlMuQOt8F5FbWWK3
         vt76w2PkIfzhBUJEB0vxUc5owPrzDguS4C7/IOac+CtulpIPNOANMQ0uj6MF6w+9nJA6
         PQuQxNVuGpAIHsg/X828heUzLy/NH7z20aszVqm1uuLr6ixiuc5SrcYh7G9H9/FI1n3z
         Qym5G4/WDEGnMHSzMjP21ZZEml8x1YGVEyXxp+nHCsAfg3D9TltoXeyOlVbZZ1fmAs5H
         Nfpg==
X-Gm-Message-State: AOAM531bHoOC7PK7nHURkfHt2W4qndZMI7z0Jkko6Y/g2Pma3enXKNZi
        LY1UfnW8xUAOZtBTZSUpdMwQD8hvmFM=
X-Google-Smtp-Source: ABdhPJyrYZyprK9kh+kshBokh+mrfrvKQPu92CZudd3lxf+J1kTMo+3LwKPipjEcD8uAzvHh9CTMeQ==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr6413328pgr.20.1599781199541;
        Thu, 10 Sep 2020 16:39:59 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id c22sm97834pgb.52.2020.09.10.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:39:58 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 2/3] openrisc: Fix cache API compile issue when not inlining
Date:   Fri, 11 Sep 2020 08:39:39 +0900
Message-Id: <20200910233940.2132107-3-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910233940.2132107-1-shorne@gmail.com>
References: <20200910233940.2132107-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this when compiling a kbuild random config with GCC 11.  The
config enables CONFIG_DEBUG_SECTION_MISMATCH, which sets CFLAGS
-fno-inline-functions-called-once. This causes the call to cache_loop in
cache.c to not be inlined causing the below compile error.

    In file included from arch/openrisc/mm/cache.c:13:
    arch/openrisc/mm/cache.c: In function 'cache_loop':
    ./arch/openrisc/include/asm/spr.h:16:27: warning: 'asm' operand 0 probably does not match constraints
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    ./arch/openrisc/include/asm/spr.h:16:27: error: impossible constraint in 'asm'
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    make[1]: *** [scripts/Makefile.build:283: arch/openrisc/mm/cache.o] Error 1

The asm constraint "K" requires a immediate constant argument to mtspr,
however because of no inlining a register argument is passed causing a
failure.  Fix this by using __always_inline.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp@intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v2:
 - None
Changes since v1:
 - New

 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index 08f56af387ac..534a52ec5e66 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -16,7 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.26.2

