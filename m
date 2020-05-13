Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B548320575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgEMWEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729775AbgEMWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:04:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55414C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:04:31 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jYzUK-00058z-Vy; Thu, 14 May 2020 00:04:29 +0200
Date:   Thu, 14 May 2020 00:04:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200513220428.4nksinis2qs5dtmh@linutronix.de>
References: <87bln7ves7.fsf@gmx.net>
 <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
 <87v9l65d2y.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9l65d2y.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-08 23:30:45 [+0200], Stephen Berman wrote:
> > Can you log the output on the serial console?
> 
> How do I do that?

The spec for your mainboard says "serial port header". You would need to
connect a cable there to another computer and log its output.
The alternative would be to delay the output on the console and use a
camera.

> > If the commit you cited is really the problem then it would mean that a
> > worker isn't scheduled for some reason. Could you please enable
> > CONFIG_WQ_WATCHDOG to see if workqueue core code notices that a worker
> > isn't making progress?
> 
> How will I know if that happens, is there a specific message in the tty?

On the tty console where you see the "timing out command, waited"
message, there should be something starting with
|BUG: workqueue lockup - pool

following with the pool information that got stuck. That code checks the
workqueues every 30secs by default. So if you waited >= 60secs then
system is not detecting a stall.

As far as I can tell, there is nothing special on your system. The CD
and disk drives are served by the AHCI controller. There is no special
SCSI/SATA/SAS controller.
Right now I have no idea how the workqueues fit in the picture. Could
you please check if the stall-dector says something?
Is it possible to show me output when the timeout message comes? My
guess is that the system is going down and before unounting/remount RO
the filesystem it flushes its last data. But this is done before issuing
the "halt-syscall".

> Thanks for your reply.
> 
> Steve Berman

Sebastian
