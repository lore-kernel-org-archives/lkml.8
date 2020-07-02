Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B49320772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAQqKXwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgGBOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgGBOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48812C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so27095208wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cen7jwZ+l5/fZQV9+f4eKCsdCtb++xjGqhYwjDReG4s=;
        b=wAQqKXwNUvkayHtIMBV6LS0l4vt72aFTjRZSPiSvZJ5C/hqTBy3STN6t0PpK9LZ9Sl
         Lb2UEfzaiMVbpQgMEOWrkp/dkAtB7fHH/UdXXaH4Bf/pD65LBDmzIoAElaEn6uRbkhsr
         Sq6KZ9fmigZNrcfwKtfJpaz/LqAUX/icEFbG3MXXNaTW9OxviX1QsPqnDatS1kMepeKS
         ppuFUZVk6RIA9kGXBgwQV83qvsCFqp560ZzvnuFh2RPn028KWAA/WSY3RrZ3P7YNx2HP
         rVxY/LyhKyYUKA1wHnrnUWETqAHP/uHelYufgGMcwMsaC+Gn9/8D884fgDtbffl5wEIf
         Db4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cen7jwZ+l5/fZQV9+f4eKCsdCtb++xjGqhYwjDReG4s=;
        b=UeL8uOwtfRZY+kkJUstISMFNEMLv1EFqcT11y20kqYoLFdSP8VsTFstsfajBVZ3fmD
         5aXwMGOsg9iYsl1LTeNS/uQD+L3D1cM53th6Hgivlwgp5PN6a8YdhvspPKLffEDPpzeO
         CX87r8u43vnMnYzps5dFZfD4Xno249pxBdndrmfpmsMpMVZQ2Dyl4ZxILKU8jPXsWrlw
         8VD6W3w/S0M96GyMDd2seXZq7E1PWVsNOYyRo3+LU6PFJIfWUlBaU0hxKXWG/j08dxqk
         X6xq01AJmdcbxRxSDy54Ha4EQc82nGwSqhmD3ce4R6r6OLcWAQp+QvxGlPvU7LQi7i9b
         bVGw==
X-Gm-Message-State: AOAM5321lGCbQpOKAoyTTm3toq5Uz3JStcmlFP1cFJPbqie6xIpT6jdy
        YmECuH0xVQBmVm2ApPHVLPQ+wfs8CRc=
X-Google-Smtp-Source: ABdhPJyKXHl2Fi+reKwJfYF/na/idnzE4RoZeL56RxRf05pfTe+1N4F2X4OdO6C8BsdOK8Y+xUFvgg==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr18364006wma.46.1593701221058;
        Thu, 02 Jul 2020 07:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:47:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 24/30] usb: mtu3: mtu3_trace: Supply missing mtu3_debug.h include file
Date:   Thu,  2 Jul 2020 15:46:19 +0100
Message-Id: <20200702144625.2533530-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the header file containing a function's prototype isn't included by
the sourcefile containing the associated function, the build system
complains of missing prototypes.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/mtu3/mtu3_trace.c:13:6: warning: no previous prototype for ‘mtu3_dbg_trace’ [-Wmissing-prototypes]
 13 | void mtu3_dbg_trace(struct device *dev, const char *fmt, ...)
 | ^~~~~~~~~~~~~~

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/mtu3/mtu3_trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_trace.c b/drivers/usb/mtu3/mtu3_trace.c
index 155eae126e5e2..d17ddb87cdcf2 100644
--- a/drivers/usb/mtu3/mtu3_trace.c
+++ b/drivers/usb/mtu3/mtu3_trace.c
@@ -8,6 +8,7 @@
  */
 
 #define CREATE_TRACE_POINTS
+#include "mtu3_debug.h"
 #include "mtu3_trace.h"
 
 void mtu3_dbg_trace(struct device *dev, const char *fmt, ...)
-- 
2.25.1

