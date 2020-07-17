Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72059C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A620691
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0hUQI3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGQJ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:28:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1838C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:28:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so3962419qvk.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=awDCkloG136ngoAY6t6Tgi/O0WGV4S/6eBJN9T7WMEY=;
        b=l0hUQI3XV0gslNHGSq5AKN6IYRqZfhlv9Nm03N05QQ+9CagB9bvYUo6+GUdgIeKWkf
         C7qCHNY6iM+yqoIBhtBbvZzbavtMqBtD6rS0j1c1Kk1yvT1ntf2nYTTTIiCCve0lWZYl
         QaZy/pAvSUTHyT/5AYCUgzw3wY9Th+EtEoWdJb07K9nnWHLLjJPnBPNR+GZzlpvI97/U
         toPO0env+PKcWHWxDimClWn/PzwqyBuB6mRtz0U2nkQqFExkSrxGRTooBRjRQnNUbTwp
         b+7INOcRYwdRyt3SRXi4MW82W4CTr7dgjekTASZ4LRliHiQkwkl9dtBXhnMBytzM50AF
         kSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=awDCkloG136ngoAY6t6Tgi/O0WGV4S/6eBJN9T7WMEY=;
        b=jJsdquCsmDtbz7B8oFUj82RsmAMC3cdcdob39bUaRxscmt6uJAthagnPkheg59xYvi
         Y26WnC30eWQZ5x4hZHYh7w085rCsFWCnE5jm6+/1WBtptllyRjAv9OAe3LKG4CUDiM3J
         s3sD3aUr50uyKaQUYcPHOohS1rdlcRP2MdzX/gY0OuO5IMDiQ01UqZtK1KIsXlOW7Xoi
         E/0uL42+ZCV+lXbMNAXM5l7KawvBYEaA/m7Ute+RHWru14bOB5LBatH8SMCyMO0mbnT1
         ydaCF00O3RKGHJvTHM6Gj9PK5RQk5SReAqcts37596dbTCFxiqcxoyxvVJMzuOoWW+5h
         PwHw==
X-Gm-Message-State: AOAM530XMXMq3I1WZwHMtNSSnDSE42X7Obc5F6KTqdxu1vAc3WIeUpLq
        9jmUXX5P+7nNP26qGoWcYFTTSjI1MjFkISr4N57EDOtA
X-Google-Smtp-Source: ABdhPJzW1Wi2+rlgq8/ZJIdhcEGp++KysgPh+vgxSR17+0KfgljD8vSzD3618McEr63Wkpqk5XipvRvSqPLfQHNMyrI=
X-Received: by 2002:a0c:a306:: with SMTP id u6mr8198298qvu.88.1594978107071;
 Fri, 17 Jul 2020 02:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com> <20200715082401.GC5451@dhcp22.suse.cz>
 <CAAmzW4P+KXn2e1pU+_+Y6NqDt1-081hCyKNsqbiwfF=FADLzxQ@mail.gmail.com> <20200717082643.GC10655@dhcp22.suse.cz>
In-Reply-To: <20200717082643.GC10655@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 17 Jul 2020 18:28:16 +0900
Message-ID: <CAAmzW4N6mQ_9jrUN5NUURpxa7tf4nKwsrgiWe79v0vNJO0_6Xg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/gup: restrict CMA region by using allocation scope API
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 17=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:26, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri 17-07-20 16:46:38, Joonsoo Kim wrote:
> > 2020=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:2=
4, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Wed 15-07-20 14:05:27, Joonsoo Kim wrote:
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >
> > > > We have well defined scope API to exclude CMA region.
> > > > Use it rather than manipulating gfp_mask manually. With this change=
,
> > > > we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is a=
lso
> > > > searched by page allocator. For hugetlb, gfp_mask is redefined sinc=
e
> > > > it has a regular allocation mask filter for migration target.
> > > >
> > > > Note that this can be considered as a fix for the commit 9a4e9f3b2d=
73
> > > > ("mm: update get_user_pages_longterm to migrate pages allocated fro=
m
> > > > CMA region"). However, "Fixes" tag isn't added here since it is jus=
t
> > > > suboptimal but it doesn't cause any problem.
> > >
> > > But it is breaking the contract that the longterm pins never end up i=
n a
> > > cma managed memory. So I think Fixes tag is really due. I am not sure
> > > about stable backport. If the patch was the trivial move of
> >
> > Previous implementation is correct since longterm pins never end up in =
a CMA
> > managed memory with that implementation. It's just a different and subo=
ptimal
> > implementation to exclude the CMA area. This is why I don't add the "Fi=
xes"A
> > tag on the patch.
>
> But the current implementation calls memalloc_nocma_restore too early so
> __gu_longterm_locked will migrate pages possibly to CMA ranges as there
> is no GFP_MOVABLE restriction in place. Or am I missing something?

IIUC, calling memalloc_nocma_restore() too early doesn't cause the
actual problem.

Final check is done by check_and_migrate_cma_pages() which is outside of
scope API. If we find a CMA page in between the gup range here, the page is
migrated to the migration target page and this target page is allocated by
new_non_cma_page().

new_non_cma_page() try to allocate the page without __GFP_MOVABLE so
returned page will not be CMA area memory. Therefore, even if
memalloc_nocma_restore() is called early, there is no actual problem.

Thanks.
