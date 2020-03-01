Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E98C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15521775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4Zf2t2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCAVUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:20:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39308 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCAVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:20:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id l7so4533834pff.6;
        Sun, 01 Mar 2020 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSE/dLT1/R1TdrIzig5uAH8kZs4aY53Q6FYuH0pUIUk=;
        b=s4Zf2t2MMt9IzcUlDUUfEqdmZpcN4tLZUAGpHUJ8zKnuw1EVVfQ/JHirIAIlRMDawn
         mMlMZpbX43B8oPQcTf2btArXgRnDiqq+DzJuv2xdZVpvgt6CiNwX9cMAxo0M6fMhSzqw
         VswjwJh0v9+r/QO+YVllvuLOTRrLMnv7gelQF7Jnz3POAYwTS+Lxr0/JSUuj9+pLEsvd
         OqPl/JewYqSoYQnnLR62c2/gNsY083N8DGDMLGBLKLCf4H0aoU05qDUaSc9puM60YrHg
         u574RD/o+Bvr7HayNpYrmG6x1BbHMGrkVcR8YuxySJSF9wb5dEBilqhpZd9jhEtILqul
         tGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSE/dLT1/R1TdrIzig5uAH8kZs4aY53Q6FYuH0pUIUk=;
        b=kSnqqRAxRrzJbl1p6ZJTDvABFDBfLgohcC6hHeJRs5lmRHBHHYX3gGvVLwY/W7CXqC
         q7amGyOXbt6eTDkAoBZhx4QayWiIIVu5WIhz3ZoDtRJ4E5DRcMJq/SL4vzQgMj+2oWL3
         nnn9Tr72xutEraIIMryGL3vgSjufDN6Ol/BAc59hlrz0WYDUu1+V/YSu77YZdgWu9AmE
         UKQDqZjSVEHco+wacBMuPCo9KJ/jLSmyNS+21lHT95RFgd3M5uXS5Q8HmcQMz+6spKvj
         ETot+6fWw5YXly3T+KfOWF4WopMdMvU1q/yL4ca+iTM76VSSND/EDSr3yjc420bcWFHQ
         I2nw==
X-Gm-Message-State: APjAAAVWNGPJehhyqlpstK3XEnFUsz1p4d4aJZ8vBPsagBJo62iVuFSu
        3OII1CFF5YhJ51XqolI7QgOc/XSE
X-Google-Smtp-Source: APXvYqym95seeMXORpjNvDAtUfGgiQZ4H2PTVGNx06uulZYbhJD58loKpNqvBWcfDllmtRSV3tT+kw==
X-Received: by 2002:a62:d408:: with SMTP id a8mr14201601pfh.99.1583097633454;
        Sun, 01 Mar 2020 13:20:33 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id u19sm4547686pgf.11.2020.03.01.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:20:32 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/3] Add support for suspend clk for Exynos5422 SoC
Date:   Sun,  1 Mar 2020 21:20:15 +0000
Message-Id: <20200301212019.2248-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seried build and tested on linux next-20200228.

This patch series tries to enable suspend clk using
exynos dwc3 driver, for this I have added new
compatible string "samsung,exynos5420-dwusb3"
so that we could add new suspend clk in addition
to the core clk. exynos dwc3 driver will help
enable/disable these clk.

This series PatchV2.
--Added the clk names for exynos5420 compatible.
--Added missing support for Exyno5410 SoC suspend clock.
--Update the commit message to support suspend clk usages.

---
Long time ago I tried to add suspend clk for dwc3 phy
which was wrong appoch, see below.

[0] https://lore.kernel.org/patchwork/patch/837635/
[1] https://lore.kernel.org/patchwork/patch/837636/

Previous changes V3 (It was send with wrong Patch version)
[2] https://patchwork.kernel.org/cover/11373043/

-Anand

Anand Moon (3):
  devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3
    clocks support
  ARM: dts: exynos: Add missing usbdrd3 suspend clk
  usb: dwc3: exynos: Add support for Exynos5422 suspend clk

 Documentation/devicetree/bindings/usb/exynos-usb.txt | 5 ++++-
 arch/arm/boot/dts/exynos5410.dtsi                    | 8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi                    | 8 ++++----
 arch/arm/boot/dts/exynos54xx.dtsi                    | 4 ++--
 drivers/usb/dwc3/dwc3-exynos.c                       | 9 +++++++++
 5 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.25.1

