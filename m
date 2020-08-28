Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B400C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CAB2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuY3Zrzo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VoChQdPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgH1BGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:06:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:06:51 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krF9UCs2hhD6NhZsGv5yMaHJjvfUJRQrRXq3bXEz52Y=;
        b=QuY3Zrzo14totflOYu8te2z0fy1UsAG/wVVrfWZnYC5/uVTPZEBmo7b19vH5JOLABQKYYH
        m5wX6WlBanxbQVXras84ZiJPHDUiFIpjWUIRhN2xnpfpOmOOqFghUZVkiWCt6sp1RN6Jaw
        dVFuUqCjTEExv7ud8IQvQpS0C0hu362WOdEDZ6Y7alk1jropK322PCkP2zfn+qmasSpxRd
        X5mTQ1UJSq4UaOBrUsrR2KxdF5kjdaFCfJghaQZLX5OcWeOdIUb7Q0Rtb4i3LzHcKzNXQ9
        vX1q5cGtPG9MWs5WKgqmr+TLt52rZOjCUM9Hp27ouInAKojmZcnkZWT841TDzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krF9UCs2hhD6NhZsGv5yMaHJjvfUJRQrRXq3bXEz52Y=;
        b=VoChQdPr25dTxfVvHeFB03GgutMQyMj81tsEEmHQXo3nMBDhZcoxoZcH1GfzpXxTQ1x4ry
        3yflVzYtCMzvohCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 0/5] seqlock: Introduce PREEMPT_RT support
Date:   Fri, 28 Aug 2020 03:07:05 +0200
Message-Id: <20200828010710.5407-1-a.darwish@linutronix.de>
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Preemption must be disabled before entering a sequence counter write
side critical section.  Failing to do so, the read side section can
preempt the write side section and spin for the entire scheduler tick.
If that reader belongs to a real-time scheduling class, it can spin
forever and the kernel will livelock.

Disabling preemption cannot be done for PREEMPT_RT. It can lead to
higher latencies and the write side sections will not be able to acquire
locks which become sleeping locks (e.g. spinlock_t).

To solve this dilemma, do not disable preemption for seqcount_LOCKTYPE_t
writers. Rather, detect if a seqcount_LOCKTYPE_t writer is in progress.
If that is the case, acquire then release the associated LOCKTYPE writer
serialization lock. This will allow any preempted writer to make progress
until the end of its writer serialization lock critical section.

Implement this technique for all of PREEMPT_RT sleeping locks.

Thanks,

8<--------------

Ahmed S. Darwish (5):
  seqlock: seqcount_LOCKTYPE_t: Standardize naming convention
  seqlock: Use unique prefix for seqcount_t property accessors
  seqlock: seqcount_t: Implement all read APIs as statement expressions
  seqlock: seqcount_LOCKTYPE_t: Introduce PREEMPT_RT support
  seqlock: PREEMPT_RT: Do not starve seqlock_t writers

 include/linux/seqlock.h | 277 ++++++++++++++++++++++++----------------
 1 file changed, 167 insertions(+), 110 deletions(-)

base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
--
2.28.0
