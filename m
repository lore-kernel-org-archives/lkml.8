Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2952073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608370;
	bh=V+PE1rRJttWwgfRiEoKsub1Yes6FAf870CGA2laaGo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+7+DV7bXER+BZWbYGDtqvgzbPFqIVQwxWWGG7axJ0CTOBh3crSdolaR3gy7oPYy6
	 SOl8w2QyFNKCGcTzLcA7f2gV6lvlFAaIP/6mnQTPmPc6MMrlsJmJ5Tna6u/FFEpfZ8
	 IrBSnnqnwHbwvbTkVW+mh6jRp6s5Ab1Qk+YVP+j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBMPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbgBMP3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:02 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0DF24670;
        Thu, 13 Feb 2020 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607741;
        bh=V+PE1rRJttWwgfRiEoKsub1Yes6FAf870CGA2laaGo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FD11zuIN5wRSE1x0Mxi0G+S7aaf8s8aKHzyKcUUOY8hD3upTbmFa0DFfUgIt82q0f
         fRL1e4gdzPSkDqBnV9A8R1VQOgcQazBpacjFxvsslztb5sSugp/FB/r0F3ZjS0UfiV
         bQDmsJ8Kd1f732pGIHjRis2lAJDs7i6xjWAbM2Qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 5.5 078/120] ARM: 8949/1: mm: mark free_memmap as __init
Date:   Thu, 13 Feb 2020 07:21:14 -0800
Message-Id: <20200213151927.729883313@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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
@@ -324,7 +324,7 @@ static inline void poison_init_mem(void
 		*p++ = 0xe7fddef0;
 }
 
-static inline void
+static inline void __init
 free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;


