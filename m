Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA364C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9543220B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sipHPhUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgFZV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgFZV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:26:36 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F3C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:26:36 -0700 (PDT)
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9165A5C0678;
        Fri, 26 Jun 2020 23:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1593206793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=BliWbyHUANX2JI8zF8nLMmP2MWt1fyzsPb8MhtX5XuI=;
        b=sipHPhUV8+3lkIgsDOcn1yjFoI/OI6Wq3d3g+xC+T09FCYzYp6yyk6eLfqFCkwwqd7FXMU
        tD+6GNxBuhOhegup5OlUpgJAbX31uVpzJ5EQD+4boDmw9i8AfDqe9e+JU0Dc6GmQG7V05d
        3BkkSMKHc0ACp0Au92vQCTXFTmtjnjk=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 0/3] ARM: make use of UAL VFP mnemonics when possible
Date:   Fri, 26 Jun 2020 23:26:10 +0200
Message-Id: <cover.1593205699.git.stefan@agner.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To build the kernel with the integrated assembler of Clang 10 and earlier
the VFP code needs to make use of the unified assembler language (UAL)
VFP mnemonics.

As pointed out by Russell, even for ARMv7 blocking VFP access through
MCR/MRC is not correct. This has been addressed in upstream Clang and
VFP access will be possible through MCR/MRC (see [0]).

At first I tried to replace all co-processor instructions to access the
floating point unit along with the macros. However, due to missing
FPINST/FPINST2 argument support in older binutils versions we have to
keep them around. Once we drop support for binutils 2.24 and older, the
move to UAL VFP mnemonics will be straight forward with this changes
applied.

Tested using Clang with integrated assembler as well as external
(binutils assembler), various gcc/binutils version down to 4.7/2.23.
Disassembled and compared the object files in arch/arm/vfp/ to make
sure this changes leads to the same code. Besides different inlining
behavior I was not able to spot a difference.

In v2 the check for FPINST argument support is now made in Kconfig.

In v3 reworded commit message and addressed review feedback in patch 1.

--
Stefan

[0] https://reviews.llvm.org/D59733

Stefan Agner (3):
  ARM: use .fpu assembler directives instead of assembler arguments
  ARM: use VFP assembler mnemonics in register load/store macros
  ARM: use VFP assembler mnemonics if available

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.assembler       |  6 ++++++
 arch/arm/include/asm/vfp.h       |  2 ++
 arch/arm/include/asm/vfpmacros.h | 31 ++++++++++++++++++++++---------
 arch/arm/vfp/Makefile            |  2 --
 arch/arm/vfp/vfphw.S             | 31 +++++++++++++++++++++----------
 arch/arm/vfp/vfpinstr.h          | 23 +++++++++++++++++++----
 7 files changed, 72 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/Kconfig.assembler

-- 
2.27.0

