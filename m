Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C4DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895252469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSFyjzXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgB1DNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:13:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38858 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgB1DNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:13:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so745842pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rbZrsVVuXpExOD+0yCysQl+fKQbRkZWqFru2LyAoZPY=;
        b=hSFyjzXo02HWa1guRWKUeAN0VKp29votagDhE+nMAmp40Q8ZkcPXeyOAsh1ZQCM7Ub
         UGRS/RYZNljlDKVvh7DG9VqSYiJEsE1esYp1DjrG69BMsMmrCqDshMPLC/NG/mQz0whs
         SrYob3uG+0IdqympVcMBADbdLtv40r1wUgbvjts2O61sTi2REGtRsFjrSa6eWnGW6E8R
         B3kviW057ERO+PwCG8JxVxq5viQTqxy+Y2/7JLQ5tkXwZuEzKRQfawuCfBaYCW1exUeh
         xMB4+Yoz5gISKcrEWwoPIXLRtO4CAKLIPREp79xsLsQeGe5ziPevKyZhxoB7GGkkfTbC
         Z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rbZrsVVuXpExOD+0yCysQl+fKQbRkZWqFru2LyAoZPY=;
        b=IGUPoUCxOqj84rEtEvZghn3TMFUocvvisZ6iYbys3t5QQfgnySIc5EhxwLJqHeiA8g
         zVOUEZaBppEqWyBRgnQ55OZYIOvksRWURlXKV89oNudzhdFGq7tPi8tvNPUTngTPlzgz
         ldU79wAQhmTti9bKPFgBwaulYXDuYdqqxxmW3mPw5XdmxXWGAtFmFa03+fzfXxtdilnc
         DRvH5NbC8zI/e43lTgJ4lgOqMqmtxQTcIOSvlFhA12ITxghAM8SyPgXM2ALtJRtxFxTx
         PjZV3f3eljvb0dogo9zr0cgXCuKwgC/ZLTevJu9j31StHpHuro+m9ChBb5+CVI0NZaQN
         tZjQ==
X-Gm-Message-State: APjAAAUr1qKplaW7JAedH9jmGAcid5ti0+zODB6bbFgRgC1F5PJzR40G
        79CXIeWs2uwWQ1Gz2LfqxJU=
X-Google-Smtp-Source: APXvYqwDkm1/XT29PxUp9wmTcGwjpDIJw3FLru7RUern1EavSXu9MENAY1lnoH5AHZuWFDgYdY5dDQ==
X-Received: by 2002:a63:114a:: with SMTP id 10mr2386967pgr.185.1582859588967;
        Thu, 27 Feb 2020 19:13:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id h22sm7983405pgn.57.2020.02.27.19.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:13:08 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:13:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200228031306.GO122464@google.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Petr, Steven, John

https://lore.kernel.org/lkml/e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com

On (20/02/27 14:08), Lech Perczak wrote:
> W dniu 27.02.2020 o 13:39, Lech Perczak pisze:
> > W dniu 27.02.2020 o 13:36, Greg Kroah-Hartman pisze:
> >> On Thu, Feb 27, 2020 at 11:09:49AM +0000, Lech Perczak wrote:
> >>> Hello,
> >>>
> >>> After upgrading kernel on our boards from v4.19.105 to v4.19.106 we found out that syslog fails to read the messages after ones read initially after opening /proc/kmsg just after booting.
> >>> I also found out, that output of 'dmesg --follow' also doesn't react on new printks appearing for whatever reason - to read new messages, reopening /proc/kmsg or /dev/kmsg was needed.
> >>> I bisected this down to commit 15341b1dd409749fa5625e4b632013b6ba81609b ("char/random: silence a lockdep splat with printk()"), and reverting it on top of v4.19.106 restored correct behaviour.
> >> That is really really odd.
> > Very odd it is indeed.
> >>> My test scenario for bisecting was:
> >>> 1. run 'dmesg --follow' as root
> >>> 2. run 'echo t > /proc/sysrq-trigger'
> >>> 3. If trace appears in dmesg output -> good, otherwise, bad. If trace doesn't appear in output of 'dmesg --follow', re-running it will show the trace.
> >>>
> >>> I ran my tests on Debian 10.3 with configuration based directly on one from 4.19.0-8-amd64 (4.19.98-1) in Qemu.
> >>> I could reproduce the same issue on several boards with x86 and ARMv7 CPUs alike, with 100% reproducibility.
> >>>
> >>> I haven't yet digged into why exactly this commit breaks notifications for readers of /proc/kmsg and /dev/kmsg, but as reverting it fixed the issue, I'm pretty sure this is the one. It is possible that the same happened in 5.4 line, bu I hadn't had a chance to test this as well yet.
> >> I can revert this, but it feels like there is something else going wrong
> >> here.  Can you try the 5.4 tree to see if that too has your same
> >> problem?
> > Yes, I'll check it in a short while.
> I checked v5.4.22 just now and didn't observe the issue. Maybe this commit wasn't destined for 4.19.y due to intricacies of locking inside printk() :-)
> 
> From my side, there is no need to rush with the revert, as I can do this locally and drop the revert with next rebase-to-upstream, which we do very often.
> OTOH, the issue is likely to affect a lot of users, especially ones using distros tracking this branch like Debian 10 mentioned earlier,
> once they pick it up the change, as the kernel log content recorded by syslog will be affected, and 'dmesg --follow' behaviour will be quite surprising.

This is very-very odd... Hmm.
Just out of curiosity, what happens if you comment out that
printk() entirely?

printk_deferred() should not affect the PRINTK_PENDING_WAKEUP path.

Either we never queue wakeup irq_work(), e.g. because waitqueue_active()
never lets us to do so or because `(curr_log_seq != log_next_seq)' is
always zero:

void wake_up_klogd(void)
{
	preempt_disable();
	if (waitqueue_active(&log_wait)) {
		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
	}
	preempt_enable();
}

int vprintk_emit()
{
	...
	pending_output = (curr_log_seq != log_next_seq);
	...
	if (pending_output)
		wake_up_klogd()
}

Or we do wakeup, but then either `syslog_seq != log_next_seq' or
`user->seq != log_next_seq' fail.


Lech, any chance you can trace what's happening in the system?

	-ss
