Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E00C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDE0217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wSlGc3Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBLVOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:14:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgBLVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NXy2WyoL4s4z0mcmpcFDbcqBMvtipXVeSVJos+aTK1g=; b=wSlGc3Pii671R4vFgbR2j+9Hx/
        5wr6AMehILQmmjqAcaAL0LE3SQaUJTLr3HznSphmGS1YWoyMm90aInwXE2ulDWJAtdgR2138/XSdE
        45GHuw12pT2rNG6QiawLpRPGr7Pw9XZFAY7C7sc/23IXfHFqRKnZiZkJjOf8gezmv59DiFt81xTB2
        cayVher4/sIOAjfKC0Jbj8ki1Bzv9DVN0ezz3RIz+H1yxD3yBHIWfNAxEbGYIEkfncwAlcl+Daaqu
        a7O+74tT2bMfC4CIANjZ+xfhVfAmCjsv9aqOHoWPdoQ0m+M8L6fAP7JbNnqZWS1S7s97TOemW7VIm
        Fk8w3t3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKK-0002Kk-K5; Wed, 12 Feb 2020 21:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C07C30220B;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7A94E203A8996; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210749.915180520@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rcu_is_watching() is notrace (and needs to be, as it can be
called from the tracers), make sure everything it in turn calls is
notrace too.

To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
implies notrace, as the function is tiny.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static bool rcu_dynticks_curr_cpu_in_eqs(void)
+static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 


