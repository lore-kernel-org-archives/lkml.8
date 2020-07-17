Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98031C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CF620768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594985944;
	bh=Q1O79PDKw4045cIPmduaCsJqy5wA5dlz9iIuqTUDHjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3SFm7IMmkSGPtAgop3Ly0j0dPpG+vPfTK+qaBx5rYJcBEPAlxM0pgvKUaYq82pnP
	 /RIWKgZIVlU0SXUrB1LMff0KFxIZK9tFM3jV3KStMyFRNPpnDcUdTsaUWbffblutsU
	 1dUGK4ghSlPORfHMJ7zhpM4szTUot2/vKj9U/IUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGQLjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgGQLjC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:39:02 -0400
Received: from quaco.ghostprotocols.net (179.176.12.94.dynamic.adsl.gvt.net.br [179.176.12.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B32D20717;
        Fri, 17 Jul 2020 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594985941;
        bh=Q1O79PDKw4045cIPmduaCsJqy5wA5dlz9iIuqTUDHjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWb+v3DJXZ1H96V/pOhLrRVD46+OTUBcKpCCeikBmYcujDr2T0DvM+GUd5es7l+4J
         R91ZMmhXZwdLftvcfwNloZtC9jsda1msIS0nRKQHmhXuXoAuYyCXdskRGeCngmK7W1
         cTlhXnzlvHzvIMjaqyTP+lqkxMyKDwTAwZnP8cak=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0F99403C7; Fri, 17 Jul 2020 08:38:58 -0300 (-03)
Date:   Fri, 17 Jul 2020 08:38:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
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
Message-ID: <20200717113858.GB77866@kernel.org>
References: <20200703004215.24418-1-yao.jin@linux.intel.com>
 <20200703110042.GA3282312@krava>
 <9fa0bd83-b21e-7bc2-af81-799f8e99f73b@linux.intel.com>
 <CAP-5=fUjUc7yAA2wyes+DhMkwP9Mw0Lu5gy=XOnugy=vW1jwoQ@mail.gmail.com>
 <b527838b-42e8-b48a-debc-fd91923150d5@linux.intel.com>
 <deb02b38-49eb-088d-6ebf-b5396e50c725@linux.intel.com>
 <20200717082412.GA522549@krava>
 <d6af19b3-a766-0c4a-a9fe-332f4b05aa72@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6af19b3-a766-0c4a-a9fe-332f4b05aa72@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 04:30:21PM +0800, Jin, Yao escreveu:
> 
> 
> On 7/17/2020 4:24 PM, Jiri Olsa wrote:
> > On Fri, Jul 17, 2020 at 11:33:46AM +0800, Jin, Yao wrote:
> > > Hi,
> > > 
> > > On 7/6/2020 8:55 AM, Jin, Yao wrote:
> > > > Hi Ian,
> > > > 
> > > > On 7/6/2020 8:47 AM, Ian Rogers wrote:
> > > > > On Fri, Jul 3, 2020 at 5:31 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > > > > 
> > > > > > Hi Jiri,
> > > > > > 
> > > > > > On 7/3/2020 7:00 PM, Jiri Olsa wrote:
> > > > > > > On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
> > > > > > > > Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
> > > > > > > > a dummy event is added to capture mmaps.
> > > > > > > > 
> > > > > > > > But if we run perf-record as,
> > > > > > > > 
> > > > > > > >     # perf record -e cycles:p -IXMM0 -a -- sleep 1
> > > > > > > >     Error:
> > > > > > > >     dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> > > > > > > > 
> > > > > 
> > > > > Sorry for the breakage caused by modifying the dummy event. Could we
> > > > > add a test to cover the issue? Perhaps in tools/perf/tests/shell/.
> > > > > Trying to reproduce with a register on my skylakex on a 5.6.14 kernel
> > > > > with:
> > > > > 
> > > > > $ perf record -e cycles:p -IAX -a -- sleep 1
> > > > > 
> > > > > succeeds.
> > > > > 
> > > > > Thanks,
> > > > > Ian
> > > > > 
> > > > 
> > > > -IAX should be no problem. The issue only occurs on the platform with
> > > > extended regs supports, such as ICL. So I don't know if it's suitable to
> > > > add it to perf test suite.
> > > > 
> > > > Thanks
> > > > Jin Yao
> > > > 
> > > 
> > > Can this fix patch be accepted?
> > 
> > hi,
> > my only concern was that it would conflict with Adrian's patch,
> > other than that:
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> > 
> 
> Thanks Jiri!
> 
> Adrian's patch has not been merged otherwise I can rebase my patch on top of Adrian's patch.

I'll check this today.

- Arnaldo
