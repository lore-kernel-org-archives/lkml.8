Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0713DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7471207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599064975;
	bh=X/bxrtY35o+52cpaA6jyJ9uEQDg4SoMGmOLJzfBMmL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DsoGAMIMiPvw9gz3xPXttM0wcZbuP4cNfYUabS84y0P3hYF9WS7vt2UtnYqlTY4uC
	 Of/8MPPG+4FEeAQBCI5sAy4JjLsrtf0XpOjVsZ5eL1ueDrM8NtcLDcjETmcFihQXFJ
	 29jcLgXv9CPnbHe1PQ5cOFAHX3wnY76eLYof+ihU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIBQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:42:53 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:37235 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:42:52 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 082GgH6e015171
        for <linux-kernel@vger.kernel.org>; Thu, 3 Sep 2020 01:42:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 082GgH6e015171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599064938;
        bh=ZhVUs/goHcS1LxnEAWcpt4HbWAUMxqkPjQXE7c9tbxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jEON0PqwsajyHdq2VJUZRS48VuyYr2lLMVTYGOjL9aX/tBv/Ayh4GQ331fp1lVPYb
         4lY+DREeW7popcXddOysHOmEI2UEFKzgqZ282bdrSbeCl4i4vVgNo3NlmxwPfqsnQb
         hIKJWP99gKmt9es5zW8rQvrx9JtQCRVudQVfCAb0bqQ7x3T5u1AoolueDBRFDqDMW6
         JVWmPM+te9uKaYILma2l6UwIpl+TQjPy4l/6b3HZ8X8h04c433Drsc4JLdX6vlLxfj
         Z8hvq8yvG663lAqyrEbNkdNcNjpYjxxVWtdoZMepis54ov/r3wR2TSZPSizLYBzp0z
         TQiaCSW+bfASg==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id y6so22555plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:42:17 -0700 (PDT)
X-Gm-Message-State: AOAM531XKXB3BQo2VxX/yesh7kPJNIgMzb98UlYX15+DhmchRxpe5jBR
        ZxhMuZrOlos5MxxkkZLehFAuVO5GAs2PLBbjnwY=
X-Google-Smtp-Source: ABdhPJxcDxIUQZugkXk3LPk8kkmWsmwye5hA9JRg0lPmMzUJcOVTrfAYNd30GApony9OTt7d+ZQ6b8VqIA+KWMb4dXQ=
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr2858708pjb.198.1599064936907;
 Wed, 02 Sep 2020 09:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
 <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org> <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
 <55b09be8-5bb2-60e3-8386-05bc9f6fd854@infradead.org> <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
 <20200826163026.hnuwqvacvziwdpbz@mail.google.com>
In-Reply-To: <20200826163026.hnuwqvacvziwdpbz@mail.google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Sep 2020 01:41:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvXzVHzZHRCPOeS+qbNxDV5G=ihpXCZOmbRx-Six=zyQ@mail.gmail.com>
Message-ID: <CAK7LNATvXzVHzZHRCPOeS+qbNxDV5G=ihpXCZOmbRx-Six=zyQ@mail.gmail.com>
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Royce <nroycea+kernel@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 1:30 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 02:34:34PM -0700, Randy Dunlap wrote:
> > On 8/25/20 2:12 PM, Randy Dunlap wrote:
> > >> On Tue, Aug 25, 2020 at 2:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >>>
> > >>> so intel_rapl_perf is listed in your lsmod.cfg file:
> > >>> intel_rapl_perf        16384  2
> > >>>
> > >>> You say Linux 5.8.3.  I'm guessing that your "make localmodconfig" tree
> > >>> is Linux 5.8.3 (?).  What kernel version are you running?
> > >>> I think that it's older, and some file/module names have changed since then.
> > >
> > > On 8/25/20 1:34 PM, Nathan Royce wrote:
> > >> Correct. I'm building for 5.8.3 and I'm currently on 5.7.4 (1 month
> > >> doesn't seem particularly old).
> > >
> > > Yes, things can change quickly.
> > >
> > >
> > > I don't see any support in streamline_config.pl for Kconfig symbols
> > > and/or modules whose names have changed.  Trying to do something
> > > like that would be a never-ending job (a la job security).
> > >
> > > At least it gave you a warning that it couldn't find a Kconfig symbol
> > > for that module.
> > >
> > >
> > > From your original email:
> > > | I'm going to assume it has something to do with the naming and it's
> > > | supposed to be associated with "Intel/AMD rapl performance events
> > > | (CONFIG_PERF_EVENTS_INTEL_RAPL)" which I already have set to 'Y'.
> > >
> > > Yes, commit fd3ae1e1587d64ef8cc8e361903d33625458073e changed the module name
> > > since it now supports both Intel and AMD.
> > >
> > >
> > > | Right below that, I also get 'Use of uninitialized value
> > > | $ENV{"LMC_KEEP"} in split at ./scripts/kconfig/streamline_config.pl
> > > | line 596.', but again that is the sort of thing that may warrant a new
> > > | email specific to localmodconfig author(s). But again maybe not
> > > | because I take it more as a warning given I don't make use of
> > > | LMC_KEEP.
> > >
> > >
> > > @Changbin: can you fix this little bug in streamline_config.pl, please? ^^^^^
> This was tested before. Is this a perl version issue?
>
> changbin@vultr:~$ cat a.pl
> my @preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
> print("@preserved_kconfigs")
> changbin@vultr:~$ perl a.pl
> changbin@vultr:~$ perl -v
> This is perl 5, version 26, subversion 1 (v5.26.1) built for x86_64-linux-gnu-thread-multi
> (with 67 registered patches, see perl -V for more detail)
>
> Copyright 1987-2017, Larry Wall
>
> Perl may be copied only under the terms of either the Artistic License or the
> GNU General Public License, which may be found in the Perl 5 source kit.
>
> Complete documentation for Perl, including FAQ lists, should be found on
> this system using "man perl" or "perldoc perl".  If you have access to the
> Internet, point your browser at http://www.perl.org/, the Perl Home Page.
> >
> > Changing email address for Changbin.
> > Plus I made the quick patch for streamline_config.pl (below)
> > although I haven't tested it.
> >
> > ---
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > A user reported:
> > 'Use of uninitialized value $ENV{"LMC_KEEP"} in split at
> >  ./scripts/kconfig/streamline_config.pl line 596.'
> >
> > so first check that $ENV{LMC_KEEP} is defined before trying
> > to use it.
> >
> > Fixes: c027b02d89fd ("streamline_config.pl: add LMC_KEEP to preserve some kconfigs")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Changbin Du <changbin.du@gmail.com>
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >  scripts/kconfig/streamline_config.pl |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > --- linux-next-20200825.orig/scripts/kconfig/streamline_config.pl
> > +++ linux-next-20200825/scripts/kconfig/streamline_config.pl
> > @@ -593,7 +593,10 @@ while ($repeat) {
> >  }
> >
> >  my %setconfigs;
> > -my @preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
> > +my @preserved_kconfigs;
> > +if (defined($ENV{'LMC_KEEP'})) {
> > +     @preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
> > +}
> >
> >  sub in_preserved_kconfigs {
> >      my $kconfig = $config2kfile{$_[0]};
> >
>
> --
> Cheers,
> Changbin Du



Hmm, I think I did not see this warning before,
but I am not sure...
Now I see this warning too, maybe perl version-dependent.


-- 
Best Regards
Masahiro Yamada
