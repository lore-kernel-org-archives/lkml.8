Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A140C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B7221655
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XE5En1H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgEGUJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728580AbgEGUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:09:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E8C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:09:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s10so2524019plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+igHgzIqWZe6OT6gTK1ehvXj127NSNGPVn9Isn122A8=;
        b=XE5En1H+lpOUQAX8ckpo+HHEGAyxCAmUBvhkKbZMRLxQT47ProdK8zaHod/JbejEoB
         sXh/Tu/5AhbLKSQfHn96xpSNZhK++iWxZEmNf3n00E7bbkO7DqQS+C+GLh9i60S4xQ0m
         eWVJ5rkfjbi64nWZcUyAR1cMh0h46rlZb+HqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+igHgzIqWZe6OT6gTK1ehvXj127NSNGPVn9Isn122A8=;
        b=YGwJIjYBrGHSH8r7zGeQkQhOWTjAsnJndfYtqqivLvwZbJiew4SO4CfObPoB9SdeJY
         iR2VdJtfSOUqmws3IoQLLNPofXNvwG9Bv73dBgLa3bqAwvUj4LHSZCqzjXghAqwqi4R3
         EciS1kkd0dOm6RZ88xRIUhslzZPzyXu+Frc8yUgxvwq94e+HnMZqSAC70wqV9Ma+8E8r
         L9ThZGDtTV+yVONGpdLvRm8gh413Y6K089ESlDbk62vpnY2kNAiIa+zOtZCzR+uRIF02
         QOvYmNtdpep400g/OIr3b4cUxTf09JO0CfoRgrfbrbAOqoTM5+shhVCiIK5kXLjgsRtm
         uQTQ==
X-Gm-Message-State: AGi0PubDRstMb/y6jsfcBAvHzpl1rhzAocH4erDZ/lSnpx/7nHvxGqxx
        d8nqskkodIK9H2+PCCs2zcqUTw==
X-Google-Smtp-Source: APiQypL0biztyRxmF7Lwtt+4aWp6foHRtH/yfwnzRkceu6JjnF1a0fFW6TVpNoKxLoUIWIM9V/3cuQ==
X-Received: by 2002:a17:902:7596:: with SMTP id j22mr14310656pll.226.1588882149206;
        Thu, 07 May 2020 13:09:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/12] kgdboc: Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc
Date:   Thu,  7 May 2020 13:08:45 -0700
Message-Id: <20200507130644.v4.7.Icb528f03d0026d957e60f537aa711ada6fd219dc@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is only ever compiled if that config is on since the
Makefile says:

  obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o

Let's get rid of the useless #ifdef.

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("kgdboc: Remove useless #ifdef...") new for v4.

Changes in v3: None
Changes in v2: None

 drivers/tty/serial/kgdboc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 519d8cfbfbed..2e9158fff976 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -380,7 +380,6 @@ static struct kgdb_io kgdboc_io_ops = {
 	.post_exception		= kgdboc_post_exp_handler,
 };
 
-#ifdef CONFIG_KGDB_SERIAL_CONSOLE
 static int kgdboc_option_setup(char *opt)
 {
 	if (!opt) {
@@ -409,7 +408,6 @@ static int __init kgdboc_early_init(char *opt)
 }
 
 early_param("ekgdboc", kgdboc_early_init);
-#endif /* CONFIG_KGDB_SERIAL_CONSOLE */
 
 module_init(init_kgdboc);
 module_exit(exit_kgdboc);
-- 
2.26.2.645.ge9eca65c58-goog

