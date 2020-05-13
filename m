Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB510C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C13A204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589405134;
	bh=jycA+VHeU/fcuDEk+08oeZlp+rfDD0wO1CCwDXKTgCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQUSncYiFA1go6BaCOLWGuBsXcSbdYmvW1Xp5pLEGxSNgjXJOInXpfE1lw2sWLjYM
	 XOYZt4iqM0N5mIxLzFDTW19TOYVqPlNwa5TKS7mOnKgHLX8zZZ9whD78ZJ7XYwVoCv
	 cC03ro0n8C2nhAh/Jc2AMItijOnDtysOtpU0cK0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgEMVZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgEMVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:25:32 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A9120693;
        Wed, 13 May 2020 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589405132;
        bh=jycA+VHeU/fcuDEk+08oeZlp+rfDD0wO1CCwDXKTgCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv/nqBozvT81+uOIvowsGAwB+C6wCVSZzE4RTQtDOelNwytDn4S/SQWGWL5s6BrkI
         ovIVQffFNazxGnZ3QpY/GRGX5WpzTAyAQgCThRB7hqmVR6JD+iyPaYoJveEGL0RY92
         Emy/E5oAhSGM0G3PRYSeNnGCZvkdRDHF+UIrIJYo=
Date:   Wed, 13 May 2020 16:30:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
Message-ID: <20200513213007.GP4897@embeddedor>
References: <20200511195643.GA9850@embeddedor>
 <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
 <20200512000404.GA4897@embeddedor>
 <20200512080607.GD2978@hirez.programming.kicks-ass.net>
 <20200512180352.GB4897@embeddedor>
 <CAP-5=fWOhnKe1-c39Pg9M14Yet7U1jRvPpKxa7N2A6JSXLRe=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWOhnKe1-c39Pg9M14Yet7U1jRvPpKxa7N2A6JSXLRe=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 02:03:56PM -0700, Ian Rogers wrote:
> On Tue, May 12, 2020 at 10:59 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > On Tue, May 12, 2020 at 10:06:07AM +0200, Peter Zijlstra wrote:
> > > On Mon, May 11, 2020 at 07:04:04PM -0500, Gustavo A. R. Silva wrote:
> > > > On Mon, May 11, 2020 at 05:20:08PM -0300, Arnaldo Melo wrote:
> > > > >
> > > > > Thanks, applied
> > > > >
> > > >
> > > > Thanks, Arnaldo.
> > > >
> > > > I wonder if could also take the other two:
> > > >
> > > > https://lore.kernel.org/lkml/20200511200911.GA13149@embeddedor/
> > > > https://lore.kernel.org/lkml/20200511201227.GA14041@embeddedor/
> > >
> > > I think I have those, but let me make sure.
> >
> > Great. :)
> 
> 
> Thanks for the cleanup! It has yielded a clang compiler warning/error
> for me in kernel/git/acme/linux.git branch perf/core:
> 
> util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized
> type 'struct branch_stack' not
> at the end of a struct or class is a GNU extension
> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                        struct branch_stack br_stack;
> 
> I think this can be resolved by reordering the members of the struct,
> and may have been a latent bug exposed by this change. It's
> unfortunate it has broken this build.
> 

Yep. The following should resolve the issue:

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f17b1e769ae4..b34179e3926f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1799,8 +1799,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)

        if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
                struct {
-                       struct branch_stack br_stack;
                        struct branch_entry entries[LBRS_MAX];
+                       struct branch_stack br_stack;
                } br;

                if (items->mask[INTEL_PT_LBR_0_POS] ||

I'll send a proper patch.

Thanks for the report!
--
Gustavo
