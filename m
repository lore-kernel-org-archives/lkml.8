Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184FFC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDF320721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNzLwVTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEDDBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDDBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:01:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC4C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:01:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b188so15259239qkd.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MXVjQh5qk+wFh49Mgj14doNyR4R5wftox/4Vl8s1gFw=;
        b=qNzLwVTAmfJuM0LtKBfIRAMIoNI7egURDU3XJZ7SKia7RZNNJVOrblZxkhkVQeHpId
         eSX9gk5nnFFtLZiR2mvXXJKUwpVhb1ECDLLNY39O50nvbLTC3Dpby7aUPzTBxGAP9+k+
         5H5v7sJpaQB19u/DquGNBlecLyKbrimNOpwufmI/RbsojGS/+Hxlg/qvy1nsqxCVxT3U
         DcUspYfwK9lnYNrol2xBILPzRsYktcTfOjTmxtmuf7IuudT2CRI/85HCSQMo1hQrlIpi
         xPDzl11tciarFfVZn36XKcXKCQUPFI8TgHA8C5uHz91mJVzD92VqRA/HzufnMYjvTNR+
         BVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MXVjQh5qk+wFh49Mgj14doNyR4R5wftox/4Vl8s1gFw=;
        b=ZhjO6oBrCmxelgaWTuO3t3pEbsU5eBEHOtluFSxV68ChdULW/lab/H2QOUSXTdGtY7
         /EUHYtOl3+dNtam9cgYfFvXk5HcJ6tzlaXspmy7uXgfLD+Szb3qNZaK4xFlWanJo8nFJ
         RfSy8Ft+ZY6v7giwBN+XV3bPoWIIX/sa064A2LslZnUaGH1HqLuGfs28ShSMk+VVU0en
         m8GdFh96J7nlJknd98ogA5Gi6hlstMENeKXndgcHu4ZQz64JWnCtzqbU42uTyzdkjaJ6
         4pzmicSRz8Pi4JmSvfFmj1YP86M3/Qu09T8KXgzfN4tOCVtJckDJupYBO1DY0G2muEOk
         k8fA==
X-Gm-Message-State: AGi0PuZpwv7v1Zsfwf6hX1LnZCeT/CroN/vpQZ/kVh4kPBCZ8u5LEZvz
        +6bz25/brKXh6lZ3NeiTcyQmfcGpuIAaxlL8A4s=
X-Google-Smtp-Source: APiQypLLCaX7+49SOXDRdiJBsEahZHc+Et54qpBgZyXkrMGUk3MglIghTnEgh2XZryXonsLTw6V6mTK8BnNyxsneNtM=
X-Received: by 2002:a05:620a:15c1:: with SMTP id o1mr13727225qkm.187.1588561303457;
 Sun, 03 May 2020 20:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-5-git-send-email-iamjoonsoo.kim@lge.com> <20200501122245.GA21897@infradead.org>
In-Reply-To: <20200501122245.GA21897@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:01:32 +0900
Message-ID: <CAAmzW4MzXNcEKMT2d3d9od9DGiyubYgwGw70yiGbk=hVMrzyLg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] power: separate PageHighMem() and
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
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:22, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Apr 29, 2020 at 12:26:37PM +0900, js1304@gmail.com wrote:
> > index 6598001..be759a6 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -1227,7 +1227,7 @@ static struct page *saveable_highmem_page(struct =
zone *zone, unsigned long pfn)
> >       if (!page || page_zone(page) !=3D zone)
> >               return NULL;
> >
> > -     BUG_ON(!PageHighMem(page));
> > +     BUG_ON(!PageHighMemZone(page));
>
> The above check already checks for the highmem zone.  So if we want
> to keep the BUG_ON it needs stay PageHighMem to make sense.  That being
> said I'd rather remove it entirel=E1=BA=8F.

Okay.

> > -     BUG_ON(PageHighMem(page));
> > +     BUG_ON(PageHighMemZone(page));
>
> Same here.

Okay.

Thanks.
