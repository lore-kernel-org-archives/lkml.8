Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D718021927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051993;
	bh=EXFUdSo/r/oSwfIUvXFfA30O8QdIYkWbR4l9z4yReIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7vnGW0xQ8BjF2B6vyY0vJXLi1C26JZxdiTyzeDQvY9EVyCmFPevjoi+SG7hUIrjv
	 6kdm8PYcuw5xlm/sxngB7CBg3dKSRlFbuRep6UuNUKSWN+2qvOu1oa4nSAmXZTZswu
	 JDUMUT0wcyNESlhFIvyuldHiaMhwGMK2WWfowcuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896262AbgDPPqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896930AbgDPNeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:34:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A661208E4;
        Thu, 16 Apr 2020 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044059;
        bh=EXFUdSo/r/oSwfIUvXFfA30O8QdIYkWbR4l9z4yReIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0HbVtnX36N1H3Z0Rgl8gm9Ai5kiNXk3m5cD69F6Ab+91RZCD8WCF4PYKUWSHN/3Cr
         +VZMXPaBR1D3HUFiAnWnf3VJVpgaQv9p2SmsEqf+j65UFnmPs4jR6ICMWX27SwyBGZ
         LNiabTawesapdw/iUfg31ZXW+Wltxlrsxzd0RTPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 063/257] x86/boot: Use unsigned comparison for addresses
Date:   Thu, 16 Apr 2020 15:21:54 +0200
Message-Id: <20200416131333.823115175@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit 81a34892c2c7c809f9c4e22c5ac936ae673fb9a2 ]

The load address is compared with LOAD_PHYSICAL_ADDR using a signed
comparison currently (using jge instruction).

When loading a 64-bit kernel using the new efi32_pe_entry() point added by:

  97aa276579b2 ("efi/x86: Add true mixed mode entry point into .compat section")

using Qemu with -m 3072, the firmware actually loads us above 2Gb,
resulting in a very early crash.

Use the JAE instruction to perform a unsigned comparison instead, as physical
addresses should be considered unsigned.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200301230436.2246909-6-nivedita@alum.mit.edu
Link: https://lore.kernel.org/r/20200308080859.21568-14-ardb@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d083ef2..777cf7d659cea 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -106,7 +106,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl    %eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ee60b81944a77..f5ee513f0195c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -106,7 +106,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
@@ -297,7 +297,7 @@ SYM_CODE_START(startup_64)
 	notq	%rax
 	andq	%rax, %rbp
 	cmpq	$LOAD_PHYSICAL_ADDR, %rbp
-	jge	1f
+	jae	1f
 #endif
 	movq	$LOAD_PHYSICAL_ADDR, %rbp
 1:
-- 
2.20.1



