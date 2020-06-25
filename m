Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73200C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C351206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPbYUR/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406324AbgFYQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406252AbgFYQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so6466341wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwnlbyOVm51Eb0pUcF4rl7PINN6mIzB8TF+ZR7WT2tk=;
        b=ZPbYUR/apHsgXXjmIkyAJtuxDa0o9TtEQ7P5i8ewdtE/m2vtGGZnK2qKwY79uju+2r
         xbQfnGIOFW5g3VQLd/aQS6AZeezdYbNkx9Oo6nn973GAkLEof6DLi6/oppQbddV84tan
         X8EBv8Qqf41PpcAA4d0ab7OlFb7cVQQ2ZiNVEvQuS4F/fiA6XynurgG3GJpWKIWT83Z6
         P7y9F1GpHSIXyGillKp2n9XqtwQN+9qVXtzB30QNistBhW/aTsJ8B1eAqXVVuDsV0hFy
         j3hwXpvQ/QirFRfIPLN33LmjPa+Zp8A7J6CvWYM07ufHjs1/xNlgUCNvbcwJH3YJwxlF
         zZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwnlbyOVm51Eb0pUcF4rl7PINN6mIzB8TF+ZR7WT2tk=;
        b=lhYRGYgbTPbAyJbSjmoL9UGPs3Q+U3SJOhFOrM0cV/AprANqBI+ND0LbHO63WDuHo+
         MasEqEXxRTLtJVwPMxUsyr7k32G+a1wZjSTFCzGNrWi8VIkwXj/vDBmFjZs3c3YfIDcP
         uFGMftN7uCgJgHn6WffjDtceYg74Axu4o+MKmPDDy7HXk6Sbo6QOgnxdG39osDawywHT
         VSyyT/vlmuAXP03Wp6ovTBek8XJmSS1AtdFinq6qc2NMurJ1ec3e8wvHp8rHN8jDqL8f
         wgUjvQy6rhPgcXA3T43+HyTmZ3sRwPrOgjGjbmuFqfvkgNstxOAHKN38Anel3LbWCEri
         /q3A==
X-Gm-Message-State: AOAM533XRl/POcG84Lva+ty3cJlNgC/Qzt+HIjVig78wdY2EIweS2jG+
        zZpyXGzUhItHmzP4Jb5193xrcA==
X-Google-Smtp-Source: ABdhPJzuGUu4iIUai+NXGCIgKUFHcPNWsPnkkzDdHPsRkCjYNZuSAZnZDpgj3O2ldTTcOrXxLOp1WQ==
X-Received: by 2002:adf:8521:: with SMTP id 30mr35819917wrh.238.1593102990051;
        Thu, 25 Jun 2020 09:36:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/10] regulator: wm8350-regulator: Repair odd formatting in documentation
Date:   Thu, 25 Jun 2020 17:36:10 +0100
Message-Id: <20200625163614.4001403-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects function arguments to be in the format '@.*:'.  If
this format is not followed the kerneldoc tooling/parsers/validators
get confused.

Fixes the following W=1 warning(s):

 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'wm8350' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'lednum' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'dcdc' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'isink' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'pdata' not described in 'wm8350_register_led'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/wm8350-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index ae5f0e7fce8bb..2e7bfdf7c87bb 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1216,11 +1216,11 @@ EXPORT_SYMBOL_GPL(wm8350_register_regulator);
 /**
  * wm8350_register_led - Register a WM8350 LED output
  *
- * @param wm8350 The WM8350 device to configure.
- * @param lednum LED device index to create.
- * @param dcdc The DCDC to use for the LED.
- * @param isink The ISINK to use for the LED.
- * @param pdata Configuration for the LED.
+ * @wm8350: The WM8350 device to configure.
+ * @lednum: LED device index to create.
+ * @dcdc: The DCDC to use for the LED.
+ * @isink: The ISINK to use for the LED.
+ * @pdata: Configuration for the LED.
  *
  * The WM8350 supports the use of an ISINK together with a DCDC to
  * provide a power-efficient LED driver.  This function registers the
-- 
2.25.1

