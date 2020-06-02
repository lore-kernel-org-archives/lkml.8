Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04093C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C2120757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLGYTNnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFBPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgFBPGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:06:21 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f1hzBB9KLB4tTNevjYrU1xXXmkoQCWVmDif8LyRXXio=; b=hLGYTNnNEFXKolZCdEaei3+P8R
        +uQGS8GDO+kejobjNymilQIbCqxMfkA4ydydJxoEvTMLJsc8GsR5VZJRmyqZdS7IKMKBdyoGGKR/c
        7nOmnue+mzQBzwLuV13NM0EEItcXekkQ0FmmPjtmD34nElrgGZ8oNOqXJ1WhsfcG/SiQKSTOUTNFw
        IHDK4+RBbwh84NLF70gUlR1reQMpYo6AjmnSKBG/SaDZnhTt6I2FugncCTv118JE4ZPcir9Dvn8XU
        lH5An/anJQHDy/ePfKDuD12Ghw9b6j5YTWlRFIqW8ZyqRXD8Brf0zSpRqiYnSBcnSr8C7hPWfe0yB
        m5n5Yq7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg8Ta-0005qW-TU; Tue, 02 Jun 2020 15:05:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20C1830081A;
        Tue,  2 Jun 2020 17:05:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0997C202436EC; Tue,  2 Jun 2020 17:05:11 +0200 (CEST)
Date:   Tue, 2 Jun 2020 17:05:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
Message-ID: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.359433429@infradead.org>
 <20200602144235.GA1129@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602144235.GA1129@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:42:35AM -0400, Qian Cai wrote:

> Reverted this commit fixed the POWER9 boot warning,

ARGH, I'm an idiot. Please try this instead:


diff --git a/kernel/softirq.c b/kernel/softirq.c
index a3eb6eba8c41..c4201b7f42b1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -438,7 +438,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	irq_exit_rcu();
+	__irq_exit_rcu();
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();


