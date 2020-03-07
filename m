Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA333C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE75206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583548050;
	bh=KepmSzl+GVqp9P03r3ns4JULrICCENSb2cKXTtBMgdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yUQk1EZSGi8UXgVh5mUW3jevkj1N+65MPrV7YIuWUHpPq3K38AzzN8wYbjSh8RFpG
	 8BR5PB+Z9u6tgcJItr8c6//Dd7ndr7No5SkJVLfeSFMdzBSmbw9ZNnigIp1dR45+zb
	 Tmeh6kMUBe54esbBXFKm5M8C/FeQ/VXFJXKIRVEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCGC13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgCGC13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:27:29 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADFC206D7;
        Sat,  7 Mar 2020 02:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583548048;
        bh=KepmSzl+GVqp9P03r3ns4JULrICCENSb2cKXTtBMgdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YnlTAycsC/Q/v0j6tVveOGgEbrARxKTrI+scw8bm6bT62meExijSQkjMayF+vIBuL
         JPOaPoxyLIxhOz84X8J+dEvQvZFtVYod9TaiLjA8lzZVNHbSXInP9ZMjCXWcqMYX61
         eDD1Afc5+i4BtrkUAEFPBtN2swlechAiYi+wC+18=
Date:   Sat, 7 Mar 2020 11:27:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [BUGFIX PATCH v2] tools: Let O= makes handle a relative path
 with -C option
Message-Id: <20200307112723.3fcb6f8f1589873d7ae1c7b9@kernel.org>
In-Reply-To: <20200306201203.GB13774@kernel.org>
References: <158351957799.3363.15269768530697526765.stgit@devnote2>
        <20200306201203.GB13774@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 17:12:03 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Sat, Mar 07, 2020 at 03:32:58AM +0900, Masami Hiramatsu escreveu:
> > When I compiled tools/perf from top directory with the -C option,
> > the O= option didn't work correctly if I passed a relative path.
> > 
> >   $ make O=BUILD -C tools/perf/
> >   make: Entering directory '/home/mhiramat/ksrc/linux/tools/perf'
> >     BUILD:   Doing 'make -j8' parallel build
> >   ../scripts/Makefile.include:4: *** O=/home/mhiramat/ksrc/linux/tools/perf/BUILD does not exist.  Stop.
> >   make: *** [Makefile:70: all] Error 2
> >   make: Leaving directory '/home/mhiramat/ksrc/linux/tools/perf'
> > 
> > The O= directory existence check failed because the check
> > script ran in the build target directory instead of the
> > directory where I ran the make command.
> > 
> > To fix that, once change directory to $(PWD) and check O=
> > directory, since the PWD is set to where the make command
> > runs.
> 
> Tested with O=/non/relative/paths, as I always use, not to polute the
> checked out kerneo sources, and with a relative path, as fixed in this
> patch, now both works, thanks, will be in my next perf/urgent pull req
> to Ingo.
> 

Thanks Arnaldo!


> - Arnaldo
>  
> > Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> >  Changes in V2:
> >  - Fix tools/perf/Makefile because it has own O= pre-process.
> >  - Use tools/perf for example.
> >  - Add explicit Cc: stable@vger.kernel.org tag.
> > ---
> >  tools/perf/Makefile            |    2 +-
> >  tools/scripts/Makefile.include |    4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> > index 7902a5681fc8..b8fc7d972be9 100644
> > --- a/tools/perf/Makefile
> > +++ b/tools/perf/Makefile
> > @@ -35,7 +35,7 @@ endif
> >  # Only pass canonical directory names as the output directory:
> >  #
> >  ifneq ($(O),)
> > -  FULL_O := $(shell readlink -f $(O) || echo $(O))
> > +  FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))
> >  endif
> >  
> >  #
> > diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> > index ded7a950dc40..6d2f3a1b2249 100644
> > --- a/tools/scripts/Makefile.include
> > +++ b/tools/scripts/Makefile.include
> > @@ -1,8 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  ifneq ($(O),)
> >  ifeq ($(origin O), command line)
> > -	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> > -	ABSOLUTE_O := $(shell cd $(O) ; pwd)
> > +	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> > +	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
> >  	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
> >  	COMMAND_O := O=$(ABSOLUTE_O)
> >  ifeq ($(objtree),)
> > 
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
