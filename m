Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A94620758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skok8w30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHQKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgHQKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04958C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 189so7292995pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6l78lXwR/yjlw8bo2gFOnw4SGZQb3C/vx4zGLauS1as=;
        b=skok8w30JX83F/n0CTjywpZkjOauFx8e98U3T7xkSpAcx2wxT90ofOzO80ro0566IG
         BKWfbDesOgk8d3hUECshOfwo4bG0AsItZi7foV3vbE8wc8MbGopUvz0gTi2UVG90o7f2
         S0fnXrUgHt/LBmvl33phs5qfPVkaUViRiMo1L3NGyalsmL2POsEvDFjuwJRVBR/3z8hm
         1/wLPnHVnbMQ8Yn/4/7WsKdsEjR9o7vhFA2S72++Ff+4IQ3+vgw/vOw+jdWEGiAGm49W
         aJK/xR3ReEVeUET3G8W8Uj8E7L4Kjt7u5ehTWzZXgyRTlBHgl8MBLibjN1ZdXq07TItn
         tPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6l78lXwR/yjlw8bo2gFOnw4SGZQb3C/vx4zGLauS1as=;
        b=F1eeZYjdI27kLp4RhSyW5IRjr1OXAKKjhaeZWhm1GWVJuH10R1dzIWEcYtMUN6L+DI
         Qap+KbaVEc6Y2zoslyvxC+Ekxfs7GnW1r2VKQaPEbu58Hs0DYXFVcWmx4KyIWZSYC4Vg
         pwAsC7zkIliLkv2mkucyufTvuO3eoX5c16q2kCZUhdvwyHzLc4IbFGXWJzDc6tXAKTgX
         gvbWOpuihW0z8UJwkUTBpTHTuPH3+VUw0pASc4tmu3WCmoY9wV+Rpc4Dd7zA+tEAMg6x
         fFciQJnoTLZzOv06N92geqjot4nMzvEvqbCIH30ZMoEOwZilucQhpqsFPO21jAcHgJZw
         Ursg==
X-Gm-Message-State: AOAM530vOOH7X+d/YOsvvp18XJHiQHCUFXwaQVnwCEHGyc58vUZx6PvQ
        nNrSHYpu8AUyHfof1yPatiw=
X-Google-Smtp-Source: ABdhPJxEwBbdlU1Kyyt1rmPfqNt8TJgGT5wdmGswAeFJAmpELOGqZ+rxlTl/nd+KcDgI4ZEdf6t1/A==
X-Received: by 2002:a62:7853:: with SMTP id t80mr10868286pfc.47.1597661319769;
        Mon, 17 Aug 2020 03:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:48:39 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 0/9] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Mon, 17 Aug 2020 18:47:48 +0800
Message-Id: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series merge different sub-device I2C read/write into one Regmap and
fix coding style for well-organized.

Gene Chen (9)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge different sub-devices I2C read/write

 b/drivers/mfd/Kconfig       |    1 
 b/drivers/mfd/mt6360-core.c |  550 +++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h  |  240 -------------------
 3 files changed, 368 insertions(+), 423 deletions(-)

changelogs between v2 & v3
- Replace mt6360_data to mt6360_ddata
- Split I2C read/write to regmap driver

changelogs between v3 & v4
- Merge back mt6360 regmap driver to MFD driver

