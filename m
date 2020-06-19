Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B60E208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q8nq2iHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbgFSTWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgFSTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:22:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F2C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMAtILRiaCMojI5+o0vMCv5bCaOrtRE5uk7FzsxuMqk=; b=Q8nq2iHmf6G7X8EfDvCGqqu4VQ
        WJp2VzpFHWiHnPAhl5syR3jz7ENbV81TEHs1iFsI+ZgQQYc4HPdjudTE55bVji1T4wQq1gmB2kCf9
        LTXBc1uls4IHSmiUqEiAGjgPTN6iHxOaBn13E3j2PdQJiwyyfHctz6PBDK+GeKqdz62NrLGyd8pFm
        hHvgyTvkyYLlpaEbT2RrgVUuEQCZYVKqklocL6HSzh09axk8ExrRt7fZUyy6A8xwZaIU+ViV1OTtd
        GB9fsd3OblxYE1joivIhnPFvrn12M7YG40za5hu/KBToKjn3fy20mHM8itQ9jF15m+88CpCJ0I3c5
        1BBMnnaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMab-0007kg-Hx; Fri, 19 Jun 2020 19:22:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAC9E301A32;
        Fri, 19 Jun 2020 21:22:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5B69214DBDDF; Fri, 19 Jun 2020 21:22:11 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:22:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 11/21] perf/x86/intel/lbr: Support LBR_CTL
Message-ID: <20200619192211.GA576871@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-12-git-send-email-kan.liang@linux.intel.com>
 <20200619184025.GF576888@hirez.programming.kicks-ass.net>
 <42ec1526-470d-014d-f3eb-2430848856af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ec1526-470d-014d-f3eb-2430848856af@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:15:09PM -0400, Liang, Kan wrote:
> 
> 
> On 6/19/2020 2:40 PM, Peter Zijlstra wrote:
> > On Fri, Jun 19, 2020 at 07:03:59AM -0700, kan.liang@linux.intel.com wrote:
> > > -	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
> > > +	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map || x86_pmu.lbr_ctl_map) {
> > 
> > > +	union {
> > > +		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
> > > +		u64		lbr_ctl_mask;		   /* LBR_CTL valid bits */
> > > +	};
> > 
> > This makes absolutely no sense. There is hoping the compiler realizes
> > how stupid that is and fixes it for you, but shees.
> > 
> 
> The lbr_ctl_map and the lbr_ctl_mask are two different things.
> 
> The lbr_ctl_map stores the mapping from PERF_SAMPLE_BRANCH_* to the
> corresponding filtering bits in LBR_CTL MSR. It is used to replace the old
> lbr_sel_map. The mapping information in the old lbr_sel_map is hard coded,
> and has a const type. But for arch LBR, the LBR filtering capabilities are
> enumerated from CPUID. We should not hard code the mapping. So I add a new
> variable lbr_ctl_map.
> 
>  	const int	*lbr_sel_map;		   /* lbr_select mappings */
> +	int		*lbr_ctl_map;		   /* LBR_CTL mappings */
> 
> 
> I think we cannot reuse the old lbr_sel_map for the lbr_ctl_map.

Of course you can, you just did it, they're the exact same variable, you
just got confused with all the naming nonsense. You then got further
confused and ended up writing code that checked if a variable was not 0
twice, just to make sure.
