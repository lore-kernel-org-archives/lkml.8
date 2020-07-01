Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE4820748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAUGuF/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgGAVNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgGAVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:13:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FBC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:13:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ee9so14555257qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quzZPMbm7PpMHF0Uc8MBUiav44rFFBJoy1a7Ni+U048=;
        b=cAUGuF/bBZXzPwqEA2KmnUAiIBZh74Axkc9kR9B2TU+pfmr0Ih1xclQdRWGsusUH4P
         aQzareypjNzLHXiV125/yObqrFXl50tJFV/rUKCZRWbD/D/1d0v4lzxP6KOcZXlgjjmi
         sgNNbvNdLJJHNlKCd14hQXkgYAlLrBsKFbkHvUNF/F6nxwrpT8jdvRZYXVdR0PC1eAI+
         4S16qlMArXxPc8oAS/ZA1yBh3hZnNw3KUW8jxg5bA8R+t6SFI15vBdFvk1Iceo4cfGw7
         X0DgYL+QU5n2iQQVkAwshCPeU4e8v2RIOl8RM6la4Auqki927z9rPEsuDYZvWCyThq2u
         QdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quzZPMbm7PpMHF0Uc8MBUiav44rFFBJoy1a7Ni+U048=;
        b=GJCakvOEaj6qx+XbAkqB78A6R/LRFv4HNPvwQZL+UF06h//8NBWOx16suXX0k3UNkO
         ue47JLlQmu2cXfZvIyiTE2QA6g4OKIOfRtrdUsPRQH6xbjjooLJiRbYljZAbXahDwMPl
         k77HL0rCHYVIBQ2fpIOpnkRmeuWB1Fwxhq+wYY10+ohp2GSihpeNjHOGwNVKDoq4aYCl
         agQGbfPFLD9+OeZQr/Zc3l+2O7VXtZBu/zfNwJPgzR+QUM5HUrd9ZxhYZC1OCM+64Mw9
         NHL98fSH2RApcODswrEGPjiJPz2Azk5e2IZVppsUf9JdEm2vr5SAmCmKEQr3/gt6PPkw
         BxzA==
X-Gm-Message-State: AOAM533sLM0Oc+x4dBlN3WzG6BJGdWMEQdsoQDNZQaQw0lX87AedXMU9
        ND68vykGZ+BWO1iOGKurk1m65lGyjtREITs6sBBf
X-Google-Smtp-Source: ABdhPJweymvrG4WnmmEfQGpTdGKKPJnK+/o6UKqXb9nuHShRn93/877F29RoxTj0lr9gwAW3khi4TR681cXl8z12ryNZ
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr25772358qvt.78.1593638026665;
 Wed, 01 Jul 2020 14:13:46 -0700 (PDT)
Date:   Wed,  1 Jul 2020 14:13:37 -0700
In-Reply-To: <20200701211337.3027448-1-danielwinkler@google.com>
Message-Id: <20200701141329.v2.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
Mime-Version: 1.0
References: <20200701211337.3027448-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 1/1] Revert "serial: 8250: Fix max baud limit in generic
 8250 port"
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        stable@vger.kernel.org, abhishekpandit@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7b668c064ec33f3d687c3a413d05e355172e6c92.

Fixes: 7b668c064ec3 ("serial: 8250: Fix max baud limit in generic 8250
port")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 drivers/tty/serial/8250/8250_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1632f7d25acca..e057c65ac1580 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
 {
-	unsigned int tolerance = port->uartclk / 100;
-
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
@@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	 */
 	return uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / UART_DIV_MAX,
-				  (port->uartclk + tolerance) / 16);
+				  port->uartclk);
 }
 
 void
-- 
2.27.0.212.ge8ba1cc988-goog

