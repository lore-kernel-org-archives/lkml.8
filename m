Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF9DC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F220578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSRizBa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgBUNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:21:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727699AbgBUNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582291263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4ms2CgVns2BaGnINjY8fAnvcQ0WnyDlOpXKLBLyMwo=;
        b=JSRizBa+LIXeP5hmVH2CE3VUhNBCclNWwE0Pfj5Iy9gnoExuPF8OXkvikYsTVvNODzcOMJ
        k2JOM0aKf43v+3S2Q5RKes4ER2PWuj2I5TLngNwhLxTEClEc11F5Nklk/a1dJ2u2EDcTYz
        AhMAX10Oo6HVKC1U6gydOh1/3tvGnR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-wrBPfRNlOUmJH_P1DeT36w-1; Fri, 21 Feb 2020 08:20:57 -0500
X-MC-Unique: wrBPfRNlOUmJH_P1DeT36w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4AF7107ACC5;
        Fri, 21 Feb 2020 13:20:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE0427180;
        Fri, 21 Feb 2020 13:20:50 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:20:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200221132048.GE652992@krava>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221080325.GA67807@shbuild999.sh.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:03:25PM +0800, Feng Tang wrote:
> 
> On Wed, Feb 05, 2020 at 01:58:04PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 05, 2020 at 08:32:16PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -5.5% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: 81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb ("perf/x86: Add check_period PMU callback")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > 
> > I'm fairly sure this bisect/result is bogus.
> 
> 
> Hi Peter,
> 
> Some updates:
> 
> We checked more on this. We run 14 times test for it, and the
> results are consistent about the 5.5% degradation, and we
> run the same test on several other platforms, whose test results
> are also consistent, though there are no such -5.5% seen.
> 
> We are also curious that the commit seems to be completely not
> relative to this scalability test of signal, which starts a task
> for each online CPU, and keeps calling raise(), and calculating
> the run numbers.
> 
> One experiment we did is checking which part of the commit
> really affects the test, and it turned out to be the change of
> "struct pmu". Effectively, applying this patch upon 5.0-rc6 
> which triggers the same regression.
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1d5c551..e1a0517 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -447,6 +447,11 @@ struct pmu {
>  	 * Filter events for PMU-specific reasons.
>  	 */
>  	int (*filter_match)		(struct perf_event *event); /* optional */
> +
> +	/*
> +	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
> +	 */
> +	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
>  };
> 
> So likely, this commit changes the layout of the kernel text
> and data, which may trigger some cacheline level change. From
> the system map of the 2 kernels, a big trunk of symbol's address
> changes which follow the global "pmu",

nice, I wonder we could see that in perf c2c output ;-)
I'll try to run and check

thanks,
jirka

> 
> 5.0-rc6-systemap:
> 
> ffffffff8221d000 d pmu
> ffffffff8221d100 d pmc_reserve_mutex
> ffffffff8221d120 d amd_f15_PMC53
> ffffffff8221d160 d amd_f15_PMC50
> 
> 5.0-rc6+pmu-change-systemap:
> 
> ffffffff8221d000 d pmu
> ffffffff8221d120 d pmc_reserve_mutex
> ffffffff8221d140 d amd_f15_PMC53
> ffffffff8221d180 d amd_f15_PMC50
> 
> But we can hardly identify which exact symbol is responsible
> for the change, as too many symbols are offseted. 
> 
> btw, we've seen similar case that an irrelevant commit changes
> the benchmark, like a hugetlb patch improves pagefault test on
> a platform that never uses hugetlb https://lkml.org/lkml/2020/1/14/150  
> 
> Thanks,
> Feng
> 
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
> 

