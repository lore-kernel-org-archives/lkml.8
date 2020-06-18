Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgFROtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFROtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:49:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:49:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jlvrA-0004Ip-DF; Thu, 18 Jun 2020 16:49:32 +0200
From:   John Ogness <john.ogness@linutronix.de>
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
Subject: [PATCH v3 0/3] printk: replace ringbuffer
Date:   Thu, 18 Jun 2020 16:55:16 +0206
Message-Id: <20200618144919.9806-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v3 for the first series to rework the printk
subsystem. The v2 and history are here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. No semantics/behavior of printk are changed.

Reviews on the ringbuffer are still ongoing, but I was asked to
post this new version since several changes from v2 have been
already agreed upon.

The series is based on v5.8-rc1.

The list of changes since v2:

printk.c
========

- console_unlock(): fix extended console printing [1]

printk_ringbuffer
=================

- data_push_tail(): fixed handling when another CPU already
  pushed the tail [2]

- desc_push_tail(): added a full memory barrier before the
  descriptor tail push [3]

- data_make_reusable()/data_alloc(): changed block ID
  reading/writing from READ_ONCE()/WRITE_ONCE() to regular
  assignments [4]

- data_make_reusable(): removed unnecessary data tail
  re-check [5]

- general: folded all smp_mb() and smp_wmb() calls into their
  neighboring cmpxchg_relaxed(), changing them to full cmpxchg()
  calls [6]

- desc_read(): changed descriptor content reading from
  READ_ONCE() to memcpy() since it served no purpose for the
  legal data race

- general: cleaned up memory barrier comments; in particular
  made sure that the reader and writer sides of the memory
  barrier pairs match in their descriptions

- added a new section in the memory barrier documentation (near
  the top of printk_ringbuffer.c) that lists all 10 memory
  barrier pairs and briefly describes what they are ordering

- _prb_read_valid(): changed the helper function to static

- general: changed block size argument type from "unsigned long"
  to "unsigned int" since a record's *_buf_size fields are of
  type "unsigned int"

- general: allow some lines to go beyond 80 characters

John Ogness

[0] https://lkml.kernel.org/r/20200501094010.17694-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/87ftcd86d2.fsf@vostro.fn.ogness.net
[2] https://lkml.kernel.org/r/87v9ktcs3q.fsf@vostro.fn.ogness.net
[3] https://lkml.kernel.org/r/87bllpyzgr.fsf@vostro.fn.ogness.net
[4] https://lkml.kernel.org/r/87tuzkuxtw.fsf@vostro.fn.ogness.net
[5] https://lkml.kernel.org/r/87pna5mjtp.fsf@vostro.fn.ogness.net

John Ogness (3):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 include/linux/kmsg_dump.h         |    2 -
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  944 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1674 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  352 ++++++
 6 files changed, 2527 insertions(+), 449 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1

