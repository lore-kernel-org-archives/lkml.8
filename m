Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D034420814
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB0jg2+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgEVHnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgEVHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:43:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B17C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:43:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a23so7653378qto.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUcyDTncPHOQV9NB5AwXf3dwySxGIAYkF3ieljmqrCw=;
        b=TB0jg2+M0AS+ysjH0wzuBKlUUn04A7Th9OEwSEL2adxl+HzF2GaVWdQRHLcakcSSqt
         Qm4WyJTb8Rxk92rzd3QgdT12nYccf6gxO3M3gkskpiFod4TmaLzkMIulzDcx3HgORF7S
         e9uczcG4iMIm7bahe028RMdUVUrQtTIcAU5d2sUdyOy0LDeZtrMz6Yh8mZjuLJKGjyyq
         PnULQBX6EPLWXkBVtde7AZqAZgIu+W9qQazAMK7tRcdFyCQOXnFyvTZbgA29dKd1xFEG
         YZvMj+TbJkSYaIUAGiPs4cSc07esM/1FxZq7F6Wx9/EwRL+FL+dRvWkgE8/CM0tzFHuU
         qwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUcyDTncPHOQV9NB5AwXf3dwySxGIAYkF3ieljmqrCw=;
        b=W4gTw/eOIbl5Eh5/LvY19R2/yLaOChpo9WV838wXO/+sn2dhqp2MCyfWiX7RxoxseV
         kp20QqtWSflfXsfaJDw2Vjw2C5zu9TOuXPMayL8aYy6Qdzz5oeIi5XSb07ugZbQGNFbS
         e8gKluJXtck55b0q4Nw6eufEdeQSwvYzkTpynQkK0VfQ6RAQMFgoPQUmPUz69Hix+RNO
         s/xNRA+y2rS8uEao6VPeR5NIE8nHRGLvDkkIhjgWmBabfW2QCklPnlXktIJkFeWkkRRk
         TKgBMegA3LpXyqw7LbSwLjir/hkK8qttakuQgmnSU4fRNIf67mjrw3tap8vapK00MLtP
         5w4Q==
X-Gm-Message-State: AOAM530okYt9AtaOsxL1+g11OjDn8cf2kg8VXGKWU1usD7jnLeifRWUG
        wuUXaLzPhRIyf4uBGm0ME/DOW5gBFyNS9D9oCeQ=
X-Google-Smtp-Source: ABdhPJzxjIXeLoZJLBiNmNp6fKB2NzHAq+EWCv5Aj/+2YQ50G/WUFWYD0VFHxxA4DNrgNWHKFxATj7Ni3i7qJ6vNAGg=
X-Received: by 2002:aed:2252:: with SMTP id o18mr14941673qtc.35.1590133382653;
 Fri, 22 May 2020 00:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-7-git-send-email-iamjoonsoo.kim@lge.com> <027b9f05-4a24-e69c-eafa-dbf7cca3ac4e@oracle.com>
In-Reply-To: <027b9f05-4a24-e69c-eafa-dbf7cca3ac4e@oracle.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 22 May 2020 16:42:54 +0900
Message-ID: <CAAmzW4Pf72YyA-w3BA-Kamf2h82rtinatUvTZwdcMvhCmc1tgQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] mm/hugetlb: do not modify user provided gfp_mask
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 7:19, M=
ike Kravetz <mike.kravetz@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 5/17/20 6:20 PM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > It's not good practice to modify user input. Instead of using it to
> > build correct gfp_mask for APIs, this patch introduces another gfp_mask
> > field, __gfp_mask, for internal usage.
>
> Modifying the flags as is done in the existing code does not bother me
> too much, but that is just my opinion.  Adding __gfp_mask for modificatio=
ns
> is fine with me if others think it is a good thing.

With the following patches, in some cases, ac->gfp_mask is set up once and
used many times. If we modify ac->gfp_mask in place, there would be side-ef=
fect.

> Does dequeue_huge_page_vma() need to be modified so that it will set
> ac.__gfp_mask before calling dequeue_huge_page_nodemask()?

Good catch! Will change!

Thanks.
