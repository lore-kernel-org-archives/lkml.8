Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E479C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DD2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582188950;
	bh=ium38FctpqX9ZvDKBkRchhI37XRwegV+qt2r/5/I8Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZEevJM71BZlQR85B1CW4P2NV8dIrEj0Z8NYv0r40xf+boQvw0KN0i0HHVReDaZPkz
	 e8y8j0241p8tmN+uMX1eLf11EKUv/rGiOHCJWt9K4zmf0yDIX3UNjbuTiTqIzh7MiK
	 MPiiCPkMbMX/qNvYgK+Pt8CcFs+eoaWpzRDhRayY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBTIzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgBTIzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:55:48 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163AE24656;
        Thu, 20 Feb 2020 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582188947;
        bh=ium38FctpqX9ZvDKBkRchhI37XRwegV+qt2r/5/I8Uk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ml7u3+/TdfEDC0yhG3v+IPIy4YksQKmsvrX3cRVcuDwTnNJyp6CGhrMATbtcxwMZO
         IsDd/r/HTFkeFmhnodDWtwcAIM8wQhzQBMUEX4TVV0GOJmK2dkoCT0GyKueovZoJ7j
         TJtd+G/NveaXVUGyjauwA2JvUIOLN9yu11w1l6ss=
Date:   Thu, 20 Feb 2020 17:55:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
Message-Id: <20200220175543.ec6d58690dcda33f89290b55@kernel.org>
In-Reply-To: <CAMuHMdVDBMii5RPiMkRo1XbFTiivbJASFUWQBn8_dU1Q5uRSzA@mail.gmail.com>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
        <158218359349.6940.8460152450938960505.stgit@devnote2>
        <CAMuHMdVDBMii5RPiMkRo1XbFTiivbJASFUWQBn8_dU1Q5uRSzA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 09:16:56 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hiramatsu-san,
> 
> On Thu, Feb 20, 2020 at 8:26 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > Set CONFIG_BOOT_CONFIG=n by default. This also warns
> > user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
> > in the kernel command line.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1218,7 +1218,7 @@ endif
> >  config BOOT_CONFIG
> >         bool "Boot config support"
> >         depends on BLK_DEV_INITRD
> > -       default y
> > +       default n
> 
> "default n" is the default, so you can just drop the line.

OK.

> 
> >         help
> >           Extra boot config allows system admin to pass a config file as
> >           complemental extension of kernel cmdline when booting.
> > diff --git a/init/main.c b/init/main.c
> > index 59248717c925..680ff7123705 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -418,6 +418,14 @@ static void __init setup_boot_config(const char *cmdline)
> >  }
> >  #else
> >  #define setup_boot_config(cmdline)     do { } while (0)
> > +
> > +static int __init warn_bootconfig(char *str)
> > +{
> > +       pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
> 
> pr_warn()?

Yeah, agreed. 

OK, I'll update the patch.

Thank you!

> 
> > +       return 0;
> > +}
> > +early_param("bootconfig", warn_bootconfig);
> > +
> >  #endif
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
