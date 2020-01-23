Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8321E206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlDi9bN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgAWLTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgAWLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so1225605plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15QkUOyqGz6eomBKIwtq/Fp2YhGFsx/KFWnHxF+6NKE=;
        b=RlDi9bN/8bPFgqQgfP/5w0XWTn0g7NWphocLjSNdwU3gk2TR5m/9JJjyX20ie+xfuB
         s/hWZ2kFtCDe1Bf3rMI4ZuOOkQxBn3ATb4RYE+NZlD8HbMJcrDUkYyAzm3XIIKG1FGPw
         bB42RmozNEd8jRo9w8i/Z8ENNegXMJVmSgfjRuZmnjX7/r3POPo59EMv5p0bP4/gPfV9
         pr/Q0QG7CBxOFXOVpKZaKzbNsFWDb9GQ4o0ohmQ1LQakTIbi1c9rA3JLeYUpi9Kyb2Bz
         G+qLMQQDHZkedyH9nwSkcriQ5oSLqk7mqFX/xiXzuBNO+2ectedr4X4S4IdqdA+ItQbX
         Wbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15QkUOyqGz6eomBKIwtq/Fp2YhGFsx/KFWnHxF+6NKE=;
        b=sE4KUmJAqYKxoR4DxKODybQ/rbB6h18bobrChVaj48eh/Im8nTt2SQWqx7hYEUzdrr
         44RK+QZ0RZfmbPwG9oQRFkuY+2v1SHNPKs47VmC+qdHHc49u2Kd49wlbTIyo1NKyeEyF
         DNQlL6Nlk34P3mArYieGcdZj/8PSYQa0PXQ9GQYxGLnCzTe25kfUvQTnZed+g8H+l6iI
         Xg2fTywHhj9gKXkooGcjbrXdQUsBxP7zO/+d8mU4Wuh068OZk51j9IiDcUF0WqtaBCx5
         nYVf1pWjy8IKM51E9sIz5muPYpSpfpceeTZGKHUuKuce+9RtaGEUk+RBgvSIRosmfrOm
         jINg==
X-Gm-Message-State: APjAAAWu4tZ57p4gx8nNq+OjyWCZOtx55rAbrw4Kv6P8iEIaEM3IPuFu
        kBUCPp4CA7Mx3Q992Onlhqx9
X-Google-Smtp-Source: APXvYqzcZRJ2TmhHoxy1Rew245aJeebuTCCNqMgta8RcCA/PQhdOitTg+76KTM3uKTY3O0heA+6vUA==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr15480441plb.246.1579778379054;
        Thu, 23 Jan 2020 03:19:39 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:19:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 15/16] net: qrtr: Do not depend on ARCH_QCOM
Date:   Thu, 23 Jan 2020 16:48:35 +0530
Message-Id: <20200123111836.7414-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
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

