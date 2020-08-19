Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A012207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LdDpla3K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1JFJlee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHSX0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:34 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XoyJHAbFx4/QtEZjlPy5bPE6pm2umAla6Dnt4MZxVH8=;
        b=LdDpla3KJIDAvI0lSkHGijKfjpIq6Onl9dtbJnYmzQoXMsoK2aiQyWudw0dbMhh8B0vy4J
        d3KScm53/56/nIm5J6wLWJVGOgYRRxUdrSarLaA7NDchYRjJlXUp6VASjJdIwLFNrL93yx
        l0a21LywuEzCeWlrY8Apo9UJJy2yCFYzZFYqmgaOzXeCJnjMJUL2wrXcKT8P9BZBmwhX26
        wFV+Sj3fI5/4/RhwsEAotGS7LnBtUqwCMc/Oq4yFMs/o94Szl1tSSuEiwH+34UAAkBm1dp
        r9m9qiJ4niL9IrKf+DbcmkSxwBVXkmkOAumsdoyR881/epEELFsc1IBOa8q22Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XoyJHAbFx4/QtEZjlPy5bPE6pm2umAla6Dnt4MZxVH8=;
        b=U1JFJleeYWT3jKbE6mnFJTuxVUbkVeuxKhP/NJNt1WbWQNrg5HQaJO1ckB5lIODs5bBe0d
        hhNX9nUesfFdx2CA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] printk: new log_cont implementation
Date:   Thu, 20 Aug 2020 01:32:27 +0206
Message-Id: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My recent series [0] to perform log_cont handling by the readers
was not received well, mainly because of the blank lines in the
output for existing dmesg and journalctl tools. This caused a
discussion about alternative methods of handling log_cont. This
RFC series is the result of that discussion.

Rather than storing individual log_cont parts into the ringbuffer,
this series will buffer the parts until flushed or the message is
complete (just as mainline does it now). The difference to mainline
is that a new API is used that allows the printk subsystem to
effectively track the caller while making use of separate
per-caller buffers.

The API is designed such that:

1. The API calls map clearly to the mainline log_cont calls. This
   is important because all current log_cont users will need to
   be updated.

2. The underlying implementation can be changed/improved at some
   later time without requiring the code of log_cont users to
   change (again).

The mainline log_cont syntax:

    printk(KERN_INFO "text");
    printk(KERN_CONT " continued");
    printk(KERN_CONT "\n");

The new RFC log_cont syntax:

    pr_cont_t c;

    pr_cont_begin(&c, KERN_INFO "text");
    pr_cont_append(&c, " continued");
    pr_cont_end(&c);

Note that both methods can co-exist until all users of the old
mechanism have been converted over.

For this RFC series, 10KiB of memory are set aside to allow up to 10
simultaneous log_cont users. Obviously that might be adjusted based
on the number of CPUs or whatever.

The first patch implements the new log_cont mechanism. The following
4 patches convert existing log_cont user code, with each patch
taking on a more complex example.

This RFC series not only improves log_cont output generally, but
also addresses the lockless printk issue related to log_cont.

John Ogness

[0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de

John Ogness (5):
  printk: implement pr_cont_t
  sysrq: use pr_cont_t for cont messages
  workqueue: use pr_cont_t for cont messages
  locking/selftest: use pr_cont_t for cont messages
  lockdep: use pr_cont_t for cont messages

 based on next-20200819

 drivers/tty/sysrq.c      |   8 +-
 include/linux/printk.h   |  19 ++
 kernel/locking/lockdep.c | 463 +++++++++++++++++++++++----------------
 kernel/printk/printk.c   | 137 ++++++++++++
 kernel/workqueue.c       |  71 +++---
 lib/locking-selftest.c   |  85 +++----
 6 files changed, 519 insertions(+), 264 deletions(-)

-- 
2.20.1

