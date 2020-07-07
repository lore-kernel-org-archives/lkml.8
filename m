Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6258EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4136C206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594148419;
	bh=FUUkWJxhlhnlJ6qB2OGmjYydtxVJgtloTkFf5fHMkx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qeZwcJAcQ1QYRqdxjGqt+mBG/2BpZoKUWSEkonFachnxcwfwb7eyENW2zCC1RXfir
	 BXBE1OKBqyqmhESpRNxtAOYFtRSIq06z+2tJP4QuYm3RP8yYDlbR2R8sJWwaamuCFE
	 gd0L1G9Uof8iwPYP7/T7oiWnXWPFgzq9t389X0Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGGTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:00:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id z2so24101873wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 12:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VoyDJTI1cJ/dJyHAL3PoVYED5J0Stt74X8oxEEic8ao=;
        b=X4fcnEahO6fiCMhc145CKw1SH4xcDyoAajz1XNtBubdJfqXXRHU/zs6B6siuoIBBWH
         1fCKpnGCob2rbukjccC7gzYn/1Dwbb4OjJRJBmd5BFljlt+vhWrhVQf4cQ5739EsMFyw
         WlEVVCpG0o9zsBHeL6lBAo5CZ0h6+0N9lZLYIFAqmwMzv+K8fdcE10iJBDuBx3imWQIu
         nb8Nf7yJBnHUIQZZPnsFViuj+HRJCyg5+HbSWqS3Q/DsnpRcNUqYjKYbEofHxsbq/oUK
         wadyc2zlBV0bV6f7jVArusHemkhu9zTdvL2Gy6NFxTS3+nfRCZYjcisA2HW9l8c1Gj+i
         5txg==
X-Gm-Message-State: AOAM533Px9WgYLDrB7yrfMw/kEoDBzkXPRmujsDRJQO9SgJ1iUpM2T/z
        bfQPxOJVZFk7yEUjWie47m8=
X-Google-Smtp-Source: ABdhPJyj3S6v1FPmg4uWREMeTffGzWqJbvJBFUP3wNgeFQT8ldjLochB7WGbW9hEpKcA9NtBo+LvEw==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr52781033wrv.381.1594148415773;
        Tue, 07 Jul 2020 12:00:15 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id h84sm2540887wme.22.2020.07.07.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 12:00:14 -0700 (PDT)
Date:   Tue, 7 Jul 2020 21:00:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 06/11] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200707190013.GZ5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
 <409b6e24-d143-a61c-95a3-1a55e1a6008e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409b6e24-d143-a61c-95a3-1a55e1a6008e@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:49:51, Vlastimil Babka wrote:
> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > There are some similar functions for migration target allocation.  Since
> > there is no fundamental difference, it's better to keep just one rather
> > than keeping all variants.  This patch implements base migration target
> > allocation function.  In the following patches, variants will be converted
> > to use this function.
> > 
> > Changes should be mechanical but there are some differences. First, Some
> > callers' nodemask is assgined to NULL since NULL nodemask will be
> > considered as all available nodes, that is, &node_states[N_MEMORY].
> > Second, for hugetlb page allocation, gfp_mask is ORed since a user could
> > provide a gfp_mask from now on.
> 
> I think that's wrong. See how htlb_alloc_mask() determines between
> GFP_HIGHUSER_MOVABLE and GFP_HIGHUSER, but then you OR it with __GFP_MOVABLE so
> it's always GFP_HIGHUSER_MOVABLE.

Right you are! Not that it would make any real difference because only
migrateable hugetlb pages will get __GFP_MOVABLE and so we shouldn't
really end up here for !movable pages in the first place (not sure about
soft offlining at this moment). But yeah it would be simply better to
override gfp mask for hugetlb which we have been doing anyway.
-- 
Michal Hocko
SUSE Labs
