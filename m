Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464FEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D41E20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBfjzNAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCMMLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:11:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45560 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:11:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so11973353qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX5mru32Gi5sOBQ/FNp2q0Ts+vriYrqCzKI6fxK8S5s=;
        b=YBfjzNAK8oAtbEB33Vg9nHEuPwS/uL5qvwqB0VYbnBqck4G5PNPfhE5uActu40HgpB
         zixEME3kMx+bgjh7VoxHYnQzZ8A9InXxC3V9WF0R/QFXOD41aXctw+9xJYbyby0wiUtj
         e6mpUSO1UynXjsGLTylQmPE9SoZxb6ozlc4RrekMF9cyX6ZVJ5h/sfV83Q4+iaGP9c5M
         3kIZbBn1sCoEf98wDnBy8c5gftnCRPb08ByAPfSFAvBCkIbODTaFkbSwrXQtDMUZCcCt
         N89yFZ6WOCHUBv5eLNS8rJMBtciy6tXVwE3tBVlzBF+jJIxKpuqQhBV1rTaVUVPxh/T1
         GUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX5mru32Gi5sOBQ/FNp2q0Ts+vriYrqCzKI6fxK8S5s=;
        b=qjECDr5/qwoHj+B+cxJphg69SBNuUam+G/pTEqh/R4VRZUtXDW9RD+4KRAoz/1+eVR
         jFZK3RPEC+agYWezMv801plW5o4PYPsbPoc2JWr69vzJy/36BqLBFUAr/vQ42zLQmtFl
         gyRvU36jRiNd/mzmY+cfZPogTjsRABxWkMifEwjHwvb7hJIQBRIo8gyCDK3HxPrSjblV
         v0vAPJ9PViXVSx33MFW/QI0Z3nNC+RzZ5bq2G4mx20OD9S9UsfGE4HgN8v9wkRb8BJ4l
         MO+l8eUVYRotZIU4Q5XxfUEPOOLE55juxi8B7PfOYezcCpZL6i3a/eTqW8KwKpCCzx21
         wgLA==
X-Gm-Message-State: ANhLgQ3lSrOK4p0Jfprtr8NdLMmbs0VcC/jE8FfUP4ccEr/trhbYQkXO
        Skm3KyLwlwkyYXCT6SUwmyqWqANyQO4=
X-Google-Smtp-Source: ADFU+vu0UgXCyUMs+9W34yBOVDQS5+nQD1LI345IKOny09UNx3zrIg4Fpy09IPHUBow+wMtngzhIxQ==
X-Received: by 2002:a37:9e88:: with SMTP id h130mr9926845qke.145.1584101493013;
        Fri, 13 Mar 2020 05:11:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l60sm8281895qtd.35.2020.03.13.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:11:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: ipa: build IPA when COMPILE_TEST is enabled
Date:   Fri, 13 Mar 2020 07:11:26 -0500
Message-Id: <20200313121126.7825-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_QCOM_IPA optionally dependent on CONFIG_COMPILE_TEST.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---

David, this implements a suggestion made by Jakub Kicinski.  I tested
it with GCC 9.2.1 for x86 and found no errors or warnings in the IPA
code.  It is the last IPA change I plan to make for v5.7.

Once reviewed and found acceptable, it should go through net-next.

Thanks.

					-Alex

 drivers/net/ipa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index b8cb7cadbf75..bcab7e52d4e6 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -1,6 +1,6 @@
 config QCOM_IPA
 	tristate "Qualcomm IPA support"
-	depends on ARCH_QCOM && 64BIT && NET
+	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT && NET
 	select QCOM_QMI_HELPERS
 	select QCOM_MDT_LOADER
 	default QCOM_Q6V5_COMMON
-- 
2.20.1

