Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E41C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31966214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="g4s5RV8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSMgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:02 -0400
X-Greylist: delayed 5273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Apr 2020 05:36:02 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F95C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 05:36:02 -0700 (PDT)
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A49755C0C22;
        Sun, 19 Apr 2020 14:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1587299759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ChrUSoSTAeUOQFZlAp8LZ3rHLQuXpNSZx/h/zMpdRro=;
        b=g4s5RV8FLX58fv8fjP+UnjELhSlF5AIBeSl091K9hGrZ5iR7b+dCZ2F8cOGUKzU8Xw6zXu
        eUMn3BOQw6Jc9UEK/72rjhh1GxYOQhKbTjbTw1AECYAVpq5Hn/4g8Rh8xSbxfxmllKLZtY
        pmJctlp8xIO3epChtNBZFSPl9Hl5vV8=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/3] ARM: make use of UAL VFP mnemonics when possible
Date:   Sun, 19 Apr 2020 14:35:48 +0200
Message-Id: <cover.1587299429.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To build the kernel with Clang's integrated assembler the VFP code needs
to make use of the unified assembler language (UAL) VFP mnemonics.

At first I tried to get rid of the co-processor instructions to access
the floating point unit along with the macros completely. However, due
to missing FPINST/FPINST2 argument support in older binutils versions we
have to keep them around. Once we drop support for binutils 2.24 and
older, the move to UAL VFP mnemonics will be straight forward with this
changes applied.

Tested using Clang with integrated assembler as well as external
(binutils assembler), various gcc/binutils version down to 4.7/2.23.
Disassembled and compared the object files in arch/arm/vfp/ to make
sure this changes leads to the same code. Besides different inlining
behavior I was not able to spot a difference.

In v2 the check for FPINST argument support is now made in Kconfig.

--
Stefan

Stefan Agner (3):
  ARM: use .fpu assembler directives instead of assembler arguments
  ARM: use VFP assembler mnemonics in register load/store macros
  ARM: use VFP assembler mnemonics if available

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.assembler       |  6 ++++++
 arch/arm/include/asm/vfp.h       |  2 ++
 arch/arm/include/asm/vfpmacros.h | 31 ++++++++++++++++++++++---------
 arch/arm/vfp/Makefile            |  2 --
 arch/arm/vfp/vfphw.S             | 31 ++++++++++++++++++++-----------
 arch/arm/vfp/vfpinstr.h          | 23 +++++++++++++++++++----
 7 files changed, 71 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/Kconfig.assembler

-- 
2.25.1

