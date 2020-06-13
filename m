Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5804120792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="blYeLB6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFMXIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:08:54 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:54384 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgFMXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:08:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ktZD0W9zz9vbsm
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a413e_RyYr0g for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:08:51 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ktZC5tC4z9vbsh
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:08:51 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ktZC5tC4z9vbsh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ktZC5tC4z9vbsh
Received: by mail-io1-f69.google.com with SMTP id x2so3321170iof.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bqeKwkOk6XZo5v2wD5bUoMhkkwGMTZ2YIiOp5s0J3EI=;
        b=blYeLB6ruy/BG0h+sr5PZC8DoM0/i2T2Yvh9NEaV9hzbNZD1SDp9DY8c6cGGW/AAT/
         39f7Fd2g7xUEK781SumumsDR8PTGMWjNkPMgb8rsDjymEeiJO+9lbMyZJn1wG9UjuiMb
         /QXZN998+U3zxGn1RCQGoxuNoYt+KjginABbTtg/Sj4aFeSW0C1XTY7YH0O6ThyPhE2E
         KTCIqxnZf8fr/NFJimQ06vaP/Vq/HJxx1HEiBl0WS0OYT0FBQTojqzpingYrxbBOOaWr
         ktfhq9wtBiQAw9gz3W7hGuQRUieM5kIlPjn3HaDvJrMU+bJ1swi6J+dcnxFdIf4lSuFT
         8q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bqeKwkOk6XZo5v2wD5bUoMhkkwGMTZ2YIiOp5s0J3EI=;
        b=UGOnFaIwvc1CMHJACPotvpv8BIv4HXl0fpzNy7L+tcihGOCM5rY0qtzu7uDaNOMST8
         WI8x8yjqH8Wn1gECx/ojPvdLjzEQ2D5+S0uyDkgUKg6shaGPOo5IQzYVevrtcixQIjHs
         cUEoiBOsm1AeCXeYRE7/RS8j4jILQbweRsm0StCZNMmuBkMAHjq9sAmVr4zV3tSXY4lL
         5J4UW4Sr3vhJcn8ufdYaFkSdmB5og5SJEKXXDblSzngsVWDCtKjPFBmPuD0n2NtoxOZR
         yo83zGPs1rFLLJWroLnM3Lp5OqrfYbw2oxNrnePZhOr90nnXJORtQKBCEh1iPtO+rMRH
         GUIA==
X-Gm-Message-State: AOAM532evKsseAJWmvMY7SKPTVFbQYe2XQ/v45MiwS1pLWE7hfJJa2xi
        Qc1FSAaFkru9hddt1oCGmTHrOt/Qj9/GuXRMiT4qI+Q59Lk6xnWPB7TKGSo1NyqStBYUb+/Fg5Y
        hgWOVVnUjg0BrslN32+n6gjCeE7S4
X-Received: by 2002:a92:b00e:: with SMTP id x14mr18850426ilh.219.1592089731319;
        Sat, 13 Jun 2020 16:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmVCe/qnocqMDuI+rUSn33JC0xwAkRz8hA8NtZAbzgXhzeCZTSmGkdB8UI2YxFK+JAFiuFRQ==
X-Received: by 2002:a92:b00e:: with SMTP id x14mr18850406ilh.219.1592089731061;
        Sat, 13 Jun 2020 16:08:51 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id y5sm5668155iov.3.2020.06.13.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:08:50 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ricky Liang <jcliang@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:08:43 -0500
Message-Id: <20200613230843.14109-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f82a81a3bdee..097f0b050f67 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -710,8 +710,10 @@ static int mtk_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
 	int ret = 0;
 
 	ret = pm_runtime_get_sync(ctx->jpeg->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(ctx->jpeg->dev);
 		goto err;
+	}
 
 	return 0;
 err:
-- 
2.17.1

