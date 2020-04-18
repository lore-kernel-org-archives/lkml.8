Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C5C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92E221D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220768;
	bh=qQJgMOooEtedMzMts41BbX4i4dAdvd931W+ZKmtKv8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jucOHbE428F4tYqbBF7LWDa7QfHIrotNPVRPV+AqIo2TZRHLtII1TzttYVpayxg/A
	 wzOimi47Lb2d40sLwH/r70YV0xTh9/JW9xguAVadr/2pvT/Ykp/4KWEE+8ZtwL37TH
	 ii6pI7Qzv0dVhK+jSB62CbatMT0W0fpGn2Sbw9i4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDROj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDROj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443BC21974;
        Sat, 18 Apr 2020 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220766;
        bh=qQJgMOooEtedMzMts41BbX4i4dAdvd931W+ZKmtKv8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9EK2swz5XvWX1LxrZv9QY67nbt5P9yi88uEnD+0ZO5wIsmb5VG+8LzM7USbPD7nw
         s5ULpgvr1RK7XAE5Roj9nmfyV4VGqltF75ke/xmlt7XBnCJsLzAJdfVAreHqetUycL
         STIenaXbXMaOBU2ZLnUPSDHJk5/KxlJCWBDYGVr4=
Date:   Sat, 18 Apr 2020 16:39:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
Message-ID: <20200418143924.GA3485638@kroah.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200413081426.GA2791586@kroah.com>
 <85d9c411-f205-56bf-df6b-6d4fa39a134b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d9c411-f205-56bf-df6b-6d4fa39a134b@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:28:22PM +0900, Tetsuo Handa wrote:
> On 2020/04/13 17:14, Greg Kroah-Hartman wrote:
> >> @@ -2223,4 +2223,15 @@ config HYPERV_TESTING
> >>  
> >>  endmenu # "Kernel Testing and Coverage"
> >>  
> >> +menuconfig TWEAK_KERNEL_BEHAVIOR
> >> +	bool "Tweak kernel behavior"
> >> +	help
> >> +	  Saying Y here allows modifying kernel behavior via kernel
> >> +	  config options which will become visible by selecting this
> >> +	  config option.
> > 
> > This "help" text really only says "say Y here to allow for some config
> > options".  It doesn't explain what these are for, or why anyone would
> > select them, or what type of options are here at all.
> > 
> > I don't see how this option, by just looking at it, relates to your goal
> > of doing things to make fuzzers' lives easier.
> 
> Well, we could add some more text (like shown below), but this option itself
> is neutral. This option is not limiting the target to fuzzers.
> Below 3 patches are an example of "a set of fine-grained configs" with
> "some umbrella uber-config" approach. Linus, are you OK with this approach?

Note, the word "tweak" is usually used where people want to get the most
performance out of a system, while here you are using it to remove
functionality out of the system.  You might want to pick a different
word, naming is hard :(

Anyway, a comment on your patch:

> >From f7f668896e188217b50c50a31c4ad1acb7556b36 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 18 Apr 2020 22:39:38 +0900
> Subject: [PATCH 2/3] tweak: Allow disabling k_spec() function in drivers/tty/vt/keyboard.c
> 
> syzbot is reporting unexpected kernel reboots [1]. This seems to be
> caused by triggering Ctrl-Alt-Del event via k_spec() function in
> drivers/tty/vt/keyboard.c file, for the console output includes normal
> restart sequence. Therefore, allow disabling only k_spec() function
> in order to allow fuzzers to examine the remaining part in that file.
> 
> [1] https://syzkaller.appspot.com/bug?id=321861b1588b44d064b779b92293c5d55cfe8430
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/vt/keyboard.c | 2 ++
>  lib/Kconfig.tewak         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 15d33fa0c925..f08855c4c5ba 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -633,6 +633,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
>  	     kbd->kbdmode == VC_OFF) &&
>  	     value != KVAL(K_SAK))
>  		return;		/* SAK is allowed even in raw mode */
> +	if (IS_ENABLED(CONFIG_TWEAK_DISABLE_KBD_K_SPEC_HANDLER))
> +		return;

Are you sure this is correct?  It seems like you just cut off a number
of other keyboard function handlers instead of just the ctrl-alt-del
functionality.  Did you really want to do that?

thanks,

greg k-h
