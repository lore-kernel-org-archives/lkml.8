Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCQEzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:55:09 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37040 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgCQEzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:55:08 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 02H4t78C021316
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:55:07 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 02H4t23B007662
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:55:07 -0400
Received: by mail-qv1-f69.google.com with SMTP id m5so18710426qvy.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=Y91b1uFvN0HdY0iOBxMABqgP7XI6TzW5dwQDX8YUsV0=;
        b=ooBWZOXegjRo3ewRuXf8Gp8rJr7XJI1HOCzf0TqVrBKdqVipO8tzV4qr9KI3p/mtTS
         iGPiSNflDPYXgE45TdfsGLfrwKF/e6DZrfKhQGPRBiGVciHz08uoWAp1KipkBJz/Oabg
         y2HoFcuMWWsKmqa4w+vxUyOnMtuNvTD2uFnXvtCmkpXTQkSL8avpHnFoPtHFnkJAO2zE
         qWwJfUUQiM+IHWl39VuXH/r5WRC7jlWR5t5wbkNo8GDGppQ/+a/Xnqce2Og+C5XY/6Da
         z6EG8sDrcaF2/aG/i9doJj1weOK3zwk5rB+CezJhtbWaYHPOSETsyEZ2bx4wnyW9SHIE
         wlMQ==
X-Gm-Message-State: ANhLgQ2GC/2ZLWBspawVkM2RiNM6OObXNx6G5Rl+wp9RRgLzDr/GAQ74
        4ylfTGtfIQHKmmdknKGHws4AQ/hPjDUf4G38AHyu04BlzRDvjJDsRWwFaQ775Q/g1TyfsZ9U+4W
        pXZQh7YfGLEGgPe0G52wTgFlKOwRuvaANRXU=
X-Received: by 2002:ae9:eb12:: with SMTP id b18mr3285575qkg.168.1584420902119;
        Mon, 16 Mar 2020 21:55:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUDl88z4JRPHz2zyJmbf9sHj2p29cr0lvKwcAfBTOfcp5n1kViR0e7V1WWDMMM/h35D2RbEw==
X-Received: by 2002:ae9:eb12:: with SMTP id b18mr3285560qkg.168.1584420901793;
        Mon, 16 Mar 2020 21:55:01 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 73sm1264022qkf.82.2020.03.16.21.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 21:55:00 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Marco Felsch <m.felsch@pengutronix.de>
cc:     Support Opensource <support.opensource@diasemi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: da9062: Fix include path
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 17 Mar 2020 00:54:59 -0400
Message-ID: <773115.1584420899@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found during a allmodconfig build on ARM on an RPi4:

  CC      drivers/pinctrl/pinctrl-da9062.o
drivers/pinctrl/pinctrl-da9062.c:28:10: fatal error: ../gpio/gpiolib.h: No such file or directory
 #include <../gpio/gpiolib.h>
          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

So... fix the errant include.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Fixes: 56cc3af4e8c8e ("pinctrl: da9062: add driver support")

diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
index f704ee0b2fd9..cfbe529e66c3 100644
--- a/drivers/pinctrl/pinctrl-da9062.c
+++ b/drivers/pinctrl/pinctrl-da9062.c
@@ -25,7 +25,7 @@
  * We need this get the gpio_desc from a <gpio_chip,offset> tuple to decide if
  * the gpio is active low without a vendor specific dt-binding.
  */
-#include <../gpio/gpiolib.h>
+#include <../drivers/gpio/gpiolib.h>
 
 #define DA9062_TYPE(offset)		(4 * (offset % 2))
 #define DA9062_PIN_SHIFT(offset)	(4 * (offset % 2))

