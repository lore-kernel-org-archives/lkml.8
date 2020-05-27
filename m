Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A53AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED320787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txx+avA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgE0GpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0GpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01431C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x29so5165847qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaLeQoi5DBWLuEVOcYdoFWBz25hF1g/z6p4tBOV7AU0=;
        b=txx+avA263khYurC1QtUhLXRBgqWxtEsC1Dl81kRn4bWuq926OBSAmSb5cNaAYjTxR
         jlZm9b8NmKNM2kzmWMHuLcRtaQe1ZbIRkj1I49s7KkjcCMBu/oiKDKKh9tjjjGX6Ir2q
         VAej7lXbr4I+fH0+fbauGpE3L/8gmXeTFF0JlNqKX1mYdiuR7m54pRKL4APul6PAwz9g
         Lib5qdMjdd04BGynjCkS+YvFpwFilbSYpydi2J5rohuQas1j1GX5ULZriJcJtV8qEbhS
         AQOlpf883Jmx4LbNx4DqZtj9nQewCxUzuG+e/B5y92DbXSFoWtXn27m05qFZzZ7Dm6mZ
         rI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaLeQoi5DBWLuEVOcYdoFWBz25hF1g/z6p4tBOV7AU0=;
        b=J1VaZQGJJi6S06PrhsS/qwWMlQG/xNKkTsGrTtKaPR167GkjKp0vArzgFWHSWX2OtY
         9Hx8vZHhTrANzXlDHF1ppDLYfH6UBOI3SdGa2nl74kVOhCzHAEAC1wXDPMrzvyMP9HFf
         5xbWD0cy14wLtdJTWtEyPP+dMfmH37x5v/uO7Lxrb72AhyJf0hz+73eReXJehCVqw3mV
         oa4lnYfPJnhgLjZdVW6lYEovkHX8+sPnLcSu9UCkjqT39hbtmBRigvJPh0LgeVTNOvaf
         snkdrpA5/5yRiuIcooU9niJes68iYpKSqORdhG0qBwN+DdIxAxVg+kNT1pEtX5gpB5mc
         PoCw==
X-Gm-Message-State: AOAM532J6s7N7XhXPv81UvCcpCc4+n02SuF7mBfs4Yt48UBYXtA76DM4
        H2Y1QfxvxYNMpV5ihitUHMho6lskce8p+B3gYU0=
X-Google-Smtp-Source: ABdhPJxcAOsdSaDgBBTBw58LUgy2dj68oIaoi7NEt2lX2itCWXLiWCPX24n98PFA7U1Llghnkkqf5DWAZrYXo5iY2UM=
X-Received: by 2002:aed:39a2:: with SMTP id m31mr2493881qte.333.1590561909048;
 Tue, 26 May 2020 23:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-2-git-send-email-iamjoonsoo.kim@lge.com> <20200521003716.GA317575@carbon.dhcp.thefacebook.com>
 <CAAmzW4ND=AfXavSbraeWH2Pr-AQ=fTAiJFTBt66MrshMNEWuhA@mail.gmail.com>
In-Reply-To: <CAAmzW4ND=AfXavSbraeWH2Pr-AQ=fTAiJFTBt66MrshMNEWuhA@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 27 May 2020 15:45:03 +0900
Message-ID: <CAAmzW4NPvAmJfX0UH5RqFM=kSoV3aw3VOM8c9V-z_y3Qe5ijnQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] mm/page_isolation: prefer the node of the source page
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  mm/page_isolation.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > > index 2c11a38..7df89bd 100644
> > > --- a/mm/page_isolation.c
> > > +++ b/mm/page_isolation.c
> > > @@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
> > >
> > >  struct page *alloc_migrate_target(struct page *page, unsigned long private)
> > >  {
> > > -     return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
> > > +     int nid = page_to_nid(page);
> > > +
> > > +     return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
> >
> > Why not new_page_nodemask(page, page_to_nid(page), &node_states[N_MEMORY]) ?
> > Still fits into 80 characters.
>
> It's just my preference not directly using function call in argument
> as much as possible.
> If you don't like it, I will change it as you suggested. However,
> since alloc_migrate_target()
> will be removed in following patch, there will be no difference in the end.

Oops... I found that your suggestion exceed 80 character.
I will leave the patch as it is.

Thanks.
