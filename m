Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96C420705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diJWGYEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgAaNvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:51:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36085 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgAaNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:51:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so2762643plm.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVMDDP45gEarE2ftOW97e9LLiKh1M1ITIXoxyhoFdNU=;
        b=diJWGYEbpsbtiXdDmfNYGwEIlgVaXgkPL9C4gv2LukE/uuAlqIHy/JWsv9fS87BvQy
         4aRTS3l3bYhN+uszlO/yWEnG4k9Uu89b61jze3JH3pK0p46+2ZKcYTiSv8Oo8pd9SSXq
         tIByh3ZDXvYK9DlrN0rCXR2IrdFbBirxOWn1YNKT+ZCd4wqe3OtgV/ORtuEcuZ0wi4Tp
         dUE0SwHK3+/dv1baqE/WH4bHEpVHLa7cWDEE0snHIg4P61VowA4bvkIGPrIQge+YgVGL
         7izMQFEktr5GflPUrtbeGFwNc1pmwswm7puAiOLBaQW+n+Nq+eEUPyGxvfJF/RJKsPae
         SosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVMDDP45gEarE2ftOW97e9LLiKh1M1ITIXoxyhoFdNU=;
        b=GQvMjZtbR9lvNwDIEfHFJxliMxE94iIuSgBtfZ+C+I23/HnvIi1RxQCy0AdDscuods
         Li8dD4MWh8ufSJvfgVqN61/p4qK2Q+UNqvPy1gPLKUtx91S2jpseI7yrtR5HgE63WP3n
         zArKKZkEPJeVMk04fP6bZeLMZSWxgM2h3qxOjlf8ZShBTqr1j8tNEE03LG86LmdMuEBw
         14C0MnvU76H4125uc9JdCtWwfIxwGE7SUb9EkBPWTW6Kln7kX5VhToYHa+NzqrcbILlT
         nvl+rkkbGNNlKannt9dZXqJp257NzDjTGOW9UO5zVkl0SVsS0qt8LvDm7lX8xQ1rAsQZ
         sfbw==
X-Gm-Message-State: APjAAAU5narfG19b0sXkehO2ipV5OCf9Yx0DGc5y9aOrYWPE7dmeea3y
        WwAs3KbujjRI58GMm7tChVNT
X-Google-Smtp-Source: APXvYqz/u1NsnI6hz7lxTDEFV1Ba73K2JOoIozinOTTVBHFU9EDn3x9/2F/xM4BofZ2Utu4S/5UaPw==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr10353463plo.330.1580478675836;
        Fri, 31 Jan 2020 05:51:15 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id p3sm10625632pfg.184.2020.01.31.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:51:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH v2 16/16] soc: qcom: Do not depend on ARCH_QCOM for QMI helpers
Date:   Fri, 31 Jan 2020 19:20:09 +0530
Message-Id: <20200131135009.31477-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
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

