Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EFC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D341D217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581035409;
	bh=nIr/9PKnEgrt2GxIVCRtoJWwTwGJ9J5EHRzdrefNNgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zet5ZBJG7e6BP9tbtgwfMdI34Tc9R8BmavMKjMhA7gXBRtCGbPdIFyHYVqhplhSTp
	 lVc8FDb8Kfuq9ZZM2dz+0nGjj2YzvzQUrouENmP5jpWNgYsw0NQHgGNQFPpRyZl3+a
	 DPFfqq4XoHfq86c/5inj3hxejnBwMUuMpUzzZnW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBGAaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBGAaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:30:08 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09302064C;
        Fri,  7 Feb 2020 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581035407;
        bh=nIr/9PKnEgrt2GxIVCRtoJWwTwGJ9J5EHRzdrefNNgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M9HW/WBjhMDhYkqE8O7McctHiinjZc+KYs2P8Zvoof9LecSqM4aqWHrJ8iVoX+GBI
         unU9ZhJJzMY9Z3NwOLg//3OUucBpu7Yy0C5cIWehvlJwv1Cv7gPLQ9TbjF3FCD1sZ6
         XokEYS9iPnPBCge+5/GUwZcyd1Rfh98IsUZAZIcE=
Date:   Fri, 7 Feb 2020 09:30:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-Id: <20200207093003.93711310cfafae98bb2a62f6@kernel.org>
In-Reply-To: <CAMuHMdVq1FFBV+XBq-BkLbCb-ZmkKvVMQ4xACxF-+2Wc3mnnNg@mail.gmail.com>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <CAMuHMdVq1FFBV+XBq-BkLbCb-ZmkKvVMQ4xACxF-+2Wc3mnnNg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 18:20:15 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hiramatsu-san,
> 
> On Thu, Feb 6, 2020 at 3:42 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Thu, 6 Feb 2020 12:54:05 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> > > On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index a34064a031a5..63450d3bbf12 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> > > >
> > > >  endif
> > > >
> > > > +config BOOT_CONFIG
> > > > +   bool "Boot config support"
> > > > +   select LIBXBC
> > > > +   default y
> > >
> > > Any particular reason this is default y? Why should it be enabled by
> > > default on all boxes?
> >
> > Oh, you are not the first person asked that :)
> >
> > https://lkml.org/lkml/2019/12/9/563
> >
> > And yes, I think this is important that will useful for most developers
> > and admins. Since the bootconfig already covers kernel and init options,
> > this can be a new standard way to pass args to kernel boot.
> >
> > And as I reported above thread, the memory footpoint of view, most code
> > and working memory are released after boot. Also, as Linus's suggested,
> > now this feature is enabled only if user gives "bootconfig" on the kernel
> > command line. So the side effect is minimized.
> 
> With m68k/atari_defconfig, bloat-o-meter says:
> 
>     add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)
> 
> which is IMHO not that small for a "default y" option that may or may not
> be used.
> 
> Especially:
> 
>         Function                                     old     new   delta
>     xbc_nodes                                      -    8192   +8192
> 
> Any chance xbc_nodes can be allocated dynamically, and only when needed?

Yes, I think we can use memblock to allocate it. However, this xbc_nodes is
__init_data, which is released right after boot. So I think it should be
OK except for your system doesn't have user space...

> Yes, there are industrial products running Linux on a current ARM SoC
> using the builtin 8 or 10 MiB of SRAM (+ XIP for the kernel), so these
> definitely want to say CONFIG_BOOT_CONFIG=n.

I think for such products the kernel must be tuned with custom config,
and you can say CONFIG_BOOT_CONFIG=n. That is a configurable feature.

Thank you,

> 
> Thanks!
> 
> add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)
> Function                                     old     new   delta
> xbc_nodes                                      -    8192   +8192
> xbc_init                                       -     854    +854
> start_kernel                                1020    1580    +560
> copy_xbc_key_value_list                        -     362    +362
> __xbc_parse_value                              -     324    +324
> xbc_snprint_cmdline                            -     294    +294
> xbc_node_compose_key_after                     -     266    +266
> xbc_namebuf                                    -     256    +256
> xbc_add_sibling                                -     254    +254
> xbc_node_find_next_leaf                        -     186    +186
> xbc_node_find_child                            -     176    +176
> __xbc_add_key                                  -     162    +162
> proc_boot_config_init                          -     124    +124
> xbc_make_cmdline                               -     122    +122
> xbc_node_find_value                            -     104    +104
> xbc_node_find_next_key_value                   -     102    +102
> __xbc_close_brace                              -      92     +92
> find_match_node                                -      80     +80
> __xbc_parse_keys                               -      78     +78
> xbc_node_get_data                              -      64     +64
> xbc_parse_key                                  -      60     +60
> skip_comment                                   -      48     +48
> xbc_destroy_all                                -      42     +42
> xbc_node_get_parent                            -      38     +38
> xbc_parse_error                                -      36     +36
> xbc_node_get_child                             -      34     +34
> xbc_node_get_next                              -      32     +32
> boot_config_checksum                           -      30     +30
> boot_config_proc_show                          -      26     +26
> xbc_root_node                                  -      20     +20
> kzalloc.constprop                            810     830     +20
> xbc_node_index                                 -      14     +14
> xbc_node_num                                   -       4      +4
> xbc_data_size                                  -       4      +4
> xbc_data                                       -       4      +4
> saved_boot_config                              -       4      +4
> last_parent                                    -       4      +4
> extra_init_args                                -       4      +4
> extra_command_line                             -       4      +4
> __initcall_proc_boot_config_init5              -       4      +4
> xbc_debug_dump                                 -       2      +2
> Total: Before=3688860, After=3701946, chg +0.35%
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


-- 
Masami Hiramatsu <mhiramat@kernel.org>
