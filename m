Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21361C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E4E20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=engebretsen.ch header.i=@engebretsen.ch header.b="K4g0aUjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgDNSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504206AbgDNSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:42:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53665C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:42:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a25so15740040wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=K4g0aUjWSXaR1qjQRM7vF6ngIM040z0byOMBmmaLbxuCHsx1eU2XHQgcC+h3zB6roD
         9OwOfH43+UCVaiqpxekqVF0+cfehe7BOCOASrrs+6egXc6i78Z+zOWxOxiDTm0H4JsP8
         oaxQ0yxuRhsYLXnA9yJjXox6PzDb/yrtuzM5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=JQsNh/kYKjLoJZkIOyqEWvncOSR/+N1cNnM27MEJQC+Pl41MThlKzm1HVmPd4ULaQU
         LbSgFpJFU1tl+sj9FxR1EiHa/AUU0GVf7AxGHl2FGh4VcBTYttcp9ElF3ejMav2Zxn8p
         LLPxicOLyQ8hjoVe6J3tZj0fUcQ1/crgrfGqBxXNXqCMPvZJyetgSr0Xprrg4+V+l9e8
         N3zr8Ics6FzcoQYtNWHmePISW+oYeAsTWW6l2ztqXf22Uk4bmUyeuf9lRm2ZcWVdz4Uv
         ZR/nSqgTzCiVldd2YUIQJX1cRJTqUzphSdPVt2zGOAysGhmG5gDkfxWSBvEbXH35ZnXB
         3lMg==
X-Gm-Message-State: AGi0PuZXId8icqWvO3ANt9ujgKlY21zcvjMSydlVZxnQLt9FEskshvIm
        rgYl20sIlh5qfc1g01ryVejIXg==
X-Google-Smtp-Source: APiQypJ4CWXJdjqsZgKMnosMbBk5AQ2uEX3vx58eKWZLcZIzyhZZOngMXbsuFGiiiFpHI3sSB0oUZA==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr23266082wrw.380.1586889759990;
        Tue, 14 Apr 2020 11:42:39 -0700 (PDT)
Received: from server.home ([2a02:120b:2c74:f040:98c9:7cd5:92ab:c7f4])
        by smtp.gmail.com with ESMTPSA id a7sm3439211wrs.61.2020.04.14.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:42:39 -0700 (PDT)
From:   Lars Engebretsen <lars@engebretsen.ch>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Lars Engebretsen <lars@engebretsen.ch>
Subject: [PATCH] iio: core: remove extra semi-colon from devm_iio_device_register() macro
Date:   Tue, 14 Apr 2020 20:42:37 +0200
Message-Id: <20200414184237.23018-1-lars@engebretsen.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d63884a54939..76ba7c9fd3e0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
  * 0 on success, negative error number on failure.
  */
 #define devm_iio_device_register(dev, indio_dev) \
-	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
-- 
2.17.1

