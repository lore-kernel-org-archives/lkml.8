Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2001820737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BA2K2kqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD2AYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgD2AYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:24:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0EC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:24:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s18so140424pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmncuCu+aKZhegSzTt7aF9ZhKop8EJqfLP9aJCLGrf4=;
        b=BA2K2kqqewuaVRpteNeRs5dZSrjrzRp1kWnQ0GjL5CAtO8roNP3gMiRhYo799seH4o
         TdW8F03C3/bt5Vbj520wGNlDyEVWyZpsCMREl+NazKoJUhi6wvyhQnVlA5ZKJ1hRRZ5D
         mKk2eulKJ7muzlbGc1BOpt1wi6VGpDgo3b8Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmncuCu+aKZhegSzTt7aF9ZhKop8EJqfLP9aJCLGrf4=;
        b=c/QeyQ+RjAuS7y0KLXINvK+YlHcoHmihqUkCKm4/eAFDuxni6VDCjIQskfyacu4EfC
         PmUxwDeqIFl+6s68R80AaWvbiv2p7JDqyshY/xmS5P66FW0zWE5G4eaRjvlqJ7dDixad
         9tUaGGVqGgk8AEIZ9BTbbQD9grccyd4xZSMRMmYgMtkczIfqV9PM1lI3V56RDiPKNyOU
         uOJdBmf63b5Omyd5CPx1PUMNCoB73M59Kr3B54XXQsXcNlDmQk+Neve2BFFTXqDZ1+ug
         l+YvB8ffimpG7oIz9QDQ1YX1/RW4W8H1GvKZbrlEZzhFnI4GFdBBo9U11kRA4CjGZcYp
         noxw==
X-Gm-Message-State: AGi0PuYioY5dR1h3I0Zes7BaxFTwf00IpRDavQ17AzFBksBY+qt2lr21
        WUMXPhzUrD+LBPMdJM0hKSYcLA==
X-Google-Smtp-Source: APiQypLM3czQW9EKrQcTgAQqT0/w5bYQiwPnPbqMlCzllO78rB6OL5shUwpeY3R9Ce2tt7QL1NQrsw==
X-Received: by 2002:a62:780b:: with SMTP id t11mr31963820pfc.196.1588119840119;
        Tue, 28 Apr 2020 17:24:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g6sm3102818pjx.48.2020.04.28.17.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 17:23:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpio: Document proper return value for gpio drivers
Date:   Tue, 28 Apr 2020 17:23:27 -0700
Message-Id: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy defines GPIOF_DIR_XXX are only for consumers. Document the
proper ones.  Also: don't use "_XXX" since that's harder to find with
"git grep".  Just list both of the values.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/gpio/driver.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b8fc92c177eb..7b5f5681b7e4 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -267,9 +267,9 @@ struct gpio_irq_chip {
  * @free: optional hook for chip-specific deactivation, such as
  *	disabling module power and clock; may sleep
  * @get_direction: returns direction for signal "offset", 0=out, 1=in,
- *	(same as GPIOF_DIR_XXX), or negative error.
- *	It is recommended to always implement this function, even on
- *	input-only or output-only gpio chips.
+ *	(same as GPIO_LINE_DIRECTION_OUT / GPIO_LINE_DIRECTION_IN),
+ *	or negative error. It is recommended to always implement this
+ *	function, even on input-only or output-only gpio chips.
  * @direction_input: configures signal "offset" as input, or returns error
  *	This can be omitted on input-only or output-only gpio chips.
  * @direction_output: configures signal "offset" as output, or returns error
-- 
2.26.2.303.gf8c07b1a785-goog

