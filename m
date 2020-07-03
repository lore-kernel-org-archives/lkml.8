Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A4F207D4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593777558;
	bh=keRg3YRbxDR461UXdjt+avGgeCv6FyZupYAUcFrt5cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wOr59Ho3Q11Cn7+F6GlZ2DaX2aHtq0gZOdQlN9B1LTa08iTEg4v4UHP/KKroMY39
	 bNUTCwSYQ1mzW2CQGlGekLZSJaT0lb/27/VJLxJ5PPd74JGTwtCSjLVEbvoIStuFCr
	 kuG3UhHXeWfBkC56RfBOrWFNcxLhhs1HCsdGiEAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGCL7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCL7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:59:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA95E20782;
        Fri,  3 Jul 2020 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593777555;
        bh=keRg3YRbxDR461UXdjt+avGgeCv6FyZupYAUcFrt5cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpsZCP0ypoAaUAk9b21qT0U1PLtj+R/qZhp0jdG1d0gTV1gZ3HCKuKqgHSTPLOOa+
         CUP0s4voHHdAXpiDVzpeLfZ2++ZGBYto/ZR8AP9GzKnyEJFDnJRvqEeYng//251jUK
         9ukX0EF/OdOiFmAeNLzBdGDrKp9rgvoTww7y761o=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BC47405FF; Fri,  3 Jul 2020 08:59:12 -0300 (-03)
Date:   Fri, 3 Jul 2020 08:59:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, guohanjun@huawei.com
Subject: Re: [PATCH] perf report TUI: Fix segmentation fault in
 perf_evsel__hists_browse()
Message-ID: <20200703115911.GE1320@kernel.org>
References: <20200612094322.39565-1-liwei391@huawei.com>
 <CAM9d7cjK=TN8-0kaWtMo2vPq_AzsmFwM9z=f_ni7qD2r9-8FDQ@mail.gmail.com>
 <48be67be-9b87-87a1-125a-bb7d0d027a57@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48be67be-9b87-87a1-125a-bb7d0d027a57@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 03, 2020 at 09:03:53AM +0800, liwei (GF) escreveu:
> Ping...

Thanks, applied and tested, added the Acked-by Jiri and Namhyung
provided,

- Arnaldo
 
> On 2020/6/12 23:19, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Jun 12, 2020 at 6:58 PM Wei Li <liwei391@huawei.com> wrote:
> >>
> >> The segmentation fault can be reproduced as following steps:
> >> 1) Executing perf report in tui.
> >> 2) Typing '/xxxxx' to filter the symbol to get nothing matched.
> >> 3) Pressing enter with no entry selected.
> >> Then it will report a segmentation fault.
> >>
> >> It is caused by the lack of check of browser->he_selection when
> >> accessing it's member res_samples in perf_evsel__hists_browse().
> >>
> >> These processes are meaningful for specified samples, so we can
> >> skip these when nothing is selected.
> >>
> >> Fixes: 4968ac8fb7c3 ("perf report: Implement browsing of individual samples")
> >> Signed-off-by: Wei Li <liwei391@huawei.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks
> > Namhyung
> > 
> > 
> >> ---
> >>  tools/perf/ui/browsers/hists.c | 17 +++++++++++------
> >>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> >> index 487e54ef56a9..2101b6b770d8 100644
> >> --- a/tools/perf/ui/browsers/hists.c
> >> +++ b/tools/perf/ui/browsers/hists.c
> >> @@ -2288,6 +2288,11 @@ static struct thread *hist_browser__selected_thread(struct hist_browser *browser
> >>         return browser->he_selection->thread;
> >>  }
> >>
> >> +static struct res_sample *hist_browser__selected_res_sample(struct hist_browser *browser)
> >> +{
> >> +       return browser->he_selection ? browser->he_selection->res_samples : NULL;
> >> +}
> >> +
> >>  /* Check whether the browser is for 'top' or 'report' */
> >>  static inline bool is_report_browser(void *timer)
> >>  {
> >> @@ -3357,16 +3362,16 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
> >>                                              &options[nr_options], NULL, NULL, evsel);
> >>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
> >>                                                  &options[nr_options],
> >> -                                hist_browser__selected_entry(browser)->res_samples,
> >> -                                evsel, A_NORMAL);
> >> +                                                hist_browser__selected_res_sample(browser),
> >> +                                                evsel, A_NORMAL);
> >>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
> >>                                                  &options[nr_options],
> >> -                                hist_browser__selected_entry(browser)->res_samples,
> >> -                                evsel, A_ASM);
> >> +                                                hist_browser__selected_res_sample(browser),
> >> +                                                evsel, A_ASM);
> >>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
> >>                                                  &options[nr_options],
> >> -                                hist_browser__selected_entry(browser)->res_samples,
> >> -                                evsel, A_SOURCE);
> >> +                                                hist_browser__selected_res_sample(browser),
> >> +                                                evsel, A_SOURCE);
> >>                 nr_options += add_switch_opt(browser, &actions[nr_options],
> >>                                              &options[nr_options]);
> >>  skip_scripting:
> >> --
> >> 2.17.1
> >>

-- 

- Arnaldo
