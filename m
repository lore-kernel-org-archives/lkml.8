Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28773C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE99220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UH/FEPUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgGBOrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbgGBOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EEC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so27100563wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3qxTGweigJBwA2Dcfmp6Oj8j3v23FLWhOhHeBcgW7I=;
        b=UH/FEPUuaJiocBixPJWaxF19GJofrsYjNd0ZwLFDYiM8v2DNvddLqbfFEcoEIAgua9
         bP2+NQ5D2EnmEmmOkQbHI1JvyYJ/o4zFDERtjZF/Uu9t+zeH9dUNXTfGa/pdIk4yUPVT
         vvgPEaa1aFKNK273L+hRW9C1Ev04KveXHYXLiyNdzpToBUXws7X15l+6DSLce7p6jeiD
         K1WSC+eCuZhhTPH1+Xzr3/PN1YghnkO1pOilzPFlhWeP9jW6k+/D1ZIAemdOPEOqmxJa
         Sfo4YYjZUP2FR65boUwbWOUyS/gbbcgDSJusheHBjW1mniiBCNgNVkiP4pZ6pixHLMGz
         YoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3qxTGweigJBwA2Dcfmp6Oj8j3v23FLWhOhHeBcgW7I=;
        b=KMay9jNGRRXj4p8/hTilFi2h3qLQOMv+k/zNYJ+j8SYVgaj9Ts+AuDFJOyqq+mXGjC
         fx2+EnbT+y+bkZRWrz//HqQu29ymuITU1A0rEDkFBOtBpCAK1TORtlFPEC3S+Ydo9ksj
         7cYLleF3Y4IN1DvDq2kAAhqCScCvPSLU7GDTYPkynLicVrrTqq5oUi3rqHFRE9YoS4sg
         DZr74YWV4ComsEDgjO3nI0K3WFpSW2K4OpLwx984DxuKG4tL1Atq2QTHZpCjYa3AeCV9
         ZEcHqOgqoQiUdZQ+qx8AI2vfEFwBLtgcVK7ERZcPdzVN6HSPseJIZogFBjt10XkAPSDp
         xI8Q==
X-Gm-Message-State: AOAM5336kZ/HfoWJRRwAKOYg5FU8IA7J1oQgO64JA7+u9/LdbBRTdffQ
        gdtu018+B77X0ZeZ0/RmxqNxBg==
X-Google-Smtp-Source: ABdhPJwSKu/tDOvAvRT809W5s5eyOxbUaM/7UBHj3f8+fnH4iRC5julZ8NEXw3uo/stZQZBYv3h22Q==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr20868613wmc.117.1593701222460;
        Thu, 02 Jul 2020 07:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:47:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 25/30] usb: mtu3: mtu3_core: Demote obvious misuse of kerneldoc to standard comment block
Date:   Thu,  2 Jul 2020 15:46:20 +0100
Message-Id: <20200702144625.2533530-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the function.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/mtu3/mtu3_core.c:805: warning: Function parameter or member 'mtu' not described in 'mtu3_set_dma_mask'

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/mtu3/mtu3_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 9dd02160cca97..6d515eb67ea79 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -797,7 +797,7 @@ static void mtu3_hw_exit(struct mtu3 *mtu)
 	mtu3_mem_free(mtu);
 }
 
-/**
+/*
  * we set 32-bit DMA mask by default, here check whether the controller
  * supports 36-bit DMA or not, if it does, set 36-bit DMA mask.
  */
-- 
2.25.1

