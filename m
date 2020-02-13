Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20390C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB1320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609117;
	bh=MXUvtE+DyhgA9eVd8REk4gWhFUqUQf7jXGOjSh3qabQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZSE04lLNbA8kC4tZ8GsX/TWoZ+gZSTaXN3pb4asSkoOtAZzx/GQmoDe3VBYjDzEg
	 gNB8So0v2/aVTynssNBEUtL7L/Ry51HpTcUEHlCIUU4nXQBijW5MslhA473gvZ0pgd
	 pfykgk35tnv3iJLDCaBNZlPjB4mxI0vfLbNUWK6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgBMPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgBMP0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:09 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B33D206ED;
        Thu, 13 Feb 2020 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607569;
        bh=MXUvtE+DyhgA9eVd8REk4gWhFUqUQf7jXGOjSh3qabQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWRebF7eprKk180MKSp+o5vmyjhiFL8c7NgrBSn4AAJSdABSuvZgPoY1beo3RPSm0
         j6PgbjsmsRsp+/s0QSGlnEEXNUrR9lkz6wdaRsKL/uvQWmKTjV+i9PwkeWFLPam0T4
         LkbzFQmibSdLhJQdmfiVR2gZXUbtz45JoMCGsiUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 161/173] ARM: 8949/1: mm: mark free_memmap as __init
Date:   Thu, 13 Feb 2020 07:21:04 -0800
Message-Id: <20200213152011.837317599@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
@@ -356,7 +356,7 @@ static inline void poison_init_mem(void
 		*p++ = 0xe7fddef0;
 }
 
-static inline void
+static inline void __init
 free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;


