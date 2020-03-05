Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EC420870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEHl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:41:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34528 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:41:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so4789682otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaKgasWVcBQ93an+Agrstk0BzArq02vl1AdAYFSL1zo=;
        b=o2wWe5YczTVHN9RM8WC5+UVvKfO/jd8xsikWF0iM9fXbP60tydn43iw8Os3cVAtjoX
         9V3wLCym4C2b4XEAzwx/SogmZLaRslnjs+O/0MZZGpSHJ8nGtbJYZB3mRlyRgGTv7n8A
         MjVsQy6y2N/ayWuWCbkR9qVi6//6PBps66bK0JuWUNnpvCVIdM+zlhe4roQibXeW44VB
         gk4qqwukps+ZBlbZxoOzBOPfadIKvvPuWyQh9lBV1SsOm7LxnXwh2utpHlInAvb6ZdWM
         k9klXNC+LGtNJ9UpJTFuPmoWSosUgfIGlEJ7qKv7kEZkCPdwpixWa8goOkbPmvYehYHn
         cGEg==
X-Gm-Message-State: ANhLgQ0aB5vebYDdbScNiLrpjTVmLn7X/5GPceVVjMMJdKw3OiqjVOIz
        RTSUyvp/wpvOhGy05fuNLT8VfHM2ig0bzB9x4zWMMywM
X-Google-Smtp-Source: ADFU+vs+r9dNshBcrKTTJ5BMCYvbI4wwrkG5wXWO03B0ztUBo++7VIkrY6dqa2ExFrA+3MjOkd21B0npHboEFnweuak=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr5620664ots.250.1583394115721;
 Wed, 04 Mar 2020 23:41:55 -0800 (PST)
MIME-Version: 1.0
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
 <158323468033.10560.14661631369326294355.stgit@devnote2> <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
 <20200304221716.007587c7@oasis.local.home> <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
In-Reply-To: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Mar 2020 08:41:44 +0100
Message-ID: <CAMuHMdVSSGbHBOvFbYaPuRH59Nmh_AaqJFfu-csJnZHOtd7mGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootconfig: Support O=<builddir> option
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Mar 5, 2020 at 5:53 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/4/20 7:17 PM, Steven Rostedt wrote:
> > On Wed, 4 Mar 2020 15:04:43 -0800
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >> On 3/3/20 3:24 AM, Masami Hiramatsu wrote:
> >>> Support O=<builddir> option to build bootconfig tool in
> >>> the other directory. As same as other tools, if you specify
> >>> O=<builddir>, bootconfig command is build under <builddir>.
> >>
> >> Hm.  If I use
> >> $ make O=~/tmp -C tools/bootconfig
> >>
> >> that works: it builds bootconfig in ~/tmp.
> >>
> >> OTOH, if I sit at the top of the kernel source tree
> >> and I enter
> >> $ mkdir builddir
> >> $ make O=builddir -C tools/bootconfig
> >>
> >> I get this:
> >> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> >> ../scripts/Makefile.include:4: *** O=builddir does not exist.  Stop.
> >> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> >>
> >> so it looks like tools/scripts/Makefile.include doesn't handle this case correctly
> >> (which is how I do all of my builds).
> >>
> >
> > Do you build perf that way?
>
> No.  It should also be fixed.

There are lots of issues when (cross)building the tools and selftest with O=.
I tried to fix some of them a while ago, but I lost interest.
https://lore.kernel.org/lkml/20190114135144.26096-1-geert+renesas@glider.be/

The only thing you can rely on when (cross)building with O=, is the kernel
itself ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
