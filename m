Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42363C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B7420656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKSED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:04:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:61977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgHKSED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:04:03 -0400
IronPort-SDR: BFyJdXhqB42qJpl5EXNCbyMbdZeFszE74sE0Vt4cr15g+OXKNz9DktmvwmtlPWdcIADRwI33tY
 GVUqciyS/IYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="141644208"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="141644208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 11:03:34 -0700
IronPort-SDR: zVv4eU1IJ+Px03kish9Dant3Vn8Yba/ZAH97DTiKTwFjiMbjLxVyTqnESBg65BYgStzTK+Y8vI
 6/c0SX/PsRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="324832517"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 11:03:34 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AA91F301CB0; Tue, 11 Aug 2020 11:03:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:03:34 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200811180334.GH1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <20200810203632.GF3982@worktop.programming.kicks-ass.net>
 <20200811142955.GC1448395@tassilo.jf.intel.com>
 <9ff26c5231954e65bbd4873d54ebd727@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff26c5231954e65bbd4873d54ebd727@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 02:47:03PM +0000, David Laight wrote:
> From: Andi Kleen
> > On Mon, Aug 10, 2020 at 10:36:32PM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 10, 2020 at 07:45:18AM -0700, Andi Kleen wrote:
> > >
> > > > Unfortunately we're kind of stuck with the old NFILE=1024 default
> > > > even though it makes little sense on modern servers.
> > >
> > > Why can't that be changed? It seems to me all of userspace changes all
> > > the time; heck that system-doofus thing flushed 20+ years of sysadmin
> > > experience down the drain, just cause. Why can't we up a file limit?
> > 
> > We could try, but I believe it's hard coded in various places outside
> > the kernel.
> 
> The place it really bites is select().
> Although the kernel supports large bitmaps glibc doesn't.
> The random bit overwrites are a PITA to debug.

Good point.

I remember I asked for a simple define to increase like glibc5 had, but 
they still didn't implement that.

-Andi
