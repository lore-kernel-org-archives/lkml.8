Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21C820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWrA80RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgGAMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgGAMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE585C03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so21602761wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrIyNI5ZF/KUj1ZtT7jKpZfKmT6HM/rM07zicowUN5s=;
        b=HWrA80RXIAqmo5CKdWTISZJHmseFSX+3Dyz3Ow1WhDW5QxMOYcgIY6wdeztm6ESucb
         Bm/J9GT1TDSzZ8gPQVE/FDr23Dp5jiDD1gHJD7RDTKJMdDq6hV0aLQfzYnkwZXaJXYCx
         lLt9OjNCVFiEVXjv0OyqtuQSXOF7Y70KV0ReaL9HJXcX0PXwm0S3VPJ/qUke3nn+sn/v
         P3m69z3xKwOK9IuXhP/xxiNZ6+vk0Maggv/Ze/Hlwl8I6LL5mP6el3w1fNIXesCUrFye
         1xghHvJgE8hIUQxPXccn0sFsIIKe9pKGOn/+6rzOAf4VIeyH4aoH0TZXq1f0/5uLccsl
         36yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrIyNI5ZF/KUj1ZtT7jKpZfKmT6HM/rM07zicowUN5s=;
        b=cBhJoqcY6qTXJiDZlrjCxQrMTWEe65/sBSxeAM6jqwRoQAR9b7wD4UunBJzajbPwHA
         o0qQS+GFvysJ4pmTw6qxGpXvwjUGzH+O/mKMMALWbYH4IuV9M+5JT1w/6CeJEMs1k8p2
         DdFCFlTohMwYv9TynD8LOE8rjT5OvTGrz9eFmxbnTf7whebJ7Ex/N15yp+59C/dX9mWP
         e8FAIWaztV4APPkDg8oXYM4I83Z/oeXhQO5s1DduVoHHD+DI4B/oy7/n9vE6Ppq6CHXE
         hg1+CHZ3ByIC6se45TDEq6qiL58OVAqceliQDHYhXjtVIaD3z65WqN9ScIEH2xvdCiLq
         2d0A==
X-Gm-Message-State: AOAM532oxFVRW7iHOqmsxSzNFBd6vsc6sJl/SAlb58tq06oSp9dXCjUs
        67G7G33mh/5GKNWtvme8dQKM8A==
X-Google-Smtp-Source: ABdhPJxrkgYBUNiXUPxL6R2LO6yk68bXOYLtPWMdEp987Bhj7XPp0ZSAKkOf3hcOpVV/xo1vAf6y1w==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr26946217wma.33.1593607639564;
        Wed, 01 Jul 2020 05:47:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Xiaobo Xie <X.Xie@freescale.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Soeren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 11/15] mmc: host: sdhci-of-arasan: Correct formatting and provide missing function arg(s)
Date:   Wed,  1 Jul 2020 13:46:58 +0100
Message-Id: <20200701124702.908713-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects arg descriptions to be in the format '@.*: '.  If either
the '@' or the ':' is omitted then kerneldoc complains that the description
is missing.  Add the missing ':' here and provide a new description for
'value'.

Fixes the following kernel build W=1 warnings:

 drivers/mmc/host/sdhci-of-arasan.c:1394: warning: Function parameter or member 'host' not described in 'sdhci_arasan_update_support64b'
 drivers/mmc/host/sdhci-of-arasan.c:1394: warning: Function parameter or member 'value' not described in 'sdhci_arasan_update_support64b'
 drivers/mmc/host/sdhci-msm.c:1887:6: warning: no previous prototype for ‘sdhci_msm_dump_vendor_regs’ [-Wmissing-prototypes]

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Xiaobo Xie <X.Xie@freescale.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Soeren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index db9b544465cda..260e06e238f7e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1388,7 +1388,8 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
  * - For Keem Bay, it is required to clear this bit. Its default value is 1'b1.
  *   Keem Bay does not support 64-bit access.
  *
- * @host		The sdhci_host
+ * @host:		The sdhci_host
+ * @value:		The value to write
  */
 static void sdhci_arasan_update_support64b(struct sdhci_host *host, u32 value)
 {
-- 
2.25.1

