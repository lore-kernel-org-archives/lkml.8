Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9379C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF50C2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgEFV5P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726927AbgEFV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:57:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD95C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:57:15 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jWS2T-0004iz-5R; Wed, 06 May 2020 23:57:13 +0200
Date:   Wed, 6 May 2020 23:57:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
References: <87bln7ves7.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87bln7ves7.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 17:46:48 [+0200], Stephen Berman wrote:
> I'm experiencing a delay or hang in powering off my computer after `halt
> -d -f -i -p' and I've bisected it to this commit in the mainline tree:

You refer to a normal "poweroff" or is this some kind of "shutdown now"
kind of thing? Unless I'm mistaken, the `halt' command above will turn
off the machine without stopping user tasks (as in "reaching shutdown
level").

…
> The delays have varied in length from ~20 seconds to seeminingly
> indefinitely long (the longest I've waited before pressing the start
> button on the machine is 6 minutes).  With kernels prior to this commit,
> my machine powers off within 4 seconds after the halt invocation.

So you say that normally the machine shuts down immediately but now it
takes 20secs+ if it shuts down at all?

…
>   sr 5:0:0:0: tag#21 timing out command, waited 120s

The CD-drive is polled regularly so it notices when a CD us inserted /
removed. It seems that one of the requests wasn't answered and it ended
up in timeout.

…
> minutes.  But after running emacs in a tty (and then killing it), the
> delay was seemingly indefinite, as it is with my usual workflow with X,
> emacs, firefox, etc. running (but I always kill them before invoking
> `shutdown -h now' from a tty).  During the bisection I tested each
> kernel build by running startx, emacs, firefox, killing these, then
> `shutdown -h now'.  I've attached the git log of the bisection augmented
> with power-off timing notes.  (FWIW, when I reboot the machine with
> `shutdown -r now' there is no delay with the problematic kernels.)

So reboot is not affected, just the halt. Could you please check if the
"poweroff" variant is also affected?

…
> Another pointer I got was to the recent commit 62849a96, which fixes a
> bug due to the commit that causes my problem.  I applied 62849a96 to
> 5.6.4, but it did not prevent the delay/hang.

You should see a warning if you were facing the problem described in the
commit.

…
>                                     Please let me know if there's any
> other information I can provide or anything else I can do to help with
> debugging this issue.  I hope you can fix it.

Can you send dmesg output of the system / lspci -k? I'm mainly
interested what drivers are bound to storage devices (you can send it
offlist if you want).

Can you log the output on the serial console?

If the commit you cited is really the problem then it would mean that a
worker isn't scheduled for some reason. Could you please enable
CONFIG_WQ_WATCHDOG to see if workqueue core code notices that a worker
isn't making progress?

> Thanks,
> Steve Berman

Sebastian
