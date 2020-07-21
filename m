Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF5C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA1920771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="oQeOhrgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGUORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:17:50 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:41508 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:17:50 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id D69401FEB4;
        Tue, 21 Jul 2020 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1595341069; bh=kZY9aXFLLPKIYt2v5Zp4tONNRS2gqJeu84+H6D3d+nk=;
        h=From:To:Cc:Subject:Date:From;
        b=oQeOhrgumRDdxyBFW4nB06zrxCJHXzA40LqVM3SzMK6C43cZTWFsZeYiyMVXPysPt
         vbFgAFrg6TaQtJ+2EFXkYIN8lAHFtKa800zc5JMz+bJrUNiYrrXGfvSmJpcLIEPEU1
         Cm0y+dua9qGOjJ7gO6qD2KyT+hfZPDyZFiyiSNVgpoVYccZK7okTFktfwIGrCybm/I
         hWMUhN8ZoKpg0bb4Lb2O83eUJYLit0cRxkVxvqHyd1vXFoAChJe2XWfqJVCu7DCJFE
         2AyBgzR29QnxaBPC9uusB1R5rwWKccCXR/w0pmZyNGbGeM00bEfRHCwUJ/Mtu+JlVO
         zbPgPy5iuqPrA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] MIPS: Loongson64: Process ISA Node in DeviceTree
Date:   Tue, 21 Jul 2020 22:17:28 +0800
Message-Id: <20200721141742.996350-1-jiaxun.yang@flygoat.com>
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

Jiaxun Yang (5):
  of_address: Add bus type match for pci ranges parser
  MIPS: Loongson64: Process ISA Node in DeviceTree
  MIPS: Loongson64: Enlarge IO_SPACE_LIMIT
  MIPS: Loongson64: DTS: Fix ISA range for RS780E PCH
  MIPS: Loongson64: Add ISA node for LS7A PCH

 arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |  7 ++
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  2 +-
 arch/mips/include/asm/io.h                    |  3 +-
 .../mips/include/asm/mach-loongson64/spaces.h |  3 +-
 arch/mips/loongson64/init.c                   | 88 +++++++++++++------
 drivers/of/address.c                          | 27 +++---
 include/linux/of_address.h                    |  5 ++
 7 files changed, 94 insertions(+), 41 deletions(-)

-- 
2.28.0.rc1

