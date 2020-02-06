Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0710EC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFFD214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBFRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:20:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44183 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBFRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:20:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so6203335otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPn+BUojxUhOvsXrFiv8dsam9EtwMGmqIOyvBWWRIVg=;
        b=my9T83Nh4DYegINCr+ppfvW59yjT/nHFV85HgfNXHa3thQ3lY+S93ZuELeJTzq+zKF
         GbBko/eGNdW7z6llOITQPZE6HQ3FlCfIT1LnZBenGAOQE+KoLQKr7COtwq9P7h6TQkaO
         hfmLu8y+s5YsMpLpih6W49bosB90wx0UldZy6/xIrfIq3eqV2NLDHvuTn14Fpf8nJFZn
         9ugyHnnoYbvXN33dZB64e+l011CstmSuEweJC2yuaweK6CYpNFA4010Z0lWosmvcFvfK
         W2f2PHoFKypshsMKDvKFLw6TedhkAGJjbKjcq89BCL6OKrHC6SUgEFSZ6VHnUO1WyEKg
         Vm5g==
X-Gm-Message-State: APjAAAUr5H/NAb/aPE65jRAhsjE0PKzBDDD3uaLxmnnEf/gXTKZsYyHv
        eSGMWxIcxs+z+kqcC03is8700xM0xWbEiEMYBjC9Qxmo
X-Google-Smtp-Source: APXvYqx+zyAEG5rElRpu+Yng0gLxdpYCjKKDUgx9uVlKE3hw10bdHLC72AOUE+idNkn/upnr3Y4BHBbMMqjQ8+LzpDI=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr31297201ots.250.1581009630530;
 Thu, 06 Feb 2020 09:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20200114210316.450821675@goodmis.org> <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic> <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
In-Reply-To: <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Feb 2020 18:20:15 +0100
Message-ID: <CAMuHMdVq1FFBV+XBq-BkLbCb-ZmkKvVMQ4xACxF-+2Wc3mnnNg@mail.gmail.com>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiramatsu-san,

On Thu, Feb 6, 2020 at 3:42 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Thu, 6 Feb 2020 12:54:05 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> > On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index a34064a031a5..63450d3bbf12 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> > >
> > >  endif
> > >
> > > +config BOOT_CONFIG
> > > +   bool "Boot config support"
> > > +   select LIBXBC
> > > +   default y
> >
> > Any particular reason this is default y? Why should it be enabled by
> > default on all boxes?
>
> Oh, you are not the first person asked that :)
>
> https://lkml.org/lkml/2019/12/9/563
>
> And yes, I think this is important that will useful for most developers
> and admins. Since the bootconfig already covers kernel and init options,
> this can be a new standard way to pass args to kernel boot.
>
> And as I reported above thread, the memory footpoint of view, most code
> and working memory are released after boot. Also, as Linus's suggested,
> now this feature is enabled only if user gives "bootconfig" on the kernel
> command line. So the side effect is minimized.

With m68k/atari_defconfig, bloat-o-meter says:

    add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)

which is IMHO not that small for a "default y" option that may or may not
be used.

Especially:

        Function                                     old     new   delta
    xbc_nodes                                      -    8192   +8192

Any chance xbc_nodes can be allocated dynamically, and only when needed?

Yes, there are industrial products running Linux on a current ARM SoC
using the builtin 8 or 10 MiB of SRAM (+ XIP for the kernel), so these
definitely want to say CONFIG_BOOT_CONFIG=n.

Thanks!

add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)
Function                                     old     new   delta
xbc_nodes                                      -    8192   +8192
xbc_init                                       -     854    +854
start_kernel                                1020    1580    +560
copy_xbc_key_value_list                        -     362    +362
__xbc_parse_value                              -     324    +324
xbc_snprint_cmdline                            -     294    +294
xbc_node_compose_key_after                     -     266    +266
xbc_namebuf                                    -     256    +256
xbc_add_sibling                                -     254    +254
xbc_node_find_next_leaf                        -     186    +186
xbc_node_find_child                            -     176    +176
__xbc_add_key                                  -     162    +162
proc_boot_config_init                          -     124    +124
xbc_make_cmdline                               -     122    +122
xbc_node_find_value                            -     104    +104
xbc_node_find_next_key_value                   -     102    +102
__xbc_close_brace                              -      92     +92
find_match_node                                -      80     +80
__xbc_parse_keys                               -      78     +78
xbc_node_get_data                              -      64     +64
xbc_parse_key                                  -      60     +60
skip_comment                                   -      48     +48
xbc_destroy_all                                -      42     +42
xbc_node_get_parent                            -      38     +38
xbc_parse_error                                -      36     +36
xbc_node_get_child                             -      34     +34
xbc_node_get_next                              -      32     +32
boot_config_checksum                           -      30     +30
boot_config_proc_show                          -      26     +26
xbc_root_node                                  -      20     +20
kzalloc.constprop                            810     830     +20
xbc_node_index                                 -      14     +14
xbc_node_num                                   -       4      +4
xbc_data_size                                  -       4      +4
xbc_data                                       -       4      +4
saved_boot_config                              -       4      +4
last_parent                                    -       4      +4
extra_init_args                                -       4      +4
extra_command_line                             -       4      +4
__initcall_proc_boot_config_init5              -       4      +4
xbc_debug_dump                                 -       2      +2
Total: Before=3688860, After=3701946, chg +0.35%

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
