Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29317C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F364F222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uj+CDaEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgCJNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50388 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgCJNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id a5so1398454wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWg1+0qPYtmwp2vWptb+cPqnhkgCvPE9D0OYxdoMQ0o=;
        b=uj+CDaEBOwgtEQBu/rWxMbpjd+4bsWWeITDpsv2+FMpwroWyL5OKnhMNrpfi58cP0y
         lQW7eIhFj/GzONqBNemOmXKjb7xXdgV1C9U1Ysi3PgatQlFZmwpoNeJKm1ImK/p/2gg8
         r3VXZuLNO4xOMBc+DsY6QbbbA2dPy6AIhjKk66GuCKtscX8ZAT7P/Zh2oajuBRiJLnWV
         M2hzvXmn4oK402LFGBk/FPB65s1ZuXY4Z+ajkk61/DlPSYK/0DYFd0PwRbSe8+hL4jLs
         ZBRtnIes5yrtiO0lDuFosDT+gwR+nAVT0Kdc77IQhsr5lesp5UUZJHUkkZ64BYyeZwYh
         qBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWg1+0qPYtmwp2vWptb+cPqnhkgCvPE9D0OYxdoMQ0o=;
        b=i7cDi7G2kJoJcPS4Hf8Yviq54XAcrS5yb2iO8PN9jV7AQEG9j6QXVaUUkAgJtzr6vK
         /70NVQldBV244hftSEMOfXirY5a+CuY8Rp7yFyj6FMc9bdFoMDuy+qqJ3ntHjFDVbBui
         xJjZKqOiurKCZJIZa+0IOf8R3DgjHK5fjQk1u1DZykUeIXjW0tjhoa01iIm2VIkFO+m1
         mNHonqNiyKb3q/MUK9KQeGlOPCUAPNPH4VCRpFbVVnYqmvX4TvYPS3bm0i9mpDZT4l35
         gcnDWMm584Pg7WktwuXFTnOln+IOEanKQHhcpPDVQIgbMdwfsplyWVCChpcTHWK0+zIB
         NFBQ==
X-Gm-Message-State: ANhLgQ01vDPfHwS2fB9izHMeBgP8dl58A48pL+B5MdmOqB6njBSZ8Hn/
        FVbgEmCHiQTO8MHxtEfcBdTi0Q==
X-Google-Smtp-Source: ADFU+vutnbY08w0N8LUWrbcc3T67wh3wqiYDtrXexch152JjaMLn/VyKwkQtjn6KrX0r+rS8r6uCvg==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr2281351wmc.32.1583846623397;
        Tue, 10 Mar 2020 06:23:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/14] nvmem: imx-ocotp: Drop unnecessary initializations
Date:   Tue, 10 Mar 2020 13:22:53 +0000
Message-Id: <20200310132257.23358-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Drop unnecessary initialization of variable 'clk_rate' and 'timing'.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 794858093086..50bea2aadc1b 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -206,9 +206,9 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 
 static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 {
-	unsigned long clk_rate = 0;
+	unsigned long clk_rate;
 	unsigned long strobe_read, relax, strobe_prog;
-	u32 timing = 0;
+	u32 timing;
 
 	/* 47.3.1.3.1
 	 * Program HW_OCOTP_TIMING[STROBE_PROG] and HW_OCOTP_TIMING[RELAX]
@@ -258,9 +258,9 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 
 static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
 {
-	unsigned long clk_rate = 0;
+	unsigned long clk_rate;
 	u64 fsource, strobe_prog;
-	u32 timing = 0;
+	u32 timing;
 
 	/* i.MX 7Solo Applications Processor Reference Manual, Rev. 0.1
 	 * 6.4.3.3
-- 
2.21.0

