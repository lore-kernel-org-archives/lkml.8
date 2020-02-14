Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE22C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB5B222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgBNGIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:08:40 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:50843 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgBNGIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:08:40 -0500
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 64818100003;
        Fri, 14 Feb 2020 06:08:36 +0000 (UTC)
Date:   Thu, 13 Feb 2020 22:08:34 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Applying pipe fix this merge window?
Message-ID: <20200213225952.GA5902@localhost>
References: <20200208083604.GA86051@localhost>
 <CAHk-=whdiabQ0dqVDJ0_5dfur7f2D5oESCjv34f4svrK3RJj=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whdiabQ0dqVDJ0_5dfur7f2D5oESCjv34f4svrK3RJj=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:03:26PM -0800, Linus Torvalds wrote:
> And I realized that I find it surprising that it makes your build
> times noticeably better.
> 
> Yes, I have that silly example program to show the issue in the commit
> message, and yes, the exclusive directed write->read wakeups should
> most definitely improve by that commit.
> 
> But the make jobserver code ends up using "poll()/pselect()" and
> non-blocking reads, because of how it handles the child death signals.
> 
> Which means that none of the nice exclusive directed write->read
> wakeups should even trigger in the first place, because the readers
> never block, and he poll/pselect code doesn't use exclusive wakeups
> (because it can't - it doesn't actually consume the data).
> 
> So I was looking at it, and going "it should actually not help GNU
> jobserver at all" in the fixed jobserver case.

I dug into this a little further yesterday and today:

- With hindsight, I realized that the performance improvements I
  observed for GNU make didn't measure the pipe fix in isolation; they
  measured 5.4 versus ~5.5-rc4 plus the pipe fix, which would include
  all the other pipe work in 5.5 and potentially other optimizations.
  *That* showed substantial performance improvements in GNU make, on the
  order of a couple of seconds in a 30-60 second kernel build. ("5.5-rc4
  plus pipe fix" is what I hammered on for a month on various systems.)

- Measuring the pipe fix patch in isolation
  (0bf999f9c5e74c7ecf9dafb527146601e5c848b9, with and without the pipe
  fix reverted, with nothing else changed), GNU make performance indeed
  doesn't show any difference.

- Other things that use the GNU make jobserver (with pipe fds in
  blocking mode) benefit much more heavily, in wall-clock time and in
  total CPU time. I saw jobs that involved just a minute or two of
  wall-clock time, where the total CPU time went down by *minutes*.

Hope that helps,
Josh Triplett
