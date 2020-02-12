Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E2FC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795A32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="fuh3dDrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBLK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:59:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33706 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBLK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:59:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so1710775wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WADwYZAFozcjUcaNyh7Kf7qDOuVzzulZ+EPYmgS/ug=;
        b=fuh3dDrYkv830SEwfl+Gn/HIHAW0qEUw/EGHH1awGm4CJl9986LeURUBY95VKJJLkg
         40E0SVzv9Khu2zcvstRjkPG7B5O88LY8+oF1T9SxcoPPIspDntkT9/g5IF7ZqmozZBLf
         V7uPsvEfuJ3ytQwOHMJwH3uVcvpYwwuEto4UV0Y4AzZK9dTKNXrfWnmQWkuftxYd0vvk
         jFZ4ScRxOgXNIvbQzQr66Bhj3PFFBmJ83WgIIwuBNcWmybE5YoGWQSJXrhCGuitSNDQ7
         e4XM1FpP1u2FSNggqhi8EkF1U1bke7Mck+BRsCccEn/dQMghtZ/TDj1hzOuFmpM3n4qE
         YMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0WADwYZAFozcjUcaNyh7Kf7qDOuVzzulZ+EPYmgS/ug=;
        b=VbzVUnKRfqtYka+ivXeUsOS4GPOuPUjh9MlZOfXrO22D+x13ZxmkZ4VSgMQ350a6kU
         FSEo3ufsx/5CAfwrgwZ7NTKlUeN6/AYMSIvOCTkW52SYTCd017XZnOXGthjLqsFCNQB1
         KgrXeuenhaWZGqaYwHki0Hl5BqK5Q8ZVMXWJQASVYzm8UvVB12b5qcf9iJpCZN5ZlSeb
         SkufH3w387qfur/pqpl8YHeQFh7qRyZArp86aX5kW2cLWy1OmW3s+jxbSnCnssYpH5b0
         lx4JGzJK3wpXa6W4UG3NqDUFLj4x1VIvQJRjgO5Ae21g1R7FJlMZanvrco0Ut2aBoZbP
         5R1A==
X-Gm-Message-State: APjAAAXjGcrdLRUT6iOVt2PeQhmjV26vg08VwT7+Pp2qVMm5AytZChKC
        QLmJkVX4BpoUl3MsCK38cPiU61aRLDwJ1bEk
X-Google-Smtp-Source: APXvYqwbrMdOWkUnuIhJNtCf0g3LbuxklJ/KJtRqXXubgkOhbjraTmG58tAP8F49wXEmVf1wvP84Tg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr14279292wrr.32.1581505189212;
        Wed, 12 Feb 2020 02:59:49 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j5sm180760wrb.33.2020.02.12.02.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 02:59:48 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@freescale.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: udc-xilinx: Fix xudc_stop() kernel-doc format
Date:   Wed, 12 Feb 2020 11:59:47 +0100
Message-Id: <c753b529bdcdfdd40a3cf69121527ec8c63775cb.1581505183.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes "driver" parameter which has been removed without
updating kernel-doc format.

Fixes: 22835b807e7c ("usb: gadget: remove unnecessary 'driver' argument")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/usb/gadget/udc/udc-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 29d8e5f8bb58..b1cfc8279c3d 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1399,7 +1399,6 @@ static int xudc_start(struct usb_gadget *gadget,
 /**
  * xudc_stop - stops the device.
  * @gadget: pointer to the usb gadget structure
- * @driver: pointer to usb gadget driver structure
  *
  * Return: zero always
  */
-- 
2.25.0

