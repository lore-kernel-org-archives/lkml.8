Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3185C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB10520708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcqgIT8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgHPLiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgHPLe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:34:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B6C061388;
        Sun, 16 Aug 2020 04:34:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so10123282eds.2;
        Sun, 16 Aug 2020 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xlb2qUCwKe4EF2PdUWQAuMEesAap269IMj+EUyQHrhw=;
        b=WcqgIT8CuBXJOgYH0CDo9fZeXs5yfYVpiQpyz9mtfnlyE9GF0dEyyx+W1HELiJW0mH
         o24rLo9hf2fkIJxclgaf9Ky9rPRO9DoNDdJ3huBU3hV7BkLvQldXDvVy8oEIuoRccxNC
         r2ZyqgkMG3avvD4v7ya5wLKIFnPAFf520a0Lcu/8K3VK9Fw+Yws/lJ1lG0JIqnIvIRUX
         DSKLNHNFlaKcnHUGPE1MppJXuygcty15vwgx+Rfd5u/cI4MyziENegTkEurZzw+eX9C1
         jchStWEz358QXPa4R7ryihNVAIDfImjySy1IhRqTIHJ6i9cpTj0MpdhCbIePKcPVxphP
         e28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xlb2qUCwKe4EF2PdUWQAuMEesAap269IMj+EUyQHrhw=;
        b=D5rvEiUDYJau4MofiALIObiucMwX4jQ1esIyufNiHzV7m6xZGJU2Psx+pKZ1TfCRm6
         V0mmg4WxYwsbJ+qk3BnhXTbveo7jfDEfDJ6YUPnOICgBi2YfYpq5TVPexq+uderUvFxp
         l447aaXPkPGTqu1fawonjKBD2BmqEVn7d70IBIjulTqetMWaEA2N0V5MenKo43sRZcVO
         V9KNt1eOQNhDnuhQO3LJnU5Kys/8x42nJQn/0bIORPX2mHm4dO0+e1VAoZR3swpGNKtk
         3ndQOQT/yFXFHIwyKZ42MhvjZFqncXIjRW/sYjt1tIy1QNl3e9ZxfN+cfRmMjWUJezpv
         Y3bA==
X-Gm-Message-State: AOAM531cSULuaMCspYjZKIoUuRitS1seB/CLB+Ie27yA/iTVQOwy5YrB
        jYykJVSZ4rSKJojKCoctqac=
X-Google-Smtp-Source: ABdhPJz0ASv6aS4Q1vBhNQA5a64FC1jxRLAGQY0I15yYZvr3Y+/9ieznHix6dQsyT+xkFkWNa2Y32A==
X-Received: by 2002:a50:dac6:: with SMTP id s6mr10458760edj.378.1597577639278;
        Sun, 16 Aug 2020 04:33:59 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id p1sm11272945edu.11.2020.08.16.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 04:33:58 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 0/3] Add Actions Semi Owl family sirq support
Date:   Sun, 16 Aug 2020 14:33:53 +0300
Message-Id: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the external interrupt controller
(SIRQ) found in Actions Semi Owl famil of SoC's (S500, S700 and S900).
The controller allows connecting up to 3 external interrupt controllers
through dedicated SIRQ pins.

This is a rework of the patch series submitted some time ago by 
Parthiban Nallathambi: 
https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/

Please note I have dropped, for the moment, the S700 related patches 
since I do not own a compatible hardware for testing. I'm using, 
instead, an S500 SoC based board for which I have already provided an
initial support:
https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

The SIRQ controller support is a prerequisite of the soon to be
submitted MFD driver for the Actions Semi ATC260x PMICs.

Thanks and regards,
Cristi

Changes in v4:
- Simplified the DTS structure:
  * dropped 'actions,sirq-shared-reg' node, now the differentiation
    between SoC variants is handled now via the compatible property
  * dropped 'actions,sirq-reg-offset', now controller base address in
    DTS points to SIRQ0 register, so no additional information is 
	required for S500 and S700, while for S900 SoC the offsets of SIRQ1
	and SIRQ2 regs are provided by the driver
  * 'actions,ext-irq-range' was replaced with 'actions,ext-interrupts',
    an array of the GIC interrupts triggered by the controller
- Fixed wrong INTC_EXTCTL_TYPE_MASK definition
- Removed redundant irq_fwspec checks in owl_sirq_domain_alloc()
- Improved error handling in owl_sirq_of_init()
- Added yaml binding document
- Dropped S700 related DTS patches for lack of testing hardware:
  * arm64: dts: actions: Add sirq node for Actions Semi S700
  * arm64: dts: actions: s700-cubieboard7: Enable SIRQ
- Updated MAINTAINERS
- Rebased patchset on kernel v5.8
- Cosmetic changes
 * Ordered include statements alphabetically
 * Added comment to owl_sirq_set_type() describing conversion of falling
   edge or active low signals
 * Replaced IRQF_TRIGGER_* with corresponding IRQ_TYPE_* variants
 * Ensured data types and function naming are consistent regarding the
   'owl_sirq' prefix

Changes in v3 (Parthiban Nallathambi):
- Set default operating frequency to 24MHz
- Falling edge and Low Level interrupts translated to rising edge and high level
- Introduced common function with lock handling for register read and write
- Used direct GIC interrupt number for interrupt local hwirq and finding offset
using DT entry (range) when registers are shared 
- Changed irq_ack to irq_eoi
- Added translation method for irq_domain_ops
- Clearing interrupt pending based on bitmask for edge triggered
- Added pinctrl definition for sirq for cubieboard7. This depends on,
https://lore.kernel.org/patchwork/patch/1012859/

Changes in v2 (Parthiban Nallathambi):
- Added SIRQ as hierarchical chip
        GIC <----> SIRQ <----> External interrupt controller/Child devices
- Device binding updates with vendor prefix
- Register sharing handled globally and common init sequence/data for all
actions SoC family

Cristian Ciocaltea (3):
  dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
  irqchip: Add Actions Semi Owl SIRQ controller
  MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller

 .../actions,owl-sirq.yaml                     |  69 ++++
 MAINTAINERS                                   |   2 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-owl-sirq.c                | 318 ++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.28.0

