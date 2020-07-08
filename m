Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E883AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F32204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594207981;
	bh=s9HfRCZApvmz7y/e3Q61nqw/KHpFSB/uN1Zs5YJupf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OhVhX2R6dU2Y+Q//HEL2uI3XWh52nZqubDjf4Sp9s83NiB1vRvTKX9DgRudw36uDr
	 P27QuSgX6GXd4+DKNRWLqWVRH41pY6WB6fg73gQ/K7GBZ+yUYw5lY5GvPDAuCyaNsy
	 Ds56G1QB1xaxB28qW8MI4fGpceN4HUjLsDK4JmSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgGHLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:33:00 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35773 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgGHLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:32:59 -0400
Received: by mail-ej1-f65.google.com with SMTP id rk21so50050987ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+9BlsY0XFg5CpKVe1acIU9xV2I7eOlxFrwWt4OM7Tc0=;
        b=NsZBP1J4gJKl82kqc9uimQF6MYcAQd0Nw4rSTX9DVXZUigT8Chi61cBVFBBtMv6YiD
         J8+xsVDRmrb2Vvr5Mnl01BfUA0ibEuAgPkhmhj1hwW5Mo6SEiq6rxUaIVP0XxH5YBoeR
         4bXnyb+aIHDdQ2j+wRPYfom87YST0BqhefChxB9KcEdCMDZfOy2diRM95AUlCpHp0Tul
         GRuHeebdhZuem9JbLf0+3dT2L15z4V/RnvY0DIN5vueSylF7IPrk/5ba9EVUu+VdEYla
         SIh1wiSR8bMC8BANShunx0RHEf4RC678Xl3qxNPHQ8TcSi4GyMBpFD2dyHzKms+shJj9
         8M3w==
X-Gm-Message-State: AOAM531xy4bVw1KK4T+i+9ej6zs3wYQaUVoWrvKDvUBFBwsAzQiPaiXI
        142UWfHn5SW/BQoqx7mRWJc=
X-Google-Smtp-Source: ABdhPJw9dltknYTt89hYa1SpdeGec/bhleJVh9/LF970K3cyJNycxptZT0tReKmdbLaSjDGVNL0y1A==
X-Received: by 2002:a17:906:2a5b:: with SMTP id k27mr49749551eje.82.1594207977416;
        Wed, 08 Jul 2020 04:32:57 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id cz2sm26895698edb.82.2020.07.08.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:32:56 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:32:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <js1304@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200708113254.GI7271@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
 <20200708074103.GD7271@dhcp22.suse.cz>
 <8549326e-7485-dd6d-1fa1-a899228b9b2f@suse.cz>
 <87h7uil1f7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7uil1f7.fsf@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-07-20 16:27:16, Aneesh Kumar K.V wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
> > On 7/8/20 9:41 AM, Michal Hocko wrote:
> >> On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
> >>> On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
> >>> 
> >>> Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
> >>> would not cause any problem.
> >> 
> >> I believe a proper fix is the following. The scope is really defined for
> >> FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
> >> will solve the problem as well but it imho makes more sense to do it in
> >> the caller the same way we do for any others. 
> >> 
> >> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> >
> > Agreed.
> >
> >> 
> >> I am not sure this is worth backporting to stable yet.
> >
> > CC Aneesh.
> >
> > Context: since check_and_migrate_cma_pages() calls __get_user_pages_locked(), it
> > should also be called under memalloc_nocma_save().
> 
> But by then we faulted in all relevant pages and migrated them out of
> CMA rea right?

check_and_migrate_cma_pages will allocate target pages that you want to
migrate off the CMA region unless I am misreading the code. And those
allocation need to be placed outside of the CMA.
-- 
Michal Hocko
SUSE Labs
