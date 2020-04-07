Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC72CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC862078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKrU9yO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGAWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:22:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44346 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDGAWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:22:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16so1764919edy.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5USL9XxCiBrVUdZKeVK74BRqC2K8QZLDtTA+0ej1Qnw=;
        b=NKrU9yO+G2yn4uJkV72gp6H8+NTVUvCmVbyJpNsEillz3U9Ndq6nBe43anGRtUvCqS
         KyBH48IxgaVqs98yYgMskXZwEdsye/zYua+p91OFh/H87X1BWl4YePH5y909VzWm/WmS
         KwJpfc7LLkhLoMfzS414h7JDQSSraS7gUPOmXTej5+tWtPJ3DuiyX3hrqzU39M0FJ/DV
         nyTv1oq7unlhOLFrbUN588eNPppzNhiO/SQSdTyalT/rvZn/dwbJc6MfcwOGulLT0nnW
         CF/3ltvMFJRrOGFtxn6gkfFAizYBVFwqCY9rvduFLJ2qBOK0XES6+m3fmLJiBnNXSOfQ
         em8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5USL9XxCiBrVUdZKeVK74BRqC2K8QZLDtTA+0ej1Qnw=;
        b=qtYe7pI8b2BSTnhw/u/amcnFVHREep7zcFEmZitVKIIvDbMOWxSvIL1HDaPXoE2H8o
         +cplHfuXvuMeOXixYKV/8OSD6MeZi50moQWQICOANJTApLkDMgZBN1d+6jcFcHICgeyQ
         +Yh5OTFonRpeNDmaykxCRmLuL85CHu3Ab6pNo11AWgKW/v09gz0ucHwKqBYeL22ep3+o
         3vA6j1gK5+lqqyzUGen9ziO5nHvY4yTNKqI8/bhQcM5zU7cVXDHT2TQKQnyBE8WSK3Ol
         0vMI+6X61hA1mb7oR186LD37w1+Ii2U1o4zxYzmnWvFouBYwQjR6nMQMSEUjI8if9/0o
         zjjw==
X-Gm-Message-State: AGi0PuYw6fj9YVaDzys/YSDNWWvuoGBa96Oahj22Wx78kCQSF0aesId1
        k7Nm1Y762X4QJya92TC5PWAQp4nWzBMw6DXFhRw=
X-Google-Smtp-Source: APiQypLJE6qwQ1ILlj8KqGCVmefoeqjeFzDja3cy9IT0+CyDOa0O18rWcYcX3aFneP6PJRqlMKemCARlBN/OETAtgMk=
X-Received: by 2002:aa7:d9cb:: with SMTP id v11mr20903338eds.206.1586218960493;
 Mon, 06 Apr 2020 17:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
 <CAHbLzkqdupWUv7vPpqDpOARuYkBiTxmQxNi-zaw_TWVB1FsNjQ@mail.gmail.com> <CAAmzW4Mr7NtOpPKpskhnMABJeVoe-CvOuC6TEfJabS7HdcwLbQ@mail.gmail.com>
In-Reply-To: <CAAmzW4Mr7NtOpPKpskhnMABJeVoe-CvOuC6TEfJabS7HdcwLbQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Apr 2020 17:22:28 -0700
Message-ID: <CAHbLzkoL7zKOFtRghEfsfeKOERZmTkjfi8MynuHf4oKXD9mcvQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Joonsoo Kim <js1304@gmail.com>
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

On Sun, Apr 5, 2020 at 6:03 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 4=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 3:29, =
Yang Shi <shy828301@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Thu, Apr 2, 2020 at 10:41 PM <js1304@gmail.com> wrote:
> > >
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > Currently, some swapped-in pages are not charged to the memcg until
> > > actual access to the page happens. I checked the code and found that
> > > it could cause a problem. In this implementation, even if the memcg
> > > is enabled, one can consume a lot of memory in the system by exploiti=
ng
> > > this hole. For example, one can make all the pages swapped out and
> > > then call madvise_willneed() to load the all swapped-out pages withou=
t
> > > pressing the memcg. Although actual access requires charging, it's re=
ally
> > > big benefit to load the swapped-out pages to the memory without press=
ing
> > > the memcg.
> > >
> > > And, for workingset detection which is implemented on the following p=
atch,
> > > a memcg should be committed before the workingset detection is execut=
ed.
> > > For this purpose, the best solution, I think, is charging the page wh=
en
> > > adding to the swap cache. Charging there is not that hard. Caller of
> > > adding the page to the swap cache has enough information about the ch=
arged
> > > memcg. So, what we need to do is just passing this information to
> > > the right place.
> > >
> > > With this patch, specific memcg could be pressured more since readahe=
ad
> > > pages are also charged to it now. This would result in performance
> > > degradation to that user but it would be fair since that readahead is=
 for
> > > that user.
> >
> > If I read the code correctly, the readahead pages may be *not* charged
> > to it at all but other memcgs since mem_cgroup_try_charge() would
> > retrieve the target memcg id from the swap entry then charge to it
> > (generally it is the memcg from who the page is swapped out). So, it
> > may open a backdoor to let one memcg stress other memcgs?
>
> It looks like you talk about the call path on CONFIG_MEMCG_SWAP.
>
> The owner (task) for a anonymous page cannot be changed. It means that
> the previous owner written on the swap entry will be the next user. So,
> I think that using the target memcg id from the swap entry for readahead =
pages
> is valid way.
>
> As you concerned, if someone can control swap-readahead to readahead
> other's swap entry, one memcg could stress other memcg by using the fact =
above.
> However, as far as I know, there is no explicit way to readahead other's =
swap
> entry so no problem.

Swap cluster readahead would readahead in pages on consecutive swap
entries which may belong to different memcgs, however I just figured
out patch #8 ("mm/swap: do not readahead if the previous owner of the
swap entry isn't me") would prevent from reading ahead pages belonging
to other memcgs. This would kill the potential problem.

> Thanks.
