Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3EEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D5320747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdrmcYg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgFOC7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFOC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:59:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20546C061A0E;
        Sun, 14 Jun 2020 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zMs2S73ZRwT7pTwkzGE7eHsG3b9G7ZiyeRv99uoKbqo=; b=QdrmcYg2iPlcqcJ+My5P2SyN3W
        pf3VQaZGyauCZG93aJj/9cmG2CPzppRgiG8Jl0I8LIa7jfWiex2YgRPLjeFF2VYOMB+E3VQRtXKxd
        mL7p+XJ6ReWiR42Bh2GVQyN1pXMwBzclSstfKpyRh3D6HXm+NrlJZwIcit9xPmVazKs3nv8KQ2zIN
        XozM/5Y8qjT47ElTAkBRgLJz0Kn00W6WUJludlFKHRcd82I0xI7zU/pL1SW/RfP6Q+QoID3XB3OYw
        jTl80VCBAsh0rL1oTajQYn8jkYMb7SfVZmGgY2T9kF4E1qtMvnBLjc/sP7U4IfAnHQmXSxEPwd0m1
        YhpIjAvA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkfL2-0002YI-M8; Mon, 15 Jun 2020 02:59:08 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: remove SH-5 index entries
Message-ID: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
Date:   Sun, 14 Jun 2020 19:59:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Remove SH-5 documentation index entries following the removal
of SH-5 source code.

Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
Error: Cannot open file ../arch/sh/include/asm/tlb_64.h

Fixes: 3b69e8b45711 ("Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: ysato@users.sourceforge.jp
Cc: linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 Documentation/sh/index.rst |   12 ------------
 1 file changed, 12 deletions(-)

--- lnx-58-rc1.orig/Documentation/sh/index.rst
+++ lnx-58-rc1/Documentation/sh/index.rst
@@ -16,18 +16,6 @@ Store Queue API
 .. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
    :export:
 
-SH-5
-----
-
-TLB Interfaces
-~~~~~~~~~~~~~~
-
-.. kernel-doc:: arch/sh/mm/tlb-sh5.c
-   :internal:
-
-.. kernel-doc:: arch/sh/include/asm/tlb_64.h
-   :internal:
-
 Machine Specific Interfaces
 ===========================
 

