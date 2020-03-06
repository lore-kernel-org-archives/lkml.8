Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D493C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4670C2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eyIim16g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFDiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:38:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rqyJWhqmtX09E///ey5psBOLsfjO99rwJHR7dADL46w=; b=eyIim16gh9rLqANg/VwkVeBX1H
        pq1Kk6qjbD4HhVOYd4K/KH/bfqLkdySFuj7BO+ZAN7legvki1J6AYoTNEeeNmUfVdAnddiTn7ljZB
        Mu12PaSqBpVdyWauK2iF2L7+epGDB/leuxct1WSaVw/snFVV0IWzaINwEvU6zHDwsWeID5pCS8xVl
        O1hbxyoR6TLQy9wfCjx2H+cvFTkQgLoZ8KJEMlflqYtcliRvcIuquWNj5Er1luBcZbprdGnmbMF8T
        UKTGf+srJWBMDJWB+SUodtyOlUuVJpwc7L5VqORCGViHblpJal9GKQHU9AY6+NLwrXQh0qMCt/rTb
        1cOUCT+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA3p4-0002KM-Sk; Fri, 06 Mar 2020 03:38:50 +0000
Date:   Thu, 5 Mar 2020 19:38:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
Message-ID: <20200306033850.GO29971@bombadil.infradead.org>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:32:18PM -0500, Qian Cai wrote:
> > On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
> > The patch titled
> >     Subject: mm/vmscan: remove unnecessary lruvec adding
> > has been removed from the -mm tree.  Its filename was
> >     mm-vmscan-remove-unnecessary-lruvec-adding.patch
> > 
> > This patch was dropped because it had testing failures
> 
> Andrew, do you have more information about this failure? I hit a bug
> here under memory pressure and am wondering if this is related
> which might save me some time digging…

See Hugh's message from a few minutes ago:

Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
