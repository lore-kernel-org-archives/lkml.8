Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A872220637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700888;
	bh=eE876jpDjIIko1hMQjdb/Pa6jHh6hICzrR88/8tAfN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccYjnc6JGOrwjYgSaD2Q593AF7I8ugSRNDvPlcIM5sZSlFL1izk4zzw5giNEYQq8g
	 A4CwRHgBVe/RIkTFGRWMEjLsghwPb8vD+8No73C84vAF1iO56zsNgVAHQzxGxv/RS1
	 INieiEW+waxPPYVKe/msqHP4ZM8cwqfxcOXmgJpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbgBNRV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391360AbgBNQKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753252469D;
        Fri, 14 Feb 2020 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696621;
        bh=eE876jpDjIIko1hMQjdb/Pa6jHh6hICzrR88/8tAfN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjGYVtf64fpytZguAIK4J7CTEVe1STfmQAGXa2RJIkgJcBq7HtjAx6DJLbTFZF6tn
         T7Rkd2/9sMLsJ3x8orTN7upXWIxXemjhiTNye7BKVY9b9EWaCxc/NG1V/pqOe3370f
         eyIvzeTHbUzgEsd1sIPHzD2L0xE2ciHJF75ibCNY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 402/459] ARM: 8949/1: mm: mark free_memmap as __init
Date:   Fri, 14 Feb 2020 11:00:52 -0500
Message-Id: <20200214160149.11681-402-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

[ Upstream commit 31f3010e60522ede237fb145a63b4af5a41718c2 ]

As of commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly"), free_memmap() might not always be inlined, and thus is
triggering a section warning:

WARNING: vmlinux.o(.text.unlikely+0x904): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free()

Mark it as __init, since the faller (free_unused_memmap) already is.

Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b4be3baa83d4d..6f19ba53fd1f2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -323,7 +323,7 @@ static inline void poison_init_mem(void *s, size_t count)
 		*p++ = 0xe7fddef0;
 }
 
-static inline void
+static inline void __init
 free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;
-- 
2.20.1

