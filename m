Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF143C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8950720728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKOd4A7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgDWQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729446AbgDWQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:30:20 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290CC09B041;
        Thu, 23 Apr 2020 09:30:18 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id q204so1451436ooq.1;
        Thu, 23 Apr 2020 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfMYnWMcgnIY3nd+oLvzUL7qnJpXroGRL8ZoecQv4Uc=;
        b=cKOd4A7azrl4Vm7tSN/fCKPvy3PR/U3Uyaw6nPIAEBZnf/F5eQ4RVSjync+mtYrfii
         u+o7EMbntnkNGQe1wddxGbM15Q5wKx/Pf1093jikw/kLl+rFbVuTO4+1cGLDja0CBCv0
         h0ugnaikixNVrNrcATsn5LdRnpos8sDly92ng1dus7UC3JvLC4m5uJkb14o+Ks2LGTm7
         WqRttur9+962uS6hWtxuftsTDHiqnApvNOQuiR/3ke12K2U+f0SR5j8if6W+Z0R6CMnL
         4g9nuAQWpZM0SWJRYGHVynESqKH6NNhd9Umst40d3QkXzVyVt0VwI5B10pZGR7t05U3h
         Tt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfMYnWMcgnIY3nd+oLvzUL7qnJpXroGRL8ZoecQv4Uc=;
        b=pWMnB3f5L2n81JOBAvc1dV+ez1A84mWYx2+aWerZVfE57auwp29M6OGgKj8abAQmhR
         ILIDMDJbQAhwvkMdL+qsqpQeYr9BWK2+rRmbGdZ/K/2Dm9Lg6XbqTrMltnZPgv0occ+u
         YSNitzgr93AwiPCyFL2I1EiZ+dkeb7W84yyM5MVXEWEaNrxP1kC22iiDniHTengq9LuP
         x0hY68osYVueiXQaouzaluax1/HXVg/iycEuNW724wzWd8rytoHvQpw+/X2jX0sBc0oG
         LedmFbz4YHc7fjHXodRAyz3BpTAjuNt1+5Qwr/hgz0h+BUkEbJ6K/4owXgoe4zHDdjZB
         AYFA==
X-Gm-Message-State: AGi0PubODAhPQo569eomRsLB5lCOYsMmQimsxU385Ec/qszWJNt68YGp
        +kUa24T1ZsSXRJ4nB8uIGoiAdLbS
X-Google-Smtp-Source: APiQypIaCRE0Nsmi4ws4s7q6Ep7nOYaDSuoHlmT9yiItoTvZh8USxpZrLlXu3lVmkvxBYIMxBz95yA==
X-Received: by 2002:a4a:df51:: with SMTP id j17mr4010608oou.57.1587659418007;
        Thu, 23 Apr 2020 09:30:18 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 10sm703031oto.80.2020.04.23.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:30:17 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] USB: gadget: udc: s3c2410_udc: Remove pointless NULL check in s3c2410_udc_nuke
Date:   Thu, 23 Apr 2020 09:29:24 -0700
Message-Id: <20200423162923.10886-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/usb/gadget/udc/s3c2410_udc.c:255:11: warning: comparison of
address of 'ep->queue' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (&ep->queue == NULL)
             ~~~~^~~~~    ~~~~
1 warning generated.

It is not wrong, queue is not a pointer so if ep is not NULL, the
address of queue cannot be NULL. No other driver does a check like this
and this check has been around since the driver was first introduced,
presumably with no issues so it does not seem like this check should be
something else. Just remove it.

Commit afe956c577b2d ("kbuild: Enable -Wtautological-compare") exposed
this but it is not the root cause of the warning.

Fixes: 3fc154b6b8134 ("USB Gadget driver for Samsung s3c2410 ARM SoC")
Link: https://github.com/ClangBuiltLinux/linux/issues/1004
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 0507a2ca0f552..80002d97b59d8 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -251,10 +251,6 @@ static void s3c2410_udc_done(struct s3c2410_ep *ep,
 static void s3c2410_udc_nuke(struct s3c2410_udc *udc,
 		struct s3c2410_ep *ep, int status)
 {
-	/* Sanity check */
-	if (&ep->queue == NULL)
-		return;
-
 	while (!list_empty(&ep->queue)) {
 		struct s3c2410_request *req;
 		req = list_entry(ep->queue.next, struct s3c2410_request,

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.2

