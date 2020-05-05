Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEAC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71D0206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+wkAt1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgEEKBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbgEEKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:01:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 03:01:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so1593585wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LL5Exw/qifs+ywjXu90IVbYhDqBc3wJ0gzzOrYmWxA=;
        b=h+wkAt1i/yCYuX+qg1JC8lx8oQsta2OrisDGdBFuMTcvtQk/cQivwwqTaDR0pmR3DP
         39LFUa7BjHELU77lw1tHM5xu+whtgayMBcmmYv3pIh9k7md57hp0p93IVtvEWnIqdujM
         coqXsmWyzIIzwqGFLyxYVnKyb92OfpUSbyDGNjGexX6ymnJPeW7KUNHXsCB2YO6JPH/n
         ENOoE7YlGuM/vT5atE4/qKpekrQsvgrCqC2/4crQaO2O7W+OLjuQGfD5khlyDBk5OuuN
         2wuWE6Kfi+D2X9DZJQ9f8lJU8LiHMfPbQu6xwjW/piotoJSnupNpYhyAgkg7XEWc77L+
         ueSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LL5Exw/qifs+ywjXu90IVbYhDqBc3wJ0gzzOrYmWxA=;
        b=lp0jbzNPtiMJCnISyL6QR1hFVEH0R4kZ5FLvCDm4Lm2lPDKbvjGLYTeyjDAn78vuCw
         Ru4gspQ7smHbNdgObhG4UvukAd+70dnlDjuj095NRz74Avcpjqoi4zsAJQjw8msiad5n
         Ka1i0DU8PfImHJhhlA2R3cYdwbZif5rG4nspNJ8iv1wH9DgorwHqApOKZG76yc7P2N0o
         zF1NKPj1r8HSnsCAOcitcoAJQWxwZLO+6MVpuzjLUM35PwSCyhhCwzjIByZJY4wf7g44
         IYQ8x7h71oVLG/ZRdAiXs1pDSc2MEkZ/viaqLVMONsVanYN0g18C4t5Bq8ip9sYmwKrp
         FPPQ==
X-Gm-Message-State: AGi0PuYt5Qsw/libL8NF9y+50Bj/UIkzT8nAQF5er8OOwHsCkGxPL3l7
        /W/NacEdOPr3RhGsw5ZVdSxSyQ==
X-Google-Smtp-Source: APiQypJH4ypVMYFM9XMVWAInmVcCnVeQt1dycl0lYgZmTAGLLZ0z5kQZxnBsAutgmTA2Hwem48xMXg==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr2318452wmg.109.1588672904726;
        Tue, 05 May 2020 03:01:44 -0700 (PDT)
Received: from localhost.localdomain ([37.120.63.158])
        by smtp.gmail.com with ESMTPSA id n6sm2884258wmc.28.2020.05.05.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:01:44 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v7 0/3] media: ov8856: Add devicetree support
Date:   Tue,  5 May 2020 12:01:27 +0200
Message-Id: <20200505100129.104673-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds devicetree support to the ov8856 driver.
In order to to aid debugging and enable future sensor
modes to be supported, module revision detection is also added.


Dongchun Zhu (1):
  media: dt-bindings: ov8856: Document YAML bindings

Robert Foss (2):
  media: ov8856: Add devicetree support
  media: ov8856: Implement sensor module revision identification

 .../devicetree/bindings/media/i2c/ov8856.yaml | 142 +++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov8856.c                    | 190 ++++++++++++++++--
 3 files changed, 319 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml

-- 
2.25.1

