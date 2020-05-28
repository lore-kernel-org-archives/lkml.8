Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD91C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F071B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aQvEiZuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404282AbgE1P2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:28:48 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:34564 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404080AbgE1P2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:28:45 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 17B9C20F0E;
        Thu, 28 May 2020 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590679723; bh=/Ixh27PBvMYRfXZQb8LgHMfG0KTPCk5wgWM8dpeEr7c=;
        h=From:To:Cc:Subject:Date:From;
        b=aQvEiZujSef6TU/HwlGHcOd4VU2sUCSplbXoDgeA38yzDsLwn4h6FSauBeLBNvCOF
         5bF5LSVqtJ7PIuIhPdxcTHi3mRpv25MTrjNnnosCV6AU0ExBCnl/dh1ub6LIvIY9nl
         vsgB9axrPiiPUYm/NF32ky7VWYL4S7Tdpx2mTy4DS8Ce2f4cUCbOJGMsa2iFiOTiah
         bEs7/gH+s64WzC6bUR9iChWSqoi5T11lwDdreTX0S22RTlcztGKfMTmmXlbr7fkJaW
         fPW15cxgcWP4G2Dwqgn0gb6u0j+V+hPPE8TmX01AsHzqpexque2lWtYmXk8OrdhHvE
         fEAPQiTLUohYg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 0/6] Three Loongson irqchip support
Date:   Thu, 28 May 2020 23:27:48 +0800
Message-Id: <20200528152757.1028711-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
  - Add some range checks in dt-schema

Jiaxun Yang (6):
  irqchip: Add Loongson HyperTransport Vector support
  dt-bindings: interrupt-controller: Add Loongson HTVEC
  irqchip: Add Loongson PCH PIC controller
  dt-bindings: interrupt-controller: Add Loongson PCH PIC
  irqchip: Add Loongson PCH MSI controller
  dt-bindings: interrupt-controller: Add Loongson PCH MSI

 .../interrupt-controller/loongson,htvec.yaml  |  57 ++++
 .../loongson,pch-msi.yaml                     |  62 +++++
 .../loongson,pch-pic.yaml                     |  56 ++++
 drivers/irqchip/Kconfig                       |  27 ++
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-loongson-htvec.c          | 214 +++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c        | 255 ++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-pic.c        | 243 +++++++++++++++++
 8 files changed, 917 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
 create mode 100644 drivers/irqchip/irq-loongson-htvec.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-msi.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-pic.c

-- 
2.27.0.rc0

