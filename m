Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FBDC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209FA206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595949738;
	bh=q1gIT5j/dZzGCzLriAHtnaeX9fMsYMhL3sm9SrPHfYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LgZe1AHtAiDNRkJ6khtMCRhCOt04SjpSEWTL9cCknoLadKRqUU1KuzlU1MN1cEeb1
	 ERlzj7u2BipsnJRbVEPw8o22s5nctbSWVth3KO/2RJtR1zLp0RC01ZOtC2jiFyEjdu
	 WCFvwN5VTgymlLruDaDiWGJIu0KjGANaTMlhIFis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgG1PWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgG1PWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:22:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C50F206D4;
        Tue, 28 Jul 2020 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595949734;
        bh=q1gIT5j/dZzGCzLriAHtnaeX9fMsYMhL3sm9SrPHfYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7UVxBqZH+dxFCNx2/Nah+gBMIHd9QrWQ3vceFc0RDP7ReGtNr0G5ygA2CKlxXqkh
         x96sgqnFOz5pgUFy24MNLB8yWuzytvKQV0ePHGnh6wjukX7yY7eMgnD0/1ONqNRqNP
         EBQtzR9FOXMR7Dm6E2DdYlfMh3TKWFq0mI0vUP4U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 511F240E57; Tue, 28 Jul 2020 12:22:12 -0300 (-03)
Date:   Tue, 28 Jul 2020 12:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200728152212.GB374564@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
 <20200720191625.GL760733@krava>
 <20200728123955.GZ40195@kernel.org>
 <20200728125456.GD1243191@krava>
 <20200728130100.GE1243191@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728130100.GE1243191@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 28, 2020 at 03:01:00PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 28, 2020 at 02:54:56PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 28, 2020 at 09:39:55AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jul 20, 2020 at 09:16:25PM +0200, Jiri Olsa escreveu:
> > > > On Mon, Jul 20, 2020 at 02:32:40PM +0530, kajoljain wrote:
> > > > > Hi jiri,
> > > > >     We need power9 lpar machine and need to make sure `CONFIG_HV_PERF_CTRS` is
> > > > > enabled.

> > > > could you please try with following patch on top?

> > > So, can you point me to the cset that this should be merged into? Or can
> > > it come as a separate patch? I'll put what I have in the tmp.perf/core
> > > branch, and will do testing, please let me know if you want to fold it
> > > or as a followup patch.

> > sorry for delay.. I planned to squash the change in, but if you already
> > pushed something out, I'll rebase on top, I will post new version tomorrow

> > 1st 7 patches are good to go in any case

> ok, I just saw it's pushed out, I'll post a patch on top of it

See, the tmp.perf/core experimentation is about making it available what
would be just my local tree for wider consumption, what I have in
perf/core is what is non-rebase material, I try to push things there
only after testing and then recording the tests performed as signed
tags, see:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-tests-2020-07-17

So if we find something wrong with material made available via my
tmp.perf/core branch, we can go back in time and fix it, to try and have
a more solid bisection base.

It may be confusing (it seems so from how you responded to this thread),
and if it ends up being so confusing, I'll just ditch it and go back to
having just local branches, would be a pity as I'm keen on having a good
bisection history so I'll probably take more time to publish things.

Opinions about this, of course, more than welcome.

Back to this specific case, when sending fixes for things in
tmp.perf/core, please state what is the cset that needs folding into.

Thanks,

- Arnaldo
