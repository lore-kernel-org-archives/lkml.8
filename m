Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE3C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170821741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581088014;
	bh=1HwKuSYV6GSjImawX62cIYl7Ls42HQRQWIKPByCh81s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y2u7jvAienZ63MAS5O2421vrq+o8cT23G8fMU015tQ/Hkmb4Mh437RD+OuEjUimKS
	 GXuoAWukC4Nh4ABDm8WVDIr6/XCMQ9jhgh7I6FN/eBWH6GeaWdRnC+s4Lu0UT8woJ3
	 qXbrIopimo0BSEZhCKZpMql3jIc26FxTKhla1sWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBGPGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:06:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52F120838;
        Fri,  7 Feb 2020 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581088012;
        bh=1HwKuSYV6GSjImawX62cIYl7Ls42HQRQWIKPByCh81s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sxzd8fuAv4Irow4aVK+DV2AUdkcLqaK2ev6HrV0Xcb8FMW4+F9UWEKcVdIilkws6w
         OWVy+au2YXowfk18DtDvDrD20JSpewDEHSERwjVIs9orjaCLTPCiF9PGXRRAbFc3eG
         rF+zJCz8ODegqVp9A3eq7acVG0XCd5MZKjbgHh/c=
Date:   Sat, 8 Feb 2020 00:06:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200208000648.3383f991fee68af5ee229d65@kernel.org>
In-Reply-To: <20200207114122.GB24074@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 12:41:22 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Feb 07, 2020 at 11:46:17AM +0900, Masami Hiramatsu wrote:
> > It could change some other things. I recommend developers to use this
> > feature to configure their subsystem easier and admins to configure
> > kernel boot options more readable way.
> 
> Well, I could use an actual justification for why I would need it.
> Because, frankly, I haven't sat down and thought: "hmm, this boot
> command line supplement thing is awful and I need a better one." IOW,
> it has never bothered me so far. But I'm always open to improvements as
> long as they don't make it worse. :)

OK, could you tell me your idea to make it better? I'm waiting for such
discussion a half of last year :)

For your information, here is the background of this bootconfig.
To build my boot-time tracing, I need a way to pass a flexible and
structured configuration at boot time.
I had tried to reuse devicetree at first, but it was rejected because
the devicetree is only for describing hardware. So I introduced this
bootconfig.
When I designed the bootconfig, I tried to sort out the requirements.
That config should be able to pass all setting we can do on tracefs.
Since ftrace already has a parser for tracefs, we don't need any types
for each settings. Thus it should be something like sysctl.conf. But the
sysctl.conf was too simple, it couldn't handle several related keys
well. So I decided to introduce braces which put together some related
parameters. And the bootconfig syntax was born.

I see that current piggyback method might look a bit odd. My first
implementation was bootloader based method (I implemented it on grub and
qemu), but that was not useful, especially it required user to replace
their bootloader...

> > Many distros may not use it unless it is default y. I couldn't find any
> > good example that the feature "default n" turns into "default y".
> > Would you have any example?
> 
> We - SUSE - always reevaluate our configs for the next service pack and
> enable things which make sense and customers use. So all the new drivers
> get enabled, kernel infra which makes sense too, etc.
> 
> If the bootconfig thing proves useful, I will glady enable it in our
> tree.

Okay, I hope it and try to prove it. Anyway, to use boot-time tracing which
can fully utilize ftrace at boot-time, we have to enable bootconfig.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
