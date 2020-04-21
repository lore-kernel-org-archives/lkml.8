Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0EE2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUWoO33Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUTNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbgDUTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:13:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F8C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:13:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so11824622ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/+YOMpTdK2B7DWfew1yvduwiCraaW2/kuntapldYZ0=;
        b=bUWoO33YlTxWoYWiORjP3cfd0fXYcJlwyVFVKaoJXnsvHiP4GSzVRDCjxFF08py8lN
         5ZUrKIqEk822Szjrlp1a4M6EooH0kyC/WpUqGiVwtSTYmjBfkxKXaIUk0OCxAPeXkyQt
         /6fuXhRJIF6ZD/CXoAAPg2r9Quv9ZDfp9xAv0Cx9MdvuVu74+9KjyhWDEj5qnLon4d8u
         nXYnLbO9ypaVJ5RXViyX+EC3kVxDVZ/QAZZ0OD1acVRZBUPXSJSR2gBVHUcVu1xrfS9Y
         rXdzeb62flwCVklON1DT44s3z++HTQophQ/mY77/dUZF7wNPPJZa/MEoe1DHqIarJdWt
         LZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/+YOMpTdK2B7DWfew1yvduwiCraaW2/kuntapldYZ0=;
        b=UBLcTE6xXggZdz51AO489mkKpQdRMfjQ6v4ll3e7+6QCUppnBZ9s7MBsg/v4kLGbZN
         LIWPvyJ9uuB3mvTD/x73woGig7p6WdhH/g2eKkNcSQ29rcossw9tDjUNgWuVay1RpR7A
         zt4SeslQ9bQ6RxIEQCkzxaznWGecXmisex/SKyaQINT+BKqRIXgwYDukC+GIv2pfvevk
         6u9yKgW3Q5VqLiXMf2zUkwb5PvbY0SgNINN21J0N/MNN7zpV4m5/Dpm2p70SYmHDVGi6
         2ISIVTqBOYdYTtgewJ+owGZww+N0mh0+T/2m/CP7gT52Z1ZDQST4kIWAm8WukummKxG3
         4/CQ==
X-Gm-Message-State: AGi0PuZwA7dA5LE13D6zfK9jw2S8E+HbXJpj7Jg2T2yykcrj7DTxmpfP
        6PMmupWUSb9ouRXs4pHv1aMP3gln/WOExvtLgG7J5g==
X-Google-Smtp-Source: APiQypKipAK8wadINnlUb+Uo4VCJh7LWj2FEF1/+sowHcDfqmnlaXFG2Y5WcttyQhyOio2DlQGMNfqNHgxfZn6kUa2o=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr12984953lja.250.1587496425813;
 Tue, 21 Apr 2020 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-2-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Apr 2020 12:13:34 -0700
Message-ID: <CALvZod4Rc0a1LBE7DCa0U8xA3a3N1u7g=mDjRw0cJEzvK62vmA@mail.gmail.com>
Subject: Re: [PATCH 01/18] mm: fix NUMA node file count error in replace_page_cache()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When replacing one page with another one in the cache, we have to
> decrease the file count of the old page's NUMA node and increase the
> one of the new NUMA node, otherwise the old node leaks the count and
> the new node eventually underflows its counter.
>
> Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
