Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97333206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq1pST3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgAWLTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgAWLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so1240138pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVMDDP45gEarE2ftOW97e9LLiKh1M1ITIXoxyhoFdNU=;
        b=gq1pST3X546LlrU71JkIqEimum7KJkT8zP0g3954nEQsSnZjo+F6aVleNGcmjkrp7j
         955/Gs4WvhhvxDh3Ko+lNyqKN3hQO+n2/gZJ07VEGZmS42FF3SbE5MZaOxQPdrEriIwU
         zviFHO2Ip3dJXCd59ZJtrkQyoDigdtNRww6dDC2EW+yvse9GHpzMcVNJ9j9QbWOyoTlg
         gZch33KG2Hz8CYA/0TJcFew6gxFw7tBtqDg6+X2bQ1VBMGFErEPk+YL5j4SINZcYKCF9
         3eFN5K376Il2WWAOHlEzhT3d5brNA3jeE57qMEqw4QBJqDSby6cTPRyjOAjq4ioDkU9V
         ty4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVMDDP45gEarE2ftOW97e9LLiKh1M1ITIXoxyhoFdNU=;
        b=HNV6GZ3Q0WuWSEwJsQNy1Teve7joToP+VPma95MBUDe/sql7WvNSoTNweNmWmkTv+Y
         MU9d2DIj2ukUkq6Otqg6l40CtPy51eQ5ZMTH0I2lrDeU91lYAdgiIqxiAWwGFypCCJ2T
         JihwK1GV5JWzJHrHTer6tRX575mQnONSdMHuUD32EGsZ73AdV6vGY11zyTnOrFXyms6q
         F/SCIPOdrTbvG/maEA9DaGQcf2bcOgFndWBH7tYOLdaaK7eptn17iUL7F6is2ktgu7kx
         bs4yHjEHEBLdKXq0Z7vlsZbpCW3v9e4wywUbTTi7JS+EujpL6ICecPXJGIfhBLENEUpT
         CMBQ==
X-Gm-Message-State: APjAAAV5qJY08fCGQJBfvTj8KGUAC7GhQ75ytWNGdfeqEB1c/WHTViCl
        hA1xtOF1meCbwqRtcL0kVBCN
X-Google-Smtp-Source: APXvYqxCdrTNghHTjvY3gNU6wjMfWTBmwK1ER/gmzX91JopZB4AclM1GiiV7l+ySRy26woQE/2J6ig==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr3293834pgg.129.1579778382628;
        Thu, 23 Jan 2020 03:19:42 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:19:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH 16/16] soc: qcom: Do not depend on ARCH_QCOM for QMI helpers
Date:   Thu, 23 Jan 2020 16:48:36 +0530
Message-Id: <20200123111836.7414-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMI helpers are not always used by Qualcomm platforms. One of the
exceptions is the external modems available in near future. As a
side effect of removing the dependency, it is also going to loose
COMPILE_TEST build coverage.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 79d826553ac8..ca057bc9aae6 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -88,7 +88,6 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM || COMPILE_TEST
 	depends on NET
 
 config QCOM_RMTFS_MEM
-- 
2.17.1

