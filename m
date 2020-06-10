Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56ABD2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8gpG2Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFJDHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:07:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80AC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:07:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so666178qte.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pp/qlAbI1TYog4rTQTyigrN+bIJRX23zhDU2fxPKerg=;
        b=N8gpG2MfNEeCZAi7wb/OaVJRGW80WDIAEt+1kte5r+MLh3hqA8HDtwwboGczXjJjtl
         0PRz/UMRbrSQjdybI6B9s8l1qWpk0Of6Du+63felYtswZJ78tznHbPs6xuXOzL9UeBJU
         c61ifXvqwMN+Ey4XlwodKUCWkE4tN5ec1wjJ+xCDc62K3FDwulpiJGhpXUVzNcw9thYu
         Kgz1XvAGMJeJb4fFk0PctyvoxFF56QmFvzAo5i+XO0+vyAxx/ByJU2dwQTZjxn2cQ2Oy
         zbjqb08xplMJb77Q55KNwfzLKg214FTe1Lyqli+ykrNPwFPPg6MB06Yy92xwsS4572E+
         8aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pp/qlAbI1TYog4rTQTyigrN+bIJRX23zhDU2fxPKerg=;
        b=H62t/JdlIuyIYzghWFCAVoSqpH0Jzx40GlVt32/9DClMNzBLUQhgTVby0isnXwmFp4
         SM0wdnAp7TPP5YI4Bf5OJY8FplWhtFL545Mfw3Ocqgje2VL8Kehoczedvzbb9mMY/tA9
         I7nSHy/xFhgYto/WoGllSu+qCMkJHbK5DMuy6EMVhAM4iN5RMPKgYDCjSrfj7u2WHTI1
         PUjVQ5POQGOacqspWTEZYSMR9mFAixGdhSuO2Q6fvTBAlk4/q7Yeb49nMVKMJgR2ZUTt
         bpxyIL/99IKBwbn+OVbnnUv4FRDTjpzhP7fTPydiJyRirP3l6a3p19O4sagX1bBYj/uP
         4AkA==
X-Gm-Message-State: AOAM532mv7NKfw/Xtx7qg8WdeWfqd61K9y0zZ+UfsBzFE7z2rMMJNAa+
        5Gixy2SWrmmlImbbRvvqDN9M8hVA64+rsh/suFw=
X-Google-Smtp-Source: ABdhPJxLyoSMn/N3QznHvELiBCI9Wonu2ALWZfIQOPd967qBid40hkbkFKSrParbIZsm+ShNs1B0hZK2SWiUZIaO+f8=
X-Received: by 2002:ac8:70da:: with SMTP id g26mr1008875qtp.333.1591758451245;
 Tue, 09 Jun 2020 20:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-4-git-send-email-iamjoonsoo.kim@lge.com> <20200609132438.GE22623@dhcp22.suse.cz>
In-Reply-To: <20200609132438.GE22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 12:07:17 +0900
Message-ID: <CAAmzW4OawW=RC4t1h_0V42Z6UKzSs9k1+Wem_MtAFqC2Ummd3g@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] mm/hugetlb: introduce alloc_control structure to
 simplify migration target allocation APIs
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

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:24, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:54, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Currently, page allocation functions for migration requires some argume=
nts.
> > More worse, in the following patch, more argument will be needed to uni=
fy
> > the similar functions. To simplify them, in this patch, unified data
> > structure that controls allocation behaviour is introduced.
> >
> > For clean-up, function declarations are re-ordered.
>
> This is really hard to review without having a clear picture of the
> resulting code so bear with me. I can see some reasons why allocation
> callbacks might benefit from a agragated argument but you seem to touch
> the internal hugetlb dequeue_huge_page_vma which shouldn't really need
> that. I wouldn't mind much but I remember the hugetlb allocation
> functions layering is quite complex for hugetlb specific reasons (see
> 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
> for more background).
>
> Is there any reason why the agregated argument cannot be limited only to
> migration callbacks. That would be alloc_huge_page_node, alloc_huge_page_=
nodemask
> and alloc_huge_page_vma.

I did it since it's simple for me, but, yes, it's not good to touch
the internal functions.

Anyway, Vlastimil already suggested not to introduce alloc_control for
any hugetlb
functions. I will try it on the next version so the next version would not =
have
alloc_control in any hugetlb functions.

Thanks.
