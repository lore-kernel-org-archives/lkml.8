Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D83206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594290490;
	bh=hUAGR+1Wt7XHNcuE/Ompj4LO8l4DU7kOhHJbLnG+A8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dR9UUxJPjzI0YldCsmHU+HWNHnyMmnysvOs03aS+Jur5khwcwAMcicRBSCrmWGBS6
	 NZoRGgEDvmWV50U8t2Qo8jcwzQjxY1sNwFBdyodCVSvuDHvOgol26XQ6k8sdzbD+QQ
	 +fSUScQ/I7CZhxFThV4/OD65010rF9b99CHW3v7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGIK2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:28:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:28:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so1762550wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vhfRd/Xz8WpuPSonhW0aG9Xlw1wwnrJlWi7lZcteXaM=;
        b=S75mO0S6CjNG4WwrjeAlmSJcF+KUF5J7bKBqCA4vGOxWErNWhe4zxLp9HKI+3gZqrI
         cAsuhIWI90VcrG36HKs+dKrTGLK5ppPlD9Nuwo8xw6dLYYVqvnZ+ak/sO5PAFb5Cjl//
         p6a71sfLjf3a0ZlAv+j0yVVyKO/4kv/292ap9Py4hT4aoj2auEJQHOuPXnDwrG/kNprn
         w3huaT0xS1Wh1gV+05gSO68bAtPftOR5ta5b+o22G1O4uunjWQzDTppS7Ur0TvMe/hgu
         mMa3gsPVe1C69GaJuBwF3x1gVa8RU5Bgu14D47DdK3WNVhAIKLiA55udhQpGdKBWVwBW
         8YvQ==
X-Gm-Message-State: AOAM5315GmJ1i6LglgebluDoKo8Bx/bLYo1kWmFEj5nOVPygCrDJBuQ/
        X1toBStAQx/qJu5tj7Dc0tU=
X-Google-Smtp-Source: ABdhPJxcmx3Lx6wndlpfqk3KIOiLTmInXeRHGpBBRxv1uHl97R8fkaA7/H4YSMEhkpYj1mv9iEtkVQ==
X-Received: by 2002:adf:f546:: with SMTP id j6mr61821883wrp.167.1594290484936;
        Thu, 09 Jul 2020 03:28:04 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id o21sm4026136wmh.18.2020.07.09.03.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:28:04 -0700 (PDT)
Date:   Thu, 9 Jul 2020 12:28:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 06/11] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200709102803.GF19160@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
 <409b6e24-d143-a61c-95a3-1a55e1a6008e@suse.cz>
 <20200707190013.GZ5913@dhcp22.suse.cz>
 <CAAmzW4PVp_PX-PySjy5axMzyy5n_4cHmzrhfT=tFH2VEzxVFRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PVp_PX-PySjy5axMzyy5n_4cHmzrhfT=tFH2VEzxVFRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-07-20 16:15:07, Joonsoo Kim wrote:
> 2020년 7월 8일 (수) 오전 4:00, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Tue 07-07-20 16:49:51, Vlastimil Babka wrote:
> > > On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >
> > > > There are some similar functions for migration target allocation.  Since
> > > > there is no fundamental difference, it's better to keep just one rather
> > > > than keeping all variants.  This patch implements base migration target
> > > > allocation function.  In the following patches, variants will be converted
> > > > to use this function.
> > > >
> > > > Changes should be mechanical but there are some differences. First, Some
> > > > callers' nodemask is assgined to NULL since NULL nodemask will be
> > > > considered as all available nodes, that is, &node_states[N_MEMORY].
> > > > Second, for hugetlb page allocation, gfp_mask is ORed since a user could
> > > > provide a gfp_mask from now on.
> > >
> > > I think that's wrong. See how htlb_alloc_mask() determines between
> > > GFP_HIGHUSER_MOVABLE and GFP_HIGHUSER, but then you OR it with __GFP_MOVABLE so
> > > it's always GFP_HIGHUSER_MOVABLE.
> 
> Indeed.
> 
> > Right you are! Not that it would make any real difference because only
> > migrateable hugetlb pages will get __GFP_MOVABLE and so we shouldn't
> > really end up here for !movable pages in the first place (not sure about
> > soft offlining at this moment). But yeah it would be simply better to
> > override gfp mask for hugetlb which we have been doing anyway.
> 
> Override gfp mask doesn't work since some users will call this function with
> __GFP_THISNODE.

> I will use hugepage_movable_supported() here and
> clear __GFP_MOVABLE if needed.

hugepage_movable_supported is really an implementation detail, do not
use it here. I think it would be better to add

gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t mask)
{
	gfp_t default_mask = htlb_alloc_mask(h);

	/* Some callers might want to enforce node */
	return default_mask | (mask & __GFP_THISNODE);
}

If we need to special case others, eg reclaim restrictions there would
be a single place to do so.
-- 
Michal Hocko
SUSE Labs
