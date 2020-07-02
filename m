Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E0BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F50206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjS0+cjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgGBOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGBOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so6524681wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6gF5OZoL4RS0/p0R84cBC4PkOOgqqKbUR7gNdMwCYM=;
        b=BjS0+cjbl/ylf9WIsjuuM5KRIKa1tflpMXbUUUReB1WQml9HUW6E7bANNjfQ5fTX/A
         ePKj5W/F4jTQ5DLni9yk4rEL0mT0PZ8dx/ky2IeK4j26F+tluYD+xaCITBCrSwhHDkG0
         UjYtzRYY1AZ1XJ9FbJStn9EZ2dOaSQVOz0ZTjAy3qfUFL/OnG1ALFNX/lOhWfCrk0PAA
         E9iW5PKN2w1rivJs2V0GOJnXF7m6RAcY+Rhv3sFBPzim9PY9lAbUX+LDiXQaJWjLIobh
         7BZt8ywcNGAKtdq5SRkR8fB6Ov7RYsv3mwiu7mpnDcFkBnkV5Ha2N/0X48uQF+Svx/43
         Gn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6gF5OZoL4RS0/p0R84cBC4PkOOgqqKbUR7gNdMwCYM=;
        b=ffXL8EqNSsxHT6sYZ1ceZ92kqXM2E573Q105rm+8xDTLGkAo/nYdzjTYB9H8fQzIag
         SUEmLCwahh/1XQ4MvYDTJlwKM5YPkfzEWu2czhWISanBkf+Cb6kQA8yUsCF2iEkBJPLK
         hnyUCnqcp924qSnFrqf+iAa2/v+oxsZ37Oc1+jX2c13NOJBbaiCqWNAlUsWCLqFlRdRL
         zDpnZegWG8g+0tm0dw3OUQ7wkBn8fj6oxOTfmG537EL60sLcH2Pg8gS742lqidQk0xGR
         OIcrJuHgMs/C507P/9jJRunWkkTI74B6ciiQP05A0Ca1Iwr/gFG4udtTXaCJn7qid9dr
         qhEw==
X-Gm-Message-State: AOAM531y19QB1l4G4ByWBYlEjBJlnOVwcddbnMLAlrENR/halARj929+
        E86d+xb7/0yPAPPKhvaewHJJPA==
X-Google-Smtp-Source: ABdhPJxPgeQecG8Qw9IvYuzEGJ3H19n5YN5vEt0bIlABEWuytzwfCAbC88GDg3TzdKAG9CqcWTyTQA==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr31220077wrq.215.1593701197660;
        Thu, 02 Jul 2020 07:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 04/30] usb: common: usb-conn-gpio: Demote comment block which is clearly not kerneldoc
Date:   Thu,  2 Jul 2020 15:45:59 +0100
Message-Id: <20200702144625.2533530-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block lacks a title and argument descriptions.

Fixes the following W=1 kernel build warning:

 drivers/usb/common/usb-conn-gpio.c:44: warning: Cannot understand  * "DEVICE" = VBUS and "HOST" = !ID, so we have:
 on line 44 - I thought it was a doc line

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/common/usb-conn-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index ed204cbb63ea1..b4051f042c79c 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -40,7 +40,7 @@ struct usb_conn_info {
 	int vbus_irq;
 };
 
-/**
+/*
  * "DEVICE" = VBUS and "HOST" = !ID, so we have:
  * Both "DEVICE" and "HOST" can't be set as active at the same time
  * so if "HOST" is active (i.e. ID is 0)  we keep "DEVICE" inactive
-- 
2.25.1

