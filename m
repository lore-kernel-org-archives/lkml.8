Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB49206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgG1NQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:16:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:46314 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgG1NQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:16:57 -0400
IronPort-SDR: 0BX2zmYYAzYYoDZ3lhGRBz9VzcapNAgBdnMgoZqwo+MbZEBVfMqlroEKOjcCDnUjgNn5PeaJWF
 aVYopg0uN6Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="138720452"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="138720452"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 06:16:56 -0700
IronPort-SDR: mLYBLhV0Rr0bgzl8YUEgbAlZG+BPbvPprwXO4KFMfByhgxAoZivS0VsYoXcZnEfJxqljsvDnll
 JRGXE9w40pPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="303850244"
Received: from wenkema-mobl.ccr.corp.intel.com ([10.255.29.50])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2020 06:16:53 -0700
Message-ID: <1f2ef9915cbc7f1d55c8ad54b3efa3d93a9ef608.camel@intel.com>
Subject: Re: [PATCH 1/3] perf/x86/rapl: Fix missing psys sysfs attributes
From:   Zhang Rui <rui.zhang@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com
Date:   Tue, 28 Jul 2020 21:16:52 +0800
In-Reply-To: <20200717083328.GA528602@krava>
References: <20200716151859.6854-1-rui.zhang@intel.com>
         <20200717083328.GA528602@krava>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 10:33 +0200, Jiri Olsa wrote:
> On Thu, Jul 16, 2020 at 11:18:57PM +0800, Zhang Rui wrote:
> > This fixes a problem introduced by
> > commit 5fb5273a905c ("perf/x86/rapl: Use new MSR detection
> > interface")
> > that perf event sysfs attributes for psys RAPL domain are missing.
> > 
> > Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection
> > interface")
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > ---
> >  arch/x86/events/rapl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > index 0f2bf59f4354..51ff9a3618c9 100644
> > --- a/arch/x86/events/rapl.c
> > +++ b/arch/x86/events/rapl.c
> > @@ -665,7 +665,7 @@ static const struct attribute_group
> > *rapl_attr_update[] = {
> >  	&rapl_events_pkg_group,
> >  	&rapl_events_ram_group,
> >  	&rapl_events_gpu_group,
> > -	&rapl_events_gpu_group,
> > +	&rapl_events_psys_group,
> 
> I did copy & paste but did not change to psys :-\
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Hi, jirka,

Thanks for your ACK.


Hi, Peter,

A gentle ping on this patch series.

thanks,
rui
> 
> thanks,
> jirka
> 
> >  	NULL,
> >  };
> >  
> > -- 
> > 2.17.1
> > 
> 
> 

