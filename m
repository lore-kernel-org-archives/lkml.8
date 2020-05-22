Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF12C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8225204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17Hsyi8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgEVUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgEVUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k3Mbxlp1+H5DgdG9uWBmILKu8uyCSkCfmikx/X5pBLQ=; b=17Hsyi8C22Bv0zQjJr5xM4LQ/2
        1LrFEIrygSAqD4UFTK3A92iJD/aWA5GVjzPhlyJT3Z1E+j5v04ywDU/bbHVc4gdXx1neJO8fVBkt/
        Sv5xjl47Ts/wAhYqTlSrMaz2Db5smjYFsjuv8enq/JbnwAa4JupoXohbhjjLj7ecCZTVMqAUCW4Ja
        wlAKN6A11SHTywlfmZdcYWzGmplOs7VvnhXK9gQZ1iBqPWG4fl9olbhhy8GpR+SrhsxKVwrSOOTHm
        yicFxBszwpioCQ1LU+Sh1aFZWZhmk1TEcDyQ1aVtgsLj+2K9P4DqYEmpL8JJ4TjoaMDYTtAnFI8ht
        rybfH+aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcEcJ-0002gT-Hs; Fri, 22 May 2020 20:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9C42306102;
        Fri, 22 May 2020 22:49:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B67832B951B52; Fri, 22 May 2020 22:49:56 +0200 (CEST)
Message-ID: <20200522204943.407362690@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 May 2020 22:47:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH 4/4] x86/entry, mce: Disallow #DB during #MC
References: <20200522204738.645043059@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#MC is fragile as heck, don't tempt fate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/mce/core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1943,22 +1943,34 @@ static __always_inline void exc_machine_
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	exc_machine_check_user(regs);
+	local_db_restore(dr7);
 }
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 #endif
 


