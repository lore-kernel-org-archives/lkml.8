Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE0C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BE246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582821528;
	bh=anbSeKn4xU2mzevjDtEBX87CI2iq94Uc7JA+ZiMfyIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vzO7VGO2ywZcD/v6ZxNrUUr0NnE9gxGce4Jq2eBx89pYOjPBhuwEGqGigqPWDm706
	 v69Tg1fzW1+lYZUcQaJL+/LrVK3BJxfPt8FCV7XzPV3fMzbiVAD43Xt4PPaIl3Pfpg
	 UVtqZKAx+waLkPxEjPe7vDNdWyeufWjF4yDEvzgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgB0Qir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbgB0Qiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:38:46 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47FBA2469C;
        Thu, 27 Feb 2020 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582821525;
        bh=anbSeKn4xU2mzevjDtEBX87CI2iq94Uc7JA+ZiMfyIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFZlZ9rb/YqyB6VM7JPuL1dDEWOyonrNW/I/W5NW5GzoLp3cMqsRNjKxGAoyBHeyR
         mEZANRFMyCIyPAedNMlBjI6vLgR8qMjqs8OLCcIlJi+zB4eoh2QHNa7pTCiOHplqJv
         9KG96Dxy1zVFFEFZhDqx+yLVTlDZw/AqejVomxYM=
Date:   Fri, 28 Feb 2020 01:38:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING dependency
 issue
Message-Id: <20200228013841.c5d50d881a3ec0f87d273bbe@kernel.org>
In-Reply-To: <CAMuHMdUXqH6yE17Us+k7T4VnhyiWdRuEexWXMyc9x5yuT_41vg@mail.gmail.com>
References: <20200225220551.d9a409bc04b77cdf48eae3ea@kernel.org>
        <158264140162.23842.11237423518607465535.stgit@devnote2>
        <CAMuHMdW+JECxNPX8yDswARq+fLXig7VAo0oosCPAkZhtc_XR0g@mail.gmail.com>
        <20200227092518.2096344e@gandalf.local.home>
        <CAMuHMdUXqH6yE17Us+k7T4VnhyiWdRuEexWXMyc9x5yuT_41vg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 15:33:44 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Steven,
> 
> On Thu, Feb 27, 2020 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 27 Feb 2020 10:18:08 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Feb 25, 2020 at 4:47 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > Since commit d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by
> > > > default") also changed the CONFIG_BOOTTIME_TRACING to select
> > > > CONFIG_BOOT_CONFIG to show the boot-time tracing on the menu,
> > > > it introduced wrong dependencies with BLK_DEV_INITRD as below.
> > > >
> > > > WARNING: unmet direct dependencies detected for BOOT_CONFIG
> > > >   Depends on [n]: BLK_DEV_INITRD [=n]
> > > >   Selected by [y]:
> > > >   - BOOTTIME_TRACING [=y] && TRACING_SUPPORT [=y] && FTRACE [=y] && TRACING [=y]
> > > >
> > > > This makes the CONFIG_BOOT_CONFIG selects CONFIG_BLK_DEV_INITRD to
> > > > fix this error and make CONFIG_BOOTTIME_TRACING=n by default, so
> > > > that both boot-time tracing and boot configuration off but those
> > > > appear on the menu list.
> > > >
> > > > Fixes: d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by default")
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > ---
> > > >  init/Kconfig         |    2 +-
> > > >  kernel/trace/Kconfig |    1 -
> > > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index a84e7aa89a29..8b4c3e8c05ea 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1217,7 +1217,7 @@ endif
> > > >
> > > >  config BOOT_CONFIG
> > > >         bool "Boot config support"
> > > > -       depends on BLK_DEV_INITRD
> > > > +       select BLK_DEV_INITRD
> > > >         help
> > > >           Extra boot config allows system admin to pass a config file as
> > > >           complemental extension of kernel cmdline when booting.
> > > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > > index 795c3e02d3f1..402eef84c859 100644
> > > > --- a/kernel/trace/Kconfig
> > > > +++ b/kernel/trace/Kconfig
> > > > @@ -145,7 +145,6 @@ config BOOTTIME_TRACING
> > > >         bool "Boot-time Tracing support"
> > > >         depends on TRACING
> > >
> > > Why not "depends on BLK_DEV_INITRD?" here?
> > >
> > > /me tries to contain the bloat introduced by the bootconfig stuff.
> >
> > Because people like me will be scratching my head trying to figure out why
> > I don't see Boot-time Tracing support ;-)
> 
> AFAIUI, without using an initrd, your fancy bootconfig cannot be appended
> anywhere anyway?

Hm, this is a good motivation for me to find a way to append the bootconfig
to kernel image itself. :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
