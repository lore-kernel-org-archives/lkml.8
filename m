Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B02071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om1gFuIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgGQIYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:24:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33468 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgGQIYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594974261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7Ti2y/rf1mCHH77oE9WR5mVm8jlwvItz+mBTyiLp7E=;
        b=Om1gFuIxyXgXcfiiQ1XhLIDGTFjR2793iIMpo3A4boJTvzEBbseFUKndtnsil8d/WT7Ign
        WtDcnrrdght6WX/kY2SkvEXXXBD435HIa8mJkuim4S4wuL5Pau+/P9f93AUg4vFYSIlsQT
        HuPRr8n41aZbZL1m/8hv+p44ElW8OxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-LmX9NkWROFmvpihkG3Redw-1; Fri, 17 Jul 2020 04:24:17 -0400
X-MC-Unique: LmX9NkWROFmvpihkG3Redw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9661081;
        Fri, 17 Jul 2020 08:24:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8437B41E;
        Fri, 17 Jul 2020 08:24:13 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:24:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user
 for dummy event
Message-ID: <20200717082412.GA522549@krava>
References: <20200703004215.24418-1-yao.jin@linux.intel.com>
 <20200703110042.GA3282312@krava>
 <9fa0bd83-b21e-7bc2-af81-799f8e99f73b@linux.intel.com>
 <CAP-5=fUjUc7yAA2wyes+DhMkwP9Mw0Lu5gy=XOnugy=vW1jwoQ@mail.gmail.com>
 <b527838b-42e8-b48a-debc-fd91923150d5@linux.intel.com>
 <deb02b38-49eb-088d-6ebf-b5396e50c725@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deb02b38-49eb-088d-6ebf-b5396e50c725@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:33:46AM +0800, Jin, Yao wrote:
> Hi,
> 
> On 7/6/2020 8:55 AM, Jin, Yao wrote:
> > Hi Ian,
> > 
> > On 7/6/2020 8:47 AM, Ian Rogers wrote:
> > > On Fri, Jul 3, 2020 at 5:31 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > > 
> > > > Hi Jiri,
> > > > 
> > > > On 7/3/2020 7:00 PM, Jiri Olsa wrote:
> > > > > On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
> > > > > > Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
> > > > > > a dummy event is added to capture mmaps.
> > > > > > 
> > > > > > But if we run perf-record as,
> > > > > > 
> > > > > >    # perf record -e cycles:p -IXMM0 -a -- sleep 1
> > > > > >    Error:
> > > > > >    dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> > > > > > 
> > > 
> > > Sorry for the breakage caused by modifying the dummy event. Could we
> > > add a test to cover the issue? Perhaps in tools/perf/tests/shell/.
> > > Trying to reproduce with a register on my skylakex on a 5.6.14 kernel
> > > with:
> > > 
> > > $ perf record -e cycles:p -IAX -a -- sleep 1
> > > 
> > > succeeds.
> > > 
> > > Thanks,
> > > Ian
> > > 
> > 
> > -IAX should be no problem. The issue only occurs on the platform with
> > extended regs supports, such as ICL. So I don't know if it's suitable to
> > add it to perf test suite.
> > 
> > Thanks
> > Jin Yao
> > 
> 
> Can this fix patch be accepted?

hi,
my only concern was that it would conflict with Adrian's patch,
other than that:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

