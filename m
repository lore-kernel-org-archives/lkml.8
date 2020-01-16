Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCEC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36DB20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/Jwb0yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgAPQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:11:19 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40035 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgAPQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:11:18 -0500
Received: by mail-wm1-f50.google.com with SMTP id t14so4388037wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6Ue17Nv7CpwQ9eQ73g3EGy6s46L1d7nm/d8/OKNYiU=;
        b=R/Jwb0yZ4nCTEDJ/W+3uPWY3XFVSFmupAkJw/0NbHLMoOxYgcyXiu3lcBwCP4JhgFU
         cCATSO9hRLkU0N+1O31R1ZoTUHzCoIP6hapgIUMWpLdAYIhIMaPSzviQSRE0+sFQwMhx
         GE3N4xVg5JNeM8EZX1S8ZteHsJZ0SNmA21kLMhRteBhTuDub0fmABOadvUKOfOXmFtSm
         vsf893kdNcl+YsL2nCzp2vso7KYIAXJarEVPrzlbzedFMg0GAL7wN99KN45+YxurKXUf
         nHq/dZ4392qdmiBxYxsKvWdY2s3LxKG3pPo+zkf7Ud6wYj0Yq7Z9Zgb1chg1apPU8M8z
         lWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6Ue17Nv7CpwQ9eQ73g3EGy6s46L1d7nm/d8/OKNYiU=;
        b=E9h0wbWEfIN8RB+8vnjjLEl9marlX3iiuFD+HqOAkhDZJuUWfFRliHdhY+AmgP/x3k
         EKpeWt4C2cAQlLffoeBkIqdDryjYVncjOIDzRKHlOQK0KYbE+5PNn/rRE4sg3tuy3Xwd
         egcAnx5GT9aMq13cf0yOdcdRiziT1uKoEk29hW3n5tjszi8HWeuIvkQCAbDOpaz+UFRM
         eLCe38rpya32SbNf4qFO3POVY9aa7c526BSbuvQG0c/hdFA6RovnYBE1aKEqwe5xTD/m
         UxRMavxe9bgI5tIwGGfFmLZ9An5r7gILbDU7UrFPNHbm3632g94o4H1GECWr2pGyhsRL
         Waww==
X-Gm-Message-State: APjAAAWQWuktvMplpsuT1vdGGcnWxVynmGIZ7nS3C6O62rstTMEw2ZhQ
        Hj1prP/0H8haKonp0eZLlH0nYg==
X-Google-Smtp-Source: APXvYqyqe1Ts/3ogKwtI8rn9n/4tj8qRwtQRixtOE5b0I2b21BE3ubBGGZ8EL6XRh8U5qSqGjufa8g==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr69104wmg.147.1579191076541;
        Thu, 16 Jan 2020 08:11:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g9sm30075740wro.67.2020.01.16.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:11:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: patches (set-2) for 5.6
Date:   Thu, 16 Jan 2020 16:10:57 +0000
Message-Id: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches set2 for 5.6 which includes new SPMI SDAM driver
and new compatible for imx ocotp provider.

If its not too late, can you please queue them up for 5.6.

thanks,
srini

Anirudh Ghayal (1):
  nvmem: add QTI SDAM driver

Anson Huang (1):
  dt-bindings: imx-ocotp: Add i.MX8MP compatible

Shyam Kumar Thella (1):
  dt-bindings: nvmem: add binding for QTI SPMI SDAM

 .../devicetree/bindings/nvmem/imx-ocotp.txt   |   3 +-
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |  84 ++++++++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/qcom-spmi-sdam.c                | 192 ++++++++++++++++++
 5 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
 create mode 100644 drivers/nvmem/qcom-spmi-sdam.c

-- 
2.21.0

