Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D72C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FEE246BE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCBJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:32:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBJc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2149B01D;
        Mon,  2 Mar 2020 09:32:55 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com
References: <cover.1582321646.git.riel@surriel.com>
 <20200227213238.1298752-2-riel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aa39b1d9-96c1-c75b-d09b-4dbacdad2f46@suse.cz>
Date:   Mon, 2 Mar 2020 10:32:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227213238.1298752-2-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 10:32 PM, Rik van Riel wrote:
> The code to implement THP migrations already exists, and the code
> for CMA to clear out a region of memory already exists.
> 
> Only a few small tweaks are needed to allow CMA to move THP memory
> when attempting an allocation from alloc_contig_range.
> 
> With these changes, migrating THPs from a CMA area works when
> allocating a 1GB hugepage from CMA memory.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

With the followup fix,

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
