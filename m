Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC50206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DohzzhVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGZAef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14663C08C5C0;
        Sat, 25 Jul 2020 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HvKiUE8vKn1AjgQg21AJZBevWr9i4FwyWssJDygpqgk=; b=DohzzhVjFvngNE5D36jS2Q01fH
        Cphn2mPeELR3SE8/rN/fUP+TI36s5xbPo9P39XI5BwPk2KvAjoanVsZN5ZpGM9bqnviUS49TiLphg
        U4fFAd7EMCUCBeqmPR3MdiiL3cYwrPlVLJQDq8OubNmZDGdPsTtuLgo48l5AG+EmFx2BOKs7yS1Kz
        lozjmyJO9FfbGfT7cTxG60f6NRWHwTk4Z2vmSuz00eAS5AFNfOEX4MizHWrUPWDB0NOE5A+lelVN4
        vrTjuIdmTuVPNEL9a6H7RZ+/AjVc8nUbj8l/PtEr1CvgTPhRrlAGOePUAN7NFbeEIoQRdaIqiFdrz
        aJ6+SPGA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUca-000328-NA; Sun, 26 Jul 2020 00:34:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 0/6] mips: delete duplicated words
Date:   Sat, 25 Jul 2020 17:34:23 -0700
Message-Id: <20200726003429.20356-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicated words in arch/mips/ header files.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org

 arch/mips/include/asm/io.h              |    2 +-
 arch/mips/include/asm/octeon/cvmx-l2c.h |    2 +-
 arch/mips/include/asm/octeon/cvmx-pip.h |    2 +-
 arch/mips/include/asm/octeon/cvmx-pko.h |    7 +++----
 arch/mips/include/asm/octeon/cvmx-pow.h |    8 ++++----
 arch/mips/include/asm/octeon/octeon.h   |    2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)
