Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C7D20782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSycPUkZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2XLcT6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHaBLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHaBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BA6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:11:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GFrwwpn3esUH5bEpAaISj6QQdK7mHWnRt/vMMgi5V5Y=;
        b=uSycPUkZO8Dn8/xRBTQ9eFsFyowv3c6R7POvzWFj8iDa1I28Mviqk/+7Y1HgbLqQSjf99y
        jJuO+NnTzcj2uGdiMNjqIAQQ+9ndKhcXsg3+VGmi2KYU1DFpRWqhfYg7ygsnEVGsv7DuH5
        Rk+ZKgyts/H3+AV7pcU43XXE6czUwik+XBPPsSNckLhoB8Qf1YSxdKwjw7/8JlAxv7HcY9
        YJzzz4V4P4SiCzndzLpUHzeHumO8zPacYM5LuzD5U2AFVvMvXXICc93c+85kIWV/qgFpHf
        2A9YwBXiX0VeLNMGkELUqoW0l2ZhdXg7cC9ml83sGoaLhs7TJKUAytwL7GnGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GFrwwpn3esUH5bEpAaISj6QQdK7mHWnRt/vMMgi5V5Y=;
        b=R2XLcT6wI/UufzjGvmsNSwclpuZtlw5hTmMHkqsfkYeMLKsevDV2XMvw9yT+dqjc8cYnXl
        ncEuk30U4en5mJDQ==
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
Subject: [PATCH next v3 0/8] printk: reimplement LOG_CONT handling
Date:   Mon, 31 Aug 2020 03:16:50 +0206
Message-Id: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v3 for the second series to rework the printk subsystem.
(The v2 is here [0].) This series implements a new ringbuffer
feature that allows the last record to be extended. Petr Mladek
provided the initial proof of concept [1] for this.

Using the record extension feature, LOG_CONT is re-implemented
in a way that exactly preserves its behavior, but avoids the
need for an extra buffer. In particular, it avoids the need for
any synchronization that such a buffer requires.

This series deviates from the agreements [2] made at the meeting
during LPC2019 in Lisbon. The test results of the v1 series,
which implemented LOG_CONT as agreed upon, showed that the
effects on existing userspace tools using /dev/kmsg (journalctl,
dmesg) were not acceptable [3].

The main difference to v2 is the implementation of the new
descriptor finalization. For v3 the implementation closely
follows the example [4] from Petr Mladek.

Patch 6 introduces *four* new memory barrier pairs. Two of them
are insignificant additions (data_realloc:A/desc_read:D and
data_realloc:A/data_push_tail:B) because they are alternate path
memory barriers that exactly match the purpose and context of
the two existing memory barrier pairs they provide an alternate
path for. The other two new memory barrier pairs are significant
additions:

desc_reopen_last:A/_prb_commit:B - When reopening a descriptor,
    ensure the commit flag is removed before fully trusing the
    descriptor data.

_prb_commit:B / desc_reserve:D - When committing a descriptor,
    ensure the commit flag is set before checking the head ID
    to see if the finalize flag should be set.

Patch 8 assumes the gdb script series [5] for the new printk
ringbuffer has been applied.

The test module used to test the ringbuffer is available
here [6].

The series is based on next-20200828.

The list of changes since v2:

printk_ringbuffer
=================

- prb_commit(): finalize self if no longer the head

- prb_reserve(): clear @info fields on success

- prb_reserve(): do not finalize the -1 placeholder descriptor

- desc_make_final(): renamed from desc_finalize()

- desc_make_final(): remove loop, change to single shot attempt

- prb_reserve_in_last(): renamed from prb_reserve_last()

- prb_reserve_in_last(): add new fail goto target

- prb_reserve_in_last(): fix logic for calculating
  @text_buf_size and add size check

- desc_reopen_last(): add extra caller ID check before reopening

- desc_reopen_last(): change cmpcxhg() to full memory barrier

- get_desc_state(): remove unneeded @is_final argument

- documentation: update finalization, sample code, and memory
  barrier list

printk.c
========

- set @text_len and @dict_len as required by prb_reserve() change

John Ogness

[0] https://lkml.kernel.org/r/20200824103538.31446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://lkml.kernel.org/r/20200827151710.GB4928@alley
[5] https://lkml.kernel.org/r/CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com
[6] https://lkml.kernel.org/r/20200814212525.6118-1-john.ogness@linutronix.de
[7] https://github.com/Linutronix/prb-test.git

John Ogness (8):
  printk: ringbuffer: rename DESC_COMMITTED_MASK flag
  printk: ringbuffer: change representation of reusable
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: clear initial reserved fields
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension
  scripts/gdb: support printk finalized records

 Documentation/admin-guide/kdump/gdbmacros.txt |  10 +-
 kernel/printk/printk.c                        | 105 +--
 kernel/printk/printk_ringbuffer.c             | 604 +++++++++++++++---
 kernel/printk/printk_ringbuffer.h             |  12 +-
 scripts/gdb/linux/dmesg.py                    |  10 +-
 5 files changed, 558 insertions(+), 183 deletions(-)

-- 
2.20.1

