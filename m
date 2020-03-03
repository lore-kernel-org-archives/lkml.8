Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E921C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50B246D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203873;
	bh=QtzMFVaHtxpE8ylLuoAKfAcoSpCasm32Oud+7bDT11U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=buJTM+GZH+7BxrXSGZNkJHEdJvK+cUzpq7tCGQna4y+zh/YQ5RvnNg8CLeqTAJRi9
	 G5VIDGM4H5SvI0GNuXqz4h98bGH6SjC0cq63mfVVlsiPOOiYU3kszGed0c55S6930+
	 /TGYf/B57sVBN0nsr+5dzPgo+7ztbG/8YjWgev8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgCCCud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgCCCuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4C7246E7;
        Tue,  3 Mar 2020 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203820;
        bh=QtzMFVaHtxpE8ylLuoAKfAcoSpCasm32Oud+7bDT11U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpD1c3BFZMOV983xHGRLbw6C/6TwMNUyylENhNLiUwZ8tSJSFBY/oxyw+DqISyuMy
         DKaN9OVH/JgHMcxMrt/0mSYLKy9Uvdbi3/TiKSJ6W3YUVaUT02k4dPeQe1l/XJxwkk
         xpvPKullfR3q3hTZEZSUhd45+9ns95zO56KTLrfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 13/13] x86/boot/compressed: Don't declare __force_order in kaslr_64.c
Date:   Mon,  2 Mar 2020 21:50:02 -0500
Message-Id: <20200303025002.10600-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303025002.10600-1-sashal@kernel.org>
References: <20200303025002.10600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

[ Upstream commit df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc ]

GCC 10 changed the default to -fno-common, which leads to

    LD      arch/x86/boot/compressed/vmlinux
  ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; \
    arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
  make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1

Since __force_order is already provided in pgtable_64.c, there is no
need to declare __force_order in kaslr_64.c.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200124181811.4780-1-hjl.tools@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/pagetable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/pagetable.c
index 56589d0a804b1..2591f8f6d45f2 100644
--- a/arch/x86/boot/compressed/pagetable.c
+++ b/arch/x86/boot/compressed/pagetable.c
@@ -25,9 +25,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-/* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
-
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
 	unsigned char *pgt_buf;
-- 
2.20.1

