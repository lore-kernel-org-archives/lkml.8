Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42CC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4020735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549587;
	bh=8dKXULgc9tL7S6NUGH/SYxbtnWrHjv56lU3vacd03ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xABeElXjR+AXQDNoaohp+fPVbh4Bvp5o88ETUE6d6LaXXsbDKGeMsWZhpZf1RSWyU
	 LeQGXOXbyHbLitEIWgQr+h+8VToTPA4Lp+QGP6kM5AhVhiXN1WLl7mXq739PWwzrbI
	 lXv91r5bD9VclbJZDKVPwaoXfGkpXq341WH9QNxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDVJ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgDVJ7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:59:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B2620735;
        Wed, 22 Apr 2020 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549580;
        bh=8dKXULgc9tL7S6NUGH/SYxbtnWrHjv56lU3vacd03ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI+HdZ3gPGLRbtcvpqktt5uQRUj78yEBiLOgOMMTHAyq1ncRDs39qrEPjQp22bRQR
         IA/k29EW2bylYn/vRj1UqFBnOk72LXzmjMYycR3/AJt3FA4007raB5THJpk4cmK/mw
         EDaCp18r0ZlbL+qLOocsnLqqDrdn4OWUr0URac08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 009/100] x86/boot: Use unsigned comparison for addresses
Date:   Wed, 22 Apr 2020 11:55:39 +0200
Message-Id: <20200422095024.457026835@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
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
index 0256064da8da3..0eca7f2087b1f 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -170,7 +170,7 @@ preferred_addr:
 	notl	%eax
 	andl    %eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b831e24f7168b..ca8151ef3bfa0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -104,7 +104,7 @@ ENTRY(startup_32)
 	notl	%eax
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
@@ -337,7 +337,7 @@ preferred_addr:
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



