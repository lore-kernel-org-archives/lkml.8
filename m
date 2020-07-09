Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AC720674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2alEo/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgGIHPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:15:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0FC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 00:15:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so850553qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7vcRUcabRzePkZOGRbYrDqFkKibNGxlJw3maVMmHDKo=;
        b=Q2alEo/X/bR3uA+F7PQQg1jWRqZg4tt0kJ8vDP5M6453eKBqxBxIZydwCd0uqZN+je
         3zxMsQfw8gN26sMy/Umrf8Fdz02pMJjEJw0yavbJsUCJYJJDW3oPHTReJslUKQIx0bdr
         BfRfcfxb/JNUd8Or/REbGyT6zWe4QOvDJYuZ0cxqxaKJWAsi4V3akY6JfcC6uENd1A03
         c5dqflme6vijOs4XN0ZHEGCHQ3yZSlk22Yj8VdK5eg1Pn8JQpQIrv9EJEljOTFRA6vZJ
         WTQDSMByTQv8LYrz1ertuRt5f1JH0Yu2CuBYU8a46wJFlIRzLbwdELNqUQc3Cy2FqFAh
         +RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7vcRUcabRzePkZOGRbYrDqFkKibNGxlJw3maVMmHDKo=;
        b=fmT2Ywu0klAuClLhZmpKOWAAR2fd8oQ1HJHP+Acg9Y/Pf9hvgFBUPLjEq9EJEwkQts
         Y412kJK6eDaMZz7kSMSLtkHfFthP/dCHmKvB/AZOOpELa/owS1gpmFfV61ZHaohZcDvi
         Cy4IZj2VKhIO0rhm0yLmrsDSi/SXn4x9Eb30gmVF7bK/Wk/WOaTse0g3v6Vgk8VA3mHw
         Va3tk05XrTNIgnsvm7UvQWQ+uAdsDdOwsd3zxs5eugt+dyuPFmWQS8CV93ZrENFj1pbx
         IfYatLvAwdvfr/HhD3FAvF5nPkX5ZCIZYPI53S6azpKpLANOy0oN8r9vl5eciRZrAqiM
         iH7w==
X-Gm-Message-State: AOAM533xhc6yuWkfAn8xqutRhbRwTc8nQFFfbVm+hJWF8LtCw8u3stnE
        AHnH0vkA5MS73sm+6LCwDHssu81LC/42uOZM5vA=
X-Google-Smtp-Source: ABdhPJw5o54iNFYrEObriOgGjU4/aQ2kPkIaqvTOAmPkBSH9/FTD9hQ5kRWHB3IJl2TUz5ARwvUOMePU9pnMmGg2nj4=
X-Received: by 2002:a37:6d2:: with SMTP id 201mr35687344qkg.187.1594278907930;
 Thu, 09 Jul 2020 00:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
 <409b6e24-d143-a61c-95a3-1a55e1a6008e@suse.cz> <20200707190013.GZ5913@dhcp22.suse.cz>
In-Reply-To: <20200707190013.GZ5913@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Jul 2020 16:15:07 +0900
Message-ID: <CAAmzW4PVp_PX-PySjy5axMzyy5n_4cHmzrhfT=tFH2VEzxVFRQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] mm/migrate: make a standard migration target
 allocation function
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
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

2020=EB=85=84 7=EC=9B=94 8=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:00, Mi=
chal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 07-07-20 16:49:51, Vlastimil Babka wrote:
> > On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > There are some similar functions for migration target allocation.  Si=
nce
> > > there is no fundamental difference, it's better to keep just one rath=
er
> > > than keeping all variants.  This patch implements base migration targ=
et
> > > allocation function.  In the following patches, variants will be conv=
erted
> > > to use this function.
> > >
> > > Changes should be mechanical but there are some differences. First, S=
ome
> > > callers' nodemask is assgined to NULL since NULL nodemask will be
> > > considered as all available nodes, that is, &node_states[N_MEMORY].
> > > Second, for hugetlb page allocation, gfp_mask is ORed since a user co=
uld
> > > provide a gfp_mask from now on.
> >
> > I think that's wrong. See how htlb_alloc_mask() determines between
> > GFP_HIGHUSER_MOVABLE and GFP_HIGHUSER, but then you OR it with __GFP_MO=
VABLE so
> > it's always GFP_HIGHUSER_MOVABLE.

Indeed.

> Right you are! Not that it would make any real difference because only
> migrateable hugetlb pages will get __GFP_MOVABLE and so we shouldn't
> really end up here for !movable pages in the first place (not sure about
> soft offlining at this moment). But yeah it would be simply better to
> override gfp mask for hugetlb which we have been doing anyway.

Override gfp mask doesn't work since some users will call this function wit=
h
__GFP_THISNODE.  I will use hugepage_movable_supported() here and
clear __GFP_MOVABLE if needed.

Thanks.

Thanks.
