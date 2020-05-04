Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A111C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F59F206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cijHvyVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgEDRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729553AbgEDRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:05:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94035C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:05:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so486731wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6inNII5kkrOkGxC9SM+OHKVL1fdGg+tB1bP7x4RQ9Z4=;
        b=cijHvyVGcv+Hb9axsZx8Iukpxxstp2yEPu+xziQQvcvVnwyZPuSmisGyalVyoLyC3A
         NG1oq92orVjdooXhp0vRTjTznKlTUbi2XCVMrupD13j2JeFGpQucEO8TwLBivmDepKs3
         ob/QKRCyzB26vB1I3HfrnlnA1vEXnhyAsv7jc8RvWFvVfnSVRpQFeXLrdHml8LPRLP66
         Dtcr0HjtM6aiKT9YnYEbJjzSyNjveIkTNT/W6rIWa5bx2Jd0GS9Ywdm6C3mVueSg8JEc
         IhtuoH7UgMky0TuoxzyY8McDmODkJ0MS5CmJcxgaI8Z8AxX15u6TCcMdjaq8JeVLDV8H
         Q65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6inNII5kkrOkGxC9SM+OHKVL1fdGg+tB1bP7x4RQ9Z4=;
        b=hLPAgnauZaFzt57exwqnrQb9wG2pOllTv3n4oScjqib2b/n4cPrvpibFo2JkOA4ftm
         RUDjw/RYKjsFtaJDK4pjbdcPDeQfUsdPPNT/mw6m6ZCsXCUKj+36MGw6sS98BvO+3qOO
         79+XIpR9xn3f9pebw/shns16qW8KBiSmULuepme+m5H3UAELQ6G69bnS+DWR7CHXmLpo
         gjOaQAy8A31fSEvl1tkwXBB/SVV1PV8An0HTXuVcmPgKgNQK0c93wu7R2gPrLoalLBWG
         QLc0SB/vkXgOwu2E/OPIsu+eSXiSN3GzPtDm+52HREZVFnV8mlfLiBg5NVfj2KL12Ihe
         4Rcw==
X-Gm-Message-State: AGi0Pub1VXNxPg4K1l8+6+Gpm2elJzTQh1nXGl6HySzaUVM5YTSzElDm
        6deBsKHqykbiEIDV/l7Ze9PIEA==
X-Google-Smtp-Source: APiQypLEH8rWgUJNRBujiwV8QQWpBqFdu3lEr6ulnlk/jeyXwqeuTWfHXN16q97LrCSCICrrlo4YJw==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr15131404wmf.145.1588611933238;
        Mon, 04 May 2020 10:05:33 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w9sm3067718wrc.27.2020.05.04.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:05:32 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Date:   Mon,  4 May 2020 18:05:18 +0100
Message-Id: <20200504170518.2959478-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
trap handler is running because issuing IPIs is unsafe (and not needed)
in this execution context. However the current test, based on
kgdb_connected is flawed: it both over-matches and under-matches.

The over match occurs because kgdb_connected is set when gdb attaches
to the stub and remains set during normal running. This is relatively
harmelss because in almost all cases irq_disabled() will be false.

The under match is more serious. When kdb is used instead of kgdb to access
the debugger then kgdb_connected is not set in all the places that the
debug core updates sw breakpoints (and hence flushes the icache). This
can lead to deadlock.

Fix by replacing the ad-hoc check with the proper kgdb macro. This also
allows us to drop the #ifdef wrapper.

Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Notes:
    v2: Improve the commit message based based on feedback from Doug
        Anderson

 arch/arm64/include/asm/cacheflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index e6cca3d4acf7..ce50c1f1f1ea 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 	 * IPI all online CPUs so that they undergo a context synchronization
 	 * event and are forced to refetch the new instructions.
 	 */
-#ifdef CONFIG_KGDB
+
 	/*
 	 * KGDB performs cache maintenance with interrupts disabled, so we
 	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
@@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 	 * the patching operation, so we don't need extra IPIs here anyway.
 	 * In which case, add a KGDB-specific bodge and return early.
 	 */
-	if (kgdb_connected && irqs_disabled())
+	if (in_dbg_master())
 		return;
-#endif
+
 	kick_all_cpus_sync();
 }


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
--
2.25.1

