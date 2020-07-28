Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB0C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B3F2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kUEIcXxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgG1PhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:37:16 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:42152 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgG1PhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:37:16 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 00F531FF08;
        Tue, 28 Jul 2020 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1595950636; bh=TzqPA5cK+YdXdB2JFRhq4i3Z0RERIdIF9jrXnm6aed8=;
        h=From:To:Cc:Subject:Date:From;
        b=kUEIcXxrJ5i51TFqKO0kQa6VI4uQsu63fDxvZB7Wo03whQwrQNy9IdD/xOa1p3JkD
         kCqQWFqGyXzVytA4zRqp69nZZkA2dwcvg0U2XYGwj9WMM7voSsIxIcY54AcPWgKO0z
         qIUF0X6ISWdMJX4CZazm6qtnnpx4lb+NeaMeOBmxNWOWr2d6St5loUQ/pP/Q4oWGZa
         ywXMDZoKQBWTzRSob46VZuiogAlC+4pLwudWff3fQFqG1uI2O7A7ePeNrCvZoA9okI
         RLiZ04h7Rb6lbVeweb2oaNLzao4hQ8fLn8ZADxXeELAv0ZadmEoDFXXSonT2tIwIlT
         OC23x2gNeB6PQ==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] MIPS: Loongson64: Process ISA Node in DeviceTree
Date:   Tue, 28 Jul 2020 23:36:54 +0800
Message-Id: <20200728153708.1296374-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series convert reservation of Loongson64 Logic PIO into DeviceTree based
method.

It can be used to replace Huacai's
"MIPS: Loongson64: Reserve legacy MMIO space according to bridge type".

Thanks.

v2:
  - Address Rob and Huacai's review comments.
v3:
  - Address Rob, Thomas's review comments.
v4:
  - Fix typo & grammar issue according to Xuerui's suggestion.

Jiaxun Yang (5):
  of_address: Add bus type match for pci ranges parser
  MIPS: Loongson64: Process ISA Node in DeviceTree
  MIPS: Loongson64: Enlarge IO_SPACE_LIMIT
  MIPS: Loongson64: DTS: Fix ISA and PCI I/O ranges for RS780E PCH
  MIPS: Loongson64: Add ISA node for LS7A PCH

 arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |  7 ++
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  4 +-
 arch/mips/include/asm/io.h                    |  2 -
 arch/mips/include/asm/mach-generic/spaces.h   |  4 +
 .../mips/include/asm/mach-loongson64/spaces.h |  3 +-
 arch/mips/loongson64/init.c                   | 87 +++++++++++++------
 drivers/of/address.c                          | 29 ++++---
 include/linux/of_address.h                    |  4 +
 8 files changed, 97 insertions(+), 43 deletions(-)

-- 
2.28.0.rc1

