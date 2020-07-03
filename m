Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3292C20836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoxGm/zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGCAwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGCAwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:52:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:52:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h23so22840833qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2QjpuD8irRgYumHEsXOFIqJW2+c7RYNi2m5T0paIeNs=;
        b=FoxGm/zHo2+JNltL2Hvy/PJXCF+wfAjZFei9JsAY/dMM2BAyPOTGUneJkLAJ4QFoop
         nzdBxbqZvzcUSlqj5AA3X9uEkejQ9Ycf+o0RhI+RgOcEmTx34jB1C03ZPA7DcNdP1KMh
         SZqVV72POrDLBkoUrNqmV7oXBXW2iSm8u1R612OjP6Wq7FQby3dFQP+zMo/1PUyKNrmw
         M4l9uPdiqD2/NFxx/Ba6cP+oM4vw+GJ6ZmNQiPCM470WdsB5vFwZssbXG7lZ9Ygw3Fa9
         Xq7gOQrf8RBoaehg5TECo+qTC/rWkP6pc6chfXuwzVFTcevrTKXTTWBnc6QpNXcFg/6C
         sugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2QjpuD8irRgYumHEsXOFIqJW2+c7RYNi2m5T0paIeNs=;
        b=LQwCPGdy/Ono5HNQsbwnUPyftlY6i9P5vctSwhUXfRgwIOB6502J+5DMFYNx/nm1Qb
         nyagAxkctH64LAJBI62P1snOqJ69+H12vJcBj9wrzuiV7qy7cXD1pHCCROkuEHz58Y6l
         gsdj89AmwmnRIU1oQrGw5V2xuyRUmwrwtzXuf7kLnWVDqUEI0oW8uUseXs8mfby7GjNc
         8swqNW8ivj4TT9EH7Rwsxg5dS75+jZV+U1uf7b/WYP9TY8l22tTbmpl5C0fnX/e2Z3+h
         D470h7TnqIvliuJeerwwrFChrn6gy5qY1SCtN7xVwu1Mfe6SEUwXB+SYthex2LH/OYxC
         VDwQ==
X-Gm-Message-State: AOAM530+tg8eWNPKsZdbOYPILZFlD9qfmZq1XnI2i7vNLZkLRhPkQwJG
        1o5bsW5PSB5L6OXNGzs5UVucGyw/11aZ/R590R4=
X-Google-Smtp-Source: ABdhPJznFzvjCeTZAs0VaMhy7b8Q5G5e2yuwANqBrtjByEe0AtLUSp6xF5bTE3Md2UYnK8r6eVLNpWC5gWLkEScSArI=
X-Received: by 2002:ac8:4d0c:: with SMTP id w12mr9456003qtv.194.1593737527417;
 Thu, 02 Jul 2020 17:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com> <47989e98-ecd2-3ea8-871c-88583e55a4dc@suse.cz>
In-Reply-To: <47989e98-ecd2-3ea8-871c-88583e55a4dc@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Jul 2020 09:51:56 +0900
Message-ID: <CAAmzW4OxEhb0WgXwr2aVsZcC=w+X9yS9Kx8URO4mnbFMbkv_6g@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] mm/swap: implement workingset detection for
 anonymous LRU
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:37, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > This patch implements workingset detection for anonymous LRU.
> > All the infrastructure is implemented by the previous patches so this p=
atch
> > just activates the workingset detection by installing/retrieving
> > the shadow entry.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 8395e60..3769ae6 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -353,8 +353,9 @@ void workingset_refault(struct page *page, void *sh=
adow)
> >       /*
> >        * Compare the distance to the existing workingset size. We
> >        * don't activate pages that couldn't stay resident even if
> > -      * all the memory was available to the page cache. Whether
> > -      * cache can compete with anon or not depends on having swap.
> > +      * all the memory was available to the workingset. Whether
> > +      * workingset competetion need to consider anon or not depends
>
>                       competition needs

Will fix it.

Thanks.
