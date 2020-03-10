Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FAFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1052071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845759;
	bh=g1x/xVNyebLXwtbW2f7iwqFin0hgFD9oiY9zOyQHEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ap1uACswxxo75ufnEpE+96T39bmYJh46N0WfiTC0UsT75FZoA8rfxvIgcw1p+9psX
	 Fh/IuJqS0ctSUq6p8iWkE6UxmZBnpZnW0who7lnyKBtyC1d2vJ5lQp8slYxq2ZCNfT
	 d3/Bphc13eOz10YpXxejvRgw6tcScEluK8siK05g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgCJNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbgCJNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:09:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE8D20409;
        Tue, 10 Mar 2020 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845754;
        bh=g1x/xVNyebLXwtbW2f7iwqFin0hgFD9oiY9zOyQHEoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjkB4rsnAPNNHUBoWi60TM3BmvYmoF8KrWz+iN0iGmGnrWzH2mW98wKXGBgKmEN9N
         NTznF0Zg5qwTBrTLPnr772aqn8xhD9CVDD5rVqOlOIRy54aSub4bfKNvoVoP5uvzyW
         5aKqd1OKmXxeHYPIguIbraWz09LYJJQYoWkKXBa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/126] x86/boot/compressed: Dont declare __force_order in kaslr_64.c
Date:   Tue, 10 Mar 2020 13:41:48 +0100
Message-Id: <20200310124209.391961646@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H.J. Lu <hjl.tools@gmail.com>

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
index e691ff734cb5a..46573842d8c3e 100644
--- a/arch/x86/boot/compressed/pagetable.c
+++ b/arch/x86/boot/compressed/pagetable.c
@@ -36,9 +36,6 @@
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



