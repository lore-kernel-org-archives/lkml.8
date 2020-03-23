Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C0C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5ED20774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRYKlwz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgCWMbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:31:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCWMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:31:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so7411483pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rEAkBJxPd4hSHqHeDBCWCT76WtgPmMTyeJUR1ztc3Ws=;
        b=QRYKlwz+3wUdtgT0HtxmgWkUMXKIl6FDmO1CEZkb865YpAP3hnIhmMRAC5Jv7LrWP3
         UqKpz8+kWkeyxuDgqiztAliegXLra6GT/RKM9sJDlP9citChqHDyKeCOucH9TCS19Wze
         dLtH4g7cxy5DNAr5ZR2ja4MoBwadhqEt+Nq1rNLwCp3Ci7rRpw8ZebP0Lc+S2jiPgxMd
         WnoYeQikA8KkBqUJp0L3Wz1QGo86NA16hnMirkv0axfVJ9f5WJjCjvmtm0D3Y7YrlSwR
         Iy3Ej6HA8IWGNoE9K4UIijkqchwpK4oKNL4wEwo8SH581O6BuqAFh3yuww0Vzm3XGw/Z
         Ke9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rEAkBJxPd4hSHqHeDBCWCT76WtgPmMTyeJUR1ztc3Ws=;
        b=hxTBjYTz2A6uqG+dyLaeptsBKQAAxlGgubWpYXZDr95NqbMnmLAr/w00ZU8jvtS8Im
         Qw//DyWT8kjTVAc6y9EIqduFyx/LIT61wcz59HXigRU7rsQ3xniwdK28y4nXbyZ9wjoF
         KzsfDRMjJJlhkRXOPG3Sta/00Mo1elfypEPBFt3Ez84Z0fHq+zijju4eUMk0OKK/aNyR
         YDfw1EC3pnEIkcrjXtB41yP/m2XoAyC5aMYSkMA4uPY6XIGkb8/kw97o20nV38hieDpt
         Cp5XYUYLx3oKD0P3S4ZVtvM0/faI2j9G20LVc428x0yiSJW7Cg5jFvp/bh4F27eJ8XzI
         sj3A==
X-Gm-Message-State: ANhLgQ2vORP15sWXrKlTK4QxC7LnALGsHuy0Uh/oYTHEFH8UsPcn8cmN
        jmaw5gik2jza8P4uqCfC+nHd
X-Google-Smtp-Source: ADFU+vsdD0ZZ982SutPaxJPmPd5nX7gRp0D+LOtoVjGZjdF/H3fWCAWtZgi/vfuak6vBRIQm6Vbxew==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr5852695pfn.82.1584966698034;
        Mon, 23 Mar 2020 05:31:38 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 144sm3590131pgd.29.2020.03.23.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:31:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH v2 7/7] net: qrtr: Do not depend on ARCH_QCOM
Date:   Mon, 23 Mar 2020 18:01:02 +0530
Message-Id: <20200323123102.13992-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPC Router protocol is also used by external modems for exchanging the QMI
messages. Hence, it doesn't always depend on Qualcomm platforms. One such
instance is the QCA6390 modem connected to x86 machine.

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

