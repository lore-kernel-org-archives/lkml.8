Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0C222B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgHEUFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:05:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgHEQfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1583AAEF5;
        Wed,  5 Aug 2020 14:04:49 +0000 (UTC)
Date:   Wed, 5 Aug 2020 16:04:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     corbet@lwn.net, rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        chunyan.zhang@unisoc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Re: [PATCH V13] printk: Add monotonic, boottime, and realtime
 timestamps
Message-ID: <20200805140430.GI24529@alley>
References: <20200729114423.30606-1-zhang.lyra@gmail.com>
 <20200729122236.17418-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729122236.17418-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-07-29 08:22:36, Prarit Bhargava wrote:
>   Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > From: Prarit Bhargava <prarit@redhat.com>
> > 
> > printk.time=1/CONFIG_PRINTK_TIME=1 adds a unmodified local hardware clock
> > timestamp to printk messages.  The local hardware clock loses time each
> > day making it difficult to determine exactly when an issue has occurred in
> > the kernel log, and making it difficult to determine how kernel and
> > hardware issues relate to each other in real time.
> > 
> > Make printk output different timestamps by adding options for no
> > timestamp, the local hardware clock, the monotonic clock, the boottime
> > clock, and the real clock.  Allow a user to pick one of the clocks by
> > using the printk.time kernel parameter.  Output the type of clock in
> > /sys/module/printk/parameters/time so userspace programs can interpret the
> > timestamp.
> > 
> ISTR the reason that this was dropped was because of the a problem with
> the way systemd read the kernel's timestamps.  It got the attention of
> Linus, and it was then pulled from the tree.
> 
> I need to go back and review the entire thread as it's been several years
> since we had the discussion although ISTR someone mentioning that doing two
> timestamps would not be a problem for systemd.

I guess that you talk about this thread
https://lore.kernel.org/lkml/CA+55aFwUfA__6MgMgjENnx+_RYY2ZOOLiSx2ea1AvYhSZN+78A@mail.gmail.com/

> For example,
> 
> [48551.015086]
> 
> would be
> 
> [48551.015086] m[xxxx.xxxx]
> 
> for the monotonic clock timestamp, and
> 
> [48551.015086] b[xxxx.xxxx]
> 
> for the boottime clock, etc.

This approach has several drawbacks:

  + Too long prefix might make it hard to see the real messages
    because of shrunken/wrapped lines.

  + Too long lines are problem with slow consoles.

  + More space will be necessary to store all the time stamps.

  + Userspace tools would need/want to parse the format. We would
    need to maintain it forever.


Linus had an interesting idea to print all timestamps regularly.
The frequency might be configurable. It might print, for example,
the following line every 10 minutes or once a day:

  [48551.015086] System alive: b[xxxx.xxxx] m[xxxx.xxxx]

It might be useful in general to see when the system was still alive
before it froze.

Would it be enough to sort messages printed with different clock
sources?

Best Regards,
Petr
