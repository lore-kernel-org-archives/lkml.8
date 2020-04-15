Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D587CC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B273220737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hvd2px1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393937AbgDOLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390657AbgDOLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:32:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF565C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJiQ+eOHsfyCYt3l0kllphhznQD2NCgBQ/HSamSBJWY=; b=Hvd2px1ghMgtRjoeyAfhjQ4Pgg
        wF35jYsZarX+C95QKpbHD2KQpRe+JDpJIuuu7Sgw6wyCMWobQVpi8CgvB4XND6weM357HTLruYWJA
        yq/rBe56qZQDyyxhVR2SB0NPKPTuUDZ4FWaYVuB6DSv98kdM9tpI3tJnljUuR8JvSfZIRKKxOL7qy
        f+9Wy1/y8jaYpNmju0yyfO9ZBY0RtnVtWz1cqM+vi+br0lCAt3eHoUiLcYstMed0HkSFqBJ8kqeOi
        GagxHZAMETWaDiG7TvDzCmQOr8P77GRvHU4p4JFXmAVvjmK4+iAIolj4oGQQmQYIH9jtOuK6XwnpQ
        DzqviHUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOgHN-000539-M3; Wed, 15 Apr 2020 11:32:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CA7F30066E;
        Wed, 15 Apr 2020 13:32:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2365203A8983; Wed, 15 Apr 2020 13:32:26 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:32:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200415113226.GE20730@hirez.programming.kicks-ass.net>
References: <20200414081951.297676-1-ying.huang@intel.com>
 <20200414120646.GN3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414120646.GN3818@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:06:46PM +0100, Mel Gorman wrote:
> While it's just an opinion, my preference would be to focus on reducing
> the cost and amount of scanning done -- particularly for threads.

This; I really don't believe in those back-charging things, esp. since
not having cgroups or having multiple applications in a single cgroup is
a valid setup.

Another way to reduce latency spikes is to decrease both
sysctl_numa_balancing_scan_delay and sysctl_numa_balancing_scan_size.
Then you do more smaller scans. By scanning more often you reduce the
contrast, by reducing the size you lower the max latency.

And this is all assuming you actually want numa balancing for this
process.
