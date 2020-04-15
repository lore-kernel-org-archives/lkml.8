Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772CC20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=engebretsen.ch header.i=@engebretsen.ch header.b="ZScong5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896311AbgDOKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896271AbgDOKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:11:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC632C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:11:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so16733575wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1/pjrVv4PJigKLZ3POs1RKnE8FSAVorP8hVCPrgqZqM=;
        b=ZScong5/HNOMpAPh7V28338qze7Fj8HTDDs5zdStu1s4ZwxvXVbHOGgD2jMyfwK27w
         8H18hO7H2Ho9iM6czMVlhPYcvwzMXQQHTgyEZ5uahEKJTS80zsFoi9yv3i7+ad+jeZmt
         qjy6YBrBQWk5GUlGFnwj5Mj418A4w1vOzQbBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1/pjrVv4PJigKLZ3POs1RKnE8FSAVorP8hVCPrgqZqM=;
        b=sEGVoV9a4hjMLVCMNwPfvuEDH/eTugqA3DRnbHX5OZZIfkHDZBJ8cRBe7BXsIytrRw
         swf8na7WFzVUhuVj6NBdFv04lmD3CB4qqXfjdi2tO4jUrkN2tSsM69Jq7dqk62IcWBCb
         ph/VfXGfMbcd24fuFIMvIzWEbAp3sS8/yrfKntEVK26Q5cG2CV27IkiWM00IAqLoxshg
         VM+RVQJbHgWqqC2EhI5/UJ5jFxq9kdca/vDvzTJiHHXs7VritSTN0fJu8B+kiCheHDCr
         xiTCOQRz3vVsOvAkQK2xKc0MiKEgM3If8PK8EWW98pWLco/BhpIgv22YPsmcok6AYYS0
         RxZA==
X-Gm-Message-State: AGi0PubvD9FE6BWktx3QPdAEcmtGqleiSZOPyUeXAW2ivJBWEX3C4s9U
        OVp1AbY/+o7g8lvaCtAGhyu+Ag==
X-Google-Smtp-Source: APiQypIhyYJx9gxV5UYGtUgzcdmmRPONTUqWN7Vk+plYr5DhM++YeoBpwITStYs8yfytXA0YN6IUhQ==
X-Received: by 2002:a1c:4186:: with SMTP id o128mr4414998wma.21.1586945471388;
        Wed, 15 Apr 2020 03:11:11 -0700 (PDT)
Received: from server.home ([2a02:120b:2c74:f040:98c9:7cd5:92ab:c7f4])
        by smtp.gmail.com with ESMTPSA id f23sm10609446wml.4.2020.04.15.03.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:11:10 -0700 (PDT)
From:   Lars Engebretsen <lars@engebretsen.ch>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Lars Engebretsen <lars@engebretsen.ch>
Subject: [PATCH v2] iio: core: remove extra semi-colon from devm_iio_device_register() macro
Date:   Wed, 15 Apr 2020 12:10:43 +0200
Message-Id: <20200415101043.32050-1-lars@engebretsen.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change removes the semi-colon from the devm_iio_device_register()
macro which seems to have been added by accident via commit 63b19547cc3d9
("iio: Use macro magic to avoid manual assign of driver_module").

Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
---
Changelog v1 -> v2:
* added commit change description

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
