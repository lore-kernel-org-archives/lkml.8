Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3595FC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686E2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582079199;
	bh=8fFQylLun6+cXpjAxmfOmKQNm6Xp2IOSmjd0Grgdgt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zcFUleDPNzAsIDjBFkRhUMFWLMluyoIWw13BW/9Jn8h7s+UqQRfWXeJdOzb/Bqzkk
	 LpYEA+FJZqvyARf3dUaOQRcDullBi8ShxznZu3AB3uQDxRy0eQLtroY7Cqj1A6SthO
	 op5tr0mIxdygCxP0wGqwlS+pIIAsCVu2VEXT8WOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBSC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgBSC0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:26:37 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8E020801;
        Wed, 19 Feb 2020 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582079196;
        bh=8fFQylLun6+cXpjAxmfOmKQNm6Xp2IOSmjd0Grgdgt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MO8oXarB3ZkCY9xieq6CmBA8iQHBtJZiAjljUMxaMDq+7d3pVTmjyGub9XRCfJEl9
         VCwfDqmCr2Gb6XD2C3MXdSN0JUlAaGtC83mE8HINmCHOU+pmry78P2YwOFQ4kJc+Ak
         gWXNhv28529Y4xNmZc/l7bU7BJNC5UzW05epkyRk=
Date:   Wed, 19 Feb 2020 11:26:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200219112632.ca2b7f683271a6864eb68149@kernel.org>
In-Reply-To: <20200218132724.GC14449@zn.tnic>
References: <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
        <20200211001007.62290c743e049b231bdd7052@kernel.org>
        <20200210174053.GD29627@zn.tnic>
        <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
        <20200218132724.GC14449@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 14:27:24 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 11, 2020 at 11:02:07AM +0900, Masami Hiramatsu wrote:
> > Sorry, you might misunderstand that the bootconfig replaces legacy command
> > line. No, the legacy command line is still there and at least the part of
> > suppremental command line parts of bootconfig are merged into the command
> > line and shown in dmesg. So even if the user use bootconfig, their kernel
> > command line was just updated, they can grub it and simply paste on other
> > machine (if it accepts longer command line)
> 
> Ok, I did just play with the thing. I used this boot config for my guest:
> 
> ---
> kernel {
> 	root=/dev/sda1
> 	resume=/dev/sda2
> 	debug
> 	ignore_loglevel
> 	log_buf_len=16M
> 	earlyprintk=ttyS0,115200
> 	console=ttyS0,115200

Ah, bootconfig syntax interprets the "," as a delimiter of array elements.
So those must be quoted by "" (or '') as below.

	earlyprintk="ttyS0,115200"
	console="ttyS0,115200"

> 	console=tty0

Oops, I forgot to support double parameters.

> 	no_console_suspend
> }
> 
> init {
> 	net.ifnames=0
> }
> ---
> 
> and added it to an initrd which I created especially for this. Which
> brings me to the next issue I see: AFAIU, bootconfig requires people
> to have initrd. And the majority of deployments do have initrd enabled
> but there are use cases where people don't need it. So if bootconfig is
> going to be default Y, it better support that case.

Yes, I think we can embed bootconfig into the kernel image while
building it as a text data. I think appending the bootconfig to kernel
image will be hard because some kernel image will be compressed and self-
extracted on memory. It might break original data.

> For example and for a similar reason I support builtin microcode in the
> microcode loader - when you don't want to enable initrd.

Thanks for the good information! I'll check it.

> Then, I did add the above bootconfig to the initrd:
> 
> ./tools/bootconfig/bootconfig -a bootconfig /tmp/initrd.img
> Apply bootconfig to /tmp/initrd.img
>         Number of nodes: 21
>         Size: 194 bytes
>         Checksum: 16268
> 
> and booted my guest.
> 
> The thing I noticed is that the guest doesn't show any output in its
> window anymore but only shows the login window when it is done booting.
> 
> And that is probably because of the console= thing. /proc/bootconfig has
> 
> $ cat /proc/bootconfig
> kernel.root = "/dev/sda1"
> kernel.resume = "/dev/sda2"
> kernel.debug = ""
> kernel.ignore_loglevel = ""
> kernel.log_buf_len = "16M"
> kernel.earlyprintk = "ttyS0", "115200"
> kernel.console = "ttyS0", "115200", "tty0"
> kernel.no_console_suspend = ""
> init.net.ifnames = "0"
> 
> and bootconfig parsing has merged the console= parameters. And the same
> thing happens if I boot the guest with "console=ttyS0,115200,tty0" on
> the normal cmdline. But
> 
> console=ttyS0,115200 console=tty0
> 
> is not the same as
> 
> console=ttyS0,115200,tty0

Yes, that is my mistake. Since the legacy command line doesn't support
array, it should be expanded. If you write it correctly, I will ensure
it to
console=ttyS0,115200 console=tty0

> 
> Former has been this way since forever if you wanna have serial output
> to ttyS* *and* tty output at the same time.
> 
> Also, I wouldn't want to rule out any other changes in behavior in
> other command line options due to this change in parsing and merging of
> options.

For the above example, I can fix it. I also would not like to change the
behaviors. Could you share your concerning items if you have more?

> 
> So again, I'm still not convinced bootconfig should be used everywhere
> and by default.
> 
> In addition to the initrd requirement, it needs a special tool to glue
> it to the end of the initrd. Yeah yeah, it is part of the kernel and the
> glueing can be made part of the initrd creation tool but still, it is
> one more and new step.
> 
> Now, if bootconfig can *supplement* the normal command line so that you
> can add more complex configuration directives with it, in *addition* to
> the normal command line, then sure, by all means.
> 
> And it seems that it does that: I did
> 
> ---
> kernel {
>         initcall_debug
> }
> 
> init {
> }
> ---
> 
> and added it to the cmdline:
> 
> [    0.047358] Kernel command line: initcall_debug root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0  bootconfig
> 
> and you can see "initcall_debug" there and it did enable the initcall
> debugging output so yeah, that seems to work.
> 
> Btw, if you remove the boot config with the tool (-d) and still boot
> with "bootconfig" it says:
> 
> [    0.043958] bootconfig size -23483140 greater than max size 32767
> 
> so you need to check presence of bootconfig blob and limits in the
> parsing code too or so.

Agreed, that's confusing message.

> 
> In any case, this is only my opinion, of course, and I might very well
> be missing something.

Thank you very much for your opinion and information!
That's very helpful to me.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
