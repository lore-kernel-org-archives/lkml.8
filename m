Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6FCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3007A206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597751522;
	bh=OSy/tv9DaM5THAW6K7D2NRAJ14Lqh7He7G1J59uUAco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vhuyv7jIBBO1SE0wh6mUXNSN4RWbR0Wo4qeGetMI9eRAhTYgAawLTCDoCdVMYLLq9
	 99PkqQ0HDvEJxX7tHTQ4HEAEFVmw5q0ywO3cUBQfgwFIl59JzIdK5wkwzS0vn6Usoo
	 7pl423OKCc5AHPNL3/VVBRZz1IAbjnXq2cK1iOhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgHRLwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgHRLv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:51:58 -0400
Received: from quaco.ghostprotocols.net (179.176.9.68.dynamic.adsl.gvt.net.br [179.176.9.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9145207FF;
        Tue, 18 Aug 2020 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597751518;
        bh=OSy/tv9DaM5THAW6K7D2NRAJ14Lqh7He7G1J59uUAco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn3fJQWF+DiXQJ896/H9ukJ/pU1iJ2UQGddROtNOf0Kx15HzXpoIhWnrBiMTaeVBo
         MY1EJVX0bfX7mK9zXpD3TJTLujRw4cNm9v3klvNj9JbvB7ITOZJhM+dDBaxX96UVXa
         mOOZJeVl+BoVXWTMqoTxhcMz08T8bOn+oLosRhdw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F79F40D3D; Tue, 18 Aug 2020 08:51:55 -0300 (-03)
Date:   Tue, 18 Aug 2020 08:51:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] perf sched timehist: Fix use of CPU list with summary
 option
Message-ID: <20200818115155.GA2667554@kernel.org>
References: <20200817170943.1486-1-dsahern@kernel.org>
 <CAM9d7chxJ9hkCsL+PnJSFfKHwbjg6=D+RVDT6E7GWKwedwzGiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chxJ9hkCsL+PnJSFfKHwbjg6=D+RVDT6E7GWKwedwzGiQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 18, 2020 at 10:29:29AM +0900, Namhyung Kim escreveu:
> Hi David,
> 
> On Tue, Aug 18, 2020 at 2:09 AM David Ahern <dsahern@kernel.org> wrote:
> >
> > Do not update thread stats or show idle summary unless CPU is in
> > the list of interest.
> >
> > Fixes: c30d630d1bcf ("perf sched timehist: Add support for filtering on CPU")
> > Signed-off-by: David Ahern <dsahern@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
 
> Thanks
> Namhyung
> 
> > ---
> > v2
> > - check that cpu_list is set before checking cpu_bitmap in timehist_print_summary
> >
> >  tools/perf/builtin-sched.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 0c7d599fa555..e6fc297cee91 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -2584,7 +2584,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
> >         }
> >
> >         if (!sched->idle_hist || thread->tid == 0) {
> > -               timehist_update_runtime_stats(tr, t, tprev);
> > +               if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
> > +                       timehist_update_runtime_stats(tr, t, tprev);
> >
> >                 if (sched->idle_hist) {
> >                         struct idle_thread_runtime *itr = (void *)tr;
> > @@ -2857,6 +2858,9 @@ static void timehist_print_summary(struct perf_sched *sched,
> >
> >         printf("\nIdle stats:\n");
> >         for (i = 0; i < idle_max_cpu; ++i) {
> > +               if (cpu_list && !test_bit(i, cpu_bitmap))
> > +                       continue;
> > +
> >                 t = idle_threads[i];
> >                 if (!t)
> >                         continue;
> > --
> > 2.17.1
> >

-- 

- Arnaldo
