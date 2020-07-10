Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB30E207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594364056;
	bh=hAo1d5SeZ+9Ir6Berd242hyxR+xiYbCPkvLNBYYxLg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bkyzJ3GOjWvvLHg/PGYCg2kCXA3/HGjKx6UExMWGhE7cE1EIBaRmwCjmGwtxk/zew
	 LU4bNoU0b602gjqp8c957sycSV8jqNxktB3Mw/NocFz3CqFfe50y5qiU2x4GKnLkZP
	 +SDYJY6RBLzZ6DPcQlb7FIXfQb/OaZYEwcbGvcng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGJGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:54:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A1820672;
        Fri, 10 Jul 2020 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594364053;
        bh=hAo1d5SeZ+9Ir6Berd242hyxR+xiYbCPkvLNBYYxLg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgGTpYG0ROo7VSeWVfg/qkrMjJE89H59E7dT58DR/GdnswkSOq7tv08qo+LRkPwOT
         b1Jldmb6DLvkB6MCVK0LyI/HC5wHnl2h8CTGFwKZezK3G6CQBkpV5w1O22+ttWD3YO
         TMRbZhRkc90cYDrSI1Cq3t014Rj5HorMrCzJ9FwQ=
Date:   Fri, 10 Jul 2020 08:54:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, Mattias Nissler <mnissler@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] binder: Prevent context manager from incrementing
 ref 0
Message-ID: <20200710065418.GA1143105@kroah.com>
References: <20200709223948.1051613-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709223948.1051613-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:39:48AM +0200, Jann Horn wrote:
> Binder is designed such that a binder_proc never has references to
> itself. If this rule is violated, memory corruption can occur when a
> process sends a transaction to itself; see e.g.
> <https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.
> 
> There is a remaining edgecase through which such a transaction-to-self
> can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
> access:
> 
>  - task A opens /dev/binder twice, creating binder_proc instances P1
>    and P2
>  - P1 becomes context manager
>  - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
>    handle table
>  - P1 dies (by closing the /dev/binder fd and waiting a bit)
>  - P2 becomes context manager
>  - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
>    handle table
>    [this triggers a warning: "binder: 1974:1974 tried to acquire
>    reference to desc 0, got 1 instead"]
>  - task B opens /dev/binder once, creating binder_proc instance P3
>  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
>    transaction)
>  - P2 receives the handle and uses it to call P3 (two-way transaction)
>  - P3 calls P2 (via magic handle 0) (two-way transaction)
>  - P2 calls P2 (via handle 1) (two-way transaction)
> 
> And then, if P2 does *NOT* accept the incoming transaction work, but
> instead closes the binder fd, we get a crash.
> 
> Solve it by preventing the context manager from using ACQUIRE on ref 0.
> There shouldn't be any legitimate reason for the context manager to do
> that.
> 
> Additionally, print a warning if someone manages to find another way to
> trigger a transaction-to-self bug in the future.
> 
> Cc: stable@vger.kernel.org
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Todd Kjos <tkjos@google.com>
> ---
> sending again because I forgot to CC LKML the first time... sorry about
> the spam.

This spits out a bunch of warnings when built, how did it work on your
end?

drivers/android/binder.c: In function ‘binder_thread_write’:
./include/linux/kern_levels.h:5:18: warning: format ‘%d’ expects a matching ‘int’ argument [-Wformat=]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
./include/linux/printk.h:507:10: note: in definition of macro ‘printk_ratelimited’
  507 |   printk(fmt, ##__VA_ARGS__);    \
      |          ^~~
./include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
   14 | #define KERN_INFO KERN_SOH "6" /* informational */
      |                   ^~~~~~~~
./include/linux/printk.h:527:21: note: in expansion of macro ‘KERN_INFO’
  527 |  printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |                     ^~~~~~~~~
drivers/android/binder.c:147:4: note: in expansion of macro ‘pr_info_ratelimited’
  147 |    pr_info_ratelimited(x); \
      |    ^~~~~~~~~~~~~~~~~~~
drivers/android/binder.c:3646:7: note: in expansion of macro ‘binder_user_error’
 3646 |       binder_user_error("%d:%d context manager tried to acquire desc 0\n");
      |       ^~~~~~~~~~~~~~~~~
./include/linux/kern_levels.h:5:18: warning: format ‘%d’ expects a matching ‘int’ argument [-Wformat=]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
./include/linux/printk.h:507:10: note: in definition of macro ‘printk_ratelimited’
  507 |   printk(fmt, ##__VA_ARGS__);    \
      |          ^~~
./include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
   14 | #define KERN_INFO KERN_SOH "6" /* informational */
      |                   ^~~~~~~~
./include/linux/printk.h:527:21: note: in expansion of macro ‘KERN_INFO’
  527 |  printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |                     ^~~~~~~~~
drivers/android/binder.c:147:4: note: in expansion of macro ‘pr_info_ratelimited’
  147 |    pr_info_ratelimited(x); \
      |    ^~~~~~~~~~~~~~~~~~~
drivers/android/binder.c:3646:7: note: in expansion of macro ‘binder_user_error’
 3646 |       binder_user_error("%d:%d context manager tried to acquire desc 0\n");
      |       ^~~~~~~~~~~~~~~~~


thanks,

greg k-h
