Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA2C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAE7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elJrTPL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgA0Tav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:30:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35827 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0Tav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:30:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so4116615plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4FpDeS7FVDfifQejKt5Fo3FpOuyI3aVXyTigplJTJKg=;
        b=elJrTPL4i5D0s3VuCe3A4IDJCMJuckpknfF6RIj8HfDon93rN/Eqzm8gM7opbJMwtg
         +olHjcgUyYyCp6ww5p5oyoHP5iI0CRYn81PHwx0DJxXLDgTpxKOJQ9U87JTTzHWG7Q0Q
         ZU7VDPNvyMmPVgsEaV3yLk0o2tiP1EGvzlAy/THV0fNIp2kl8NcYAicRC8bdPPvYXuiN
         nftlTxOTXAO2K0Z4hKH7cYPykfFl9cqSVl11uuxm6YXeRxO8g9DdkB8Fw+8Ux5+dO+1k
         EpKJAVe9HrdQX3VpnlSo8njj5kQdqYeb5f6yjOXsP3e4VhjxFigNXszMJNPAujQRe42Y
         PQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4FpDeS7FVDfifQejKt5Fo3FpOuyI3aVXyTigplJTJKg=;
        b=kdI8Sa8cdW2PFW8eg4fh2raQEy3oXLw07D2pV64et8G1fSVCPl+Nk4MKBlDTWbbiL8
         tNCNDNpcHl1IgptdDEDfDKHOThnySvk/QTgdwkzd35EP+tbI95Xqh6k/FV7bOOMoH7J0
         bdHnNEDcaJdZkD68iShSImY1+cyt6OZwCPJ/GbmrFy0wayYNbgz3SBTFVzrIiy8bfnj0
         Hms6pGHETzdBB5ZzrDq7mE0v8TuDTFgnhqrvO+M0mKgfuDZzYbk4wjvXXhC5C4oSuniF
         a4Ma6YSEaQO7WgBMoZmS3SIqkpe1ZtgcLRpWnk0JtuUuQj+ZOvpFU4h0IZ882gTL5QpF
         P7mg==
X-Gm-Message-State: APjAAAXGSJdJLXBxCf9RcSS48FzqFUZux0L9j01QpLTnYZzMmRZHXXNE
        w0DebswdXJRwUHeVqzhIh+TyzyY3/Fk=
X-Google-Smtp-Source: APXvYqzh/Vr2MusTZAdq4TOlr4ztx3Wty77tirQdE63vSY4MuktYCgn7bpoGIcSfXi+Hff+43HUCfw==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr200813pjn.117.1580153450023;
        Mon, 27 Jan 2020 11:30:50 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k26sm9349186pfp.47.2020.01.27.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 11:30:49 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Felipe Balbi <balbi@kernel.org>, Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
Date:   Mon, 27 Jan 2020 19:30:46 +0000
Message-Id: <20200127193046.110258-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

The current code in dwc3_gadget_ep_reclaim_completed_trb() will
check for IOC/LST bit in the event->status and returns if
IOC/LST bit is set. This logic doesn't work if multiple TRBs
are queued per request and the IOC/LST bit is set on the last
TRB of that request.

Consider an example where a queued request has multiple queued
TRBs and IOC/LST bit is set only for the last TRB. In this case,
the core generates XferComplete/XferInProgress events only for
the last TRB (since IOC/LST are set only for the last TRB). As
per the logic in dwc3_gadget_ep_reclaim_completed_trb()
event->status is checked for IOC/LST bit and returns on the
first TRB. This leaves the remaining TRBs left unhandled.

Similarly, if the gadget function enqueues an unaligned request
with sglist already in it, it should fail the same way, since we
will append another TRB to something that already uses more than
one TRB.

To aviod this, this patch changes the code to check for IOC/LST
bits in TRB->ctrl instead.

At a practical level, this patch resolves USB transfer stalls seen
with adb on dwc3 based HiKey960 after functionfs gadget added
scatter-gather support around v4.20.

Cc: Felipe Balbi <balbi@kernel.org>
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
[jstultz: forward ported to mainline, reworded commit log, reworked
 to only check trb->ctrl as suggested by Felipe]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Rework to only check trb->ctrl as suggested by Felipe
* Reword the commit message to include more of Felipe's assessment
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 154f3f3e8cff..9a085eee1ae3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2420,7 +2420,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.17.1

