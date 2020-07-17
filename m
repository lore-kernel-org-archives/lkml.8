Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C26C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D5A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otR6BaPI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfhrArN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGQXs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:56 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595029734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hLhSscQ3zjADZ+KvQLXC+idNGz5GUHoq9ureYCScp5U=;
        b=otR6BaPIX5ohSReVosDJMA7wVnx74Mt1JjlMB/d2YD3fO+9yblYQrARg0Dkk2auM4iL22o
        aCnjFY+hCu6smfszJQalEPfseSQ9tXZFw8ssK5E36SGeCCzMsE4WzaoKKH9MdqFcNY4PY8
        LhUR7AsAfVnbYSt5poq5JOXT+hK9C2kUjFd5/NpdAcrA9QktEy9gTJHQbY+ufa4JwJvUwl
        GanUD6/J2LDk9RluUBaTw4PtUdFJUBUoB49qeoGBE0AcMDiLC9zyQIsKfA4yAG8+O8q+7B
        119hePJXpFb22yZOQevEr2rUbfZ96MkSOiUo2ZdMmPaGwH8ALz/UUfuZkQIILw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595029734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hLhSscQ3zjADZ+KvQLXC+idNGz5GUHoq9ureYCScp5U=;
        b=kfhrArN30d6YNoUwK1sDjzlfSELEzY7vWajQmDmdzPRtazzFBvNQf98PUPIWzA92B/Sa5l
        gOSSiOH+weNgcsCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] printk: reimplement LOG_CONT handling
Date:   Sat, 18 Jul 2020 01:54:14 +0206
Message-Id: <20200717234818.8622-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the second series to rework the printk subsystem. This series
removes LOG_CONT handling from printk() callers, storing all LOG_CONT
parts individually in the ringbuffer. With this series, LOG_CONT
handling is moved to the ringbuffer readers that provide the record
contents to users (console printing, syslog, /dev/kmsg).

This change is necessary in order to support the upcoming move to a
fully lockless printk() implementation.

This series is in line with the agreements [0] made at the meeting
during LPC2019 in Lisbon, with 1 exception: For the /dev/kmsg
interface, empty line placeholder records are reported for the
LOG_CONT parts.

Using placeholders avoids tools such as systemd-journald from
erroneously reporting missed messages. However, it also means that
empty placeholder records are visible in systemd-journald logs and
displayed in tools such as dmesg.

The effect can be easily observed with the sysrq help:

$ echo h | sudo tee /proc/sysrq-trigger
$ sudo dmesg | tail -n 30
$ sudo journalctl -k -n 30

Providing the placeholder entries allows a userspace tool to identify
if records were actually lost. IMHO this an important feature. Its
side effect can be addressed by userspace tools if they change to
silently consume empty records.

For dump tools that process the ringbuffer directly (such as crash,
makedumpfile, kexec-tools), they will need to implement LOG_CONT
handling if they want to present clean continuous line messages.

Finally, by moving LOG_CONT handling from writers to readers, some
incorrect pr_cont() usage is revealed. Patch 4 of this series
addresses one such example.

This series is based on the printk git tree [1] printk-rework branch.

[0] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[1] https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git (printk-rework branch)

John Ogness (4):
  printk: ringbuffer: support dataless records
  printk: store instead of processing cont parts
  printk: process cont records during reading
  ipconfig: cleanup printk usage

 kernel/printk/printk.c            | 569 ++++++++++++++++++++----------
 kernel/printk/printk_ringbuffer.c |  58 ++-
 kernel/printk/printk_ringbuffer.h |  15 +-
 net/ipv4/ipconfig.c               |  25 +-
 4 files changed, 434 insertions(+), 233 deletions(-)

-- 
2.20.1

