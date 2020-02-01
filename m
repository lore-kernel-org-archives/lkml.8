Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D7C33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA1320722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkaLZn8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgBAB73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 20:59:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBAB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u4zofrgpa+AjJJCnQZ3PeAHEog0fTuL8n8cEhgWl/pw=; b=jkaLZn8BOr8CQVXQ70qmBB94b
        GFnBxe1vmGv5VXzxwjUPK1tj2ZdDTklGTaoaKHGs+fOWcDzifGLboDlYH4Y9GzZ+ek1TOloxSFYsj
        qQgbR7tJvgXK0pwvk+JA/3BDilDPlmeh0kR4HN0cPzVtUgloqHWvcYApF2ehNAiXq2x7F/wh1ic82
        ooHLv6tyltTcksrgVtNjubpEWoKFMkNE/yBdYAcwTlyeoooVMtJxJ1aRmEkpjSTS/8k42uGjgxG7Y
        f+TZaipAsVTSBEYxKVsIL2cJUEHX01BTtxf9tDV+en8U2GrsiBrTJBxQluCKIddCrYY5Nswluw/qu
        va4iA/fng==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixi4F-0007ay-BV; Sat, 01 Feb 2020 01:59:27 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/xtensa: fix Kconfig typos for HAVE_SMP
Message-ID: <500b2132-ea3c-a385-1f37-05664de5f1dd@infradead.org>
Date:   Fri, 31 Jan 2020 17:59:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos in xtensa Kconfig help text for HAVE_SMP.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200131.orig/arch/xtensa/Kconfig
+++ linux-next-20200131/arch/xtensa/Kconfig
@@ -180,11 +180,11 @@ config HAVE_SMP
 	depends on XTENSA_VARIANT_CUSTOM
 	select XTENSA_MX
 	help
-	  This option is use to indicate that the system-on-a-chip (SOC)
+	  This option is used to indicate that the system-on-a-chip (SOC)
 	  supports Multiprocessing. Multiprocessor support implemented above
 	  the CPU core definition and currently needs to be selected manually.
 
-	  Multiprocessor support in implemented with external cache and
+	  Multiprocessor support is implemented with external cache and
 	  interrupt controllers.
 
 	  The MX interrupt distributer adds Interprocessor Interrupts

