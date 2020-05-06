Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46061C4725B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D1E20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3aDzcaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEFEuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEFEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:50:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6133C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 21:50:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so241118pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 21:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FSudHAT4wzxoYvh1XMNs5f+xHdE9nw3XTPAzmG768CM=;
        b=U3aDzcawg82HoyJF4XsjEECEGMvShr3jwEb08q/y3Gp5KJ+A3SFFYbESzXQpGxuCsd
         zACdWKMqVeq0+JZChcq/Dedbf8ZWMoE0WJucb2veZ59NC8vm1DJH2xTm0/Ua6ewnL/1f
         rU3Ur6HaT4HXlf/+xuubUBeWjsOGpYKr3JjLVJZ9419XaxgVNACzR6YpAXP2ZcreWRYT
         6jpduQWONW5u40Rkh+SLKyLnRXEIyxom2Wq7OAVnyUpmDk3TYRx1Py8ZacO5QVW/O/DB
         9iSGlaZthKfyUGXTH+4wCIpTPZd8MunSTBr45HNfxwdI+IeGPklbqUO8K+JU3UZpGoEs
         SkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FSudHAT4wzxoYvh1XMNs5f+xHdE9nw3XTPAzmG768CM=;
        b=Ohrv4Rw9t2ACRTc8+tYR0LzY2wlRTCZIcm3xNCZI1Y+ss0VWMp/8wIq5AYWmQ7Mu1s
         D/t4E3BhhyOYk3qijp3ismrR2YauOucCJFE1qJrIqge1OGQGGZ8Z1j1iusDRnD6z/Cp3
         op/36D/Hlnhn2NVGe4AA+J3fVlmWMudF2La4Kh6IofqtKfKHRyCeEqO81Mo9kv9gr+5j
         swDAzeP3mkv0wK3aWu5FJc/WA/gpetZ0h0ZSI0GNrJKlRURBFFLupxnLQIL8yUdZa1Ez
         zGpwGe1g7wFpY9nBqWac8BHB9npIseM/gJxpaeTDuNWITFq1zr3dD/MkYlfOKH4RHsl6
         0Lwg==
X-Gm-Message-State: AGi0PubiCCCMjiHjJGEFhtmPaiMeXbTABwQcprxbp5IHtzZpxJV8u8S0
        wJlnPFTpOk4J61VWIE6D6vfD
X-Google-Smtp-Source: APiQypLjtuvE/fbjYHCJaAnW9hNPEbhOvT1KeTnwHy+YbHtcJlY6KdWyWjT2sssutPY0psBUFA480Q==
X-Received: by 2002:a65:5947:: with SMTP id g7mr5550370pgu.258.1588740649191;
        Tue, 05 May 2020 21:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e88:ac9a:a18c:3139:9aa9:bb73])
        by smtp.gmail.com with ESMTPSA id n69sm3491840pjc.8.2020.05.05.21.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 21:50:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net
Cc:     kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] net: qrtr: Do not depend on ARCH_QCOM
Date:   Wed,  6 May 2020 10:20:15 +0530
Message-Id: <20200506045015.13421-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506045015.13421-1-manivannan.sadhasivam@linaro.org>
References: <20200506045015.13421-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPC Router protocol is also used by external modems for exchanging the QMI
messages. Hence, it doesn't always depend on Qualcomm platforms. One such
instance is the QCA6390 WLAN device connected to x86 machine.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

