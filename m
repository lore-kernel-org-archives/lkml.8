Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16AEC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B704E2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiuCUmCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgBTKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:00:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50810 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgBTKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:00:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so675745pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15QkUOyqGz6eomBKIwtq/Fp2YhGFsx/KFWnHxF+6NKE=;
        b=hiuCUmCfLCKyVHPPxzjMhumjyrh6B1A16pg0DojQwPUiI964RCzIfqNv+XihK+bp3V
         TUJPE6MYFQKH2Wv4ZwqZPYy8BpZHZUBU4xcxShBEIgECEBYnfvsDq9ZSC5Qpniy7WgvV
         stZSLcQmVbb0yDumCgAnGFWISB9/pc1GKEX1VUHG0suceqKhXrM31B0NT9cq1lSLP2gw
         y1+g8FDEpwz6tKpq2XlttWsN4p15OVSz+BKidJFBy27N6sqVOdWL3fEDr0qZCvLO25j/
         Cc61Q/6tpVvaVMoreeGMuW39HDaz9tuUipKZb4p26vaGF4XvTqrhxmHqHp983fnor+8x
         1MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15QkUOyqGz6eomBKIwtq/Fp2YhGFsx/KFWnHxF+6NKE=;
        b=E4IV2SpCn50xfIP6W7ebuUWdiO+kAElyDrZNjrMm7wN0p5NaymqSctrZZUYKzHhk3F
         W0XVIGlVOomRI915kXhAAjS36CHJ4GUnw0vi+8B451LnB4403CNBGczWli6CDsh/Zi0D
         BME1M5Erki83xSi/rV70arpwmYvcaigrdQRD3A9ejlR4ReFJKdLwEzBI44NciMGRf0St
         zQValSifqSreT0KjbOaPcvrZRh62XEJVrmSh8MecrY+qpil5uWi6mNgfIuqcZaQW8KFL
         qMZJUMR6TwlXZBoHsUGN8HhcCD+KFbMVDfK+2CcGvn3qFscfQc4xvnGehf/LvnhRI01c
         xNXg==
X-Gm-Message-State: APjAAAVZLzfnqg1Mux0GdvjskaNemGaO5/EzvJUuGSSaOQaKcupuU6WB
        dbqFbp1LNtGlt75UiKsDEBTj
X-Google-Smtp-Source: APXvYqwacF6ybkjY5Ij8gFwXOma6aXyq39Ay53DohmoLvDmhDkqUODMNBJth9hqvAnFA5BC1cCbHAg==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr29352446plj.273.1582192826397;
        Thu, 20 Feb 2020 02:00:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:edda:4222:88ae:442f])
        by smtp.gmail.com with ESMTPSA id b3sm2678644pjo.30.2020.02.20.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:00:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH v3 15/16] net: qrtr: Do not depend on ARCH_QCOM
Date:   Thu, 20 Feb 2020 15:28:53 +0530
Message-Id: <20200220095854.4804-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPC Router protocol is also used by external modems for exchanging the QMI
messages. Hence, it doesn't always depend on Qualcomm platforms. As a side
effect of removing the ARCH_QCOM dependency, it is going to miss the
COMPILE_TEST build coverage.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/qrtr/Kconfig b/net/qrtr/Kconfig
index 8eb876471564..f362ca316015 100644
--- a/net/qrtr/Kconfig
+++ b/net/qrtr/Kconfig
@@ -4,7 +4,6 @@
 
 config QRTR
 	tristate "Qualcomm IPC Router support"
-	depends on ARCH_QCOM || COMPILE_TEST
 	---help---
 	  Say Y if you intend to use Qualcomm IPC router protocol.  The
 	  protocol is used to communicate with services provided by other
-- 
2.17.1

