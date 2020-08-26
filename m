Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A08207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHZVKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgHZVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:10:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCAE20737;
        Wed, 26 Aug 2020 21:10:07 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:10:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nathan Royce <nroycea+kernel@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
Message-ID: <20200826171005.2027e9fa@oasis.local.home>
In-Reply-To: <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
        <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
        <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
        <55b09be8-5bb2-60e3-8386-05bc9f6fd854@infradead.org>
        <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 14:34:34 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/25/20 2:12 PM, Randy Dunlap wrote:
> >> On Tue, Aug 25, 2020 at 2:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:  
> >>>
> >>> so intel_rapl_perf is listed in your lsmod.cfg file:
> >>> intel_rapl_perf        16384  2
> >>>
> >>> You say Linux 5.8.3.  I'm guessing that your "make localmodconfig" tree
> >>> is Linux 5.8.3 (?).  What kernel version are you running?
> >>> I think that it's older, and some file/module names have changed since then.  
> > 
> > On 8/25/20 1:34 PM, Nathan Royce wrote:  
> >> Correct. I'm building for 5.8.3 and I'm currently on 5.7.4 (1 month
> >> doesn't seem particularly old).  
> > 
> > Yes, things can change quickly.

Yes and as Randy said, there's no way to easily fix that.

> > 
> > 
> > I don't see any support in streamline_config.pl for Kconfig symbols
> > and/or modules whose names have changed.  Trying to do something
> > like that would be a never-ending job (a la job security).
> > 
> > At least it gave you a warning that it couldn't find a Kconfig symbol
> > for that module.

Correct, this is exactly why I have it warn. Because this happens all
the time. In most cases, I simply ignore the warning ;-)


> > 
> > 
> > From your original email:
> > | I'm going to assume it has something to do with the naming and it's
> > | supposed to be associated with "Intel/AMD rapl performance events
> > | (CONFIG_PERF_EVENTS_INTEL_RAPL)" which I already have set to 'Y'.
> > 
> > Yes, commit fd3ae1e1587d64ef8cc8e361903d33625458073e changed the module name
> > since it now supports both Intel and AMD.
> > 
> > 
> > | Right below that, I also get 'Use of uninitialized value
> > | $ENV{"LMC_KEEP"} in split at ./scripts/kconfig/streamline_config.pl
> > | line 596.', but again that is the sort of thing that may warrant a new
> > | email specific to localmodconfig author(s). But again maybe not
> > | because I take it more as a warning given I don't make use of
> > | LMC_KEEP.
> > 
> > 
> > @Changbin: can you fix this little bug in streamline_config.pl, please? ^^^^^  
> 
> Changing email address for Changbin.
> Plus I made the quick patch for streamline_config.pl (below)
> although I haven't tested it.
> 
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> A user reported:
> 'Use of uninitialized value $ENV{"LMC_KEEP"} in split at
>  ./scripts/kconfig/streamline_config.pl line 596.'
> 
> so first check that $ENV{LMC_KEEP} is defined before trying
> to use it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Randy, please send this as a stand alone patch to the KBUILD
maintainers.

-- Steve


> 
> Fixes: c027b02d89fd ("streamline_config.pl: add LMC_KEEP to preserve some kconfigs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Changbin Du <changbin.du@gmail.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/kconfig/streamline_config.pl |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-next-20200825.orig/scripts/kconfig/streamline_config.pl
> +++ linux-next-20200825/scripts/kconfig/streamline_config.pl
> @@ -593,7 +593,10 @@ while ($repeat) {
>  }
>  
>  my %setconfigs;
> -my @preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
> +my @preserved_kconfigs;
> +if (defined($ENV{'LMC_KEEP'})) {
> +	@preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
> +}
>  
>  sub in_preserved_kconfigs {
>      my $kconfig = $config2kfile{$_[0]};

