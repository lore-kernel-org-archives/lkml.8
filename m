Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7DEC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F06217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581081454;
	bh=Wh+aHr1NwR/7KKHMurCrnVibPU11CvnUs69GsuGeCdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MYmcjgaQxD3xey+mBKFXdTB3/DdyEpwhW/jfRO9iuWC4ej8q7DLKt3QSWzds3AORp
	 k/dr8kbGs+STVoRvjbe8W+VCcor3e5nBEYBlma5nKMUq/ACUQ9m2cR871Jr5Y56EuM
	 1dAqQt3Y649jgAOpysAEH+VxukpzxSc2I7HZV8wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGNRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:17:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A1921741;
        Fri,  7 Feb 2020 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581081452;
        bh=Wh+aHr1NwR/7KKHMurCrnVibPU11CvnUs69GsuGeCdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNHkG0Je9VOsZhBmi0gzPOvS79dhT9Y9WH+g7Bjv7dTp2Gya7FdUgsqCECKVOdJip
         M5PP18yP0bVCzAKk/aG0Rq5YQgQC0US4sGL3p46JFKAefPsL0HcAikpJEbvFUFi3n/
         Plu8x3XLmVc59ikgo7h8NL/Zfs1FAPynvW0wrJBM=
Date:   Fri, 7 Feb 2020 22:17:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200207221728.b79eecfe98b99bb4b2f4cc42@kernel.org>
In-Reply-To: <CAMuHMdVW74CKL-HYJS1YcK2KDew5db6TudC3O7vxk6mjmHxAvg@mail.gmail.com>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <CAMuHMdVq1FFBV+XBq-BkLbCb-ZmkKvVMQ4xACxF-+2Wc3mnnNg@mail.gmail.com>
        <20200207093003.93711310cfafae98bb2a62f6@kernel.org>
        <CAMuHMdVW74CKL-HYJS1YcK2KDew5db6TudC3O7vxk6mjmHxAvg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, 7 Feb 2020 09:49:02 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hiramatsu-san,
> 
> On Fri, Feb 7, 2020 at 1:30 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Thu, 6 Feb 2020 18:20:15 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Feb 6, 2020 at 3:42 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > On Thu, 6 Feb 2020 12:54:05 +0100
> > > > Borislav Petkov <bp@alien8.de> wrote:
> > > > > On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> > > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > > index a34064a031a5..63450d3bbf12 100644
> > > > > > --- a/init/Kconfig
> > > > > > +++ b/init/Kconfig
> > > > > > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> > > > > >
> > > > > >  endif
> > > > > >
> > > > > > +config BOOT_CONFIG
> > > > > > +   bool "Boot config support"
> > > > > > +   select LIBXBC
> > > > > > +   default y
> > > > >
> > > > > Any particular reason this is default y? Why should it be enabled by
> > > > > default on all boxes?
> > > >
> > > > Oh, you are not the first person asked that :)
> > > >
> > > > https://lkml.org/lkml/2019/12/9/563
> > > >
> > > > And yes, I think this is important that will useful for most developers
> > > > and admins. Since the bootconfig already covers kernel and init options,
> > > > this can be a new standard way to pass args to kernel boot.
> > > >
> > > > And as I reported above thread, the memory footpoint of view, most code
> > > > and working memory are released after boot. Also, as Linus's suggested,
> > > > now this feature is enabled only if user gives "bootconfig" on the kernel
> > > > command line. So the side effect is minimized.
> > >
> > > With m68k/atari_defconfig, bloat-o-meter says:
> > >
> > >     add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)
> > >
> > > which is IMHO not that small for a "default y" option that may or may not
> > > be used.
> > >
> > > Especially:
> > >
> > >         Function                                     old     new   delta
> > >     xbc_nodes                                      -    8192   +8192
> > >
> > > Any chance xbc_nodes can be allocated dynamically, and only when needed?
> >
> > Yes, I think we can use memblock to allocate it. However, this xbc_nodes is
> 
> Good.
> 
> > __init_data, which is released right after boot. So I think it should be
> > OK except for your system doesn't have user space...
> 
> __initdata is still part of the kernel image (note that we no longer
> have __initbss) and consumes RAM early on, and is thus subject to e.g.
> bootloader[1] and platform limitations (e.g. the kernel must fit in the
> first block of physical memory).
> So trying to avoid large static arrays is useful.

OK, I'll replace it with memblock. Then it will be 5 - 6KB in total.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
