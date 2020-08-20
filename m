Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB5AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE00F2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926534;
	bh=m+JpuHsTtgvxwpkh5h7HvBT8UphTi0sJ7hf212vjRi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ew1FiS81tVdpEcJkXw8lvUrf5Y4gdE16Klq03bjP5n0yMi/8rygwbAUJaU1xTizof
	 zuLVb+vTNv+JSOLJ3DHmgXpi8whqatD6rvBY+lB5L6feR5wz4HJE85PGgF4kXRCdXf
	 hf+oyn/qzn/96KQVkGSvF/gEWfBZkAza9otjxy4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgHTM2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgHTM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:28:34 -0400
Received: from quaco.ghostprotocols.net (unknown [177.135.15.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2125F20738;
        Thu, 20 Aug 2020 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597926514;
        bh=m+JpuHsTtgvxwpkh5h7HvBT8UphTi0sJ7hf212vjRi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvef028tek4cFywqdyQSepvfZmr+uKGuagBJO+TD7cF7lQkHrEFUUxrPgCTcXpIi/
         S+ukjIy6VaJmClfs654xUol53yTqp1+IPxbEi+txErgfx/NuqqcTjNHkegKfctrA6y
         8EEhx+y7QLspBNbRkqVKR3fCHuG07EK7QgXnewfU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99BC240D3D; Thu, 20 Aug 2020 09:28:30 -0300 (-03)
Date:   Thu, 20 Aug 2020 09:28:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Wei Li <liwei391@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, guohanjun@huawei.com
Subject: Re: [PATCH] perf: arm-spe: Fix check error when synthesizing events
Message-ID: <20200820122830.GC2667554@kernel.org>
References: <20200724072628.35904-1-liwei391@huawei.com>
 <20200724083218.GA5185@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724083218.GA5185@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 24, 2020 at 04:32:18PM +0800, Leo Yan escreveu:
> Hi Wei,
> 
> On Fri, Jul 24, 2020 at 03:26:28PM +0800, Wei Li wrote:
> > In arm_spe_read_record(), when we are processing an events packet,
> > 'decoder->packet.index' is the length of payload, which has been
> > transformed in payloadlen(). So correct the check of 'idx'.
> >
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Good catch.  I checked the ARMv8 ARM and the function payloadlen(),
> can confirm the fixing is correct.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

> > ---
> >  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 302a14d0aca9..93e063f22be5 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -182,15 +182,15 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
> >  			if (payload & BIT(EV_TLB_ACCESS))
> >  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
> >  
> > -			if ((idx == 1 || idx == 2 || idx == 3) &&
> > +			if ((idx == 2 || idx == 4 || idx == 8) &&
> >  			    (payload & BIT(EV_LLC_MISS)))
> >  				decoder->record.type |= ARM_SPE_LLC_MISS;
> >  
> > -			if ((idx == 1 || idx == 2 || idx == 3) &&
> > +			if ((idx == 2 || idx == 4 || idx == 8) &&
> >  			    (payload & BIT(EV_LLC_ACCESS)))
> >  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
> >  
> > -			if ((idx == 1 || idx == 2 || idx == 3) &&
> > +			if ((idx == 2 || idx == 4 || idx == 8) &&
> >  			    (payload & BIT(EV_REMOTE_ACCESS)))
> >  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
> >  
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
