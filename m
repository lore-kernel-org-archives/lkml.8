Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C46C2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgCEDRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgCEDRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:17:19 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1900720870;
        Thu,  5 Mar 2020 03:17:18 +0000 (UTC)
Date:   Wed, 4 Mar 2020 22:17:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] bootconfig: Support O=<builddir> option
Message-ID: <20200304221716.007587c7@oasis.local.home>
In-Reply-To: <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
        <158323468033.10560.14661631369326294355.stgit@devnote2>
        <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 15:04:43 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/3/20 3:24 AM, Masami Hiramatsu wrote:
> > Support O=<builddir> option to build bootconfig tool in
> > the other directory. As same as other tools, if you specify
> > O=<builddir>, bootconfig command is build under <builddir>.  
> 
> Hm.  If I use
> $ make O=~/tmp -C tools/bootconfig
> 
> that works: it builds bootconfig in ~/tmp.
> 
> OTOH, if I sit at the top of the kernel source tree
> and I enter
> $ mkdir builddir
> $ make O=builddir -C tools/bootconfig
> 
> I get this:
> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> ../scripts/Makefile.include:4: *** O=builddir does not exist.  Stop.
> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> 
> so it looks like tools/scripts/Makefile.include doesn't handle this case correctly
> (which is how I do all of my builds).
> 

Do you build perf that way?

$ mkdir buildir
$ make O=buildir -C tools/perf/
make: Entering directory '/work/git/linux-test.git/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
../scripts/Makefile.include:4: *** O=/work/git/linux-test.git/tools/perf/buildir does not exist.  Stop.
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/work/git/linux-test.git/tools/perf'

-- Steve
