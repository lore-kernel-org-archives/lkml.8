Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C776DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3A020777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R36N4MAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCYRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:45:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55103 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbgCYRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585158299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4Qfjdrf/9hR5jWluXLfGirtkwElAUjeNbM8dtmiVo0=;
        b=R36N4MAQr1tlbFkHPCjhBUlrLgSIyfuwg/nNoMyeHxMYI515a3QNEQ0Of6VQ5puxsqWTpQ
        mibf1rXMWAHhhGMFoykpLgJ7f6wDddX4zyoxA68OSrbquv0oQJO6shlyn6XA73nOl1v98u
        oHB86GF4Ns1QM2i4clkvAjYrONagDAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-JPvNj2qTMvGHPkchAgUJ7A-1; Wed, 25 Mar 2020 13:44:57 -0400
X-MC-Unique: JPvNj2qTMvGHPkchAgUJ7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A249149CC;
        Wed, 25 Mar 2020 17:44:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1358190A13;
        Wed, 25 Mar 2020 17:44:54 +0000 (UTC)
Date:   Wed, 25 Mar 2020 18:44:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200325174449.GB1934048@krava>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava>
 <20200325142214.GD14102@kernel.org>
 <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
 <20200325152211.GA1908530@krava>
 <fc3c4dee-981e-4c39-566a-4163ee0bcc02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3c4dee-981e-4c39-566a-4163ee0bcc02@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 07:10:44PM +0200, Adrian Hunter wrote:

SNIP

> > ---
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 7b1c8ee537cf..347eb3e6794a 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -342,11 +342,15 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
> >  	 * Because the prefix cycles is mixed up with cpu-cycles.
> >  	 * loads and stores are mixed up with cache event
> >  	 */
> > -cycles-ct					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> > -cycles-t					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> > -mem-loads					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> > -mem-stores					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> > -topdown-[a-z-]+					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> > +cycles-ct				|
> > +cycles-t				|
> > +mem-loads				|
> > +mem-stores				|
> > +topdown-[a-z-]+				|
> > +tx-capacity-read			|
> > +tx-capacity-write			|
> > +el-capacity-read			|
> > +el-capacity-write			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
> 
> Yes that works, as does
> 
> tx-capacity-[a-z-]+
> el-capacity-[a-z-]+
> 
> Do we have an explanation for why we cannot make it accept 3-part names
> without handling them as special cases?

check the pmu_str_check, I guess it could be more generic,
but it gets complicated later on, so I'm not sure there's
some other obstacle..

CC-ing Kan Liang, who wrote that

jirka

> 
> I just tried but it didn't work.
> 

