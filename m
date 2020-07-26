Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF81C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CDC206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQMOv8Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGZAiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711CC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qqBNtVYmHwnVeQr7ZDJy/dH44DWLhllZ51Sz2gAU7es=; b=YQMOv8Zu+XZPp0H4UPX23P+w1W
        6jXeekNCNZvuNSyCTvmgci4RfuMCdzQgFYvbLFFfTsgKerBwQjS86UUFebquf5vb7jPe781jNY3X/
        LrcUAmpJzFLYgY0hGNWYCv+sbRTlVJBMW8ty4zQKzmBnxWOn6lHkV5fbpE4qI2vlpX9bR+pukLjgY
        lJW0aWfDfLPHC64xhuUFD+OQ5ID4iTIa7leqpMPQ1pvewyTpM7hoqaNxDrbRu3rEWNgZ6JFd2JWiI
        bhi33Pjt1ZU0VxN7OqSvnRgnZloLn47UW+LX1zV28p+09qR0UX+JES1YVn2sPJf0YC4wxrjXIeU9A
        RvFUCxXQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUg8-0003Cq-8T; Sun, 26 Jul 2020 00:38:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/9] powerpc: delete duplicated words
Date:   Sat, 25 Jul 2020 17:38:00 -0700
Message-Id: <20200726003809.20454-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words in arch/powerpc/ header files.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    2 +-
 arch/powerpc/include/asm/book3s/64/radix-4k.h |    2 +-
 arch/powerpc/include/asm/cputime.h            |    2 +-
 arch/powerpc/include/asm/epapr_hcalls.h       |    4 ++--
 arch/powerpc/include/asm/hw_breakpoint.h      |    2 +-
 arch/powerpc/include/asm/ppc_asm.h            |    2 +-
 arch/powerpc/include/asm/reg.h                |    2 +-
 arch/powerpc/include/asm/smu.h                |    2 +-
 arch/powerpc/platforms/powernv/pci.h          |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)
