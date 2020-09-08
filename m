Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79001208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyD6Y0i+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDu7Djz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIHU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgIHU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:29:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA37C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:29:01 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599596940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M5nXFElMjAq6K+M5WKZcB15Sz7rT6r2u9VSa5GOS9lY=;
        b=RyD6Y0i+W5Gb+dbvwl/r0BxmEnyLL+G2fwVkNVNZoFpMx7J0ky3ITC34c9/uHhAHfXlEdi
        lMRD9/5JciBHUChlIPnF9q2oNGtbd9ucFrZsBPuejaPFh9Zhmc9lbU8LKxSltyVX6mSKH8
        x7YALitRoEIDLh4AjMqtnOzZBMGyMibgqcmIW7eEC3TgwZ9jAcwd4tGlr00rU22E9YuGhW
        Vx7IstVvey5VJwbjxo7wjYLThzcH1hHY9BA+QRXVwaN0kQgk+yJ/lYpN2qdLDxtdRIuu2d
        NuTG8fxXrPYLX0TEfo0BRGTwetK3WvNf53w54thNDm1uoP7jL4dxAuobJUJ/ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599596940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M5nXFElMjAq6K+M5WKZcB15Sz7rT6r2u9VSa5GOS9lY=;
        b=jDu7Djz1F6mabHMJLULVUOgfIngakre+Nq/Nmv3YargyABLyLuRGFbdb7gZqAc9QXW0M/P
        K2uTbbKze683FDDw==
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
Subject: [PATCH printk v4 0/6] printk: reimplement LOG_CONT handling
Date:   Tue,  8 Sep 2020 22:34:53 +0206
Message-Id: <20200908202859.2736-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v4 for the second series to rework the printk subsystem.
(The v3 is here [0].) This series implements a new ringbuffer
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

Patch 5 introduces *four* new memory barrier pairs. Two of them
are insignificant additions (data_realloc:A/desc_read:D and
data_realloc:A/data_push_tail:B) because they are alternate path
memory barriers that exactly match the purpose and context of
the two existing memory barrier pairs they provide an alternate
path for. The other two new memory barrier pairs are significant
additions:

desc_reopen_last:A / _prb_commit:B - When reopening a descriptor,
    ensure the state transitions back to desc_reserved before
    fully trusting the descriptor data.

_prb_commit:B / desc_reserve:D - When committing a descriptor,
    ensure the state transitions to desc_committed before checking
    the head ID to see if the descriptor needs to be finalized.

The test module used to test the ringbuffer is available
here [4].

The series is based on the printk-rework branch of the printk git
tree:
e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")

The list of changes since v3:

printk_ringbuffer
=================

- move enum desc_state definition to printk_ringbuffer.h

- change enum desc_state to define the exact state values used
  in the state variable

- add DESC_STATE() macro to retrieve the state from the state
  variable

- add DESC_SV() macro to build a state variable value given an
  ID and state

- get_desc_state(): simply return the state value rather than
  processing state flags

- desc_finalized is now a queried state instead of a state flag

- desc_read(): always return a set @state_var, even if the
  descriptor is in an inconsistent state (desc_reopen_last()
  relies on this)

- change state logic that tested for desc_committed to now test
  for desc_finalized, since this is the new state directly
  preceding desc_reusable

- data_realloc(): add a check if the data block should shrink
  (and in that case, do not modify the data block, i.e. data
  blocks will never shrink)

- prb_reserve_in_last(): add WARN_ON for unexpected @text_len
  value

- prb_reserve(): save a copy of @seq and use use memset() to
  clear @info

- desc_read_committed_seq(): rename function to
  desc_read_finalized_seq() since desc_finalized is the desired
  state for readers

- documentation: update state and finalization descriptions

printk.c
========

- use @text_len and @dict_len for memcpy() size

gdb scripts
===========

- update to use new state representation

John Ogness

[0] https://lkml.kernel.org/r/20200831011058.6286-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://github.com/Linutronix/prb-test.git


John Ogness (6):
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: clear initial reserved fields
  printk: ringbuffer: change representation of states
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension

 Documentation/admin-guide/kdump/gdbmacros.txt |  13 +-
 kernel/printk/printk.c                        | 110 +--
 kernel/printk/printk_ringbuffer.c             | 695 ++++++++++++++----
 kernel/printk/printk_ringbuffer.h             |  35 +-
 scripts/gdb/linux/dmesg.py                    |  12 +-
 5 files changed, 624 insertions(+), 241 deletions(-)

-- 
2.20.1

