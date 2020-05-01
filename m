Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6112166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPXHbASQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgEAQUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:20:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 09:19:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so12035514wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq8gwi8GSwXFvqdFVywCJSsl3feyfQ65SGiht+YKk6g=;
        b=zPXHbASQoqBg1Npt8Xzk7yRKEqfpEuY7QvZ+IoFuU4VN/odUmoWdUy5Cz+U0MfOaUE
         57aux5SMXGvxyPCXn3FSARElWT+5U9lNI1PMOCJX0oo4LSTISVLw2MZRMW4jBqWHv0Sx
         dhW/SEMp6ZuFzgQylGhx130zFM6abaEh8V1S4P6yRYVSF+hZ+ISSsIQ2RMBq2Y52OKoS
         3+RDkp8idiO+IIly+5sfufjOAbwnEws+Yi7YnShsQnspUoqTJPyue8zgSFlnL3SZWYhO
         0Qajiy6bhRZWH8taWBHjSmvNkavetqo2dN1E33rugXfXENcPkXkYW8jaJaIacQagbf/g
         etPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq8gwi8GSwXFvqdFVywCJSsl3feyfQ65SGiht+YKk6g=;
        b=G0E1MMoMA3OlYNK6M4NUDu27PuPYipsSDwEppsVKQ4T0IQ6FJLHs/XV1RysTYhSyhc
         FOidSD28S1tD4obvVeJ08hNSLhjbR7PmVwuH2A2RpU3Lr1FIU32/l3tUExa/BNKcLDBo
         9SwBOl9q3yRjfUOSNyBFsDwZA8ZDTUknHcR1fSYXTjH1O5AvLACV40S8+UrrrY/pbKvr
         aEUPhfPBoIkxcIb2O+XOQVzZafEkHa1XiW0tmZLnlwT1Ookj2msWNm+lk5iCgPCYHPIH
         B4kKNfLtqBVrg7+jGLx9VGfKnQdW3zSFB9OcDAhDBJNa+FyFldqAjOPA6g3VABNbmtyz
         SnDA==
X-Gm-Message-State: AGi0PubnZ5NMmntbWrsv+q6Bbq/qaaHFFH2S26/v/ey6Syfgsw522ffl
        7qFC9bEcfft3Sc4RjaBxnPB0ng==
X-Google-Smtp-Source: APiQypJdqqAmA5NZRljQci8YaPRabwage+tSbfJLtETNB78EkLvJaFcS7Q763kbrV3j/xjoej9nRRg==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr4812672wrt.407.1588349998229;
        Fri, 01 May 2020 09:19:58 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h2sm5644313wro.9.2020.05.01.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 09:19:57 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] arm64: cacheflush: Fix KGDB trap detection
Date:   Fri,  1 May 2020 17:19:38 +0100
Message-Id: <20200501161938.2949443-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
trap handler is running because issuing IPIs is unsafe (and unnecessary)
in this exection context. However the current test is flawed: it both
over-matches (could skip the IPI when the kgdb trap is not running) and
under-matches (does not skip the IPI for all kgdb cache operations).

Fix by replacing the ad-hoc check with the proper kgdb macro. This also
allows us to drop the #ifdef wrapper.

Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
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

