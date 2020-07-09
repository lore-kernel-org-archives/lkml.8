Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FF320786
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqukxlMh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rL47dvpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGINXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:23:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGINXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:23:53 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594301032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w+n6OxHUPqDUjezjmzQQ+q/N430M63eFVjSjWykE69w=;
        b=bqukxlMh0huifO3XHgPvZZsBMnBlntY4qGpAg7gWxCxJsAkfEAUeYIvXGxxzcAoyEhuX7f
        aylm0GSsgUnHgBYmLAFpRPfcz6SEhR9GP1DfCN8kslmn6pymmTb6TmguXqUCDfDB4DIthZ
        Eo24v0T8ClTd4L11w8QujmHNMYuVQUfDea0Y/QqrAKDsa3tu//giMauE2rdCoxN3JmN+8O
        m/B7nR68hA6GL6cDWQsRSZ+NQ3TmJdIjbgrDTbu7UU+3lmUr9otmhYNiYqEHSwo0xqkZOe
        bxgdPDRcT8z/9nWQiy94bdU+IAJoD9gwU48g9roDzjKW7LOt/BESdi0ZrEPK6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594301032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w+n6OxHUPqDUjezjmzQQ+q/N430M63eFVjSjWykE69w=;
        b=rL47dvpAPr0fqZl7AzlMfykqJijLWsTKAyRRdOlhcHCFFBpPbS9dw17I7Hf2Z0Rz4TECqO
        nIHwEoCJN3tILmAA==
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
Subject: [PATCH v5 0/4] printk: replace ringbuffer
Date:   Thu,  9 Jul 2020 15:29:40 +0206
Message-Id: <20200709132344.760-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v5 for the first series to rework the printk
subsystem. The v4 is here [0]. This first series
only replaces the existing ringbuffer implementation. No locking
is removed. The semantics/behavior of printk are kept the same
except for a minor optimization that is reverted (patch 3).

RFC patches for various userspace tools to dump the kernel log
are available: crash [1], makedumpfile [2], kexec-tools [3].

This series is based on v5.8-rc4.

The list of changes since v4:

printk_ringbuffer
=================

- added new prb_first_valid_seq() for readers to retrieve the
  oldest valid sequence number

- prb_first_seq(): now static

printk.c
========

- devkmsg_read(): fixed returning EPIPE on buffer wrap [4]

- setup_log_buf(): fixed printk conversion specifier [5]

- replace all prb_first_seq() usage with the new
  prb_first_valid_seq() (because that is what the readers are
  actually interested in)

[0] https://lkml.kernel.org/r/20200707145932.8752-1-john.ogness@linutronix.de
[1] https://github.com/Linutronix/crash.git (printk branch)
[2] https://github.com/Linutronix/makedumpfile.git (printk branch)
[3] https://github.com/Linutronix/kexec-tools.git (printk branch)
[4] https://lkml.kernel.org/r/87zh89kkek.fsf@jogness.linutronix.de
[5] https://lkml.kernel.org/r/87r1tmcfhf.fsf@jogness.linutronix.de

John Ogness (4):
  crash: add VMCOREINFO macro to define offset in a struct declared by
    typedef
  printk: add lockless ringbuffer
  Revert "printk: lock/unlock console only for new logbuf entries"
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  950 ++++++++--------
 kernel/printk/printk_ringbuffer.c | 1687 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  399 +++++++
 5 files changed, 2586 insertions(+), 454 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1

