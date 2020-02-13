Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC320661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608932;
	bh=Phxh66VPzy23PBDwqX9uiCzs6TZITtcNUJ+P67F1EEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q6FjMxbkzwS9F25iwA2Bzvt9LcWAIo9V7mFSq9SexEW6ynIyD6oDmgBNGQx4nSm3b
	 Tc1+i/E/QQ40FuJ2d3TR0whJ2LpNpzEDKFyANag7D0iPWnJMOo36u4UZoOi2/Fhn2z
	 xiglkNnBjNqUQ7oF4kFVQzBotMqgsVhv1tOoPgj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgBMPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgBMP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0572465D;
        Thu, 13 Feb 2020 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607609;
        bh=Phxh66VPzy23PBDwqX9uiCzs6TZITtcNUJ+P67F1EEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVdt2WC9J8u8c6dn8D8sLiGZPJFWQAmPL3eLZZtQcmGQ7Jxjp2iwpWtQVg6WhZ2p/
         fjYgA0PB9SzIe/Ngth5DK4iKPo/JECqLrklPX9PKi5DpUW3bvOWMmYvFQOM5PNRIQc
         ND3q+qBN8C+Eo1NvUBO2prSsenE5Wji5eHFlpumo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.19 33/52] ARM: 8949/1: mm: mark free_memmap as __init
Date:   Thu, 13 Feb 2020 07:21:14 -0800
Message-Id: <20200213151823.739419113@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

commit 31f3010e60522ede237fb145a63b4af5a41718c2 upstream.

As of commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly"), free_memmap() might not always be inlined, and thus is
triggering a section warning:

WARNING: vmlinux.o(.text.unlikely+0x904): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free()

Mark it as __init, since the faller (free_unused_memmap) already is.

Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -357,7 +357,7 @@ static inline void poison_init_mem(void
 		*p++ = 0xe7fddef0;
 }
 
-static inline void
+static inline void __init
 free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;


