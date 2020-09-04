Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A2BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB2020770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKQptKe5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NrMT2JMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIDPcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA9C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:32:05 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rSCW3ByRFMYvEoYwmcb4lzYw4fsM0+Zw7CquB9xGWrw=;
        b=EKQptKe5F9xnHP/B7LudRVUuQC0e/5xfdyXJAzXj/q8trSFdgoPCKQh02Ep5xAaDenV5YE
        cs8peUClqLUOs0K+TDdvXyNBV+EdtY/W4DoeTTXoFaKLg8hMIb1+UQCTEpxwcr/h5pvFSy
        Tt5OioK82Unm5PsZNVcJJWp3twKd3PASI70iXxRhAyqhP8wkhOtDWEuaEbAFDTZfzigesb
        ZSYmbTUIihSB3FgrWNRr+h1Opo6JHPHwhhWuVDlP4A40IuLLtdirKuUC0idbIhgGlfK4AE
        eTp0Hxjpl39mxT/5fTfPVrO3JWB1m2SbiGNvNK6bZB6QGFHuJRUSlQy7MrMJ4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rSCW3ByRFMYvEoYwmcb4lzYw4fsM0+Zw7CquB9xGWrw=;
        b=NrMT2JMySmccXfRhuW+2AUBT8f5WaSleSzC4NlM6RBtnGD9asZ+hMz+6h5XX/vNn0mzsgc
        EVOFHk4zZoalfOBA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 0/5] seqlock: Introduce PREEMPT_RT support
Date:   Fri,  4 Sep 2020 17:32:26 +0200
Message-Id: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog-v2
============

  - Standardize on seqcount_LOCKNAME_t as the canonical reference for
    sequence counters with associated locks, instead of v1
    seqcount_LOCKTYPE_t.

  - Use unique prefix "seqprop_*" for all seqcount_t/seqcount_LOCKNAME_t
    property accessors.

  - Touch-up the lock-unlock rationale for more clarity. Enforce writer
    non-preemitiblity using "__seq_enforce_writer_non_preemptibility()".

Cover letter (v1)
=================

https://lkml.kernel.org/r/20200828010710.5407-1-a.darwish@linutronix.de

Preemption must be disabled before entering a sequence counter write
side critical section.  Otherwise the read side section can preempt the
write side section and spin for the entire scheduler tick.  If that
reader belongs to a real-time scheduling class, it can spin forever and
the kernel will livelock.

Disabling preemption cannot be done for PREEMPT_RT though: it can lead
to higher latencies, and the write side sections will not be able to
acquire locks which become sleeping locks (e.g. spinlock_t).

To remain preemptible, while avoiding a possible livelock caused by the
reader preempting the writer, use a different technique: let the reader
detect if a seqcount_LOCKNAME_t writer is in progress. If that's the
case, acquire then release the associated LOCKNAME writer serialization
lock. This will allow any possibly-preempted writer to make progress
until the end of its writer serialization lock critical section.

Implement this lock-unlock technique for all seqcount_LOCKNAME_t with
an associated (PREEMPT_RT) sleeping lock, and for seqlock_t.

8<--------------

Ahmed S. Darwish (5):
  seqlock: seqcount_LOCKNAME_t: Standardize naming convention
  seqlock: Use unique prefix for seqcount_t property accessors
  seqlock: seqcount_t: Implement all read APIs as statement expressions
  seqlock: seqcount_LOCKNAME_t: Introduce PREEMPT_RT support
  seqlock: PREEMPT_RT: Do not starve seqlock_t writers

 include/linux/seqlock.h | 281 ++++++++++++++++++++++++----------------
 1 file changed, 167 insertions(+), 114 deletions(-)

base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
--
2.28.0
