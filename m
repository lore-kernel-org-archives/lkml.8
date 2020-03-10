Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58BE21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="myQMTVO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCJWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:01:27 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43964 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:01:27 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1E5BF5C2157;
        Tue, 10 Mar 2020 23:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1583877685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=y9mUQ47Qx5sWxU4e4s/o/28BEccjHtCQBjF8z/UpJQA=;
        b=myQMTVO9iLbwC69i6CgS14cavDxa3wRcSvyTw2x8TEZPdhyjXpSUnaXFceu7NNWcTEBJs7
        pf3ixShGDXOIbwMQnyWr7xcXSEVSoDaqlJ2gtLApsaVmOJeP5lNv9Be6mTxMbr/3J64CTC
        24wOk8GGmKBHVICv329Ipn1ASCGvVNw=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/3] ARM: make use of UAL VFP mnemonics when possible
Date:   Tue, 10 Mar 2020 23:01:18 +0100
Message-Id: <cover.1583360296.git.stefan@agner.ch>
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

This replaces (and extends) my earlier patch "ARM: use assembly mnemonics
for VFP register access"
http://lore.kernel.org/r/8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch

--
Stefan

Stefan Agner (3):
  ARM: use .fpu assembler directives instead of assembler arguments
  ARM: use VFP assembler mnemonics in register load/store macros
  ARM: use VFP assembler mnemonics if available

 arch/arm/include/asm/vfp.h       |  2 ++
 arch/arm/include/asm/vfpmacros.h | 31 ++++++++++++++++++++++---------
 arch/arm/vfp/Makefile            |  5 ++++-
 arch/arm/vfp/vfphw.S             | 31 ++++++++++++++++++++-----------
 arch/arm/vfp/vfpinstr.h          | 23 +++++++++++++++++++----
 5 files changed, 67 insertions(+), 25 deletions(-)

-- 
2.25.1

