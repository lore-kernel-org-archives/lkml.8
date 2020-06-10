Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F61C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900B12074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2BZcbxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgFJDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFJDI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:08:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A84C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:08:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 205so771688qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nxc1gVJf3J9VlsDFgF/n6DV/Fj0KBzAAvL6U4OgcS0A=;
        b=a2BZcbxG/VyEJHOxKSR2WaBQGDhAIPhdPiTMdVM7i9U66JOWNf4rEL7zc+C+e/03cr
         BpnhoyGEPqDaBFafy2Y2/18hK/lhumjDl5aLrEFs4N3qt8ZMFqQG50UvETtQqbm/3MzR
         GIsRgG/CiOJYPkYX2fGVKOXFJYgAvijcYUIPAtNS8wu4X567/0+WpPg3eIHM2h3VDeM+
         gZ06IYW4RE9bNCTf8b73TvbXOFOAvqvXfBqZ4xl7lxug0SqwXeKu16ufS+a4bG+2RyDD
         NZcyecGsFa2AA/lKhA4CaFKkkOeYiD9DBiFkph/qq/VJz9gEyoeyFuR/uCTdh4jM/6PR
         SIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nxc1gVJf3J9VlsDFgF/n6DV/Fj0KBzAAvL6U4OgcS0A=;
        b=nlZxPnNQM/Hr13cZUiQLOgYlZiTMx5JKEbMIJwwUixhfsvFxafWqQVREB/+1P2Apa+
         ALo6lPmJr98VKsasSg8rVoddiSA0iW/Pf3H3AU83of2pON0FitwqA+cWVTO44KSK5Ybn
         RpHZTiWrPgTDujD48ZPm0/vvKJuOP92ISBtQ+UQsUQrPpjaZ8Rz2A0SUeo+WF6FTvHp7
         t+Dl+Qr6yMSg9/HWNDiFXAWukAroHdDw5pxRsAJUtct1msg5yAs9ulGCHyG/kSvFVXMD
         tnsxYQtXqIRnMBqcypsPOhOAZcuqzVjQBthpCljISzZl6QaB5JGxebgEi19Of/A5Q0ch
         P47Q==
X-Gm-Message-State: AOAM532uVthUMA5/ms1IkuVffaM42TpBGOTfy0k7F3vEpYbgCECYTifp
        ah4T/YiaLWIJ8Z8FRbQ6mhnXDESJqmGbbJfpQ5c=
X-Google-Smtp-Source: ABdhPJzTddH41yWKgFtiMurzaACGltf3sAfRYgLL+lYRQIRaSRYdJ5BlYQR6Vz0bduM/uB6/Sv18iMGl576h+BwgSsc=
X-Received: by 2002:a05:620a:a4a:: with SMTP id j10mr1011155qka.272.1591758534422;
 Tue, 09 Jun 2020 20:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-5-git-send-email-iamjoonsoo.kim@lge.com> <20200609132629.GF22623@dhcp22.suse.cz>
In-Reply-To: <20200609132629.GF22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 12:08:40 +0900
Message-ID: <CAAmzW4Pch4XAfLVckKkhP32U=57g8NjC3YsKS3gemKWCYoWquQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] mm/hugetlb: use provided ac->gfp_mask for allocation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:26, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:55, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > gfp_mask handling on alloc_huge_page_(node|nodemask) is
> > slightly changed, from ASSIGN to OR. It's safe since caller of these
> > functions doesn't pass extra gfp_mask except htlb_alloc_mask().
> >
> > This is a preparation step for following patches.
>
> This patch on its own doesn't make much sense to me. Should it be folded
> in the patch which uses that?

Splitting this patch is requested by Roman. :)

Anyway, the next version would not have this patch since many thing will be
changed.

Thanks.
