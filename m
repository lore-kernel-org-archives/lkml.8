Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D50C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3C12068E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8D+I33r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDFBDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:03:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34858 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgDFBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:03:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id k134so4066606qke.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4gvRC3/e1k9R9I9Q2d6O+PKvsuPb+opEx00+0iSIi9Y=;
        b=l8D+I33rbsmZHIbQlKZhIfE5pX+0DAUH6dnSi4pQqxR7xj8G8WJe1t3A6VDA/bw++v
         vDM5BCXweQ+xBMRBSEUNswawHNqAjIGzNki9P/Ova8bepwFR66HrO8n04zgbF7+qelF4
         cxlWFUhKwgdUrXjrHxYhDX0lXtBNUUslY0t9k16wDhGMiALVvUDbJ9clsGAHG9e1bQi5
         oaaKvkpIqZAU/7zCQlDUo35Ea7VGe+zx/9KzQPWs7RnwIHyGUggKRAxAMNH+8VRZHJUi
         mPEIEg4iU4rDokjm3XCBOR9nfZntv1iljG2LSzIfDujhlcUKVJRI+36VyRqAJlb4SE0A
         8rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4gvRC3/e1k9R9I9Q2d6O+PKvsuPb+opEx00+0iSIi9Y=;
        b=UFOzq7tqjabn1QtJ+x+2MBPgNIaMDzeXMiVmtYHxmnsenlGJmX85mm4pLHyyXxrW+q
         lc4wvVpVFgOCAfJzpQReUGoIPxsZxnZiK2AnqQZnvy8CHZbPcBhnUqP6UThR/py7iUip
         hxWo+lJwwr9IK5lxos3HrwPmRIjuXqJ4K+13vIID1zCn6rp/Z0DaG/2UAEzWxvvo9cjc
         NfMXBiMHL5wfgbKdEe2NBtxkjKhA4sxj264dQ/0fVLrBb+k9aESeGFEUfDWzQys030sD
         enRIUKjExLwtIqkvs8j4UPjYVC4Zf2uu/F9p7r2FEfQa2XqgNIcloeeytnsRhNVvSV8W
         qddg==
X-Gm-Message-State: AGi0PuYRBBy/njpqmtOzXbEQ7W5p6Mtu1pgmqQ7tlbY79i8wj0YvPdtK
        OapUeff8jm8c7HcytNUL2EUmYxUkXlMdx8EjcQA=
X-Google-Smtp-Source: APiQypLlK7cOIEA7v1yCMBunQ4R1g/gH99w9sYxIDhvDxnMHR6kliVqSmFS/FAzD7e2CnqD3BESzApHvfqfFlx95dUI=
X-Received: by 2002:a37:af86:: with SMTP id y128mr19768852qke.429.1586135022424;
 Sun, 05 Apr 2020 18:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com> <CAHbLzkqdupWUv7vPpqDpOARuYkBiTxmQxNi-zaw_TWVB1FsNjQ@mail.gmail.com>
In-Reply-To: <CAHbLzkqdupWUv7vPpqDpOARuYkBiTxmQxNi-zaw_TWVB1FsNjQ@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 6 Apr 2020 10:03:31 +0900
Message-ID: <CAAmzW4Mr7NtOpPKpskhnMABJeVoe-CvOuC6TEfJabS7HdcwLbQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 3:29, Ya=
ng Shi <shy828301@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Apr 2, 2020 at 10:41 PM <js1304@gmail.com> wrote:
> >
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Currently, some swapped-in pages are not charged to the memcg until
> > actual access to the page happens. I checked the code and found that
> > it could cause a problem. In this implementation, even if the memcg
> > is enabled, one can consume a lot of memory in the system by exploiting
> > this hole. For example, one can make all the pages swapped out and
> > then call madvise_willneed() to load the all swapped-out pages without
> > pressing the memcg. Although actual access requires charging, it's real=
ly
> > big benefit to load the swapped-out pages to the memory without pressin=
g
> > the memcg.
> >
> > And, for workingset detection which is implemented on the following pat=
ch,
> > a memcg should be committed before the workingset detection is executed=
.
> > For this purpose, the best solution, I think, is charging the page when
> > adding to the swap cache. Charging there is not that hard. Caller of
> > adding the page to the swap cache has enough information about the char=
ged
> > memcg. So, what we need to do is just passing this information to
> > the right place.
> >
> > With this patch, specific memcg could be pressured more since readahead
> > pages are also charged to it now. This would result in performance
> > degradation to that user but it would be fair since that readahead is f=
or
> > that user.
>
> If I read the code correctly, the readahead pages may be *not* charged
> to it at all but other memcgs since mem_cgroup_try_charge() would
> retrieve the target memcg id from the swap entry then charge to it
> (generally it is the memcg from who the page is swapped out). So, it
> may open a backdoor to let one memcg stress other memcgs?

It looks like you talk about the call path on CONFIG_MEMCG_SWAP.

The owner (task) for a anonymous page cannot be changed. It means that
the previous owner written on the swap entry will be the next user. So,
I think that using the target memcg id from the swap entry for readahead pa=
ges
is valid way.

As you concerned, if someone can control swap-readahead to readahead
other's swap entry, one memcg could stress other memcg by using the fact ab=
ove.
However, as far as I know, there is no explicit way to readahead other's sw=
ap
entry so no problem.

Thanks.
