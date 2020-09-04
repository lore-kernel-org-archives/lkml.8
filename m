Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D776CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA2A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599247160;
	bh=3/XHR9KmR5+E+hPmAKgHDEXT1FicpzNwBSYSgTYPZNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q11DFdxUqFGbtX4Q8Vmg0dwvgsd61xOdA+Me72PSjZfzg6vaIVfDBcAr+TpGZjW67
	 92V6NJiM5kLyrrQaqX42blDlliD4DTH2fYnyMI/tXJTiZpfmn3o2UZxZboiR60E+rl
	 drkYX9hhzyneurv7IfTDhq3JoFSMOKjgEDzcN09o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIDTTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgIDTTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:19:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BCA20684;
        Fri,  4 Sep 2020 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599247154;
        bh=3/XHR9KmR5+E+hPmAKgHDEXT1FicpzNwBSYSgTYPZNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLiouQIN7OnbOd1Lo/0aSn+Ks/3xl5tv1+NflqUwsH5rv0vmI/tLjs6TYOhSvN6On
         zSHkAn7x9mRVwwXIY6aOvgqULRJ6UX1po9hD9lqWcCTFgO7jq7OG56vlxuXSWzTR78
         cSRcBMxtKrqIeYJtoptYfRAlpPjLwIKSQ0hkN1io=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E2F740D3D; Fri,  4 Sep 2020 16:19:12 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:19:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add ITLB Instruction Fetch
 Hits event for zen1
Message-ID: <20200904191912.GF3753976@kernel.org>
References: <20200901220944.277505-1-kim.phillips@amd.com>
 <20200901220944.277505-2-kim.phillips@amd.com>
 <CAP-5=fW84gvGr+RxovDrFaRozHEY-_9mV2K-_bG04pmg8SJGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW84gvGr+RxovDrFaRozHEY-_9mV2K-_bG04pmg8SJGvw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 11:03:38PM -0700, Ian Rogers escreveu:
> On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >
> > The ITLB Instruction Fetch Hits event isn't documented even in
> > later zen1 PPRs, but it seems to count correctly on zen1 hardware.
> >
> > Add it to zen1 group so zen1 users can use the upcoming IC Fetch Miss
> > Ratio Metric.
> >
> > The IF1G, 1IF2M, IF4K (Instruction fetches to a 1 GB, 2 MB, and 4K page)
> > unit masks are not added because unlike zen2 hardware, zen1 hardware
> > counts all its unit masks with a 0 unit mask according to the old
> > convention:
> >
> > zen1$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >
> >            211,318      cpu/event=0x94/u
> >            211,318      cpu/event=0x94,umask=0xff/u
> >
> > Rome/zen2:
> >
> > zen2$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >
> >                  0      cpu/event=0x94/u
> >            190,744      cpu/event=0x94,umask=0xff/u
> >
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
