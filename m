Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F506C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE302080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLxJvfQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgDBFgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:36:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37772 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgDBFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:36:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so926148plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPuAXHpqrNAT+U03Z2D0D9d6MExECUerQyolxFR+Rtk=;
        b=FLxJvfQS0ysmXpNHESPUDdj7u8d5tYFdiE/P7MB7ZAiuFbqgIiOi0ODzXBe0HK5t5y
         05ZME+MBiIQY5rPFJhn/ankIYTGPQ39BjLn3zNjh/hKIl83Cq5plB/coFF1KyMN5Wv6x
         sDjUTNTxeGnF1C9EwKC5E58eLETX49fVYiRrILohyk8d4PThgmZFwY+iYVcnpbPamiKB
         +VHONI6ttdeP87QsPum9UOXkFBP/QxZOVh1bft6RS92h6kicR1Y7AJsTzXs35vARM8FX
         xhLXxvZT0kQqlH534Yc9tglbmXj6DaWECLZVNh/vc3ALb/ev+KfKHOlcrHYT8uEppfiD
         p2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPuAXHpqrNAT+U03Z2D0D9d6MExECUerQyolxFR+Rtk=;
        b=LAJJ6m90k08ZeNc/b4zK1A+i2qJBFjD1mGx7dmFhZ+VbqRUNQAEdwCpas2yyoKrcau
         4wh/cbcxcxB98WEEkiWf615+JR10VjssPsf/KVzpdYi3tnbioJ6m4x5zDaYEifzt7d+y
         6jA8KzLSA+vlgiU+4t9N7ECxCNvRQdOqAiOXwIXDbHsw3cNSKIMxiPMuVd+0yZh296Xq
         bHixc8FzAfv6ZVcHjbdwFPfiJTr/AO41jBUYFLpf0DpNt5N5/jsF2f+Tfex92r3ZTpss
         3SxN+KeO8u4Wity9FfVXC9Dftq+fgiCfIDfSQkjkuBAjjX+Kj1cI8S8fqGGOQQvsgiYm
         VTyw==
X-Gm-Message-State: AGi0PuZ+Uip8l6IY8q5zhRgI2Yd7LLptbHVjtsm0hMoXasni0QcNoy2B
        nQ2Y8gtAi8kGJsheyndRPvct
X-Google-Smtp-Source: APiQypLUO9ItCUYvMe/cdxMNd9ZZ/BddDu0GYPMSa91cheBTNWouOMVF2ehqKljSAS/Zgn43sQDi/w==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr1414399ply.68.1585805800814;
        Wed, 01 Apr 2020 22:36:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:29a:a216:d9f7:e98f:311a:69f6])
        by smtp.gmail.com with ESMTPSA id s14sm2684824pgl.4.2020.04.01.22.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:36:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH v2 3/3] net: qrtr: Do not depend on ARCH_QCOM
Date:   Thu,  2 Apr 2020 11:06:10 +0530
Message-Id: <20200402053610.9345-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402053610.9345-1-manivannan.sadhasivam@linaro.org>
References: <20200402053610.9345-1-manivannan.sadhasivam@linaro.org>
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

