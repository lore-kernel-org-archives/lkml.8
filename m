Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF7FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFC5208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519702;
	bh=bPxqR0PLtI2XhTEKDMmR4d8gFqmhTzEniP59wxMePZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQnNDq3UwwXpXaDG7y+3bOitnd0SUJIYOuoPNvKPuNglG20VAn7cXWc0KVxPFIM2g
	 CJdUxLnw0mXxLSyLaT/6/+EZj13NHwmo6jbMP51xhLnK/GCwqB3vhT/lmRBMgaQeuI
	 zFye1oRvhLj+BJw3Xi/c5c9CG62wjuPZJc4/2tzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbgEZTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403766AbgEZTBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:01:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7F7208A7;
        Tue, 26 May 2020 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519693;
        bh=bPxqR0PLtI2XhTEKDMmR4d8gFqmhTzEniP59wxMePZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG4qyIP6FZepDFN7HTnmH4QHrOolPXobIPGE2MUZnfrX2HPkj/1Gzorf8DDPPFHyk
         /XDPzCK2aNDMK+0YB6h4ytbc7OwF3oXnhuffWFXbZB0J5PJ8Vr03igWGynTrrQZqik
         z6lEQ6F4oEOzZrvuhv5qBcmQe1rbOLFF+9/VB93k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/59] powerpc: Remove STRICT_KERNEL_RWX incompatibility with RELOCATABLE
Date:   Tue, 26 May 2020 20:53:25 +0200
Message-Id: <20200526183920.239637537@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

[ Upstream commit c55d7b5e64265fdca45c85b639013e770bde2d0e ]

I have tested this with the Radix MMU and everything seems to work, and
the previous patch for Hash seems to fix everything too.
STRICT_KERNEL_RWX should still be disabled by default for now.

Please test STRICT_KERNEL_RWX + RELOCATABLE!

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191224064126.183670-2-ruscur@russell.cc
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6b73ef2bba2e..b74c3a68c0ad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -141,7 +141,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
-	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
-- 
2.25.1



