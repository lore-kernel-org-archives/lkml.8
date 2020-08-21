Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD791C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70382078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598011709;
	bh=3o9HFOJnx9ArA+CDFFKSPintjWmzreIRPj9S6cSlGrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KV3+jnSCyOqAem/kKfnyry7Oc6olA3vD6wAiYdtpsugYgYm2OCgYBrvpFoO5oSY9H
	 tVCXbl31fkuE1TWKGKg63tQy9RjipgZFHVYm/IDHfGSNVjZcMixn4/XXZxjggbgsTg
	 YVQZxBJzUHh5u6J392vXDUwBBPLm9wlk8mnFtTCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHUMI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbgHUMIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:08:02 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.208.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6032078D;
        Fri, 21 Aug 2020 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598011681;
        bh=3o9HFOJnx9ArA+CDFFKSPintjWmzreIRPj9S6cSlGrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVzS4Dc7ONMzIkhKBXiRQDT9Ct8Fa3hHb0v6+SZzznUpOmb97tMPEWhbdBDKxybeq
         7fWfL/P4UUjqFcPIT8oQd6/u5CFd1hlsqFdDGIp4Fl0mV30JYmekemVxsuxK4oI85h
         UP2VNBbQRF0udbDa6wUIZdymTIDaFsBKAisLZVpM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 339BA40D3D; Fri, 21 Aug 2020 09:07:58 -0300 (-03)
Date:   Fri, 21 Aug 2020 09:07:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        john.garry@huawei.com, leo.yan@linaro.org, jolsa@redhat.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add entries for CoreSight and Arm SPE
Message-ID: <20200821120758.GE2667554@kernel.org>
References: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
 <20200821090531.GC20255@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821090531.GC20255@willie-the-truck>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 21, 2020 at 10:05:31AM +0100, Will Deacon escreveu:
> On Thu, Aug 20, 2020 at 11:55:10AM -0600, Mathieu Poirier wrote:
> > Add entries for perf tools elements related to the support of Arm CoreSight
> > and Arm SPE.  Also lump in Arm and Arm64 architecture files to provide
> > coverage.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > V2:
> > - Completed fileset for SPE.
> > - Added Arm and Arm64 architecture files.
> > 
> >  MAINTAINERS | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index deaafb617361..e76f7bb014ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13569,12 +13569,18 @@ F:	kernel/events/*
> >  F:	tools/lib/perf/
> >  F:	tools/perf/
> >  
> > -PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> > +PERFORMANCE EVENTS SUBSYSTEM ARM64
> 
> I'd probably prefer to go with TOOLING instead of SUBSYSTEM, since the
> kernel parts are covered by the "ARM PMU PROFILING AND DEBUGGING" entry.

Yeah, I think its appropriate to have TOOLING instead of SUBSYSTEM, that
is more commonly used when referring to the kernel.

I'm applying with that change, locally, with your and John's Acked-by,
please holler if that is somehow controversial.

- Arnaldo
 
> >  R:	John Garry <john.garry@huawei.com>
> >  R:	Will Deacon <will@kernel.org>
> > +R:	Mathieu Poirier <mathieu.poirier@linaro.org>
> > +R:	Leo Yan <leo.yan@linaro.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Supported
> > +F:	tools/build/feature/test-libopencsd.c
> > +F:	tools/perf/arch/arm*/
> >  F:	tools/perf/pmu-events/arch/arm64/
> > +F:	tools/perf/util/arm-spe*
> > +F:	tools/perf/util/cs-etm*
> 
> Either way,
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Thanks,
> 
> Will

-- 

- Arnaldo
