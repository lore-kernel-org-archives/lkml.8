Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25854C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB77620729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuFuDos0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgGUCsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGUCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:48:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42679C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:48:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so913526pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cksS06U1qnevoEJIlv+grV0Oemjc9a1w0y2kvjgWiuI=;
        b=HuFuDos0EOAHqmklXCF6gWZVZJzosnL8X6CGvqcgM6Kqt0FAoBhM18o9itrl3wkJ9D
         gfELwTrd2bcEv7VjAZVmMIIWXZQOh1WHsuk5R4BY1m+gd4sHfU41p72+wqttC/euBOku
         w4Aq0LdhD98P7K3hM5FSwH5kDcPkvfiVGvlPo4Xr3FmhbrYzyCAPr4JZ4GdKYCg/DZEU
         BII6Oj/0/CJh2B+PO2MUN/Bh+K8UVqhwykSnDRewsUDKAm+iBqRWKRxu5cn5nf1Tmame
         MoAZZObOq1ucNhnSXD/cFC8bJ2LyWcHg9kt0MvlSvhvZJ87ct10JOnoa/eOg02L7K4bt
         TGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cksS06U1qnevoEJIlv+grV0Oemjc9a1w0y2kvjgWiuI=;
        b=l5pVoEEEQ5gHGOZs1xuGIUOu44JJk/46w9H+MXprnjrJwVVOVest0qen97Ar02Z9U7
         pjPqxHjw2LEdq1mYsYorcwYofKS9x01aKwNqJuQxKmcM7ROXRgqkCtNLi52etJHUCK8o
         HhBNkS5ngDfjDV2J5FSmIbR39sk5dxeVWmiOZcnARkkhOYLH1G+ES05mNQ7ksIOSQ4Qo
         2AK4juPSd755tDIkm8hGpIxhsbN/6brt4DYkisrLwCm6YVchEEGr5eHEJDtyFwX42rNT
         GzVly2QjnudpFRCN9IxsARje9c+KoFbA+HmuarhdcszT4eHo5Rcxi6nSTVqIJKWxoWIg
         btdw==
X-Gm-Message-State: AOAM5324LpdT+9JRThGtthHf+vKnOqqiUkyi4qJwGT+5z5elpA+notYh
        H+DHR6IiOd8Pzagi/AGhwAU=
X-Google-Smtp-Source: ABdhPJzEYBvW4gWqRIZtm8Q/iIG1zLRgwM7HyAYiumOOM4fHYbUEO6Z81UKPatzXGRlfXb10duvBtg==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr2375673pju.62.1595299683886;
        Mon, 20 Jul 2020 19:48:03 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id p9sm14336962pgc.77.2020.07.20.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:48:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] xtensa: fix closing endif comment
Date:   Mon, 20 Jul 2020 19:47:51 -0700
Message-Id: <20200721024751.1257-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8f74afa22d9b ("xtensa: switch to generic version of pte
allocation") introduced the following build warning for xtensa
  arch/xtensa/include/asm/pgalloc.h:67:8: warning: extra tokens at end of
  #endif directive [-Wendif-labels]
Fix #endif comment.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Fixes: 8f74afa22d9b ("xtensa: switch to generic version of pte allocation")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
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

