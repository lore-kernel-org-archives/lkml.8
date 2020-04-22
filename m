Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA3C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D11F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aBFA8jqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDVO0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:26:15 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:59258 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgDVO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:26:15 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id A7F4B20CD7;
        Wed, 22 Apr 2020 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587565563; bh=yzj3obMtgh8EsESdciGUOI+o2hcpe8mFlM3owBlPDbc=;
        h=From:To:Cc:Subject:Date:From;
        b=aBFA8jqB6F1yCUeQ5WILR6IdVp461Blt/Ilbt/Kw7E5zm1thEzKvXwMHs5Rrdmjpf
         EKUTj2xxa2kFtfIZ7eVMktvv92vMXv2aXCJzC1FM7GjSMxp0QoDgmKsn3MxEoXD6O1
         HlABW/gCmm4sqRom52dfvjNoKIa/BOgF9EqNkYo34YZygRFf1YIuZ6z3lpguDNWiDf
         918pgBEweCrvnboY4Fk3O1t6ddslj+WE7Cvn05kCXK4TNmC0Hga9JIq3aprbRA+tRe
         EEphAs8trrnx5brWYrikldA6sMVC0NjKBaAlx2w+bo2HHWeS8VkWUoDs0NRkIXQJr6
         18AdUt4f2T85w==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org, maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/6] Loongson PCH IRQ Support
Date:   Wed, 22 Apr 2020 22:24:20 +0800
Message-Id: <20200422142428.1249684-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly added IRQ support for Loongson-7A1000 PCH.
DeviceTree will be added later as PCI support is also pending
for reviewing.

Jiaxun Yang (6):
  irqchip: Add Loongson HyperTransport Vector support
  dt-bindings: interrupt-controller: Add Loongson HTVEC
  irqchip: Add Loongson PCH PIC controller
  dt-bindings: interrupt-controller: Add Loongson PCH PIC
  irqchip: Add Loongson PCH MSI controller
  dt-bindings: interrupt-controller: Add Loongson PCH MSI

 .../interrupt-controller/loongson,htvec.yaml  |  59 ++++
 .../loongson,pch-msi.yaml                     |  56 ++++
 .../loongson,pch-pic.yaml                     |  55 ++++
 drivers/irqchip/Kconfig                       |  26 ++
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-loongson-htvec.c          | 217 ++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c        | 265 ++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-pic.c        | 256 +++++++++++++++++
 8 files changed, 937 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
 create mode 100644 drivers/irqchip/irq-loongson-htvec.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-msi.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-pic.c

-- 
2.26.0.rc2

