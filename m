Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884AE20786
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVq47utF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4VeeEwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGGO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762EBC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:59:40 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594133978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LdvL/x2dKuN9iAnoWSsz2ILnlZfZBQJ9bRLZQEL/pxs=;
        b=yVq47utFIFnT0UDbkP9zxfJk4vzd5h882nKGG99PDKiEt1l2YfbUjley8z8Urqm3wd2v5M
        371VeJ6NG0eIuT01oVpdYMjVQ2sTsyK/vw1DUC3TUrujCTOHifDzr+0gTfG2f3kjSPRTaC
        Hr0ZdiVlUuTTDt9qkAWVqRgIaOQQKTpOslf5ko7Av8Co6OVoej1C7kAWSZ9tojUwTnsk3m
        P3Xw+nDIdAdEv4j8Vb9ovZzco+7OBf9HdeCXd5BCS9YbAn6xXoug90Q0nf24EMzDFzwfop
        /OLLXWcg+vpt5gKKsOgnjmfmTDFVjyMmXmyROq6hRQIyRzyXzha7p03YgMId8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594133978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LdvL/x2dKuN9iAnoWSsz2ILnlZfZBQJ9bRLZQEL/pxs=;
        b=T4VeeEwxYXyid87FZyQczDQqXHKDTIfz42dcgEOggnhwF4DlpEhlVKquP74YXl8RSSd7dA
        +rRIoWEImmIwY5AQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] printk: replace ringbuffer
Date:   Tue,  7 Jul 2020 17:05:28 +0206
Message-Id: <20200707145932.8752-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v4 for the first series to rework the printk
subsystem. The v3 is here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. The semantics/behavior of printk are kept the same
except for a minor optimization that is reverted (patch 3).

Despite minor changes to the ringbuffer code since v3 (comments,
function names, very minor refactoring), the ringbuffer logic
itself has not changed. And, in particular, the memory barriers
have been exactly preserved from v3. For this reason I deem it
appropriate to keep Paul's reviewed by tag (patch 2).

RFC patches for various userspace tools to dump the kernel log
are available: crash [1], makedumpfile [2], kexec-tools [3].

Finally, I would like to thank some people/organizations that
helped with performing ringbuffer stress tests on big or rare
hardware that I do not have access to:

- Prarit Bhargava of Red Hat (x86_64, ppc64le power8)
- Michael Cree of Debian (alpha)
- Jeff Scheel of OSU Open Source Lab (ppc64le power8 kvm)

These tests were extremely valuable during the memory barrier
work. Thank you!

This series is based on v5.8-rc4.

The list of changes since v3:

printk_ringbuffer
=================

- data_alloc(): remove unneeded check for a NULL data ring [4]

- prb_next_seq(): simplified by assuming u64 never overflows [4]

- added prb_for_each_info() macro to iterate record meta-data [5]

- prb_count_lines() renamed to count_lines() and is now a static
  helper function [5]

- buffers defined by DECLARE_PRINTKRB() now static [6]

- DECLARE_PRINTKRB() renamed to DEFINE_PRINTKRB() because it is
  defining, not declaring

printk.c
========

- added a compiler macro test to ensure CONFIG_LOG_BUF_SHIFT
  is greater than PRB_AVGBITS [7]

- setup_log_buf(): fixed handling of failed allocation of the
  dictionary data ring [7]

- setup_log_buf(): now verify that no messages were dropped
  during the transition to the dynamic buffer [7]

- setup_log_buf(): added size checks, comments, and temporary
  variables to clean up the code [7]

- setup_log_buf(): use ilog2() instead of order_base_2() [8]

- truncate_msg(): no longer truncate dictionary data [9]

- record_print_text(): refactored code and comments [10]

- get_record_text_size() renamed to
  get_record_print_text_size() [11]

- use prb_for_each_info() instead of prb_count_lines() to get
  the number of lines in a message (also avoids unnecessarily
  allocating buffer space and/or copying message text) [5]

- reverted printk optimization to only wake klogd if
  vprintk_emit() actually produced new printing content [12]

[0] https://lkml.kernel.org/r/20200618144919.9806-1-john.ogness@linutronix.de
[1] https://github.com/Linutronix/crash.git (printk branch)
[2] https://github.com/Linutronix/makedumpfile.git (printk branch)
[3] https://github.com/Linutronix/kexec-tools.git (printk branch)
[4] https://lkml.kernel.org/r/20200702083518.GB14288@alley
[5] https://lkml.kernel.org/r/87k0zp8rrn.fsf@jogness.linutronix.de
[6] https://lkml.kernel.org/r/20200619082919.5d604e58@oasis.local.home
[7] https://lkml.kernel.org/r/87sgeh3m5j.fsf@jogness.linutronix.de
[8] https://lkml.kernel.org/r/20200702132758.GD14288@alley
[9] https://lkml.kernel.org/r/87wo3u2b0l.fsf@jogness.linutronix.de
[10] https://lkml.kernel.org/r/87k0ztbea9.fsf@jogness.linutronix.de
[11] https://lkml.kernel.org/r/20200625152523.GJ8444@alley
[12] https://lkml.kernel.org/r/87o8oznh2c.fsf@jogness.linutronix.de

John Ogness (4):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  Revert "printk: lock/unlock console only for new logbuf entries"
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  950 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1676 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  399 +++++++
 5 files changed, 2575 insertions(+), 454 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1

