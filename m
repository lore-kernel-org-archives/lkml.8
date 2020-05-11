Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239EBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E7C206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpbbUDaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgEKQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:29:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533FBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:29:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m24so9098644wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfKRBxYbb6m/b9/QgIvfPiqDsDk95S9RSARlHkl9An0=;
        b=tpbbUDaAZgNrNk6b/o76dv2RwUJW97IOxe00ZbkrdrnRmywGmfAcFgQsKy7HSDdaBz
         /JuMTpwP917IjwDx1/UoF8IXmuR8N6LsfGGfA82Zq883kkxmCQqnMi2yy1Gsdv+UFSZ2
         LJ9IlGoDv1nPJ7moHEYnOXMk5cn9lsFdrx8ZQSYmL3QKg3XHg59cZFcmMo1uylKQCTBR
         Aa3PGblZ0yHOFMzKC06F8+MmwdlTZ2MSLPe+k+6QTiyuRAuT6msI5rBhwnPEmnKNPcEf
         xLWqAndl9jaaFYKI7YBsyKH7LRsbFawTBChG5bQK3QmmR64ux4F4z04VizBWJQVX8qgG
         e8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfKRBxYbb6m/b9/QgIvfPiqDsDk95S9RSARlHkl9An0=;
        b=Vu37VegXOTd5RsHeD+Z2xGOZW2928xwpNPuEoJLy/L2tENnF6fw7W/w0zGFUKe1Tkk
         wuXZiTtVIKTveGfKI3tb3SGHZYfFMsnhM9i7tzGC3MuOljWB/zjSBphkmWqzFQzE6Mp9
         WgIwknjCgKFmXJXfrlEPxfsvWtuVNMpfKqIciHY4LxdMObdwPKymMXEt7lCAYOXXbeFe
         niobDF9rkihov6SgI73+W02lcOabKXusyYtAdq/431N/7XsrLL3mlsKuoGrF8rK8hLHn
         kHBnCtS6vHI5SlD8ymvvhkuCNzZwHZjFkvO/Weh2BHhjlJb3iFVSI9q9gENbBSlB+REx
         PsQg==
X-Gm-Message-State: AGi0PuYr2KRibwa2FwRQKMhQ4vo4XVRamOmD8NBdXfEmz4+LYRJLABD5
        dmXeguVBMuWS5JQYUtIGU4j2mA==
X-Google-Smtp-Source: APiQypKnL7Dw9SKRhLpoN/UNhN4ri2w0wkwrh/2jeR0e6yW4+wkl3lNIi1z/67KMUeRls0AE2M5Yag==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr18700616wml.117.1589214575942;
        Mon, 11 May 2020 09:29:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 7sm20448844wra.50.2020.05.11.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:29:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] misc: fastrpc: fix potential fastrpc_invoke_ctx leak
Date:   Mon, 11 May 2020 17:29:27 +0100
Message-Id: <20200511162927.2843-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fastrpc_invoke_ctx can have refcount of 2 in error path where
rpmsg_send() fails to send invoke message. decrement the refcount
properly in the error path to fix this leak.

This also fixes below static checker warning:

drivers/misc/fastrpc.c:990 fastrpc_internal_invoke()
warn: 'ctx->refcount.refcount.ref.counter' not decremented on lines: 990.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9065d3e71ff7..07065728e39f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -949,8 +949,10 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	dma_wmb();
 	/* Send invoke buffer to remote dsp */
 	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
-	if (err)
+	if (err) {
+		fastrpc_context_put(ctx);
 		goto bail;
+	}
 
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-- 
2.21.0

