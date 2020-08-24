Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8592067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3tP25wGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TK6Jzmd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHXKfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:35:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:35:41 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598265339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2pN2Dyy+eVsAxTr0PWCwpbf/sM/+iRTo6lcU9xVYOSQ=;
        b=3tP25wGrZjvRx8SyX2fGfs3wSOdyOcrbftXS30qVDYFhr2PLC9kpRELabVC9AZ3ZGxet8V
        vD31DfzftQb48NE/gt7vvRleY/k+gi9eKvZ9Q/Z3Lj5yGNxtbAlVfihH1tq2igKy26Nj4Y
        tjsEVr7/aCKiSOMj435BZtFVfOwiIyedz6Tp51L6h7+BHvzlHbgXmZAgpnYhJHbM4URO9p
        la/jPmXIr6Vy6ov6KIaycfakONVS1xgxP9smahDMT3c9rJqDf7VXRkFhxacVxP6sUmcyxT
        ROpyzGj4snjI0ltjFTu/vMvOrTf0p9Jj5hovtD15t3qSQ5vjrEKTCtekGYwQgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598265339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2pN2Dyy+eVsAxTr0PWCwpbf/sM/+iRTo6lcU9xVYOSQ=;
        b=TK6Jzmd+kFGc3ttopDgu4UQNOb5iQ6aYCI5LIeYcjNs6cTmVAj4tK8e7LYWfPNsJCWpjyK
        6bEs8XvC9agZhvAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7][next] printk: reimplement LOG_CONT handling
Date:   Mon, 24 Aug 2020 12:41:31 +0206
Message-Id: <20200824103538.31446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 for the second series to rework the printk subsystem.
(The v1 is here [0].) This series implements a new ringbuffer
feature that allows the last record to be extended. Petr Mladek
provided the initial proof of concept [1] for this.

Using the record extension feature, LOG_CONT is re-implemented
in a way that exactly preserves its behavior, but avoids the
need for an extra buffer. In particular, it avoids the need for
any synchronization that such a buffer requires.

This series deviates from the agreements [2] made at the meeting
during LPC2019 in Lisbon. The test results of the v1 series
showed that the effects on existing userspace tools using
/dev/kmsg (journalctl, dmesg) were not acceptable [3]. That is
why a new decision [4] was made to preserve the current LOG_CONT
behavior.

Patch 5 introduces two new memory barriers. However, both are
alternate path memory barriers. They exactly match the purpose
and context of the two existing memory barriers that they
provide an alternate path for. For this reason, I do not
believe that a new memory barrier review is necessary.
Nevertheless, I have included the memory barrier experts CC.

Patch 6 assumes that the gdb script series [5] for the new
printk ringbuffer has been applied.

John Ogness

[0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://lkml.kernel.org/r/CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com
[5] https://lkml.kernel.org/r/20200814212525.6118-1-john.ogness@linutronix.de

John Ogness (7):
  printk: ringbuffer: rename DESC_COMMITTED_MASK flag
  printk: ringbuffer: change representation of reusable
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension
  scripts/gdb: support printk finalized records

 Documentation/admin-guide/kdump/gdbmacros.txt |  10 +-
 kernel/printk/printk.c                        |  98 +---
 kernel/printk/printk_ringbuffer.c             | 496 +++++++++++++++---
 kernel/printk/printk_ringbuffer.h             |  12 +-
 scripts/gdb/linux/dmesg.py                    |  10 +-
 5 files changed, 453 insertions(+), 173 deletions(-)

-- 
2.20.1

