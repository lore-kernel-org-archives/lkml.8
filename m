Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEEC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA08221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mDpYd1gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgDQKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgDQKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:06:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cOrb9bPUWtgd6Wsapeaho8G1pU3bJiwluL4FFzGvoDY=; b=mDpYd1gB+bi0K4T4b1v2Ciw4pB
        UIpwkgnCLwn7EJ8E43eLTiXToKyD7vCnn5f/+RDLTb4wEVE1AKWZq5y27rYTaouKNUL1doADfsHBS
        g4e49uwqq6dw+4sABzWQLf8R2J28Yvu3fUzjDSl4LOmfp/ca3DIMYuBG9MO87/vb46UgyltIgcBVe
        tqZe/VN94XQXkHZlFN0VhQmTAXOc/o3gZl80CZTsTawZ+vKl7Xe97Uvk/63Y39/t72JrDcykvywjV
        SSK5qmyEXIntmLYozQxcBrrceaBJ2zPOWWiOs0I/U6YOuLuuvq1nQt951OIlVEsHRlXz/yBwA0OZc
        WD2KJbWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPNtL-0000Hp-Tm; Fri, 17 Apr 2020 10:06:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03B773006E0;
        Fri, 17 Apr 2020 12:06:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B68282B1213AC; Fri, 17 Apr 2020 12:06:33 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:06:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200417100633.GU20730@hirez.programming.kicks-ass.net>
References: <20200414081951.297676-1-ying.huang@intel.com>
 <20200414120646.GN3818@techsingularity.net>
 <20200415113226.GE20730@hirez.programming.kicks-ass.net>
 <87o8rsxlws.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8rsxlws.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:24:35AM +0800, Huang, Ying wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Apr 14, 2020 at 01:06:46PM +0100, Mel Gorman wrote:
> >> While it's just an opinion, my preference would be to focus on reducing
> >> the cost and amount of scanning done -- particularly for threads.
> >
> > This; I really don't believe in those back-charging things, esp. since
> > not having cgroups or having multiple applications in a single cgroup is
> > a valid setup.
> 
> Technically, it appears possible to back-charge the CPU time to the
> process/thread directly (not the cgroup).

I've yet to see a sane proposal there. What we're not going to do is
make regular task accounting more expensive than it already is.
