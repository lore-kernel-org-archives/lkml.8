Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C4EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D557206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EBSK+E9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgCZNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55065 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgCZNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so6511979wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2Nej3PvIghRUOKzyBo4bIwNfTfqhNtg3/diQuBc7As=;
        b=EBSK+E9NDW6/g5NS8KEfKOXbeCyuAzwOTDTO1vQwh0l3zrv8Q2tyK/LrydSklc4JX+
         pqsTOR4naUDFKVaVpM1TqekGxLf2R03Yg30rMeFkiES78oulP5qC5aCOZ66Ku27ITvYq
         OVevZUCL3r8VcaWFHv9qIPfi5YBlHdnrk2HJiQGdHpq1h4T7m3VLpePVbjr5hM6yCWu6
         +w1U1yZCLQJt16R2im4++WMu1WiU7m2qkpA0eOum52mdnKyyjQqUWYrMxmxu3Yrs5dxt
         lxOFJOZmCbfFlS3sErPEPe/+Lj5XimXNaignHRINQQKQ5JzcTo6a4XJeC85hfOe0nsQ6
         E6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2Nej3PvIghRUOKzyBo4bIwNfTfqhNtg3/diQuBc7As=;
        b=PJl28aCqWG53OKEWWz+eWw7G5pRihui2rpX7/OiHAxtN60b/UrNkHT4gcugnfly+qE
         hqKrXfeP7D+nWiOGSVhLfcSLaLIZZa5IQzt6MQL//eJ1bwMG+UdQEwKTrR8AlkGgdvkl
         RbRBxe3ic7nLJ13B/ORfFRnQR7hWudkK8j1R6kdkDJeOenT1r3F3WR7vQcIGXjmw52Cc
         qmeCvKAbc2qdlxcyqQMeexoP79QjwAWcLYQ7T7IETwKGmtyaE8BWCGKEhhJB2Mj2CFhH
         nlSCDWEjEds1yYr1hxjO5kN+N80w1Zs0TYr1u2H73BJBMDUw+9pFmvO5VLkNn9nwXqa5
         Y1Xw==
X-Gm-Message-State: ANhLgQ3twBOjD80QvnynIwubJRQjsI1KyfDGyrApH59dvIYlC09GsjUY
        W62ab+HHFMrZAi8PFQ0OmH9BCQ==
X-Google-Smtp-Source: ADFU+vvlZVniCdthaZ5Ps9LD3FGyRxckA9MDLoj9Ko1f8T/NE7VRmePqEkNAlyEGnn9joVshcbaFYQ==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr43647wmj.170.1585230317388;
        Thu, 26 Mar 2020 06:45:17 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] usb: dwc3: meson-g12a: check return of dwc3_meson_g12a_usb_init
Date:   Thu, 26 Mar 2020 14:44:57 +0100
Message-Id: <20200326134507.4808-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3_meson_g12a_usb_init function can return an error, check it.

Fixes: e3e716e6b889 ("usb: dwc3: Add Amlogic A1 DWC3 glue")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 41bcbd31fe4e..69381c42a6d3 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -588,7 +588,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	/* Get dr_mode */
 	priv->otg_mode = usb_get_dr_mode(dev);
 
-	dwc3_meson_g12a_usb_init(priv);
+	ret = dwc3_meson_g12a_usb_init(priv);
+	if (ret)
+		goto err_disable_clks;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
-- 
2.22.0

