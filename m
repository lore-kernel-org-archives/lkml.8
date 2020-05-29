Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E146C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73335208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0jsynJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgE2Gup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgE2Guo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:50:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530DC03E969
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:50:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q8so1268894qkm.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qRkkDEMBa8+Sw1PQF85wu1nOLeFHhIPcQ18vc9mOo9I=;
        b=V0jsynJr91xXD3ECziMlTvwwY3BIzgFRTP48yQLtFSySSTn9Y5w10c7lTVq/3wBak7
         7dMlGLXQ4Jq7vq3+hqKy0xLxKaA8NRHzbkaKwvSrQ9wTEF/lgHsFw1QGrmJ+8mbJFrAS
         KvQVFZGrYQ1/MFx1T4ctxLoDv+qEQOurqvxj3qaQVDekQfLfp++idJ400vfGs6SbWPe6
         TAkatuLCQ1TfynB6eGOWQs5HLY2mIj70JdApYXViVZslGQUyLoN97dIUW35lJK1uKWvT
         lLxutF829bHLmgEhZ4KZbSMkhyz1+PMz3zwUn6x6c04i/O+JM/UUxHul1nfz0z2pQrXN
         rWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qRkkDEMBa8+Sw1PQF85wu1nOLeFHhIPcQ18vc9mOo9I=;
        b=mMQr6k00wIam9RAAjejYA5wZY8PNzxjrCoWI+Le4RgLFfHiRR2alJyMC3tPlWuHF0S
         eczDFkCwQhMvh1qxXlsnMWXcw226WkM9DM6M+CQu+WDbx9wmkpWetkdETSDzcuktlwH6
         ijLCVjASD/wR5W2aqNs5YSwxEfoH6xqSuWbqZZ7G5BSJ2ZIjSivGXQT/jGcRoM8OkmVQ
         rUi+xqKNRl3MFsvgqw/EbNMdgmqI9ECcKax1O/rn22ta+7LyHHBDueaPUrmbVNV2YYff
         fL95WpSLQRnp/dLlcPgWJHhCScLoJW7JN9jVyeuosU+lpHp2ylTImLpCwKJewf+BLNu5
         M3bw==
X-Gm-Message-State: AOAM533OuljNVU+674Fg2HvOBhRRGDsS+5I0mu7zIvGWYFcrP9Xa6kIl
        Z+vGPaYr4K2K0hyTV+DtjHE20osmcwrUrd5zUBA=
X-Google-Smtp-Source: ABdhPJzPqcVGzu201fZFnPLWkfprZQBErzcQSvNNlVp5TtnFbh0zFNrA7C3UrybY84bym68Wh4QxRMI+1zu1SDYt5IU=
X-Received: by 2002:a05:620a:164c:: with SMTP id c12mr5919292qko.343.1590735043874;
 Thu, 28 May 2020 23:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com> <45a8ee8b-ec3a-df0f-fe23-6f64097cd263@suse.cz>
In-Reply-To: <45a8ee8b-ec3a-df0f-fe23-6f64097cd263@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 29 May 2020 15:50:33 +0900
Message-ID: <CAAmzW4OY9gOPcWsUwQ+O3vfFJvrWvNFnuy4O5FbPYwnWfF1wEw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] clean-up the migration target allocation functions
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:25, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 5/27/20 8:44 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > This patchset clean-up the migration target allocation functions.
> >
> > * Changes on v2
> > - add acked-by tags
> > - fix missing compound_head() call for the patch #3
> > - remove thisnode field on alloc_control and use __GFP_THISNODE directl=
y
> > - fix missing __gfp_mask setup for the patch
> > "mm/hugetlb: do not modify user provided gfp_mask"
> >
> > * Cover-letter
> >
> > Contributions of this patchset are:
> > 1. unify two hugetlb alloc functions. As a result, one is remained.
> > 2. make one external hugetlb alloc function to internal one.
> > 3. unify three functions for migration target allocation.
> >
> > The patchset is based on next-20200526.
> > The patchset is available on:
>
> I went through the series and I'd like to make some high-level suggestion=
s
> first, that should hopefully simplify the code a bit more and reduce chur=
n:

Thanks for review!
I have not enough time today to check your suggestions.
I will check on next week and then reply again.

Thanks.

> - in the series, alloc_huge_page_nodemask() becomes the only caller of
> alloc_migrate_huge_page(). So you can inline the code there, and it's one=
 less
> function out of many with similar name :)
>
> - after that, alloc_huge_page_nodemask(ac) uses ac mostly just to extract
> individual fields, and only pass it as a whole to dequeue_huge_page_nodem=
ask().
> The only other caller of dequeue...() is dequeue_huge_page_vma() who has =
to
> construct ac from scratch. It might be probably simpler not to introduce =
struct
> alloc_control into hugetlb code at all, and only keep it for
> alloc_migrate_target(), at which point it can have a more specific name a=
s
> discussed and there's less churn
>
> - I'd suggest not change signature of migrate_pages(), free_page_t and
> new_page_t, keeping the opaque private field is fine as not all callbacks=
 use
> struct alloc_context pointer, and then e.g. compaction_alloc has to use t=
he
> private field etc. alloc_migration_target() can simply cast the private t=
o
> struct alloc_control *ac as the first thing
