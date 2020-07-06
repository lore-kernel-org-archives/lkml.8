Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40299C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193BF206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLGORxri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgGFNdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgGFNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8337C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so12968624wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da1l6YoL6n3bU+jKdqHFRQjokYKz+vBJsiPCL0gGolc=;
        b=RLGORxri111/tc0Sf0mSoMmtk2VwtRaHx86WcvDwSf1/2SpW+CMz1rr253sGKsrvUK
         uK22hb403LtPowLnwcDgpTXUfLiAzl7Ehka5hCIWxZK6tjJrXH/wyoVJgONMo5Vu0Nlj
         JOVU+F2Tj3eJNLPuV+P6fh0BlaNOe3kQimvqE0cUCtSdVVV++6OkgHXYK9XMdK6fCCjd
         iZNN4s0Qp4aWOgSDwztx886A+qDLbMjw6kR7XG7HJvjUgbm3GyBPHn2A4CX1p7G+5fJG
         RBZDMLNZSD0KaU+9REz4lAenuUrsvBhPyngaO9nQBPnshwM8sSoFKRwQJe7F/lZ+K4W/
         mSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da1l6YoL6n3bU+jKdqHFRQjokYKz+vBJsiPCL0gGolc=;
        b=Ib9T98BScRAfmJ+90rsXyC7+65VYA+Coue65YjMcc0avB+b7bgQXDABEicrdV2etol
         BZ2DZ+Wa+dsegJkq2j/WyJk0vCytB6Sc2s46f0x0r9oXb/KOtsXnIyygiiq4hmFsyYya
         U0qg/WO8iYL1lpARn6QEx5hOmnQ9UI5Poul/+y2JgXDMJ3sDD+5F4lEfdlDiFHqAHgDF
         JPf+Swv1rKWMwe/QQXcczYHQpLYPIWutwtTHMWyVaGMnC1s2gbIMaNIqpGAR+8EnKpKI
         B0ZSRNNGTW9HgwKUM+3rJjm8LFB1EjCEPYm0LHvxwtxs0N0gXesDvc+z48vns1ZC5k3b
         PVEw==
X-Gm-Message-State: AOAM533q0d04fnLSLEvn1tTT+nwOYjztSdkqJ2QPltXFaz8jDnIJcHjz
        SxYPIBcn4eAIQWJVkTtF+20Ssw==
X-Google-Smtp-Source: ABdhPJxATiVCCEdpbl6fe+AbCMEAVhovrhkPLT0ovW8Huxs2dGyxJI6Eppza+UQYGaCLyWLadV5R2g==
X-Received: by 2002:a5d:504b:: with SMTP id h11mr47735862wrt.160.1594042428510;
        Mon, 06 Jul 2020 06:33:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 03/32] usb: gadget: legacy: printer: Remove unused variable 'driver_desc'
Date:   Mon,  6 Jul 2020 14:33:12 +0100
Message-Id: <20200706133341.476881-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/legacy/printer.c:24:19: warning: ‘driver_desc’ defined but not used [-Wunused-const-variable=]

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/legacy/printer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/printer.c b/drivers/usb/gadget/legacy/printer.c
index 57858f0c2b6c9..2cd389575084b 100644
--- a/drivers/usb/gadget/legacy/printer.c
+++ b/drivers/usb/gadget/legacy/printer.c
@@ -21,7 +21,6 @@ USB_GADGET_COMPOSITE_OPTIONS();
 #define DRIVER_VERSION		"2015 FEB 17"
 
 static const char shortname [] = "printer";
-static const char driver_desc [] = DRIVER_DESC;
 
 #include "u_printer.h"
 
-- 
2.25.1

