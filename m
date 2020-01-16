Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32351C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFA6wLdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgAPEzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:55:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46809 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAPEzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 23:55:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so9255029pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 20:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8v+4DgG5fbcG655PWQyALbezwDT0tnYhquzZ6Aq2MQ=;
        b=eFA6wLdiEyl3ZoRG7Sqd18ajRt2HOl+aeMKbdK4pAQPh+xanYAztfw5U5LK0gzJC6U
         4Ko/MudJrnmRZIdvZ7rUiUhrXfklOq+riOxXv5OrM+XaQFdaRaEZkL73OMTYNGhtf+A0
         SSromzDHLBBuOP9xfqmg5KDVMnedlxikPtVONL9AM+5q1DeKkeAiuagJATY3XGidmeOp
         uy6GUdr3rDdNyAABTH2PnWA1WwJiv9qUvpvugtoYYEWFg6WmpidBQgc9OMOLnsXXkgyr
         O/0Q6KUrD+sOq3mYUobqdruGJEHQbuMY1Y98g0Iy+5/P33+4XoP9csFE6nS8ytsV9BWO
         qRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8v+4DgG5fbcG655PWQyALbezwDT0tnYhquzZ6Aq2MQ=;
        b=E5SZFWhZTo66e6sWp/aDyq3Cm6CDvGMOneJizSUzqwDYJhar0GOhbwINxR4HgbT60z
         7gMfqIzflF9DhUkefzIn2SQ/cdsHgBlwr57YQduvx6i3rPpIglpcaG7Ugll1AuNxAthG
         exQfMvFpbO7RPn8lzlZnU5liAgSCJRBr+6sEeurIyyWU0noendBvpfhWPRgSs/9T3ISC
         BvRFerOHuPpdJTroGvyfYdplfcs9MDmd6Q/DpeahvQnf2ogBOCp8nckJyS1PXDnc5Vcg
         awpQss3TvvBQlZtiUZQIh4PXDrTiWKlGh6O2wymRszpjfK+RQ4DitqUg50IRVGhlAE0m
         Rd4g==
X-Gm-Message-State: APjAAAXoMGXSYOsuAhBZVUo+0e9RaLzg3xOPWXnImjs7jsON8ynhh1eQ
        1X2NER4NIoseI5Iw/bfSfHq8hw==
X-Google-Smtp-Source: APXvYqxnV6r1cSp8obgrdpEsHKaYRE3hpOyfzEi1lowGIpNqD6SK+1CizrnQ2nn9d21ZheCDgnO6MQ==
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr37091031pgl.275.1579150546866;
        Wed, 15 Jan 2020 20:55:46 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c1sm24140468pfa.51.2020.01.15.20.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 20:55:46 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Olof Johansson <olof@lixom.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SC7180 pinctrl and gcc
Date:   Wed, 15 Jan 2020 20:54:57 -0800
Message-Id: <20200116045457.2489704-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm SC7180 pinctrl and gcc driver, in order to allow the
kernel to boot to console.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8409aa80e30a..a1766c05cfe4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -412,6 +412,7 @@ CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_GPIO_ALTERA=m
@@ -722,6 +723,7 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SC_GCC_7180=y
 CONFIG_SDM_GCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_QCOM_HFPLL=y
-- 
2.24.0

