Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20854C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF98320738
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHr4v8ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgDUGt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDUGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:49:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F097C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:49:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t8so4093663qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5YbLsKCYzHJjqZKHmOzPYxnR4/ybuDNs41jdJOZ0kcU=;
        b=XHr4v8ubQCubJxaztTveYKxTL+o7Ta5nt4OaycGIwPfKXXI4ptAonw/22gL6+zw5zd
         KkE9TY5h8EdhoHD3KrFiL3/mf4C47QbpjtEVOZVeRt1i1EGLvsD3icnFqoq8k69j91GB
         ymvwYnbcVTe7ynIMbQL8l5p5hxX3P+5sj1PI+XfEzlZGXN2OSqFGeXUg4OOLC8Qg2Vqz
         c9o8DLefGPXOmjXqCscilG1hQafxMxxTp7zixJagkNfyDCRgTKPxy/qKzR1xI9gMjnx7
         LKaMxzyDrP4PMgK4pcUBfs0oYQf9ap9zKwlIec7Y+ZCJcq17fTnjIzSm9n+a9MEFsNbY
         1btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5YbLsKCYzHJjqZKHmOzPYxnR4/ybuDNs41jdJOZ0kcU=;
        b=YpFfRKmuCqoc/nW9F1X89E3oJOc6KWyrIa4Nwxn5SxfJO0In/aitJQ09l54tNhYygr
         HA0NLtBZNlz75FafMyEFIATqOmUl2ouZeDTTWcMO1ALxOulcD2hReA7xYFQHrtXIMZ8J
         6pCMqktNU8Vf8plhyYt2VwvgjaCJNd8rc2/3Kc7JSUp0M9qIB255t9k59qS5ZIBgXLrs
         8LWBM+syiQ/IFzHkquYR3MZ6Wu/QicQ0O6UTd5zfpMustarvSAGuXJnIBzTtMPXdyqME
         auTEqqxmR0u8W/VJf+JyLGWZF2eaNYhhTWnKN3AnkVwg5tlOGqS4UpDgeoIDD+L5uwPv
         E0wg==
X-Gm-Message-State: AGi0PuZVUe+50muQfwc1TLYX5/o+WVzkAbPMr01yqw1GCFEAz5fsCLD9
        ysqiSdmxZgNb8eTnR6hQvEV75WDYle1hIdkzudw=
X-Google-Smtp-Source: APiQypIqzLG4pTe/AdivZMhQC8Rg52W6xtI+TVlru4ziYt0FnHQtpUnN4nvGg3la4v/AC4bTEDYIBU7Wif9fu2ktKaM=
X-Received: by 2002:a05:6214:1248:: with SMTP id q8mr18877300qvv.66.1587451766306;
 Mon, 20 Apr 2020 23:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-3-git-send-email-iamjoonsoo.kim@lge.com> <412ea2bd-1719-c086-b3e7-64eec6e2bdc4@amd.com>
In-Reply-To: <412ea2bd-1719-c086-b3e7-64eec6e2bdc4@amd.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 21 Apr 2020 15:49:15 +0900
Message-ID: <CAAmzW4MkKmAcFDHartRE6UK4W2SdZ519RP2UXYxCxzrvUWTzdw@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/ttm: separate PageHighMem() and
 PageHighMemZone() use case
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 20=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:42, C=
hristian K=C3=B6nig <christian.koenig@amd.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Am 20.04.20 um 09:59 schrieb js1304@gmail.com:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Until now, PageHighMem() is used for two different cases. One is to che=
ck
> > if there is a direct mapping for this page or not. The other is to chec=
k
> > the zone of this page, that is, weather it is the highmem type zone or =
not.
> >
> > Now, we have separate functions, PageHighMem() and PageHighMemZone() fo=
r
> > each cases. Use appropriate one.
> >
> > Note that there are some rules to determine the proper macro.
> >
> > 1. If PageHighMem() is called for checking if the direct mapping exists
> > or not, use PageHighMem().
> > 2. If PageHighMem() is used to predict the previous gfp_flags for
> > this page, use PageHighMemZone(). The zone of the page is related to
> > the gfp_flags.
> > 3. If purpose of calling PageHighMem() is to count highmem page and
> > to interact with the system by using this count, use PageHighMemZone().
> > This counter is usually used to calculate the available memory for an
> > kernel allocation and pages on the highmem zone cannot be available
> > for an kernel allocation.
> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementatio=
n
> > is just copy of the previous PageHighMem() implementation and won't
> > be changed.
> >
> > I apply the rule #4 for this patch.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the TTM
> changes, but I can't judge if the general approach makes sense or not.

Thanks for review!
General approach needs to get an agreement from more developers.

Thanks.
