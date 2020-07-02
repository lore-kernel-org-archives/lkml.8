Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F202BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38012067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mq1Q5i/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgGBOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgGBOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291CC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so17512568wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2ZbcYjJZjZ17aCzzB/muazXcgiT4k+gU+MxkZwfWa8=;
        b=Mq1Q5i/AEO457zmTrv+POuxnGzOAe+6/nY9A5cmZtvfowIplFqpV1Eke6o1PXZdyi6
         VJNNLYPpwyhWZlYftQRTK49825KmLFsYZ5p8sohqPXDFA1DByoIbH7eMh2WdHrbZHk4a
         tUrM5lieL0qZWrljuF0MFtiyYIIgD0lEYfkh90NWOfpwpubQITmjvwsPJTyovuFg6ZLi
         geCvUfUGEhMmASDmyzzSvlUfJO//nZLj45kN6iVv6QAtcOo9cBt3Kp5viFUQj8cXEb+Z
         mw00++JZLQ1CQr9sHz5dLhc3zIELZJdfkdmgGOGRamyf0zqOn5oU+GPnyIQfEx9uddeM
         JIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2ZbcYjJZjZ17aCzzB/muazXcgiT4k+gU+MxkZwfWa8=;
        b=q9DMmhJ+SkUxKwlCS7aOWDLQ/CeXT4u3m5zBv9gfC2jAgjeOCi2J3Hj09ciCX2pyII
         80Q14rJXLa6/2iJBFEo0/OD3l01Izg/+cTsl/v5prRMIdUsWaxtntti0NSRNqcq2kfU6
         CezfHcBTSLkpLMS8QZ3ZUjc5VtM5ZTNm8rpx4473QAkVFOTwNF0B5r1jHz2ZCcbXEKFe
         3cD/qpyXEvva3ndTdQdEG5XuNuA/EWgl4NA7sUReQjrIj0o6t6SP0R9MXrttuRrMqY3O
         RW2+s7XHdQ1K2MdZSugUR9uUo78NO/RjiH1bZ30gG4dF0/YXJPX0MaQzs5MBgIa6g3Ey
         X78g==
X-Gm-Message-State: AOAM532MC0ef0/fA8xt84GyVmZ9jEsWPgPG4VuZVwRRQrU5WTynPOmJO
        SE6LyIon7gWdoSElS0HoKLExQA==
X-Google-Smtp-Source: ABdhPJzL8QUTzwy3oMlhA58n2PXE6vG/UgMbPHNq/o/+zK/18O97nXXvR9OcedR0UNxfobMNkjoqDw==
X-Received: by 2002:adf:f445:: with SMTP id f5mr32588597wrp.339.1593701210450;
        Thu, 02 Jul 2020 07:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>,
        John Youn <johnyoun@synopsys.com>
Subject: [PATCH 15/30] usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
Date:   Thu,  2 Jul 2020 15:46:10 +0100
Message-Id: <20200702144625.2533530-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warnings:

 drivers/usb/dwc3/dwc3-haps.c:19: warning: Incorrect use of kernel-doc format:  * struct dwc3_haps - Driver private structure
 drivers/usb/dwc3/dwc3-haps.c:23: warning: cannot understand function prototype: 'struct dwc3_haps '

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: John Youn <johnyoun@synopsys.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/dwc3-haps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
index 3cecbf1694526..55b4a901168e8 100644
--- a/drivers/usb/dwc3/dwc3-haps.c
+++ b/drivers/usb/dwc3/dwc3-haps.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-haps.c - Synopsys HAPS PCI Specific glue layer
  *
  * Copyright (C) 2018 Synopsys, Inc.
-- 
2.25.1

