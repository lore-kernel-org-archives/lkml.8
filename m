Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F5E206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ew3fcGEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBRN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:27:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRN1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:27:30 -0500
Received: from zn.tnic (p200300EC2F0C1F0028FD4265E0CDE335.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:28fd:4265:e0cd:e335])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89AFA1EC0CD1;
        Tue, 18 Feb 2020 14:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582032448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hFxRM15HM26NyrxumWRXrxY4uiJbKqEVp2xvq+9/djw=;
        b=ew3fcGEuEhnDUgEWcWklSGlyzB2TZgFb2Q5AoeeBTbAzi1ue2u2GESDvhlhkGj9SCONJDV
        zpngw05x1Jsv8FvRs/sXddC+7fnXe4eNzSAKtnSB2JTLYVlHV/atQSU8lAEtZZzvoYvu4L
        PP6CFbRl78hyR/GcQUGLH4nwHfKsWf4=
Date:   Tue, 18 Feb 2020 14:27:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200218132724.GC14449@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:02:07AM +0900, Masami Hiramatsu wrote:
> Sorry, you might misunderstand that the bootconfig replaces legacy command
> line. No, the legacy command line is still there and at least the part of
> suppremental command line parts of bootconfig are merged into the command
> line and shown in dmesg. So even if the user use bootconfig, their kernel
> command line was just updated, they can grub it and simply paste on other
> machine (if it accepts longer command line)

Ok, I did just play with the thing. I used this boot config for my guest:

---
kernel {
	root=/dev/sda1
	resume=/dev/sda2
	debug
	ignore_loglevel
	log_buf_len=16M
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	console=tty0
	no_console_suspend
}

init {
	net.ifnames=0
}
---

and added it to an initrd which I created especially for this. Which
brings me to the next issue I see: AFAIU, bootconfig requires people
to have initrd. And the majority of deployments do have initrd enabled
but there are use cases where people don't need it. So if bootconfig is
going to be default Y, it better support that case.

For example and for a similar reason I support builtin microcode in the
microcode loader - when you don't want to enable initrd.

Then, I did add the above bootconfig to the initrd:

./tools/bootconfig/bootconfig -a bootconfig /tmp/initrd.img
Apply bootconfig to /tmp/initrd.img
        Number of nodes: 21
        Size: 194 bytes
        Checksum: 16268

and booted my guest.

The thing I noticed is that the guest doesn't show any output in its
window anymore but only shows the login window when it is done booting.

And that is probably because of the console= thing. /proc/bootconfig has

$ cat /proc/bootconfig
kernel.root = "/dev/sda1"
kernel.resume = "/dev/sda2"
kernel.debug = ""
kernel.ignore_loglevel = ""
kernel.log_buf_len = "16M"
kernel.earlyprintk = "ttyS0", "115200"
kernel.console = "ttyS0", "115200", "tty0"
kernel.no_console_suspend = ""
init.net.ifnames = "0"

and bootconfig parsing has merged the console= parameters. And the same
thing happens if I boot the guest with "console=ttyS0,115200,tty0" on
the normal cmdline. But

console=ttyS0,115200 console=tty0

is not the same as

console=ttyS0,115200,tty0

Former has been this way since forever if you wanna have serial output
to ttyS* *and* tty output at the same time.

Also, I wouldn't want to rule out any other changes in behavior in
other command line options due to this change in parsing and merging of
options.

So again, I'm still not convinced bootconfig should be used everywhere
and by default.

In addition to the initrd requirement, it needs a special tool to glue
it to the end of the initrd. Yeah yeah, it is part of the kernel and the
glueing can be made part of the initrd creation tool but still, it is
one more and new step.

Now, if bootconfig can *supplement* the normal command line so that you
can add more complex configuration directives with it, in *addition* to
the normal command line, then sure, by all means.

And it seems that it does that: I did

---
kernel {
        initcall_debug
}

init {
}
---

and added it to the cmdline:

[    0.047358] Kernel command line: initcall_debug root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0  bootconfig

and you can see "initcall_debug" there and it did enable the initcall
debugging output so yeah, that seems to work.

Btw, if you remove the boot config with the tool (-d) and still boot
with "bootconfig" it says:

[    0.043958] bootconfig size -23483140 greater than max size 32767

so you need to check presence of bootconfig blob and limits in the
parsing code too or so.

In any case, this is only my opinion, of course, and I might very well
be missing something.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
