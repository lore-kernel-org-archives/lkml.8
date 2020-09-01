Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D88EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161312098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIAGoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:44:19 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41148 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAGoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:44:17 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0816h5ik000896;
        Tue, 1 Sep 2020 08:43:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, George Spelvin <lkml@sdf.org>,
        Amit Klein <aksecurity@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
        Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>
Subject: [PATCH 0/2] prandom_u32: make output less predictable
Date:   Tue,  1 Sep 2020 08:43:00 +0200
Message-Id: <20200901064302.849-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the cleanup of the latest series of prandom_u32 experimentations
consisting in using SipHash instead of Tausworthe to produce the randoms
used by the network stack. The changes to the files were kept minimal,
and the controversial commit that used to take noise from the fast_pool
(f227e3ec3b5c) was reverted. Instead, a dedicated "net_rand_noise" per_cpu
variable is fed from various sources of activities (networking, scheduling)
to perturb the SipHash state using fast, non-trivially predictable data,
instead of keeping it fully deterministic. The goal is essentially to make
any occasional memory leakage or brute-force attempt useless.

The resulting code was verified to be very slightly faster on x86_64 than
what is was with the controversial commit above, though this remains barely
above measurement noise. It was only build-tested on arm & arm64.

George Spelvin (1):
  random32: make prandom_u32() output unpredictable

Willy Tarreau (1):
  random32: add noise from network and scheduling activity

 drivers/char/random.c   |   1 -
 include/linux/prandom.h |  55 ++++-
 kernel/time/timer.c     |   9 +-
 lib/random32.c          | 438 ++++++++++++++++++++++++----------------
 net/core/dev.c          |   4 +
 5 files changed, 326 insertions(+), 181 deletions(-)

Cc: George Spelvin <lkml@sdf.org>
Cc: Amit Klein <aksecurity@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tytso@mit.edu
Cc: Florian Westphal <fw@strlen.de>
Cc: Marc Plumb <lkml.mplumb@gmail.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>

-- 
2.28.0
