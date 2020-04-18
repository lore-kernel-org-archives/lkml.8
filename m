Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08388C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA792221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D305RZ2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDRIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:24:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535DBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so5350916wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YoRycWp3ZzU6ErnPbJY/a8TLBc8LlFawMbLlTROq7MU=;
        b=D305RZ2S/XwIEs+u9UXdO/egTZZyN0JtEkCJNrw+rCvbhyeXWoUQ3Y5+qp4K/gfC2m
         yxaTE1mZlgL70F/uXe3/J0a6UnXKvQ6r4wDLJiXgT+6PJ5eEwNqtoTR2qdYGChBEboTN
         kkMic28U5HUmHukzQynghRGtvbfsWGfucOppRPcfbofKR8HjY6aN+oqsYpfT1q2gNA3o
         9cyGVSAqTsr9wSYre4flN2FqfXIlWd5a1VfPks/xc92s/U9zrICFoRvBaIsG6RuFbg5F
         VeW/nuEm+6GolPJ0MZxdMrPUM1+7ZqXTafTiaB0iGn4vMrtz+Cdkir+8bAl7z7555NF6
         nuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YoRycWp3ZzU6ErnPbJY/a8TLBc8LlFawMbLlTROq7MU=;
        b=RTAZkmVZxG+y3rDtN8OZWn8bPSt4ldKPlq07Y0RO3/HKRFGRPbJL3D+OlL1umEPgPG
         TalDNEzPyt3CeBymA0OdJUMoxSqVVlQL0xixStEsOtyT/qjEwraI29h13boAc3fRhg1n
         1f5HPJ0Hnj0Cc044JmsTNovSJL3H/5yP4qCSxAGZGDytirhMATZ25EwseFmfmMy9letR
         MB1VZMV1HPkQVn9wgzjs+cjbu/4CgiG+OXXqQakZ5aelVswlHsHuiHuaqhjEVcIiwtMZ
         LBG0eOZosTWpwgS+k9efpivEjNsEVMkz2xKtouTG9BLuGZp1RrUvSXyyvtTbHhA1SwIY
         qKvA==
X-Gm-Message-State: AGi0PuaCmnBVV6nJSwRR55FpyqjKGCsBMysM0ExZIv9kkNYGOWdfxTEj
        x2XuyVVojqqwJemOB96+vBT5R4l1
X-Google-Smtp-Source: APiQypIkxjXkl5ScsvKV+bL8A2MjKxCrN88xM/PSWGeNeJ6XrNhFBiGbI+grLRUciKMSlTFKu92/Ow==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr7130209wmq.175.1587198287809;
        Sat, 18 Apr 2020 01:24:47 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c190sm10898087wme.4.2020.04.18.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:24:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/5] habanalabs: Allow access to TPC LFSR register
Date:   Sat, 18 Apr 2020 11:24:37 +0300
Message-Id: <20200418082440.21277-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418082440.21277-1-oded.gabbay@gmail.com>
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Allow user access to TPC LFSR register, as it might be accessed by TPC
kernels.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_security.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index d6ec12b3e692..2dfdfbb07905 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -683,7 +683,6 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1 << ((mmTPC0_CFG_SEMAPHORE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC0_CFG_LFSR_POLYNOM & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_STATUS & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
-- 
2.17.1

