Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CABC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E552074A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588118355;
	bh=u/ltYCv1p8OpW209IZjq1/zAWf9Lt/dtQuqXy6qlGD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wbIlN29vgiZScD7nJr5M+yCJoQ6gmBl/763bBokLK7UtX2NctvO+Fv3ytNwozsdz9
	 Z3Ou/mFzk6+WzUJX4uMPzTPYMA7nwi4wpBjCzUrXT02HcI3B/HxlOGQq9DrT7lkGXA
	 VP316dAKxu42d6Fvv7GOi1yrPg1rFzkKI2GX0FTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgD1X7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgD1X7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:59:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7162720737;
        Tue, 28 Apr 2020 23:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588118353;
        bh=u/ltYCv1p8OpW209IZjq1/zAWf9Lt/dtQuqXy6qlGD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m65GDnRjsU0lHcSgWzFNtw5c3ZB/b0Jrw8m+ErHshFyk+jt70URJA1Wj66MWCmAAs
         BUfltVs8sxcuUAQ30NYBkBYwdViYHDF/yQMy1P5lTERcMZcl1h9es6FOYz3heDh0+O
         23pd1ZMGBIzaDM32UYjwEAqkFixws4d52KfH2cyI=
Date:   Tue, 28 Apr 2020 16:59:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-Id: <20200428165912.ca1eadefbac56d740e6e8fd1@linux-foundation.org>
In-Reply-To: <20200428093836.27190-4-srikar@linux.vnet.ibm.com>
References: <20200428093836.27190-1-srikar@linux.vnet.ibm.com>
        <20200428093836.27190-4-srikar@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 15:08:36 +0530 Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Currently Linux kernel with CONFIG_NUMA on a system with multiple
> possible nodes, marks node 0 as online at boot.  However in practice,
> there are systems which have node 0 as memoryless and cpuless.
> 
> This can cause numa_balancing to be enabled on systems with only one node
> with memory and CPUs. The existence of this dummy node which is cpuless and
> memoryless node can confuse users/scripts looking at output of lscpu /
> numactl.
> 
> By marking, N_ONLINE as NODE_MASK_NONE, lets stop assuming that Node 0 is
> always online.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -116,8 +116,10 @@ EXPORT_SYMBOL(latent_entropy);
>   */
>  nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
>  	[N_POSSIBLE] = NODE_MASK_ALL,
> +#ifdef CONFIG_NUMA
> +	[N_ONLINE] = NODE_MASK_NONE,
> +#else
>  	[N_ONLINE] = { { [0] = 1UL } },
> -#ifndef CONFIG_NUMA
>  	[N_NORMAL_MEMORY] = { { [0] = 1UL } },
>  #ifdef CONFIG_HIGHMEM
>  	[N_HIGH_MEMORY] = { { [0] = 1UL } },

So on all other NUMA machines, when does node 0 get marked online?

This change means that for some time during boot, such machines will
now be running with node 0 marked as offline.  What are the
implications of this?  Will something break?
