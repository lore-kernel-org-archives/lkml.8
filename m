Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4C6C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B9521D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DyT5X2yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgDQKFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDQKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:05:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545CFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GVL6tgAFwgffDbhheeH49uz+J5xS7rxe9LbYjvob9SI=; b=DyT5X2ywxTKZXaAlPBbRhvJa5b
        qJswAbTkoXJhlMCc3mwsLtxcmc0wulm9BuvH4g4svEPKyQIpdW6mcq2CfQLmeYJ8ocVptbJQjU909
        kGFdPLM9QOEsH46r4juwUcVB/vrs/MkYRDbAbqbc+8y47W2d2QEN9ENLYyMfYBvPgqiBVe8sJ1Tso
        AzsNCXjHCw0TAOKbCCLY90M8N8c4TrCMKSCmZ11Baj3Ozdrv60M6oZeJmfN5AjhavyPpoRpeOzNx3
        dau6rrsisCeRholRRndwScMlHyb/+1qb7z2ZuIOP6/lQ20EHXtFUn5BZOUBm2h2fXZi+mdtFYR1qt
        Xjvd4EMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPNrB-0004aT-Kn; Fri, 17 Apr 2020 10:04:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C10D930477A;
        Fri, 17 Apr 2020 12:04:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9829F2B1213AA; Fri, 17 Apr 2020 12:04:17 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:04:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200417100417.GT20730@hirez.programming.kicks-ass.net>
References: <87eespyxld.fsf@yhuang-dev.intel.com>
 <20200417070508.32243-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417070508.32243-1-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> I think the main idea of DAMON[1] might be able to applied here.  Have you
> considered it?
> 
> [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/

I've ignored that entire thing after you said the information it
provides was already available through the PMU.


