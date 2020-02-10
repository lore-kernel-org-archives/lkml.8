Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A56C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFABA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581347413;
	bh=vTR6ay2rTMWbD7WmnoyN014vTkNPpyTlmii8NwEA79A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jmSR7ke4pmzenARZMbpI2iHiZACFlzbWp2jIB3nCwfJhG815YBDNeNwVDDXxCCuF4
	 GAvOKIFcYIt0Ff2Ys4kTA2ePP5nH+PkyT06JCT+sj2AK+vI1wmxIRjYep+Ro8SKjpy
	 TSJbH+l4Par9nQxy2Wu+9DQIG10WdobYlljHlrSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgBJPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbgBJPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:10:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4EB20661;
        Mon, 10 Feb 2020 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581347411;
        bh=vTR6ay2rTMWbD7WmnoyN014vTkNPpyTlmii8NwEA79A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u4dnRcarX25/fF73QozHItzoHS4cTCd/yH7muQpEKWQyTWvZtZJvmYP2eGJXcidW0
         SyGsw2xbHDgnFZQvGXi5qljU8VTvithIR2j8RQMqU3lbNmAIMmJLa1ZSD1gFyRuJDk
         NE7F4nsH+QLuGQZXW9y2Pc22zGuP6uAALGmuCOBQ=
Date:   Tue, 11 Feb 2020 00:10:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200211001007.62290c743e049b231bdd7052@kernel.org>
In-Reply-To: <20200210112512.GA29627@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 12:25:13 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Feb 08, 2020 at 12:06:48AM +0900, Masami Hiramatsu wrote:
> > OK, could you tell me your idea to make it better? I'm waiting for such
> > discussion a half of last year :)
> 
> Yah, situation sounds familiar. :)
> 
> > For your information, here is the background of this bootconfig.
> > To build my boot-time tracing, I need a way to pass a flexible and
> > structured configuration at boot time.
> 
> Can I see an actual example of what you're doing?

Sure, there are some examples under Documentation/trace/boottime-trace.rst.
Since the tracefs (ftrace's filesystem user interface) is extensible
by dynamic events and instanses, I need flexibility of option "keys"
not only values, also I need structured settings because some keys
will configure same events or trace instance.
For example, ftrace has tracing instances (which represents different
trace logs) which has some set of configuration parameters. Some
parameters has sub-parameters (trace options), and most parameters
have default parameters. I don't want to make it a single parametarized
options, like ftrace.instance="NAME:OPT1,OPT2:CLOCK:SIZE:SNAPSHOT:...",
because it is not human readable and easy to make mistakes.
Instead, bootconfig solve that with structured, multi-line keys;

ftrace.instance.NAME {
	options = OPT1,OPT2
	trace_clock = CLOCK
	buffer_size = SIZE
	...
}

If we have 3 or more instances, it is easy to expand it as

ftrace.instance {
	NAME1 {
		...
	}
	NAME2 {
		...
	}
	NAME3 {
		...
	}
}

(Hmm, maybe I should reserve "default" name for setting a default configuration)

> > I had tried to reuse devicetree at first, but it was rejected because
> > the devicetree is only for describing hardware. So I introduced this
> > bootconfig.
> 
> Makes sense.
> 
> > When I designed the bootconfig, I tried to sort out the requirements.
> > That config should be able to pass all setting we can do on tracefs.
> > Since ftrace already has a parser for tracefs, we don't need any types
> > for each settings. Thus it should be something like sysctl.conf. But the
> > sysctl.conf was too simple, it couldn't handle several related keys
> > well. So I decided to introduce braces which put together some related
> > parameters. And the bootconfig syntax was born.
> 
> Ok, here's my boot command line:
> 
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.5.0-rc7+ root=/dev/nvme0n1p2 ro root=/dev/disk/by-id/nvme-eui.0025385481b2fe2a-part2 resume=/dev/disk/by-id/nvme-eui.0025385481b2fe2a-part1 debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 mem_encrypt=off systemd.log_target=null
> 
> How do I use the bootconfig thing with it? Or is it not supposed to be
> used that way? IOW, how is it supposed to be used so that it needs to be
> enabled on every box?

Sure,

1) write a following bootconfig file
----
kernel {
	# root device and resume devices
	root = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part2
	resume = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part1
	ro			# Mount root device readonly.
	debug			# boot with debug log
	ignore_loglevel	# this will print all messages
	log_buf_len = 16M	# So expand log buffer to 16MB
	no_console_suspend	# Debugging suspend process
	mem_encrypt = off	# Set AMD SME to off
}

init {
	net.ifnames = 0	# Use tradisional ifname
	systemd.log_target = null	# Ignore systemd log?
}
----
2) Use tools/bootconfig/bootconfig to apply it to your initrd image
# tools/bootconfig/bootconfig -a <your-bootconfig> <your-initrd>
3) boot.

Note that I don't intended to "replace" all legacy command line
(but it is easy for bootloaders to use bootconfig) it seems above example
seems have some options which added by the bootloader.

> 
> > Okay, I hope it and try to prove it. Anyway, to use boot-time tracing which
> > can fully utilize ftrace at boot-time, we have to enable bootconfig.
> 
> Ok, this is getting closer. But not everyone is using boottime tracing?

No, (but I HOPE so). 

> 
> Or is the logic: every user/tool might need to be able to do boottime
> tracing at some future point in time and bootconfig is a mandatory part
> of that use case?

Boot time tracing is just a example. I think we can expand this for some
other subsystems too. And this might be also helpful for adding a bit more
complex syntax to those parameters without parser.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
