Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EB52065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DvdWnLIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbgEZUaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389853AbgEZUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:30:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6BBC03E96D;
        Tue, 26 May 2020 13:30:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b91so18798082edf.3;
        Tue, 26 May 2020 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJGAhXW9kaqHmdjOkBKCCdqPZdpTsmEr75Eb52L7QxM=;
        b=DvdWnLISXQXckcKGz5k9iHMnMLw7t+1Bf5ROTwcPt0G7qtxsWYK0OLFt/tU4vxx5HS
         p9EtwrWaJYBdUO6wX0O+ud7L5aW0BxMpMbjSSzaTcR42410tsoOJDstMiRFCexUxy7ub
         4sEe/Q5IELF9Hj3JKo85j6fTjE2mt+OINcfHZ7ALe+tA9B/K0rb7zr6tvZpj18bOe0VK
         bih/T7ZuWH3bpXLMP93jHxz/4p0S4r6KYn+iYt2V/QgkJrHgdLNqHkgYlbvMl7UBO6DW
         Uo3H+PhKLoc4hnnghNVyaGDunmyCoqxaFV+7xL9yD+zzN7TIBT/ErUdSC0OjLzed6nYp
         Le3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJGAhXW9kaqHmdjOkBKCCdqPZdpTsmEr75Eb52L7QxM=;
        b=g2MRwGY7lICjxo5i4wY67HuUMfE59bBgoluVZV66hzn/Xf2LeMhtTi91zbRWu7iC2k
         KjMoJST/5VKHRSkc+D/Gi66LMeDwV7m42L2757SRxO3X7XTjdA5M0L+E7lvL8UZEn6Ke
         aqFbebIRylUiIq7goZEfHAJNE/WHrpbBY+7AiIs09xcesRKn6zpfakrRHpWQ6/6vxbcS
         LsgA6Gkq3mf3wn+DuRkXK7icT8Z7l03gg1WGU4tIS5sz2LAcS1kG5BbTkNLE8SSn+dPe
         blS5jnEYrV7MsFu3YLG2UqkO1pSt+qCoZlTjK7u+VZsSp4OESQCxBkM7K80H0Vv/k+zz
         uTtg==
X-Gm-Message-State: AOAM532ccLxu58N45L3PY9Bx4VchY0/MMkGz7YVIq1a4dK7V5WaTcei2
        2b1AyEOP9TBN1iQevVc5Qy0=
X-Google-Smtp-Source: ABdhPJy0Ce3NFppUwfK2zdiMLWn+r3b9wC6i+sHOfqsQ0eHIH0E7/7C4q8MKdRlIaLKasDmDQnql+w==
X-Received: by 2002:a05:6402:8c1:: with SMTP id d1mr21864323edz.265.1590525008143;
        Tue, 26 May 2020 13:30:08 -0700 (PDT)
Received: from localhost.localdomain (p200300f137189200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3718:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ce16sm735517ejb.76.2020.05.26.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:30:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com
Cc:     hanjie.lin@amlogic.com, yue.wang@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH for-5.8 1/2] usb: dwc3: meson-g12a: fix error path when fetching the reset line fails
Date:   Tue, 26 May 2020 22:29:42 +0200
Message-Id: <20200526202943.715220-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
References: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable and unprepare the clocks when devm_reset_control_get_shared()
fails. This fixes the error path as this must disable the clocks which
were previously enabled.

Fixes: 1e355f21d3fb96 ("usb: dwc3: Add Amlogic A1 DWC3 glue")
Cc: Yue Wang <yue.wang@amlogic.com>
Cc: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bd744e82cad4..ce5388338389 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -738,7 +738,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->reset)) {
 		ret = PTR_ERR(priv->reset);
 		dev_err(dev, "failed to get device reset, err=%d\n", ret);
-		return ret;
+		goto err_disable_clks;
 	}
 
 	ret = reset_control_reset(priv->reset);
-- 
2.26.2

