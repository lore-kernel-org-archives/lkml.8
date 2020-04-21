Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA3C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE18F21927
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cj0aBop9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgDUIRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDUIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x3so6278209pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCOK+HxEBj2bh5BFlG2zt/46BhY0DW9NF3gypZJ6i18=;
        b=cj0aBop907dm+mkl5z5Mfm3dfJHK382iyGGadBdhXTU4SezE2MCsVNmjWKHydO1MeY
         hFpq9McPFpfy4rmx7G+Ad1j8hWL2TnkmF0IkMCtKAGmpU+zQZ6aqaTdmOppP8E8jMoFd
         Fk88jdQI+8R4LkqajRqwVMi8EwnmwqLx6QnbQ8a9F0T2Mu69VHyd9ana73iFO3tfR1QY
         WOG8lsevniXIBle/Wpw32M1HPnUM/cXVhVfyULOzUIUxNwMYRjXLGcKHakrVVhIkdCst
         HcA/EUYHskjCRFk4RGeoZHsmrSkm/oL6EadoBmaeDy9n6/Ei3y51wlw/4DW50BwDLHDj
         41mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCOK+HxEBj2bh5BFlG2zt/46BhY0DW9NF3gypZJ6i18=;
        b=du2hnmBg5+Th16D2zRIkYyOq920hrxjsCT0dycyIOJjdq7BUqOJ5E8VFwGEvjXDVwf
         6nTjOFDRyknh48OASaXXrW/NbZ8HihLVC74LGZQqw6BUUrkNzl98V7/fLW2dhIpRBzOk
         jTasIrc6Ta7BrYpmlprXCjr8e3hj9zSZmcmbwMf0TdtlQsncgJ6rJUvdzF439gRp7Y27
         ihwbqGKgAN5qUIuG7qAFFEpGskd1Lq392pfgDcIgsFAPsh1Ph1h6EchGvEfwFAFkGIDE
         1JRfRfdNv0ItKbYTtOKvwB8bq1kk48YVzfK5CCidhh8InhoaAoAOcPFCicqr8wFWx28V
         lKRg==
X-Gm-Message-State: AGi0PuZdFubhQstXVdAOXm1lo5AbAMJ/pViw3KJ7kUxVR1KV2LC13dwc
        fgES4I1+Oo64ggB4ErlVyGiewQ==
X-Google-Smtp-Source: APiQypLl5oCj7vFGv7zZNaxGJsgDSRmBearvlFa0TCQKMUrRrSskifrV8HFOIzfmSxRHB+7OBiCjMA==
X-Received: by 2002:a62:18c8:: with SMTP id 191mr21232603pfy.255.1587457048276;
        Tue, 21 Apr 2020 01:17:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v9sm1610067pju.3.2020.04.21.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:27 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/4] mm: add DEBUG_WX support
Date:   Tue, 21 Apr 2020 16:17:12 +0800
Message-Id: <23980cd0f0e5d79e24a92169116407c75bcc650d.1587455584.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587455584.git.zong.li@sifive.com>
References: <cover.1587455584.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support DEBUG_WX function, it's verbatim from each
others. Extract to mm/Kconfig.debug for shared use.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 mm/Kconfig.debug | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 0271b22e063f..077458ad968d 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -118,6 +118,39 @@ config DEBUG_RODATA_TEST
     ---help---
       This option enables a testcase for the setting rodata read-only.
 
+config ARCH_HAS_DEBUG_WX
+	bool
+
+config DEBUG_WX
+	bool "Warn on W+X mappings at boot"
+	depends on ARCH_HAS_DEBUG_WX
+	select PTDUMP_CORE
+	help
+	  Generate a warning if any W+X mappings are found at boot.
+
+	  This is useful for discovering cases where the kernel is leaving
+	  W+X mappings after applying NX, as such mappings are a security risk.
+	  This check also includes UXN, which should be set on all kernel
+	  mappings.
+
+	  Look for a message in dmesg output like this:
+
+	    <arch>/mm: Checked W+X mappings: passed, no W+X pages found.
+
+	  or like this, if the check failed:
+
+	    <arch>/mm: Checked W+X mappings: failed, <N> W+X pages found.
+
+	  Note that even if the check fails, your kernel is possibly
+	  still fine, as W+X mappings are not a security hole in
+	  themselves, what they do is that they make the exploitation
+	  of other unfixed kernel bugs easier.
+
+	  There is no runtime or memory usage effect of this option
+	  once the kernel has booted up - it's a one time check.
+
+	  If in doubt, say "Y".
+
 config GENERIC_PTDUMP
 	bool
 
-- 
2.26.1

