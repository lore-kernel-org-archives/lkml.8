Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC00221D7B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVUgIyhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgIHIVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbgIHIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:21:01 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C72C061756;
        Tue,  8 Sep 2020 01:20:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q21so15125672edv.1;
        Tue, 08 Sep 2020 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63STSyHRLazmb7nSKR8rGI5k4M8WJtXmYGJdf9TDYBs=;
        b=aVUgIyhAUnxSTk/UkOHy70pKspSNsP/kxLtvkI+yxJaokuR5x8I+MaN9uUZFSp0y2a
         7P3rtQI1cTRnJ5X/u/Y81bLWpBFEr2EK9pttyGdLgsORjwv3RfirJb/Cop7jjHpQsY1v
         LgFKUVqy2K0gKEY9hgW4SYLeKmebb6F1/XUozoPvXZEN+BtdDadcPTqAhqV0Fn/Ca3wk
         TYUFsqRmRkGpgGaWOqHDkVmNHc9srWqRUvSFv2o7uhn0WmuSLvniwH8kg4bFDpk6C0Wt
         d+tFB/nURlYwOFMEIYYrdw9i+sAnP54LQ5TtyHcZ6ZLQD/2MetkzY3FAvXwgVm2zeAW/
         s6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63STSyHRLazmb7nSKR8rGI5k4M8WJtXmYGJdf9TDYBs=;
        b=RkiVcTmB01o/MyuxMjxPx4TrGyU6EwoqQSul3mbsEZUEDkv0sYaT1XkdHGUN25eRu0
         HHke41b/Ib9oKbvZps3zAd0PZzacoWj4MTZlCFdfiLrJ0KeAYfTrj8gJQzwD8bp7OsXU
         i+3/8veNdmr0O22LMLmWFGNzri3pTNYVY6Sr72N8j4ODyLNVYvnCL0SBkHntoYlFpeW3
         QgSNmU83QsalEAw2Ki0hOMMDtpIK5nUM6N4hD/pQhA50F8dvpxj/Sx2iWFkowup/twNz
         trD1Pl45GbtM8AV8nqjzycsgHz/pXVMVxP53b8h+r02+uFRKeivI5HLv4ICOGSLYeR0C
         iSsw==
X-Gm-Message-State: AOAM533aH4TyljsQpgLayCUUz0XoTOrGxkpBIIiYG35cHgC+772Nk16U
        cu5tNFOaHic8CK+Xj2be8eA=
X-Google-Smtp-Source: ABdhPJw1KTXm9rLt7JG8xTpbt4XCQYBwwTuJs1QMGPu103vrbGICvY6QbNyT8rr3CfqsY+Z57kS59Q==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr26634894edq.101.1599553253064;
        Tue, 08 Sep 2020 01:20:53 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g24sm13172326edy.51.2020.09.08.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:20:52 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v6 0/3] Add Actions Semi Owl family sirq support
Date:   Tue,  8 Sep 2020 11:20:47 +0300
Message-Id: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
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
https://lore.kernel.org/lkml/cover.1598621459.git.cristian.ciocaltea@gmail.com/

Additionally, I have taken the authorship for the driver patch,
considering the original code has been already modified to a great
extent and I'm firmly committed to maintaining it in the long run.

The SIRQ controller support is a prerequisite of the upcoming MFD
driver for the Actions Semi ATC260x PMICs.

Thanks and regards,
Cristi

Changes in v6:
- Integrated binding doc related feedback from Rob and Marc
- Updated cover letter to handle the authorship issue indicated by Mani
- Rebased patch series on v5.9-rc4

Changes in v5:
- Integrated Marc's review (more details in the driver patch changelog)
- Rebased patch series on v5.9-rc1

Changes in v4:
- Simplified the DTS structure:
  * dropped 'actions,sirq-shared-reg' node, now the differentiation
    between SoC variants is handled via the compatible property
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

 .../actions,owl-sirq.yaml                     |  65 ++++
 MAINTAINERS                                   |   2 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-owl-sirq.c                | 359 ++++++++++++++++++
 4 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.28.0

