Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B249620897
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRSz0KIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHZJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgHZJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8674C0617BC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so1097215wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbQ7t0QGJIX1BQrFfjs1A3AU9N9ket4sk5RytzzLdJE=;
        b=PRSz0KINW/7dL8S4WUZCQfxd14f4YMJbSkBmMHyG1/sQbxmgJbiocMe/T8daglorDC
         82MT3w5DXKs4BUDFZ9bXUh2OUgS2NbldfNZvjCgcUdBicoWPOyzI/BFV/5DDflpTHbRK
         zLv56uyXsO0Ewpl/da6nT0Q2P9XMWgRjvzZ0TO4soBXqTnfOGdxr2CYpFowLMwj7bInj
         rwmedvcZrOsJxhEwALwPT+KAXfokSNPEFhCOM6Mpzo+OlkIKxmpu5wGDQ9HIa79SyM6B
         evqqzzuLy045QKid+uDUpQSB8Z+5R8GVMJnXM3r1J20fJjwx3uros9QGhioEqP0eQmiE
         eJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbQ7t0QGJIX1BQrFfjs1A3AU9N9ket4sk5RytzzLdJE=;
        b=PDcr/sbId/WtvNvuSFiFmt0rz+jsFSs7q1n1tkRx5asynKts12pu7QUiF1dtZGWALS
         NPo4OY1W7Y0A7ODHNsybOxJb+MBlDjtZfMdo/2x0jRKYk+EHGTsVloOJnA3MW1Aj8fYB
         8WWIIlHUzfGWhvds0lZ8GbTMZ0dREfT0Qvpll7DTPurFmcVapwH8WKNoM8dLay8rAfr8
         vPBuZ86xpj74tnCZYXnOxMRzc3lPGg9MoAa85kXKncOM4PXjoyK9Dy0u/NoHhDGUHSuI
         RxbDlUUK1VNp/ufkKaBak5qaWfY3jV19VTFwktjdpd7Hk0Am3POfb55Lp2k7T9ahRzEQ
         M3yg==
X-Gm-Message-State: AOAM530Olnppl3w1SIBLM8REmgPBjpoglOgaadzcvrhTUjRsa5U9Dlq0
        I31ACJwqpSJrw4InykZNKXytlg==
X-Google-Smtp-Source: ABdhPJyojt+ahgae3vKUeH/4QLEhz8Ub210s3VTJowaHOeDDKiO30miza1Ko42Y4aau/f4Uin3GtRQ==
X-Received: by 2002:adf:e781:: with SMTP id n1mr4587780wrm.195.1598434456444;
        Wed, 26 Aug 2020 02:34:16 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>
Subject: [PATCH 09/30] wireless: zydas: zd1211rw: zd_chip: Fix formatting
Date:   Wed, 26 Aug 2020 10:33:40 +0100
Message-Id: <20200826093401.1458456-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/zydas/zd1211rw/zd_chip.c:1385: warning: Function parameter or member 'rx_frame' not described in 'zd_rx_rate'
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c:1385: warning: Function parameter or member 'status' not described in 'zd_rx_rate'

Cc: Daniel Drake <dsd@gentoo.org>
Cc: Ulrich Kunitz <kune@deine-taler.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
index 0af4b1986e487..0216b1583b48b 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
@@ -1375,8 +1375,8 @@ static inline u8 zd_rate_from_ofdm_plcp_header(const void *rx_frame)
 
 /**
  * zd_rx_rate - report zd-rate
- * @rx_frame - received frame
- * @rx_status - rx_status as given by the device
+ * @rx_frame: received frame
+ * @rx_status: rx_status as given by the device
  *
  * This function converts the rate as encoded in the received packet to the
  * zd-rate, we are using on other places in the driver.
-- 
2.25.1

