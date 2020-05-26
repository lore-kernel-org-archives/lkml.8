Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2556AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD4A208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520252;
	bh=uRYjAfcBLCDplyNwEKjmFODt4UceFio/YeWgljBxLy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F2SKCjg9/1eHRvS/Pjxknz1bqrJUauyMh2KMB4OG7Sw98vOM4Dspmqbc18kAQxYD9
	 mPcJ4eUn6oBqjeE0+5AvR21+o7cmQyidAo4zxxqtqPuZqk2E/xdxvKqyYc/2a6zqew
	 hbRjcIeaFyO28oOJLyYI90SnSBk7qRQ8kpJHChxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391768AbgEZTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390891AbgEZTKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EA9208A7;
        Tue, 26 May 2020 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520244;
        bh=uRYjAfcBLCDplyNwEKjmFODt4UceFio/YeWgljBxLy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCJoYVeGR1snWkBBMYg2xi3/4Z8oweuxtrwATAeB1pYxETURmbRIRkuHvxCNJidNp
         7VIOIif0qNh1zwuRz9NkvSUOxxPi6yQr34nEuvRuKFXsRWaiLK9s2FHOvykm8lKELd
         4/d8drdKsEru+okSFyfuoQuZoEWoYKVFnYJEX6s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/111] powerpc/64s: Disable STRICT_KERNEL_RWX
Date:   Tue, 26 May 2020 20:53:35 +0200
Message-Id: <20200526183940.153290244@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 8659a0e0efdd975c73355dbc033f79ba3b31e82c ]

Several strange crashes have been eventually traced back to
STRICT_KERNEL_RWX and its interaction with code patching.

Various paths in our ftrace, kprobes and other patching code need to
be hardened against patching failures, otherwise we can end up running
with partially/incorrectly patched ftrace paths, kprobes or jump
labels, which can then cause strange crashes.

Although fixes for those are in development, they're not -rc material.

There also seem to be problems with the underlying strict RWX logic,
which needs further debugging.

So for now disable STRICT_KERNEL_RWX on 64-bit to prevent people from
enabling the option and tripping over the bugs.

Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200520133605.972649-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 198bbf42e398..3dc5aecdd853 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -133,7 +133,7 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
-	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
-- 
2.25.1



