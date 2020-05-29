Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F102C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D396A2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4P4ruJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgE2VnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2VnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:43:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC64C03E969;
        Fri, 29 May 2020 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ab0jxe5bKfD6GeppZDuw9sanZscYluyoJpWAvdwL/58=; b=d4P4ruJRpLWAL0MspqbSMdzM8I
        tAsESb42E1U9/qjhOEjigWYVWRpcKBvYorWBk7mV1bYIcUZKA5sqhbuub5Gp3yUVDfr/5fFVIcmtu
        Z7Ly/Qmw+uO9ikXoyshym3uYqJGLzZyBoPfRn13o5gscy6icosqPjUI+1EHzHf4HUxSUZwyrixHss
        CcJFm4KWMulHj3r7yOYgqP6avq+wxV1brjkpkdFJVNCy91krGWanAcS0HbVtXOOmcY/4iptY1Yz5T
        j1JUN5TY2Ona/hLe9hzLTQdI7lRVE/IJXRLqSwbl5xGiuzf1h+bEH76qZDDlOzHroxEOOPcoMfPps
        2Jx/NMqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemmK-0006Hp-09; Fri, 29 May 2020 21:43:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2305D301A80;
        Fri, 29 May 2020 23:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D51FE2B9B1BC6; Fri, 29 May 2020 23:42:57 +0200 (CEST)
Message-ID: <20200529214203.786639120@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:35:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 3/5] s390: Break cyclic percpu include
References: <20200529213550.683440625@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/smp.h         |    1 +
 arch/s390/include/asm/thread_info.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -10,6 +10,7 @@
 
 #include <asm/sigp.h>
 #include <asm/lowcore.h>
+#include <asm/processor.h>
 
 #define raw_smp_processor_id()	(S390_lowcore.cpu_nr)
 
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 #include <asm/lowcore.h>
 #include <asm/page.h>
-#include <asm/processor.h>
 
 #define STACK_INIT_OFFSET \
 	(THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs))


