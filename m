Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6520A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595938648;
	bh=PsfBZPvm8C6J4L11gPAZ+Mfo5hkustU/Edw7NUR2XJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JBR0nRJq8wgeUN8iRapQWFADlECuf+rHhEpRzWcLEVuv7fPPRj4lc2nzVOrL37rNS
	 XfUAeAP3HtT2lf/Zims/tTmrqSczBvOEnaF5Olzn5XG6BFkenYCI6DmKu3VbyKLwr1
	 U5RCo9OuBJQg9rjL+SbHZpWlW4UJTigbjijtSC2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgG1MR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1MRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:17:25 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96272206D8;
        Tue, 28 Jul 2020 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595938644;
        bh=PsfBZPvm8C6J4L11gPAZ+Mfo5hkustU/Edw7NUR2XJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7AfZRRWRt5Xd0N8GNWDyRYXhCuyHeBQaSB9x8d8+zuBKv6O0WaFBb7Fzxrvp6Bvc
         FwIe0kbWnh6gpc0CtwOw3K/CWDJ+utFGx8eC8JCPJ5QzFbjrS8PEeBaRBDHKjphnnv
         oaBEWsojgjDu0DIamsbPRB0IzOhVJd1NPZqEYQZU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A24A7404B1; Tue, 28 Jul 2020 09:17:22 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:17:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCHv2 2/2] perf tools: Fix term parsing for raw syntax
Message-ID: <20200728121722.GF40195@kernel.org>
References: <20200726075244.1191481-1-jolsa@kernel.org>
 <20200726075244.1191481-2-jolsa@kernel.org>
 <4d30edad-8df1-ac9d-c70d-9019935c4d4c@linux.intel.com>
 <003c9419-4396-6ad6-b934-ec04bf9f8a63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003c9419-4396-6ad6-b934-ec04bf9f8a63@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 27, 2020 at 08:26:27AM +0800, Jin, Yao escreveu:
> 
> 
> On 7/27/2020 8:21 AM, Jin, Yao wrote:
> > 
> > 
> > On 7/26/2020 3:52 PM, Jiri Olsa wrote:
> > > Jin Yao reported issue with possible conflict between raw
> > > events and term values in pmu event syntax.
> > > 
> > > Currently following syntax is resolved as raw event with
> > > 0xead value:
> > >    uncore_imc_free_running/read/
> > > 
> > > instead of using 'read' term from uncore_imc_free_running pmu,
> > > because 'read' is correct raw event syntax with 0xead value.
> > > 
> > > To solve this issue we do following:
> > >    - check existing terms during rXXXX syntax processing
> > >      and make them priority in case of conflict
> > >    - allow pmu/r0x1234/ syntax to be able to specify conflicting
> > >      raw event (implemented in previous patch)
> > > 
> > > Also adding automated tests for this and perf_pmu__parse_cleanup
> > > call to parse_events_terms, so the test gets properly cleaned up.
> > > 
> > > Reported-by: Jin Yao<yao.jin@linux.intel.com>
> > > Signed-off-by: Jiri Olsa<jolsa@kernel.org>
> > > ---
> > > v2 changes:
> > >   - added comment to perf_pmu__test_parse_init
> > 
> > Acked-by: Jin Yao <yao.jin@linux.intel.com>
> > 
> > Thanks
> > Jin Yao
> 
> Also added with:
> Fixes: 3a6c51e4d66c ("perf parser: Add support to specify rXXX event with pmu")?

Thanks, applied.

- Arnaldo
