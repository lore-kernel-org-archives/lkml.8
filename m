Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC90C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F592082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581386533;
	bh=ZionIfc0gJyrO2taTIjl+OmJyY0BF7Kh4yrggTreWcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XG4HqgWMXOepoXJathihJDs5xTd/EyF7+MUKmJ/Ws73E2sZVLEeMVvdd1fxHB2GCy
	 qslt3XUiAsHezgiLmAeuqqW/fyur54Yv0Xkq2Ogv9iUbFZTUalYGS3Ng4Bv0/S/9S2
	 YcfNq6alYuVzBQaa1cSiR/fagfokyga1f0R5Dz9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBKCCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgBKCCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:02:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9E02070A;
        Tue, 11 Feb 2020 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581386531;
        bh=ZionIfc0gJyrO2taTIjl+OmJyY0BF7Kh4yrggTreWcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ro6K2cnHNwuVa6lxNLaH5gQnV1RcDSIrR12eCmu0KB99Snxj/1ZbGoyswRAkTjb3l
         v54KJeg22PFgB/Q+Hpj0FG6Rxa+YdCQiQwdWAKsj8E5AOI7yDca0ljg5uJBW8rPdzW
         QiSowF4eOV3gduvAEY0n2BFBSMOk3ZDm5sNAOtR0=
Date:   Tue, 11 Feb 2020 11:02:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
In-Reply-To: <20200210174053.GD29627@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
        <20200211001007.62290c743e049b231bdd7052@kernel.org>
        <20200210174053.GD29627@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 18:40:53 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 11, 2020 at 12:10:07AM +0900, Masami Hiramatsu wrote:
> > Sure, there are some examples under Documentation/trace/boottime-trace.rst.
> > Since the tracefs (ftrace's filesystem user interface) is extensible
> > by dynamic events and instanses, I need flexibility of option "keys"
> > not only values, also I need structured settings because some keys
> > will configure same events or trace instance.
> 
>  [ ... ]
> 
> Yap, gotcha. It makes a lot of sense for you guys because you don't want
> to be typing all those long ftrace command lines on every boot. And the
> command line in grub can become too long and hard to handle too.

Thanks :)

> 
> > 1) write a following bootconfig file
> > ----
> > kernel {
> > 	# root device and resume devices
> > 	root = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part2
> > 	resume = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part1
> > 	ro			# Mount root device readonly.
> > 	debug			# boot with debug log
> > 	ignore_loglevel	# this will print all messages
> > 	log_buf_len = 16M	# So expand log buffer to 16MB
> > 	no_console_suspend	# Debugging suspend process
> > 	mem_encrypt = off	# Set AMD SME to off
> > }
> > 
> > init {
> > 	net.ifnames = 0	# Use tradisional ifname
> > 	systemd.log_target = null	# Ignore systemd log?
> > }
> 
> Ok.
> 
> However, this has a downside. When you request dmesg from a user because
> you're debugging an issue - and we do that all the time - if the command
> line were in a config file, we would have to see that config file too.
> 
> VS now, it is simply in dmesg.

The above kernel.* and init.* are merged into the legacy command line
before printing it out to dmesg. For boot-time tracing, yes, we need
/proc/bootconfig too.


> > Boot time tracing is just a example. I think we can expand this for some
> > other subsystems too. And this might be also helpful for adding a bit more
> > complex syntax to those parameters without parser.
> 
> Yes, I think I see it now. And I still don't think you want this enabled
> by default on every box. It is expressed perfectly fine here:
> 
> config BOOTTIME_TRACING
>         bool "Boot-time Tracing support"
>         depends on BOOT_CONFIG && TRACING

Hm, at least "select BOOT_CONFIG" so that user can see this option is
there on menuconfig :)

> so if distros want to enable that, they will enable BOOT_CONFIG too,
> transitively. And other subsystems would simply depend on it the same if
> they wanna use bootconfig.
> 
> But the way we supply command line args now ain't broke. And they normal
> user doesn't care - grub simply pastes them everywhere.
> 
> Don't get me wrong - I don't mind using a bootconfig. I simply don't see
> a compelling argument to have it enabled everywhere and by default and
> think that other stuff selecting it is perfectly fine. IMO, of course.

Sorry, you might misunderstand that the bootconfig replaces legacy command
line. No, the legacy command line is still there and at least the part of
suppremental command line parts of bootconfig are merged into the command
line and shown in dmesg. So even if the user use bootconfig, their kernel
command line was just updated, they can grub it and simply paste on other
machine (if it accepts longer command line)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
