Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A81EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6408020888
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZPlaQmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHSQiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:38:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8ECC061757;
        Wed, 19 Aug 2020 09:38:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so27105451ejx.6;
        Wed, 19 Aug 2020 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aNI7vXPweXU0xeLfQMTOUq4C8U6Hd6f9EUV+FsNfGY=;
        b=QZPlaQmYiTEEzpLW9J3XqSpHGGdCCg9D+RTfmhlMqd1d3ItkuAoHjyBAW58uBEasHt
         6MjLmIVo+bDsM2nmle61oFsL/z/rkN74k8usw+kSQxMQSJJnjPkBbI5Ag4yluIlp2w8B
         28q5UoemgDJkHRyEQ5pBnXHH9GAodjXXY2/9cFCSn30/cXZh2bTZGjVXBqagrUPiNZuM
         kbnuB4L2g1EuSjkEqHkDOmVT61mJQlDKPSSDhPhdMT158zFZk7R9b/Nt6fPPF+Y2WDz5
         y8b2BzkhPEJLP5nrYofR/8zE/JdohiBSIgzzYkuBFJkjV8trhd7gS6Oud9b6oxJY0w5b
         04iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aNI7vXPweXU0xeLfQMTOUq4C8U6Hd6f9EUV+FsNfGY=;
        b=hVX0UJ/qtonTUqGsPgPt3AMww/3MX3SAGMXmrybHvd3bnH7FzyqEfLTFQDCMvMaFom
         GzScyM/4mnHSsr/1Cu0J4SX5J1AP5aiQ4aiOol47ngOkv7yGACuQ7N/T4R8nIzSgZixf
         thtZ+0CIsGJUwIo7WyA3QfkdCw5jlUjhUkNqm5Ju5Cvv6SettpBCHdF/ht4wNh+kn5va
         D8v1nfbYgCElJtQt1kAcDiOMNOeJWisd5sxhck9mvthgGclHN7hdo/FTZ8fuD14+qn9u
         RO0IuHGbZ4uW3jZd+efs0xYf/R7amO0SAPfutDe386plEuON+0i8KFjOHOsZ0aG5LyyH
         aF7w==
X-Gm-Message-State: AOAM531bbCkvreZ1Y13aBq2MY5vgGnSmeHGNt9PbBtP0IMg4ejBcU0Jh
        peir5BW5M0TB63oKd6rvaDQ=
X-Google-Smtp-Source: ABdhPJyAR7gVU7w4pXzDT/4F9iydlbvDGAB7vWGxTGgBHRB16SLjUEKppg4RCjmYi1nRsq0dSerjfg==
X-Received: by 2002:a17:906:6801:: with SMTP id k1mr26149858ejr.492.1597855080803;
        Wed, 19 Aug 2020 09:38:00 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id m13sm18310774edi.89.2020.08.19.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:38:00 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add Actions Semi Owl family sirq support
Date:   Wed, 19 Aug 2020 19:37:55 +0300
Message-Id: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the external interrupt controller
(SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700 and
S900). The controller handles up to 3 external interrupt lines through
dedicated SIRQ pins.

This is a rework of the patch series submitted some time ago by 
Parthiban Nallathambi: 
https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/

Please note I have dropped, for the moment, the S700 related patches 
since I do not own a compatible hardware for testing. I'm using instead
an S500 SoC based board for which I have already provided the initial
support:
https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

The SIRQ controller support is a prerequisite of the soon to be submitted
MFD driver for the Actions Semi ATC260x PMICs.

Thanks and regards,
Cristi

Changes in v5:
- Integrated Marc's review (more details in the driver patch changelog)
- Rebased patch series on v5.9-rc1

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

 .../actions,owl-sirq.yaml                     |  68 ++++
 MAINTAINERS                                   |   2 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-owl-sirq.c                | 347 ++++++++++++++++++
 4 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.28.0

