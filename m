Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C920C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4295020768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594974978;
	bh=oZq7Fbz2TiMvKHe/JBvvtXTy/iMy1j03VTqamEx6+uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nvGf+7OoKpTd4OcGOQyDgBxWMe2MGEPggKaNcwBb2kaLo5Ghp0WyP5LWR3Zy3bhjG
	 B5RKS6IePWIJYs3uBSoMvP/Wl3I+DA1kVHpCizGovG2bz8k1e/UHPNlZdgrklggHaj
	 R5HwkCOyu7ytiC+Ml5+QwdwsWAVEq9pgvRZOUsSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGQIgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQIgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:36:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE8820578;
        Fri, 17 Jul 2020 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594974975;
        bh=oZq7Fbz2TiMvKHe/JBvvtXTy/iMy1j03VTqamEx6+uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpru/62UBNss/0vd6CA4dag6ysIfD42h6V8SYYF9qGsSWt2ofAx9oRkx4viT8yRYo
         Y6Um5luBQjY9SE4jYnOd+yPmK8iEGn/VZKctod7P9KE6WnlkhHxGkJzm26CIwve2+z
         T4CnhIma70WB23k2ovEQycWQ2dBwidbQqrHxmJiU=
Date:   Fri, 17 Jul 2020 09:36:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
Message-ID: <20200717083608.GA8293@willie-the-truck>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:32:53AM +0530, Anshuman Khandual wrote:
> 
> 
> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
> >>From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Tue, 14 Jul 2020 15:54:46 -0700
> > Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
> >  hstate
> > 
> > Instead of calling hugetlb_cma_reserve() directly from arch specific
> > code, call from hugetlb_add_hstate when adding a gigantic hstate.
> > hugetlb_add_hstate is either called from arch specific huge page setup,
> > or as the result of hugetlb command line processing.  In either case,
> > this is late enough in the init process that all numa memory information
> > should be initialized.  And, it is early enough to still use early
> > memory allocator.
> 
> This assumes that hugetlb_add_hstate() is called from the arch code at
> the right point in time for the generic HugeTLB to do the required CMA
> reservation which is not ideal. I guess it must have been a reason why
> CMA reservation should always called by the platform code which knows
> the boot sequence timing better.

Ha, except we've moved it around two or three times already in the last
month or so, so I'd say we don't have a clue when to call it in the arch
code.

Will
