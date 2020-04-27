Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC660C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF2620728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1MoGpGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD0H7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgD0H7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:59:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5759C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:59:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so8618267pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPuAXHpqrNAT+U03Z2D0D9d6MExECUerQyolxFR+Rtk=;
        b=j1MoGpGODY0G+y0YAjbilr/Dm5aQfXd9MCiY/FcdZcdVBByNPe2LcKMDjoZJQdqpJC
         eEodDfBogAmd+rBU/dgf3nJ5zdJrMNuTJqhBtS/iSgl4HpvmMJzFaQO4rB71uw+HMlA4
         uqSWAKRcw0tNlQezUH2GxNshYDP1eORsMQgJFQoznbI54J+owrXIE3h3wxvfxFL03l+o
         vb832Zd/4KmQdiSf8i9drvrBK2/4dA1yTi6T6oMOuvxvlwIbmr/whiz1BBs9VfuHT9fW
         jBGBUJ4aRvv+AS1iu6e4rxDRNFuIcAz58C746IMS8TRtDLRbt2D3Ta8b+VuPbVZS6LDT
         DKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPuAXHpqrNAT+U03Z2D0D9d6MExECUerQyolxFR+Rtk=;
        b=hR3MzJjDT7JBsuTAv0Fz8qfUeGWnDVCZ2XAlqXShiwNwqA4NR/2uKBoIMer9DE+uyc
         eTOC+OUDQKFgDiH3SdjBAD+yk2HCTmpKXeJiKebTwWBAiq4hVItSUZ9b5cEnIisVU4YI
         0ZcnsbizEEYqiVfkITSv5ZGXSPjAOyIyE/ieNpBOvY0bI9jDT4x/LomFP/rAxR8j/8cS
         lWgD/mP3oW1pW+A5biZgwXcG7v97YlTAbEvOfL5XdaFd8rO93qasgUcJvdC98XzbHPek
         KR9FCWciGcOJ9tYe+lF5yZVYHTO36D4A6AKjIfduuM2VmufosSMkM6xW1P++R5fuYJLs
         Lz1Q==
X-Gm-Message-State: AGi0PuYXvRY7JCiWT4IGbBRQJ3JJYm91qET6mAvy7IjXtOrhuytnPDkR
        sTdziWvefD0H2EbYnSFZNayH7TAIXQ==
X-Google-Smtp-Source: APiQypLZpxltxsTka+7sS/LyifM/nE79AgNzoR4gAcDIxipkFRxh/hIm6cR1gUqyoxtd8NkbZ/xIjQ==
X-Received: by 2002:a63:ec0b:: with SMTP id j11mr21238091pgh.376.1587974343260;
        Mon, 27 Apr 2020 00:59:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:996:8534:f925:aed4:6e41:e1dd])
        by smtp.gmail.com with ESMTPSA id a12sm11621190pfr.28.2020.04.27.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:59:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH v3 3/3] net: qrtr: Do not depend on ARCH_QCOM
Date:   Mon, 27 Apr 2020 13:28:29 +0530
Message-Id: <20200427075829.9304-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427075829.9304-1-manivannan.sadhasivam@linaro.org>
References: <20200427075829.9304-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPC Router protocol is also used by external modems for exchanging the QMI
messages. Hence, it doesn't always depend on Qualcomm platforms. One such
instance is the QCA6390 WLAN device connected to x86 machine.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
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

