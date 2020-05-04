Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E28C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E472206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyaliD4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgEDXMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:12:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB5C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:12:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so6339760pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=h46EDReUv1S1ATBaSl4X6yKFbL5PQevboB9D//kDD+k=;
        b=xyaliD4Ok584TZG1EfQuKvA1CS0QaaSTFLv5YqnxSu7oVan9VyIOvVgszhDFsUZOgO
         lBRSEAaRfnsKPVy2d3fw02VbY3jbDVUHlWqijiJYRPQI080Ay0+Sw1rYmrSFGyg+nSW4
         CtGwL9HBGfWLPCWkjtl5xDyQF7wiK1kN+rdJbOT5oVe/arvGK5ZL/BWX32qlg34nl/c1
         awrQ0EJvv2BUZr6hJ2An4niDAHtO42d8bEcOtD1MjDPLtFiGcpsvSHfmcgESc/kI41Ov
         JnzTQcwT6ZKTvYjcsZ8kayOkEdjXzxqrD7BbrKmHKwx+HAYxsv74RGvrjPi8k9QnnLLk
         hfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h46EDReUv1S1ATBaSl4X6yKFbL5PQevboB9D//kDD+k=;
        b=TgGe8hC0+9RuhfJqHfTb0TcSYgYOTLPpSZ/uM/n+BszD3oWahJ0ZqvfjbmBfLUNVKV
         BtsZ5ibUVCZyteq/q4k7u227zISD9MRk5/Bh/UlWjOOLls5gdQPzG0Zl+Rh8GtcGxVpr
         Y0odpYCz6El9kr4kJK2jf00U3sf7qvGPpbIumXAbI9USPmSiu37o0ryoikcU62aYUQKs
         8aumugSTwFX8nyDL9PVTcrz+m//HCZK634Gswfcfsgtvwe21VNsP4IPnFpxnKNewgaj0
         wwlR7V7d87+cMn24BBeLFI141U3ZMPG7yzj7rquGXvEjOufLG+GTCJ2KS+CHzteC8YNn
         nH2g==
X-Gm-Message-State: AGi0PuYdP1EqF1kG+FfhqeRAfiKY27Hq8KvCb8HX2k2trXfvx72eXnoG
        OjmyAv+vY0YGwt+T1PfJETKj//VIgzk=
X-Google-Smtp-Source: APiQypKQgSB/Vffht7a4qUOaNUPHx8aJxH7d+fFEHtLffIrJKk+EXWHLsxzHL/CzPeeFIQX4QXtylw==
X-Received: by 2002:a63:ff42:: with SMTP id s2mr534731pgk.410.1588633938678;
        Mon, 04 May 2020 16:12:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id e196sm160964pfh.43.2020.05.04.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:18 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Josh Gao <jmgao@google.com>,
        Todd Kjos <tkjos@google.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: [RESEND][PATCH] dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
Date:   Mon,  4 May 2020 23:12:15 +0000
Message-Id: <20200504231215.55956-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for the HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
causes us to break out of the loop before we call
dwc3_gadget_ep_reclaim_completed_trb(), which is what likely
should be clearing the HWO flag.

This can cause odd behavior where we never reclaim all the trbs
in the sg list, so we never call giveback on a usb req, and that
will causes transfer stalls.

This effectively resovles the adb stalls seen on HiKey960
after userland changes started only using AIO in adbd.

Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Josh Gao <jmgao@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org #4.20+
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 00746c2848c0..585cb3deea7a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2483,9 +2483,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	for_each_sg(sg, s, pending, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-			break;
-
 		req->sg = sg_next(s);
 		req->num_pending_sgs--;
 
-- 
2.17.1

