Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F92B2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595772991;
	bh=zVU7cccZJMSnC+aYNnB5KrF2gE1bqUAI8XDld2dEmf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R02RtHvKFRu/MvBBqKLPT59ryJOhPSy8jK5zm3TnuTm6yvJfCj35h/wKdodogWR3M
	 jpnr6il+qVyW8nxFcyh15k5aVFu3yXY+LdvX1WO+ML1h5YibvN1lK/PfLfUeVnkarB
	 7+Mx4bAUjwzEVewLZbsZRiMIfHyO2FDWuj3WMavc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGZOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZOQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:16:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C08206D8;
        Sun, 26 Jul 2020 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595772989;
        bh=zVU7cccZJMSnC+aYNnB5KrF2gE1bqUAI8XDld2dEmf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIuxgsx3h/OlKyZDcEN0r33bghADU9tgUHQB73nP47orbJDBSZmy8Bn6VwvZHlKbJ
         HTTdnzDD+nssYQTgAti0MToWmNzAWAnYZkNQ4y0DE3k0i/t6RY2OXg6C/d3rTsWZf9
         bHVaPs4i5r6bSfuak3Bwp8Gs9yhjpNBSLRggjaJ0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65A33404B1; Sun, 26 Jul 2020 11:16:26 -0300 (-03)
Date:   Sun, 26 Jul 2020 11:16:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tools/perf-bench: Add basic syscall benchmark
Message-ID: <20200726141626.GN77866@kernel.org>
References: <20190307185253.28432-1-dave@stgolabs.net>
 <20190307191157.GB32240@kernel.org>
 <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
 <20200514203942.v2dbjeqrdpuucx5h@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514203942.v2dbjeqrdpuucx5h@treble>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 14, 2020 at 03:39:42PM -0500, Josh Poimboeuf escreveu:
> On Fri, Mar 08, 2019 at 10:17:47AM -0800, Davidlohr Bueso wrote:
> > On Thu, 07 Mar 2019, Arnaldo Carvalho de Melo wrote:
> > > You forgot to update tools/perf/Documentation/perf-bench.txt, and please
> > > take a look at tools/perf/util/pmu.c convert_scale() to see how to save
> > > the current locale, set the one you want, then restore the previous one,
> > > so that at the end of this benchmark the environment is back to where it
> > > was.
> > 
> > Here's an updated version with the corresponding docs, but I removed the
> > setlocale() - doesn't seem worth it; I hope Mel has no strong objection.
> > 
> > Thanks.
> > 
> > -------8<----------------------------------------------------------
> > [PATCH v2] tools/perf-bench: Add basic syscall benchmark
> > 
> > The usefulness of having a standard way of testing syscall performance
> > has come up from time to time[0]. Furthermore, some of our testing
> > machinery (such as 'mmtests') already makes use of a simplified version
> > of the microbenchmark. This patch mainly takes the same idea to measure
> > syscall throughput compatible with 'perf-bench' via getppid(2), yet
> > without any of the additional template stuff from Ingo's version (based
> > on numa.c). The code is identical to what mmtests uses.
> > 
> > [0] https://lore.kernel.org/lkml/20160201074156.GA27156@gmail.com/
> > 
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> 
> It would be nice to see this merged.  I posted something very similar
> back in 2016.

So, I took this as an Acked-by: Josh, and the previous "no objection"
from Mel as well, its now in my tmp.perf/core branch while it, together
with other stuff goes thru build tests + 'perf test'.

Sorry for the long delay in processing it, I shoudl've noticed that my
review comments were addressed in v2.

- Arnaldo
