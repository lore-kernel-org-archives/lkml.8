Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F149C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AB02070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsMPMGwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgG1CjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG1CjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:39:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C54BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so11058834pgf.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUYI/adhyPiJsueR+/blXGuxT74bedpBLyWN5AzH71w=;
        b=CsMPMGwi5qjh99+swfSsReaiMN1qq+LT1t0y0ZOTQIXJLGdNORymR9nu4xE/IM1dER
         79j83O+lMV2cp1RWIIPguXuX+QHPsKMq63S9aoFkycDHNEdPrriBG2+gJ/6SJrVZkfm4
         tfYaVpb3mfRA94cNvS8CbW1Irh15z/HBoVXu0AdcMTsh2ADSw+N8Ie9FefhGNSS1BvLg
         AADSh17QNCD6+1s9Jq/GgXPT8IAaEjbDtCXhxGekzj3TAXbRg5IDlYynSgZU4sGkT2Nq
         i+uNetnqlvLrGcPY7wg5cGkRgPKJbv8IGpyw0rWoOpDYzODQIdxcKZljBtnCQ5VbBNr4
         aBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUYI/adhyPiJsueR+/blXGuxT74bedpBLyWN5AzH71w=;
        b=psTg+EUqnWjhALykIPO6hiJ4yoUUyrviOWxz1C5QpyEmfaai6oO+1iCQtEvNObJ/6M
         TEQW9bdTsj4wU9NieYKIcYggKrA3aIkMRiLnFe6/C++ZR4fNtoOLCiwXo/XHPZPJo8DK
         U22h+ztSnrQ9fMqHghUPErhgP5bfudtCrsbrQTz0+lgWdTv0etugMlpTi4IpsvM8OQos
         K94kCHLLW/tYm3JUtOLtfQ3SKzESnGND1tBDEcK009KEElTTo7OWJVrTAMowsX92ssqu
         bsXmfNNB8oEjCyKKisufCleLPKzpE3+jz7GEEIP1uIhSe+Rg9Sz4s4E8/3VaLA2MFuYh
         AhWQ==
X-Gm-Message-State: AOAM530IGBqhB6teIsPRbsHfCerzPwGVt+vTKo8TBXJho9rB+zHThhfB
        rG8dcWjXAU/0x1wdN8o52YQ=
X-Google-Smtp-Source: ABdhPJwEW/i6cr8yKGUV4iUrV+oc9zuODe5AZFGhlurHT47TWT1ZKuVR/jgiS2zUyWoOzg6xYrAKag==
X-Received: by 2002:a63:df54:: with SMTP id h20mr21931159pgj.319.1595903956116;
        Mon, 27 Jul 2020 19:39:16 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id q66sm16428921pga.29.2020.07.27.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:39:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] xtensa: fix closing endif comment
Date:   Mon, 27 Jul 2020 19:38:53 -0700
Message-ID: <20200721024751.1257-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id p9sm14336962pgc.77.2020.07.20.19.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 19:48:03 -0700 (PDT)
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200728023853.aCKZfShGDVL2ofdGY6josWnhkM7wJK9LwJFbR-BzzkY@z>

Commit 8f74afa22d9b ("xtensa: switch to generic version of pte
allocation") introduced the following build warning for xtensa
  arch/xtensa/include/asm/pgalloc.h:67:8: warning: extra tokens at end of
  #endif directive [-Wendif-labels]
Fix #endif comment.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Fixes: 8f74afa22d9b ("xtensa: switch to generic version of pte allocation")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Andrew, could you please take this patch as the change that it fixes is
currently in the mm tree?

 arch/xtensa/include/asm/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 699a8fdf9005..d3a22da4d2c9 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -64,6 +64,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
-#endif CONFIG_MMU
+#endif /* CONFIG_MMU */
 
 #endif /* _XTENSA_PGALLOC_H */
-- 
2.20.1

