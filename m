Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C4BC433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7E122D0B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="blwBIVMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgHFKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgHFKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:00:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFFC06179E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:00:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so9079713wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+V7CqI/htEIIY4PnseQyLNdhHuJMGQr2hPmi29hq7rk=;
        b=blwBIVMkBZZkw+M4KMDSy/63AIjjwVfHw43Oy0ACpSlXffJeTWN3CY93N5DaXkVswb
         3HO9lN0cc7W/frHVpA1yzI+9QdNdtcTSbJ3U12dMbNGAMRnPXC6uourzC0TxP02RMSW0
         2YZhbW77PIM3IWsGrmCnFyar1JiKYi8EC0zZ2eUfUIyLXV4zSaY/Tynm4kxpOKm0x7Tw
         o3yUaWgOxLx0kNiYBdmmp9itGhYWMLYKoPz53xjRL0+3b/ynmuHFvPDpqTtqpDB5wOs+
         //cXcteNIqc1KkQ1WluccIM7NTYAxYVY50qpNsTStA573o5lNYOfDyRXIlEtEwixDkW/
         xYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+V7CqI/htEIIY4PnseQyLNdhHuJMGQr2hPmi29hq7rk=;
        b=IQT3QlU7j7a9PW4NkLoVy3a+tJsJE0v+v+P8KHLXFqD2fYGznuIVXMhkzYvD9qsDzb
         YhmN7UjevN76goyg0CBmhdMRGtggbhJAPfhWyRpYXgn+OC9uMK9fiO7lmhzJd1UJPGLT
         dYg8GsMw7ib2d4L08go8VvTCSLWyUfuwh6dnruSRTe85D5AC+RJUpQI6YUH2B+K+tyBA
         s5afxqQgBvOF0OXHD4mxM1nEXW+ndyWabaKUGvyvI/1ZtrfuTL5VSIqQl/l/tJh9GVff
         akIBy1TMZztGzOTW0KE7ddhKHAFDnZeS/YyvRXERYzm0Ko/1UrkujnCaGxEQXLyxSbML
         iTbg==
X-Gm-Message-State: AOAM531iNh1qJPL+N+xt7F7elTWHDUaESYytMNEeR6nK8Ofti1g4zJEH
        sjlzuGUE/SByg6ss9W//q3j9sA==
X-Google-Smtp-Source: ABdhPJwERWrzbPFeEbvwnDFlnCmx/Q90cpWFyXp3nyjuWcAWsrGJT8br/+ZFQznxexxykT9CnEnETA==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr7189068wml.186.1596708014190;
        Thu, 06 Aug 2020 03:00:14 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id p3sm5741376wma.44.2020.08.06.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:00:13 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, sumit.garg@linaro.org,
        jens.wiklander@linaro.org
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        ricardo@foundries.io, mike@foundries.io,
        gregkh@linuxfoundation.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/2] hwrng: optee: handle unlimited data rates
Date:   Thu,  6 Aug 2020 12:00:09 +0200
Message-Id: <20200806100010.20509-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
timeout on the call to msleep. Avoid this scenario by using 0 as the
unlimited data rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 49b2e02537dd..5bc4700c4dae 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -128,7 +128,7 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 		data += rng_size;
 		read += rng_size;
 
-		if (wait) {
+		if (wait && pvt_data->data_rate) {
 			if (timeout-- == 0)
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
-- 
2.17.1

