Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B3C81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E1520775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrS+xrLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD0WfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0WfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:35:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04754C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:35:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so22458209wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HraMkEGX88busPiKwmuzcywo9Z5JiKgdM87rLcbGz7w=;
        b=PrS+xrLFJjfmWKdUOKxQx1/DWa89j1oD/k/VkN8XJSWgznN9FUUeWAyNCtZnTN1W3C
         bMKkV+eGBfd3pA6MUgZc6B0v3lccOkmSNZw43rTnD+oTK5VdzJfWW/p2nw4x7QPGa6l1
         SnAgbNwg5b9dMtXheWRVbRAw5uhQ3k6KbX/JWsMTOeibgfbiyq/p+D1e/1AVcUb7ou9j
         z5euEvYcfQ3cBGBPd7rnwtVq8839MfVwcPTQOhZFfrZVGg3z9FMzKjAfGpuXwtCGRjqG
         2956+L/Y+Vgy2HNy2mTzj/vSC9BCwzOkLW6wJHR4mt7VGBzpmsVyJ4ZHlxYD5fpCArLm
         psOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HraMkEGX88busPiKwmuzcywo9Z5JiKgdM87rLcbGz7w=;
        b=ZdXKtFQRn7K2tT+dufVQB+k2xEg6LIVNstasPRl8JIXqyWfX0hN2kV9JnCweRciixb
         EfkRaFp62OJ4gmX0mFcQ9nS7IawyiKoA30K4zeJ8GEO14Wz/cuukGVGA1X2VrTCJMgyE
         +lcwDOs/kFp4b7pPXn+v5RcKGt0G+dDjJo1cH3o7BRJd96XqSo3vG9akPXQRKkxs4qdx
         wRnf49ny5kWOsG2tuq7P/NTCEwv+qQv/FRLzd0JZa3ty6ZuuOaF3UE/QJs0JyRPMt8Vb
         vTF3BL2XiJ8gms9iLrnXhPzGuhdeAgpgNPm6jDbaBUHq5eyJsGtr1D2/7q6rh6vpeSrB
         FXYQ==
X-Gm-Message-State: AGi0Pua6akxiaWB0qXvjVL58uNrgOwY+WCSw98ZAZEr/YEbFiLhVwhS9
        GPyDilP8dFBN3FnvBB8+HxYbg4jU
X-Google-Smtp-Source: APiQypKp6o3vUuS8yllHng+UfxAMY+LezMbqYOstcbBwnkQ736u+VGri2bpiJiN2wgQnh2Su8piMcw==
X-Received: by 2002:adf:f784:: with SMTP id q4mr29734099wrp.102.1588026906094;
        Mon, 27 Apr 2020 15:35:06 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s30sm22999162wrb.67.2020.04.27.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 15:35:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Adam Aharon <aaharon@habana.ai>
Subject: [PATCH 1/2] habanalabs: enable trace data compression (profiler)
Date:   Tue, 28 Apr 2020 02:40:46 +0300
Message-Id: <20200427234047.13249-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Aharon <aaharon@habana.ai>

Set the STMTCSR.COMPEN bit to enable leading-zero trace data
compression functionality for the extended stimulus ports.

Signed-off-by: Adam Aharon <aaharon@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index a1bc930d904f..1258724ea510 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -266,7 +266,7 @@ static int goya_config_stm(struct hl_device *hdev,
 		WREG32(base_reg + 0xDF4, 0x80);
 		WREG32(base_reg + 0xE8C, input->frequency);
 		WREG32(base_reg + 0xE90, 0x7FF);
-		WREG32(base_reg + 0xE80, 0x7 | (input->id << 16));
+		WREG32(base_reg + 0xE80, 0x27 | (input->id << 16));
 	} else {
 		WREG32(base_reg + 0xE80, 4);
 		WREG32(base_reg + 0xD64, 0);
-- 
2.17.1

