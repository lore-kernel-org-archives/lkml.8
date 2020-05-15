Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625A2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589562279;
	bh=BEK6lnyqMJIaseew03bp3BaqZcHS1kkrmH5FPxLSqhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WYlAgqRCsDwDgRTnhbt00DrlvfuBXYa1cCu/pqWh7jUWLyyJkxQel8ZXXL2xCAWCn
	 GqslvcfsbW31G6re0uLkB9hxR4ZjDiZXwfqN9m7/CNKyd+OIp/bSaMs9d1g7a78b6S
	 V+A51pU76dTlB+kV0ISxvtRXQWHQB1ENtuBtz6M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgEOREj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOREi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:04:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E50320727;
        Fri, 15 May 2020 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589562278;
        bh=BEK6lnyqMJIaseew03bp3BaqZcHS1kkrmH5FPxLSqhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRax1DLumm/3bwzM8C7uWKcMuogxq70S4Rhw/uREndpefa7Rq2j4STmPRDF6Zr2OX
         Nxvtc3LJerky2Bp3iKm2luvpQJT0pDDxahYqwvrjyfAzYOK8qXIhdEAa9zbecxkS1n
         CoYuTHo9EuSOJnQotGd5VmFbchNsENauHFTm0kCc=
Date:   Fri, 15 May 2020 12:09:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200515170918.GB30837@embeddedor>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor>
 <20200515164153.GD9335@kernel.org>
 <20200515164331.GE9335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515164331.GE9335@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:43:31PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 15, 2020 at 01:41:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 14, 2020 at 07:10:25PM -0500, Gustavo A. R. Silva escreveu:
> > > On Thu, May 14, 2020 at 03:46:05PM -0700, Ian Rogers wrote:
> > > > On Thu, May 14, 2020 at 3:04 PM Gustavo A. R. Silva
> > > > <gustavoars@kernel.org> wrote:
> > > 
> > > Yep. I just built linux-next --which contains all the flexible-array
> > > conversions-- with Clang --GCC doesn't catch this issue, not even GCC
> > > 10-- and I don't see any other issue like this.
> > > 
> > > I mean, I have run into these other two:
> > > 
> > > https://lore.kernel.org/lkml/20200505235205.GA18539@embeddedor/
> > > https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/
> > > 
> > > but those are due to the erroneous application of the sizeof operator
> > > to zero-length arrays.
> > > 
> > > > complicated stack allocation I suggested. It may be nice to save
> > > > cycles if code this pattern is widespread and the code hot.
> > > > 
> > > 
> > > Apparently, this is the only instace of this sort of issue in the whole
> > > codebase.
> > 
> > Adrian Hunter was not CCed, Adrian?
> 
> Gustavo, I've removed this from my tree from now till this gets
> resolved.
> 

Yep, sure.  In the meantime, I'll send a patch without the changes
to struct branch_stack.

Thanks
--
Gustavo

