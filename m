Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DD82072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591633040;
	bh=jy945Wzc7D6P8GLpZfk4ltA86iAqCKbubgUjYjV1mmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=asIbli8C5CDmDbvv/5i+bMYUL/Kr8xpiKm2oempfI7RAhoTJiNAKOJ8uxq6VjgcD6
	 nemxUpWtLVoENn3Hstfw1djjPmIcZUeGbjt1hxU7xjzmBUmRS8EgaZs53sKbiTK6sR
	 JqlmEWjbXZmHZpbxXYxKbpHofvq/HZDv1e5ak0Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgFHQRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgFHQRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:17:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33774206D5;
        Mon,  8 Jun 2020 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591633038;
        bh=jy945Wzc7D6P8GLpZfk4ltA86iAqCKbubgUjYjV1mmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auUSdU2mCgNKkCLdje3J/JlQRB/y5C4WVs9lFw59+4hdbhHI/vBOKM603hnG9rp4h
         /Oz2GcGMGhuNHjM9V21guu4vUALNjbz34tOvG9a64fKiyywqSvaa2g4zuFWwvQVrPo
         M0/ZLDERCVEC3Q3KTMyPf5+E+wjDVhyYnu3Of3mk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5716740AFD; Mon,  8 Jun 2020 13:17:16 -0300 (-03)
Date:   Mon, 8 Jun 2020 13:17:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix null pointer dereference in
 hists__fprintf_nr_sample_events
Message-ID: <20200608161716.GB3073@kernel.org>
References: <CAFAFadADkyJ4qn8Ax2Ratnw03jHiTqY1pvj=AU6kwaqGDNkdfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAFadADkyJ4qn8Ax2Ratnw03jHiTqY1pvj=AU6kwaqGDNkdfA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 06, 2020 at 06:44:45PM -0400, gaurav singh escreveu:
> Hi,
> 
> evname is assigned if condition (evsel__is_group_event(evsel)) is true . It
> is checked for nullnuess here:
> 
>     if (evname != NULL) {
>         ret += fprintf(fp, " of event%s '%s'",
>                    evsel->core.nr_members > 1 ? "s" : "", evname);
>     }
> 
> and later on its used directly : strstr(evname, "call-graph=no")) which can
> possibly cause null pointer dereference. In order to fix this, add an an
> extra check in the if.
> 
> Please find the patch below.
> 
> Thanks and regards,
> Gaurav.

I'm applying the patch by hand, your e-mail client garbled it, I'm also
adding:

Cc: Kan Liang <kan.liang@intel.com>
Fixes: 9e207ddfa207 ("perf report: Show call graph from reference events")

Thanks,

- Arnaldo
 
> 
> From 399b3faaa5283a488f4227a13d69255e0f316d94 Mon Sep 17 00:00:00 2001
> From: Gaurav Singh <gaurav1086@gmail.com>
> Date: Sat, 6 Jun 2020 18:37:17 -0400
> Subject: [PATCH] Fix null pointer dereference in
>  hists__fprintf_nr_sample_events
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  tools/perf/builtin-report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index b63b3fb2de70..d8a45c28ba53 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -478,7 +478,7 @@ static size_t hists__fprintf_nr_sample_events(struct
> hists *hists, struct report
>   if (rep->time_str)
>   ret += fprintf(fp, " (time slices: %s)", rep->time_str);
> 
> - if (symbol_conf.show_ref_callgraph &&
> + if (symbol_conf.show_ref_callgraph && evname != NULL &&
>      strstr(evname, "call-graph=no")) {
>   ret += fprintf(fp, ", show reference callgraph");
>   }
> -- 
> 2.17.1

-- 

- Arnaldo
