Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F63C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAFB2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="al9N3pH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGPGPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgGPGPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:15:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so3423016ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NH8aoxyeroB9r2QCUkJbzC8njwuGOl2txaaxtAHbw8Y=;
        b=al9N3pH2qFvWwSBc8W/ztrqzKd8bd1pyR+1d1oVXLKb49o52h5gNdw9FNyFPExLy0C
         Wfftfu7vRuEfQNU83Zw+n370ONmwthk2AIMqzgMjgOiOqKHirErJOc6nY9kgSSI82mDi
         CXbWLS/zhRxRh1jnPa8B4fG5mMSZWcg3idp+CiJsDQGP50k9FUCZbzbDstw1L9PrxoQh
         h2zGbKTWGiEh8KdRIeCZ5MziDD8BEzW1O9cPCsnwQIO47UOE+N9qjSKuRnoVhN79zC0F
         3jp//s+xZ4R5E/hZX+N65zfCjVDcPySj11v+cR0aoeGksyu2p+F6MMpy3NW5yQdgYP9a
         HBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH8aoxyeroB9r2QCUkJbzC8njwuGOl2txaaxtAHbw8Y=;
        b=CsVwpgN3/Z9+6kNLVaVjdM7flgvhyu/JGxWRtTvIksMEds4aaIXunkVRW/8M6cpr6X
         Bmba60w+TKyqXjKdmIUs1krLnwzNE4Ln4grNzPN0BwXaJKdau4fO8iT0GDHeLnfqV6bQ
         xc7VJsC4aILOBIP2pw6HK1YG65GbBUsWywMqUCOW/cgu4oiMh97J/FcDs3LG1O8seNGt
         J0bwnuuzfmluqfhSJI7a6tneCoQXAT4Z0h6wyNDQWA3jPbxcWH6mmYjhmCy13qeEr8+9
         q22720UlJSLRMbEB5Q91GeoxhPP5iakHkWBpWhs/FMs6i5I/1xyHGvPpYHIxSrA20Wj3
         NcMQ==
X-Gm-Message-State: AOAM53077K5n/3EFLfSb6/OnUffUGJx6g5um0UIwuKazFfYN3rQtmOcz
        pNuPjfsPCVm14NYL5U/5xF1J24X8Ph4=
X-Google-Smtp-Source: ABdhPJzleHvggTpz3JiVT7FG0OtQVvIPyv7xwLfn4i023ZwXgV+KjpcGGIOtQaCuKqOKSR3mKS+2/A==
X-Received: by 2002:a17:90a:1acc:: with SMTP id p70mr3456925pjp.210.1594880133577;
        Wed, 15 Jul 2020 23:15:33 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w20sm3669904pfn.44.2020.07.15.23.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:15:33 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/2] riscv: Fix build warning for mm/init
Date:   Thu, 16 Jul 2020 14:15:26 +0800
Message-Id: <0ce0ae99b9af776497bce02f9ee1efb85797ce9f.1594880014.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594880014.git.zong.li@sifive.com>
References: <cover.1594880014.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add static keyword for resource_init, this function is only used in this
object file.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 92002952c621..66f5952f39c0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -517,7 +517,7 @@ void mark_rodata_ro(void)
 }
 #endif
 
-void __init resource_init(void)
+static void __init resource_init(void)
 {
 	struct memblock_region *region;
 
-- 
2.27.0

