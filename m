Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D5C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E1A24676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsGmOvIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAVW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:26:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34274 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAVW0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:26:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so286494pgf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JESjh6inBv92WxZqfb4czYKZ8FKdIT47e0CUpHsL9zw=;
        b=RsGmOvIt+Bzr6i4aIVzintUFXr+6XX+aQJNI6juKMss4wBAunzxItSZlGbXw7ha+3c
         V5pNjplf1oyvhJV3/UY1eBclT7Bav7RGheW0wzEZ34ThAk5YhiMCUCN0jmmS1fz8i5Rq
         3WBNsJe0+drVR3Fi8glb78/uzKQBNkHkind1gitZeqjlkXBg0eabjb5ILlDjiP473ux2
         LZ5J1BPDiBf1L0IJfDdw5BDmpkkp2vVEuWl426uWWk4c+8E+pLHAJj5YK1M0M+OeLBsV
         MxdvsQOkXmBtkojh4QldDc4RcnkQiSuotRNJcvmGpFH5ESJmrVx/O4yKvoYr4dhdqkxW
         1p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JESjh6inBv92WxZqfb4czYKZ8FKdIT47e0CUpHsL9zw=;
        b=F99/4MlsTkU3JNxu9txlWnRlWLu020Uun1+5iumV+tKvBlH5pkSfyO0HZkeLkLGCJc
         zajyk5CzPFDm/inVgsOb/VWqgfCzellawoahNQMxaQ586ak9MpHquer0KrogfxH+h2iH
         YuX2GSOGvSC3l6TZw8YruM6nKCHrJXmbU/KGracWp2C5y5Vn5KRv9w5/XJdXMg9b/1XU
         3YZY/gecJpM1dv6LYrTyAQKkX44Np9wCjTveR5+Tg2uHZKpM05jH6S5z6CdzO8lXbqOm
         e2pKYYGmCpAaLD6SYYOnNWObcaUPWLpg3yNon+ULNRQl3kTK4Cvi9ceReBAVyOkeDpO2
         6kEw==
X-Gm-Message-State: APjAAAWa0Un63qI9umyVDMkgQ0Q1MdPqerF1A4Ojnj/dBwr56WuoNY4G
        KgL8OqQMxbrK2MBs459NDY3M9R2Mlxs=
X-Google-Smtp-Source: APXvYqyHFnzdcPwFmtLdIrSYOuAiwsCTGRIQwQ9Jlfx8tJ4RGPs5SBRmOuXWib6jnxyijCN3yYVuiA==
X-Received: by 2002:a63:111e:: with SMTP id g30mr541062pgl.251.1579732011742;
        Wed, 22 Jan 2020 14:26:51 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a28sm47793509pfh.119.2020.01.22.14.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:26:51 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 1/2] usb: dwc3: gadget: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Wed, 22 Jan 2020 22:26:44 +0000
Message-Id: <20200122222645.38805-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122222645.38805-1-john.stultz@linaro.org>
References: <20200122222645.38805-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

At a practical level, this patch resolves USB transfer stalls seen
with adb on dwc3 based HiKey960 after functionfs gadget added
scatter-gather support around v4.20.

Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Cc: stable <stable@vger.kernel.org>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
[jstultz: forward ported to mainline, added note to commit log]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 154f3f3e8cff..1edce3bbb55c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2420,7 +2420,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.17.1

