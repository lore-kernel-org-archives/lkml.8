Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F19C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B720663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9VAvmlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCXG2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:28:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40153 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXG2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:28:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id c9so7118092qtw.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UeR+WctkiQFjyudT58ukpFLDVLpreIAvF+0Uils+20U=;
        b=f9VAvmlq/OnYPz8TdXl8tGTtShIl3d4rinP15u1VrlUSmUaaOVVs2YhocxdpOrf/8C
         QhLKXiAJSrwJfZuppp2XDyMR5W3u0jKrM6kyT0af3Y+2vH6eV2j5K5Fmp3mElRmHPcR5
         XeIZbUzDOycVk1fumI+fnQ0Rvy1MML/808QzQdMZikscRt3F5nHJPhRcNmVUJAD7L/Ml
         ELw4DmQHl6EuSJ4ap4HFhlhO57nDlUFlkc7n+Kofy5Ju2sd50ijHeZgQpYfxBdHT3A2R
         NTJA/7XIKo3YyWK77imovp1xPv5POMJr4lQZYBDUmYoIqEHX10AZXcewU05fw7e5o9q6
         IeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UeR+WctkiQFjyudT58ukpFLDVLpreIAvF+0Uils+20U=;
        b=ZQJwvXfkZK0gTM7TbugNkNKhbmabpe12iy0W6qF10dCmccl08g56L0btpZjbgoy7sn
         J4+Tf1aL9jO7SsUWNGSKIP4bLK6UZVca3YUOO4/ry6Htz+97YNoUctC8lf6EoKaChzWX
         VhUi32344ooO11yOjWkQyenPa+A837um4zpC4Cl4d0o+GvpVV4ZmsZuMBLvCc2sAuVuZ
         lPyLHSz45O16rVkf2Fri0XHMKxZCt3bL6d1ivDsobz+P51yEahisQP+hctuQyIy7H95O
         XUD5uvTrkka80xfQQYGYnsfNtGttDXAIN9rThtGtYF5yvM59h/l5Y9MTv6qI5B2SVjKL
         Nfmw==
X-Gm-Message-State: ANhLgQ26GAZmfz/t1OUOt3oq8+lPoNyXFDL0RPxGZ9jGAJdpna/eSBZG
        smoJntP53FaxRgszBlxntWC4ogIvZ8ojB2r3qxA=
X-Google-Smtp-Source: ADFU+vs0c/6r9rUWsVmVu8Uq/NXxjewHjvbCESmshY1cW5DQswDnY3jgZwOm8Wsg0dI+KC6zSYPSRMS0hGd4qZDgnmA=
X-Received: by 2002:aed:34e6:: with SMTP id x93mr24599704qtd.194.1585031326961;
 Mon, 23 Mar 2020 23:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-9-git-send-email-iamjoonsoo.kim@lge.com> <20200323174257.GF204561@cmpxchg.org>
In-Reply-To: <20200323174257.GF204561@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 24 Mar 2020 15:28:36 +0900
Message-ID: <CAAmzW4Mts-EbsYGWbdJyAR01dsoVNR4OYbRDCxfp_eD_p4fD0w@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm/swap: count a new anonymous page as a
 reclaim_state's rotate
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

2020=EB=85=84 3=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 2:43, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Mar 23, 2020 at 02:52:12PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > reclaim_stat's rotate is used for controlling the ratio of scanning pag=
e
> > between file and anonymous LRU. All new anonymous pages are counted
> > for rotate before the patch, protecting anonymous pages on active LRU, =
and,
> > it makes that reclaim on anonymous LRU is less happened than file LRU.
> >
> > Now, situation is changed. all new anonymous pages are not added
> > to the active LRU so rotate would be far less than before. It will caus=
e
> > that reclaim on anonymous LRU happens more and it would result in bad
> > effect on some system that is optimized for previous setting.
> >
> > Therefore, this patch counts a new anonymous page as a reclaim_state's
> > rotate. Although it is non-logical to add this count to
> > the reclaim_state's rotate in current algorithm, reducing the regressio=
n
> > would be more important.
> >
> > I found this regression on kernel-build test and it is roughly 2~5%
> > performance degradation. With this workaround, performance is completel=
y
> > restored.
> >
> > v2: fix a bug that reuses the rotate value for previous page
>
> I agree with the rationale, but the magic bit in the page->lru list
> pointers seems pretty ugly.

Yes, pretty ugly.

> I wrote a patch a few years ago that split lru_add_pvecs into an add
> and a putback component. This was to avoid unintentional balancing
> effects of LRU isolations, but I think you can benefit from that
> cleanup here as well. Would you mind taking a look at it and maybe
> take it up into your series?
>
> https://lore.kernel.org/patchwork/patch/685708/

Thanks for pointing that.
I will remove the magic bit and imitate your patch to solve the problem
of this patch.

Thanks.
