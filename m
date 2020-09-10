Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAEDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E83C20731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xes36BsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgIJVnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgIJNBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:01:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so6609218wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJ2vHaYqoVGimQqIW+dGq81Ddb4etTQVEuSJ6N8/hV4=;
        b=Xes36BsZfAJFtqugTewRnG8S2F4SvtKI3ao41dtEndBZ6+tMSuxg2QYTyWuc2rLsv2
         dOk8MBtBz6erlo84rPylqikZUL3dr7mKIs4oRostt0NTudrbX3JzMzoH5PWdpmAIgOOL
         P9svCMAyrJaFMjzvfAtZ/O1Ob2HskNoICrLWNoSR3QDsHWfC80vnXy+F9RD11BpTEZJH
         J0SyhjkPnjODgRtc7CLZqHm8fG6KIcdOX1nJ7uV2CuKxEpunYhM+OsitUxa3e2UJnWs6
         lL6jtrqQAa477lPUpx+VmiChJcvPAh80Jnxc5+IibbSGDYBFtm2NxdOsd6oEqlDfAGaI
         fJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJ2vHaYqoVGimQqIW+dGq81Ddb4etTQVEuSJ6N8/hV4=;
        b=WcNOCbOiv5p85LYd3GBJtG5UCB1o66bRvKbFJjfRsfHndF+xeEYc1pnGr6Qrm2mbF1
         CFjBkf7RmWBkKCYMivkvqsQ/3XmWyhqGbBGwrS+V4haNRtViHFaFkPDHpp03FxhyQNkP
         Dbu557wl2WBCndzUo1eCyHdIoQ1MGSw7TpXwTwbsV2UP0JKx72RtnXtt7k5bLFMdabfz
         A+PbFidCFxkM3j2dalgo754BDqnro99e+31GgVBpkBDQO3vJT6+4HhYUetMe4RefYqEr
         33BpXUrzdaSdefBeXVH6+s7dgBys7sKdg5hsfgLsICExWRxeozhaSjHxZul8ysJjJmu8
         zbnA==
X-Gm-Message-State: AOAM531r41XJuUDWoBTklH97/FnhBBoAMXmiZjxNc6RJwgyNKwAx8NyN
        dVviaxsMzESLAnUFOX+9qljDbw==
X-Google-Smtp-Source: ABdhPJwTMfl8B7RyFT52ujmfWEzGY2zJt6LYENlU0R1nqA53iSiN5gy6cYDGYtwKp1dHNpKPfW+fFg==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr8524324wrr.235.1599742897157;
        Thu, 10 Sep 2020 06:01:37 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y1sm9488269wru.87.2020.09.10.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:01:36 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 0/4] Add support of mt8183 APU
Date:   Thu, 10 Sep 2020 15:01:44 +0200
Message-Id: <20200910130148.8734-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Mediatek's SoC have an Accelerated Processing Unit.
This adds support of the one available in the mt8183
(aswell some derivative SoC).

This series depends on two other series:
- Mediatek MT8183 scpsys support  
- arm64: dts: Add m4u and smi-larbs nodes for mt8183

Changes in v2:
- Drop the workarounds needed to load bad firmwares
- There are many name for the APU (most common one is VPU).
  Rename many functions and dts nodes to be more consistent.
- Use the bulk clock API, and enable / disable clock at a better place
- add few comments explaining how to start the APU
- update the way to use pinctl for JTAG
- fix some minors issues
- fix device tree bindings

Alexandre Bailon (4):
  dt bindings: remoteproc: Add bindings for MT8183 APU
  remoteproc: Add a remoteproc driver for the MT8183's APU
  remoteproc: mtk_vpu_rproc: Add support of JTAG
  ARM64: mt8183: Add support of APU to mt8183

 .../bindings/remoteproc/mtk,apu.yaml          | 107 +++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  39 ++
 drivers/remoteproc/Kconfig                    |  19 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_apu.c                  | 437 ++++++++++++++++++
 5 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
 create mode 100644 drivers/remoteproc/mtk_apu.c

-- 
2.26.2

