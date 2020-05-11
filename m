Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE20C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB0D20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A24qyFSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgEKG2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgEKG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:28:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q24so7289498pjd.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hw7W11s3UbHTXMwi4d3Emxm52KAS85qy3o8wSco/FQ=;
        b=A24qyFSBnJlVW10vJD/OsHYNVsGAKGxT6IKCsDcV77ZIUGy3cUz90TaIn1VZHKmXN9
         1cNA7LK7GVLu2mQRsL49Jr6QUuiZUIXMbv/3prsNPJc8kemOmuUgCeQ6MfnaO7HJ+Jo9
         ckq9i7clpAaHESR+4C2QsAdO2tfolYvRwl5KoiWAZclkXTfe0UMX9JZkWEnd16WprXgD
         KISvrEDl5FObBxwW3M7SlTNB1B9fAk3p1FIloGl1e2ut/3B1ZesgxAWWGlFraT3PG8NX
         5MD8aMCDJxK0vQdeEZjCUBnTsB0sGOFHW7PVhHwc6HyFJD5gv2Qj/F0vQKnUf/Wt8cfV
         IAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hw7W11s3UbHTXMwi4d3Emxm52KAS85qy3o8wSco/FQ=;
        b=rj9oGVJV8wITK22kjhmWZCrdkcOOFmlpzfzh08J8dXBcNRZFdF4jOGsTMXzJNeUusI
         soURpYzOzdfxpjtHTLtlJfbp5K/BOxynw19O2kJfcEUHByJCCatnigumKjaFZSoqFtBg
         LIhOTTAio0QacluLux7zGsLo4VhoDkBwZPO8erC6fTildzsWuBAuge1b1746chnWjdJN
         6nvStRvmpIyrh2x8Rkpiehittpw8cAf7lgsd1HGO8P3xMDhrWpA/6y/9zWO+ekjGBreb
         uBP1z7aVLvKGyenwzVPkIC1TLFjKKaAaWFzCqXnhkwPMCnFy0IsQ4uDSDhKaXftgEfnH
         b9GQ==
X-Gm-Message-State: AGi0PublvUEPdGAPy7r5N97XXXVBgKWXhqwFBxfDRwdhtnhCwFQYmtX8
        jFnYTgBkHcuX8N60+mRa54MppA==
X-Google-Smtp-Source: APiQypLoz0Tpjdb7pZxLrrNwuO1H2peG9xW14xrRtIbvRe+teZpWvfo7fCkB5fZoR4yart+YnD9qMg==
X-Received: by 2002:a17:90b:78e:: with SMTP id l14mr20777973pjz.144.1589178510039;
        Sun, 10 May 2020 23:28:30 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j63sm5179558pge.76.2020.05.10.23.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 23:28:29 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/2] mm: add MMU dependency for DEBUG_WX
Date:   Mon, 11 May 2020 14:28:20 +0800
Message-Id: <4a674ac7863ff39ca91847b10e51209771f99416.1589178399.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589178399.git.zong.li@sifive.com>
References: <cover.1589178399.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_WX should be enabled on MMU system. It had got build error when
enabling DEBUG_WX on NOMMU.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 mm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index b8cbe035247f..2409f7fc1567 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -124,6 +124,7 @@ config ARCH_HAS_DEBUG_WX
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
 	depends on ARCH_HAS_DEBUG_WX
+	depends on MMU
 	select PTDUMP_CORE
 	help
 	  Generate a warning if any W+X mappings are found at boot.
-- 
2.26.2

