Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC452087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZVLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgHZVLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:11:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 838A1207CD;
        Wed, 26 Aug 2020 21:11:17 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:11:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
Message-ID: <20200826171115.0d8ca7ef@oasis.local.home>
In-Reply-To: <20200826163026.hnuwqvacvziwdpbz@mail.google.com>
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
        <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
        <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
        <55b09be8-5bb2-60e3-8386-05bc9f6fd854@infradead.org>
        <663f60dc-6e91-128b-67e7-ccf2ced32ef1@infradead.org>
        <20200826163026.hnuwqvacvziwdpbz@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 16:30:28 +0000
Changbin Du <changbin.du@gmail.com> wrote:

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

I see that warning too:

$ perl -v

This is perl 5, version 30, subversion 2 (v5.30.2) built for x86_64-linux-thread-multi
(with 70 registered patches, see perl -V for more detail)

-- Steve
