Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD12C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E92070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkSfCfrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDVHzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:55:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B8C03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:55:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v10so424035qvr.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xHJTiCZuYPHQ76leKfZ3xJ/74uh6M+nUkAErV8qQlvs=;
        b=hkSfCfrbbAm+HLe+KrV3RnSh5abeV84ZxoVl1yBMh4PJWTsG6DPJ71QVKL9JnIizob
         UlWuIriCsDXjOcyzBeWrjzDKgK1TD87LvDqAUih8jmOnGdkOK6wX+D1ZJOvVdXcAbmWv
         1rr2qAB99SaM72ln8DVQI7B1G//UcBaebKO5JWsWryhmU7WXIm4GDPs5rnh5oNKDRdTH
         c0vLrwcafB3oUhhyBPCF3d4YnqADvl7fxEFw97+EwoN5zRrDxHy3l6oR5m8snGjkqc22
         O9EDoKCESqQPsJjlKuroJngWV2rzL6YZg1+QHtbhSqF3Ov/SKRKU6vAMQ9QIDYmqceFm
         XcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xHJTiCZuYPHQ76leKfZ3xJ/74uh6M+nUkAErV8qQlvs=;
        b=tqkA+wyv9Jr5H9Qep8riMltBRFgXlQ6ImEETWkMdr0+CeRJuzI4IuqBz5A8FwQ4/fw
         FLL706DPYiF4D2ZgiQAZdLMFmMcAo6ck2BPhfYrkuSMk+/0J37iRwh5F3Wrtnd7bnGMo
         0L5qDfEBMcVLlTQDPx9UHKrkoswMLftAocexdJwZMXI4iPMisfgg5j6rKM34680oxudj
         GPrpFPvL9euFHmUGyfIPYfwdHJu2jRL7GcBLFMxSxTBwyvn02RtipDZ5v1dVVnTncB7Y
         5xKQzGdVwOx1pyKUoo8aquQSstJDMtXOtPA9N4gEN6DfP0cKh524pljNV8mHwWJeNN+8
         d9Xw==
X-Gm-Message-State: AGi0PubS684ruoaPyhuGbkyp4z7LFDjcGpUtQ4AvQe50E3JfGF6FzZLm
        yUYB4riZAPiBQjPysKKuu+umb50QZpCAWkcVJtA=
X-Google-Smtp-Source: APiQypKE3uqNyzRviE2W0tPIBqg/0GXqy4kx8ZZl/teh095sCD9n/vA1kn9Jl8aI22VF+9NjuQOhGgAHTgJEjrjyIB8=
X-Received: by 2002:a05:6214:7e1:: with SMTP id bp1mr23425411qvb.208.1587542130191;
 Wed, 22 Apr 2020 00:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-4-git-send-email-iamjoonsoo.kim@lge.com> <20200422074423.GA12288@infradead.org>
In-Reply-To: <20200422074423.GA12288@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 22 Apr 2020 16:55:19 +0900
Message-ID: <CAAmzW4MOzTU2BLffuVm_CHbWs3SJTcCdhEGQyfR3FsCgoiG1Dw@mail.gmail.com>
Subject: Re: [PATCH 03/10] mm/migrate: separate PageHighMem() and
 PageHighMemZone() use case
To:     Christoph Hellwig <hch@infradead.org>
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
        Christian Koenig <christian.koenig@amd.com>,
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

2020=EB=85=84 4=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 4:44, C=
hristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Apr 20, 2020 at 04:59:35PM +0900, js1304@gmail.com wrote:
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
> > I apply the rule #2 for this patch.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  include/linux/migrate.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 3e546cb..9a57766 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -47,7 +47,7 @@ static inline struct page *new_page_nodemask(struct p=
age *page,
> >               order =3D HPAGE_PMD_ORDER;
> >       }
> >
> > -     if (PageHighMem(page) || (zone_idx(page_zone(page)) =3D=3D ZONE_M=
OVABLE))
> > +     if (PageHighMemZone(page) || zone_idx(page_zone(page)) =3D=3D ZON=
E_MOVABLE)
> >               gfp_mask |=3D __GFP_HIGHMEM;
>
> I think this would be much cleaner if you open coded PageHighMemZone
> here.
>
> E.g.
>
>         int zone =3D page_zone(page);
>
>         if (is_highmem_idx(zone) || zone_idx(zone) =3D=3D ZONE_MOVABLE)

Okay. I will use open code here to make two condition checks similar form.

Thanks.
