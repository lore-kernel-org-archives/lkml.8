Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8953320722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTYsKZg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbgF3Nej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbgF3Nd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE193C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so7159551wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qg/i7Z+DVHnxMJURbtuvnuqmQ2dblOKzOYHmn2TAyNw=;
        b=wTYsKZg6XOOwxF3oDluUk1u7aO7yNTj639l5CvuRCOC6RNDIbnTV/IcodT/0pqXNw5
         pFneNKZwxITWnSGPM7dh/ReDTHF6g0AZZopWTNoTm3SVu8g3gabrkJMYF+fLUxsCAOtc
         g2sEqrZ62BMpGwWgQhxIyK1xLKtDhgVq7F4kMmb84oNfW36RuTgAnkrQ2AUiRMYHq5mb
         5Z1wMXrCHXX73X50iSEhunoIGLBqslyiYCHs+Ekoh9ShjjyXgkgMDYMdvtVrgjQCiCAw
         crp4lzcA5lAPU0j8es+fPggZvMOjmHObzD87nJW7VuLRDGYln9cRTzANzvJR6PXgUd8P
         FLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qg/i7Z+DVHnxMJURbtuvnuqmQ2dblOKzOYHmn2TAyNw=;
        b=U95r+HhlwrIjx9/7Ce4wxzYb+aeeIS5Y/k3cHgICwNgvNuHehQkaTyjTSDZ3wfVbW8
         WaavNyhDaSCwb78YbJQoScen78pnJ46bJTmilEBMlrP14klxJEN4+l60rB+7/z2Veyus
         HOcOcKOZQVL9tmMECCT22OamY5eynHEFAJbVByN8YtU3bF0iD08Wh6+6j8zF5vnsuT+S
         VWQRBmQotFRh1bvz3ZWc2qrzR7AYGAPNindESTuKRnncT1LVbWdeOWpugWW4+mGE6zRU
         66BOvQA9WNjwESEe6lMYU49U8GRaJjr+KnF6VV55NLjITK6jta/QwjtuY8QnXRNOrfbq
         Rliw==
X-Gm-Message-State: AOAM531NH0HVEImImNd8kVmWxcYNwNzrS3LZI+MIXUh4CSvYGgUBZOOq
        xKBMO+Ie835+e2Jw/LnR8VQ/QA==
X-Google-Smtp-Source: ABdhPJxuB0GHncTea0p5EeyC3ow+2hK3Kp2Tm41ZPwIkJuIuPL7Leq57W4yxAyWNj5wXl7BWX7g3dQ==
X-Received: by 2002:a1c:6102:: with SMTP id v2mr22253807wmb.6.1593524036198;
        Tue, 30 Jun 2020 06:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.eu>
Subject: [PATCH 07/10] gpio: gpio-it87: Fix formatting issues which confuse kerneldoc
Date:   Tue, 30 Jun 2020 14:33:42 +0100
Message-Id: <20200630133345.2232932-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects struct properties to be documented using the syntax
'@.*: ', but no ':' has been provided in 'struct it87_gpio's
header.  Add them to stop confusing kerneldoc.

Fixes the following W=1 warnings:

 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'chip' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'lock' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'io_base' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'io_size' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'output_base' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'simple_base' not described in 'it87_gpio'
 drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'simple_size' not described in 'it87_gpio'

Cc: "Diego Elio Pettenò" <flameeyes@flameeyes.eu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-it87.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
index b497a1d18ca9b..8f1be34953ce4 100644
--- a/drivers/gpio/gpio-it87.c
+++ b/drivers/gpio/gpio-it87.c
@@ -47,13 +47,13 @@
 
 /**
  * struct it87_gpio - it87-specific GPIO chip
- * @chip the underlying gpio_chip structure
- * @lock a lock to avoid races between operations
- * @io_base base address for gpio ports
- * @io_size size of the port rage starting from io_base.
- * @output_base Super I/O register address for Output Enable register
- * @simple_base Super I/O 'Simple I/O' Enable register
- * @simple_size Super IO 'Simple I/O' Enable register size; this is
+ * @chip: the underlying gpio_chip structure
+ * @lock: a lock to avoid races between operations
+ * @io_base: base address for gpio ports
+ * @io_size: size of the port rage starting from io_base.
+ * @output_base: Super I/O register address for Output Enable register
+ * @simple_base: Super I/O 'Simple I/O' Enable register
+ * @simple_size: Super IO 'Simple I/O' Enable register size; this is
  *	required because IT87xx chips might only provide Simple I/O
  *	switches on a subset of lines, whereas the others keep the
  *	same status all time.
-- 
2.25.1

