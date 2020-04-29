Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC49C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C0E2137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huwf0HvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD2KGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgD2KGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:06:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490DC03C1AD;
        Wed, 29 Apr 2020 03:06:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so1788709wrx.4;
        Wed, 29 Apr 2020 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nu1X2CW6jPtDQ0aEhEItVv3kksJg5s4aseacqkeIhzw=;
        b=huwf0HvL6kpp+czUgrhjvRS4qZYndq90uhZM4bWYOZfbxK7vqRE95//PfH49sRMF0K
         gjmLwjrKYHai0Y52Fg/6e0HydeOgU3IZ2Bffnx3P6/xgWvTcMCUvc050VNQICGtjhSKP
         xnOCt9d9gN4JkAWiQ65oqNc16HqXA+tIm4LSDYqZJZNwJOG0as5NQVCECvMpJK8obg7n
         HX/kf2pSKCE1B0T9WXGId98rqK7ZOkExlBZj/mKS4bepIidwYPVTu9fVdF5patYeGxwK
         Zy2HnES4sM/lzJdoupRJRjcOHI89hlcW0pPIxFWGAV1tA7j5jWM/H+14sQKZEJg1wjGz
         dUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nu1X2CW6jPtDQ0aEhEItVv3kksJg5s4aseacqkeIhzw=;
        b=Ucsbq1lPpL5/7lcRqLz7zI2byM9DBCFDR44V2VyUPQYgnGUQ59wl33+YFU0ujhuaX0
         0NxY13JRzvHR3C9m0P90qMfa9owPEFVMLiTJ63ZtvgTlMaNsKaPjnE39s5DRcC2+7KIz
         hIveuMmvdMFcbJJ9jyHTLGDMbh6JQ7XiCr6rriGqRoW8WDqgFzFW93Q2AZp82tTDYrHB
         oJHNbNDZkxtftI0vayJDf4/yI4pocCaoSk0L02zKFHRE6S7zVQSEdaYjJ+HSK7eWOKFH
         UfZjqECK1N+HuaeidC53fYi6wjVFhMmCtaRiaZ4mhxs8TaHCJMzQ9OZKT3H7MTWehxTc
         eBGA==
X-Gm-Message-State: AGi0PuZZhOVPGM0OQgcCFGfxTu6O+MwGAv3v1ZTV5KB/B5OFX8YBz73H
        oG4PhhWdf4F8i/uPnpuWCUpv8W++xQ==
X-Google-Smtp-Source: APiQypJ/GTZod9A7Y8IqPtMshR7Flx22YxFkPVs6PA3aNO1TPy2CHjJzDQ5A67Gu+PvIRtWiVlvtWA==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr41352720wra.271.1588154803962;
        Wed, 29 Apr 2020 03:06:43 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-195.as13285.net. [2.102.14.195])
        by smtp.gmail.com with ESMTPSA id 1sm7205478wmi.0.2020.04.29.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:06:43 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE)
Subject: [PATCH 1/6] usb: gadget: Add missing annotation for xudc_handle_setup()
Date:   Wed, 29 Apr 2020 11:05:23 +0100
Message-Id: <20200429100529.19645-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200429100529.19645-1-jbi.octave@gmail.com>
References: <0/6>
 <20200429100529.19645-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at xudc_handle_setup()

warning: context imbalance in xudc_handle_setup() - unexpected unlock

The root cause is the missing annotation at xudc_handle_setup()

Add the missing __must_hold(&udc->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 29d8e5f8bb58..ae22882dba6a 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1733,6 +1733,7 @@ static void xudc_set_clear_feature(struct xusb_udc *udc)
  * Process setup packet and delegate to gadget layer.
  */
 static void xudc_handle_setup(struct xusb_udc *udc)
+	__must_hold(&udc->lock)
 {
 	struct xusb_ep *ep0 = &udc->ep[0];
 	struct usb_ctrlrequest setup;
-- 
2.25.3

