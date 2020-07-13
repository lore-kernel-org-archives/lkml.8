Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27837C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F1D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eZztk7O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgGMN3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgGMN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:29:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28930C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so16570354wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8M2es7HHouzmCUpyAYFqBmq/VXXAGiCHzbOor1SAZdY=;
        b=eZztk7O7rf+DFBdXysVaFW4Q6svK0fGNMvSOeDFuBZn/YGHCVDHChUbKn5LhBskGZF
         z4kFVrudVva1mgg1mPIwMgG/zOElB0ulSNlJAWaXR4twxVMVl3if3wzh4Jerf2NIhpy9
         ZgYZpN1qdb1PX8A36OK7S2FYxhqRzMqWnhli036pECPg1gVa6H+PclsfMX1+zivylIBh
         EdcoHIsqNvh00CBTbSgfCw04YoJLD5d00c8lG8RVo0q06XZ1R2AfjmaXvoXcZiRPu0I+
         TnQBMfQZVhJf8vwoGnfJyVRgxYMSADJXe6+/E4ouhnfFeOQD3BoMi4SN7/c/DPG7Jt5h
         uUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8M2es7HHouzmCUpyAYFqBmq/VXXAGiCHzbOor1SAZdY=;
        b=pFqBVz3uj6PAXk/mkLf/BWV8PvRZpsTVGheenWJ+xvxku0/AGrZ92fdDy930gmkwix
         Osm9CD+Q0D4v2Yo8gO+LGj+sx/gZgN7grL0ZCq8QXKzPn3mciBc60mRLgym5G7ARdFAG
         nv3JjJU7T4Nir/z++b8Slj2B5bY7w5rfoUW/jpiEndSTrcwU3n8Ni7G3tn7vBTfdA/Rc
         mXe2GxodgYzZss7vLTKv/pWx7jKGgMsB1t29UjapsovJGUA3OhRnjPPhW0lEz29VmCmo
         hywC9CDSKgWvf/WBvD3KwiJftwWWY8bMupfZCP09SRnoLq3ETXRSsiS/jDJ/S/Yb+hop
         nthQ==
X-Gm-Message-State: AOAM531OV2AS9dTdS5UhQMZfMHKBlfI62iqYpgBwfeVVeqTHeISsd6Y3
        NmFcyBa0lf83BHkLPDInxHOPqg==
X-Google-Smtp-Source: ABdhPJxMEwQ8RYMjAHEW54Z1j94xXKNRmix+I5953GVI4mfW5CH5zrllY5eazKO4pgPCsaIsWRN1NA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr86432689wrm.271.1594646979741;
        Mon, 13 Jul 2020 06:29:39 -0700 (PDT)
Received: from linux.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j14sm23896642wrs.75.2020.07.13.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:29:38 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/6] Add support of mt8183 APU
Date:   Mon, 13 Jul 2020 15:29:21 +0200
Message-Id: <20200713132927.24925-1-abailon@baylibre.com>
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

Notes:
This series include two workarounds:
- remoteproc: mtk_vpu_rproc: Don't try to load empty PT_LOAD segment
- rproc: mtk_apu: Don't try to use local APU RAM

The first one is required to load malformed firmwares.
This is probably caused by the toolchain we are using (a fork of gcc 4.2).
It would be better to fix the firmwares but I don't know how to fix it.

The second one prevents the CPU to access to the APU local RAM.
If the CPU tries to read or write the APU local RAM, then the CPU will
hang. I'm still looking for a solution, but until, we must prevent
remoteproc to write something (usually, to initialize data section).
Because of that issue, the current driver doesn't map the the local RAM.

Alexandre Bailon (6):
  dt bindings: remoteproc: Add bindings for MT8183 APU
  remoteproc: Add a remoteproc driver for the MT8183's APU
  remoteproc: mtk_vpu_rproc: Add support of JTAG
  remoteproc: mtk_vpu_rproc: Don't try to load empty PT_LOAD segment
  remoteproc: mtk_apu: Don't try to use the APU local RAM
  ARM64: mt8183: Add support of APU to mt8183

 .../bindings/remoteproc/mtk,apu.yaml          | 121 +++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  42 ++
 drivers/remoteproc/Kconfig                    |  19 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_apu_rproc.c            | 501 ++++++++++++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
 create mode 100644 drivers/remoteproc/mtk_apu_rproc.c

-- 
2.26.2

