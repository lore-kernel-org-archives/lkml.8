Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D790208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbgFSTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgFSTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:22:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B6EC06174E;
        Fri, 19 Jun 2020 12:22:13 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5FFFB23B;
        Fri, 19 Jun 2020 19:22:12 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:22:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: remove SH-5 index entries
Message-ID: <20200619132211.0d2b19db@lwn.net>
In-Reply-To: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
References: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 19:59:07 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Remove SH-5 documentation index entries following the removal
> of SH-5 source code.
> 
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
> 
> Fixes: 3b69e8b45711 ("Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: ysato@users.sourceforge.jp
> Cc: linux-sh@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  Documentation/sh/index.rst |   12 ------------
>  1 file changed, 12 deletions(-)

Applied, thanks.

jon
