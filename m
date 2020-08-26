Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E246AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B892A206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHs41RjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHZQbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHZQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:30:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:30:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so1239209pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AUlG2R8uhb9Gydd220DHjL+5CJl351Ub4I13YAQRBMA=;
        b=HHs41RjGyqUStueAOkuLo3Cupdpa/I+JMpQrpzkyoI47xmDDt6sSoLCjiVJO05wGu3
         8pMwRkAPeL9ce0V3NTMP3npsEmDWCFcSvskXMppWlKKHjTkjuUXOlkR7CvHMDKLNmXoh
         ZLxis0oJMzeWE8cDIRYequ2itbb+V+vbOIuAzjj2JQrT1/MzBaXKlEpoAK3dH0WhKLj4
         pndaU2Z8OpLCtJuG0Z9DW6rt1QlXGf2lCjXEdiMKjgaSkGQdH0fAi1MguORsUXFv8DOe
         J07VZasBpwDvG0GWFurLgAF8ygktvdwt1ucYirt2ke0siBXyWuIBfR9Pq+xq/2m9t9J2
         DL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AUlG2R8uhb9Gydd220DHjL+5CJl351Ub4I13YAQRBMA=;
        b=bYe8khCNRFOp9X1pe/xlxWjMs0J4TS6VHVlBKeArsa8J8SjVNY6EYWsouyZtSG6Gkq
         E44NHofDZY0DkPnfBXbiP6B9r5zA8/B0SFPHcEWN50Hg4GUzGQ8MVJ4AN+tUlSGqXYuk
         LaHJrNDl1WRUn5f0AAgMk9LZjQAwwnm4/2sU5yyim4LwwJO/vKgG8rl0Qj0SHjxLy1RW
         psWnkTrBqv5nEJxhKyDOt+JNABq4W+eupVVKbL983GKp9Av3WXy9r7r6o5oIu+IksJvA
         2uhOsD0CtMPyzCE3qFGLk63bwPsX8DcC79mQ+SPM46S8lNz95odCgzZ2FBMzqa7U48p5
         6HUQ==
X-Gm-Message-State: AOAM533rMmb9zVtX9xZzigrnbnrSQF/pUGOdDVPbmpt7BofV3NwLnroO
        U8LlhAAydBUf3tdlxnVfyOZ5JnqV8H1rzw==
X-Google-Smtp-Source: ABdhPJwCwxH+esTRiVfr8QkEXpmHO3TUVNkfu04ZoIQ/vsIsCopPe6pkGSSBgssoedlXHgeHnvl2ew==
X-Received: by 2002:aa7:81c1:: with SMTP id c1mr13048134pfn.203.1598459434908;
        Wed, 26 Aug 2020 09:30:34 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id e16sm3502108pfl.100.2020.08.26.09.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 09:30:34 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:30:28 +0000
From:   Changbin Du <changbin.du@gmail.com>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
Message-ID: <20200826163026.hnuwqvacvziwdpbz@mail.google.com>
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
 <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
 <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
 <55b09be8-5bb2-60e3-8386-05bc9f6fd854@infradead.org>
 <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:34:34PM -0700, Randy Dunlap wrote:
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
> > 
> > 
> > I don't see any support in streamline_config.pl for Kconfig symbols
> > and/or modules whose names have changed.  Trying to do something
> > like that would be a never-ending job (a la job security).
> > 
> > At least it gave you a warning that it couldn't find a Kconfig symbol
> > for that module.
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
This was tested before. Is this a perl version issue?

changbin@vultr:~$ cat a.pl
my @preserved_kconfigs = split(/:/,$ENV{LMC_KEEP});
print("@preserved_kconfigs")
changbin@vultr:~$ perl a.pl 
changbin@vultr:~$ perl -v      
This is perl 5, version 26, subversion 1 (v5.26.1) built for x86_64-linux-gnu-thread-multi
(with 67 registered patches, see perl -V for more detail)

Copyright 1987-2017, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.
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
> 

-- 
Cheers,
Changbin Du
