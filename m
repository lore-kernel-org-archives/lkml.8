Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291CC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474DF2074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC43dJcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEaRrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEaRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:47:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C766C061A0E;
        Sun, 31 May 2020 10:47:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so9144534wmi.4;
        Sun, 31 May 2020 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74PNAAD3pBvnsCVGDyDbZgcDCGsmspG3CPBBtpSlgDc=;
        b=TC43dJcKvEj9zljBOZ2LvawBD/1PjvVsaYKhjg2MJAMqJXvFocJwoi7a+ZIV0kHvvd
         wysTvyYujn9wbVrkDKNfdKczjNFqKxth04Jt0ldcMxL99cZIjkgyHXuin8HY2H8pW/vn
         cl7z2IjqN02JXH58MwBPewxY2/2BcnGgrq1Ey/MEzTX6vQ/FvcJ2o2k50qlfh5TNn9BI
         ofgpN7rxaGgqDbO6tuDgUL5RdFtxZ2J8121e+Szoh7PAdY2XFXQkZnzpoAUrbn4Qz5LB
         FBJYYtbcPF34KK8gj+GJTsRcV07fPZVV2mE8BBF4ZYiqygU0ouGfvSB0oabz7LrlNl+t
         rK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74PNAAD3pBvnsCVGDyDbZgcDCGsmspG3CPBBtpSlgDc=;
        b=c320RstXt1oIMmPBd/LJC8OggwPKX+a4Aw/tmejFp5H52pvvFcwM3PwOnUk/er85jI
         evc2/XjPgHPrlVpa/JRVsLtmn1xlQy8ZvKdayuyaC6pXm0R19bcQ9+qPZTzLCeDcex4U
         i3Qo8aYDDsletfiTil/CCEQOBLd1r66ssPWzTi1KePnSQaihUXDnk/VKnHiZ3wCrMKCl
         6eSLoM0nve654rTylsviwVje27MrFG9o6LCKaTKncuJXTtbcCalhzwCXInL5ESuDYyRS
         ounG7aGgJMNHrEGNSz2yuO+c1c9OpZkEl3DA2/N8axTTrpb+utpx7VjK5m4iot/USoJY
         4oYg==
X-Gm-Message-State: AOAM532i20Psr0l/j18hKLJmDILvR8FIlSDcPfoGP5kcVPkYmplymJXa
        5uMaei9EQ+zXvnjWx3qepkM=
X-Google-Smtp-Source: ABdhPJw20cPOBuAzZh+bpYUBVoYgh/nEYQ4URWcQ4Da3bpGglKd7mqhxEZWgQEGhwcnR6atjiMNVdw==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr16860159wmg.63.1590947233131;
        Sun, 31 May 2020 10:47:13 -0700 (PDT)
Received: from localhost.localdomain (abad130.neoplus.adsl.tpnet.pl. [83.6.167.130])
        by smtp.googlemail.com with ESMTPSA id x186sm9716494wmg.8.2020.05.31.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 10:47:12 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] driver: clk: Add msm8992 GCC Kconfig and Makefile entries
Date:   Sun, 31 May 2020 19:46:10 +0200
Message-Id: <20200531174612.260113-5-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531174612.260113-1-konradybcio@gmail.com>
References: <20200531174612.260113-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 drivers/clk/qcom/Kconfig  | 8 ++++++++
 drivers/clk/qcom/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 11ec6f466467..d102b4015289 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -197,6 +197,14 @@ config MSM_MMCC_8974
 	  Say Y if you want to support multimedia devices such as display,
 	  graphics, video encode/decode, camera, etc.
 
+config MSM_GCC_8992
+	tristate "MSM8992 Global Clock Controller"
+	select QCOM_GDSC
+	help
+	  Support for the global clock controller on msm8992 devices.
+	  Say Y if you want to use peripheral devices such as UART, SPI,
+	  i2c, USB, SD/eMMC, PCIe, etc.
+
 config MSM_GCC_8994
 	tristate "MSM8994 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 691efbf7e81f..4d931562c42f 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MSM_GCC_8660) += gcc-msm8660.o
 obj-$(CONFIG_MSM_GCC_8916) += gcc-msm8916.o
 obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
 obj-$(CONFIG_MSM_GCC_8974) += gcc-msm8974.o
+obj-$(CONFIG_MSM_GCC_8992) += gcc-msm8992.o
 obj-$(CONFIG_MSM_GCC_8994) += gcc-msm8994.o
 obj-$(CONFIG_MSM_GCC_8996) += gcc-msm8996.o
 obj-$(CONFIG_MSM_LCC_8960) += lcc-msm8960.o
-- 
2.26.2

