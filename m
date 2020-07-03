Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2110A2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE5Ob0jK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGCAvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGCAvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:51:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:51:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so27438647qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLFGT/BBldZHf5sKMBUPCZSt+jbFoZ4KvTvg/Gf1JYs=;
        b=bE5Ob0jKSu7KhEBUFlQPcIMPq17doykc18l+PBJ2fg8blHy2jIHU9FclxiycIFZ/yt
         3uXHNIgCpSv87fDrZn1NkYiKs9w9wDS3UKyNAh4Hjn6PLRO/vNBUn68E8XyfPu23yvTo
         GVIRzdVRuJ+yxNCukqgIeQhYkt9UamxipRNAdhtXl0taq3wJrsUPyecrB5a13llc5g0Q
         cBgCSsh9qJn65oczXnL69iIAxLSVHZCfndDa3BFkynHJDbpTdrUd/GUWBg8nPXmUtVIl
         tXj1M1fsNDsO/TwuoiL+vhjZb45cVOGvg/rbIdAmK65NDxcR0ty7BM7eTfZXOurL7gt2
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLFGT/BBldZHf5sKMBUPCZSt+jbFoZ4KvTvg/Gf1JYs=;
        b=fKZGWoa9CaG1Bgn18CJkeKU/5ZB2vIgmvX4/mM8VXHDAXDYp5fALdhePlMI/r1+Jz7
         xWbi3LLjvw1IlgIyXXg7Q4zjItL4vZLP80DxfuFopskz4liUtlvFR0xRirqM00H5vZUE
         5U12k+f7x0HqCtdeQmafCwjvQqz2KawVZ5+gMsX/4nPSBurDuTiIv9qicq+DVX3G6rdV
         3GcBV2CJqPqnO/8UvjYxK5W2Os+243vnA67hPZAuYAywxMI76rng8n54stznMP98g+oG
         tYbaQJzfrC+D48w/FQnMbCI2UVOVcZkQlsISLTpeJJGqUxMTv8pVIKM271euQoPdwKR0
         BzGw==
X-Gm-Message-State: AOAM533Gmi2UarkwE3rVsILsjxx2gsvb9USfEH4jEfPx6MkphV7hiv9N
        jh0NjztSRvkSEYlJl9vSY/VbDBi44Du2v+XfWxU=
X-Google-Smtp-Source: ABdhPJyXteh71iUaNTMFeenK1NVxNDjmbT9PEIq8o+TxNYMGvGmZqotkQy90xkaeKbrxbT8kuDjvYW8RoOqDXQrFQLA=
X-Received: by 2002:a37:345:: with SMTP id 66mr31062128qkd.272.1593737495575;
 Thu, 02 Jul 2020 17:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-4-git-send-email-iamjoonsoo.kim@lge.com> <8d12fc23-8731-c5f5-e38c-f40bfecb067f@suse.cz>
In-Reply-To: <8d12fc23-8731-c5f5-e38c-f40bfecb067f@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Jul 2020 09:51:24 +0900
Message-ID: <CAAmzW4NTntpWVyYf_SbmeDiOQNMwaQuq9Xb8ejBkcKVN3JPk=A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/workingset: extend the workingset detection for
 anon LRU
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 6:25, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Hi,
>
> I would adjust the subject, as it sounds like the patch does the whole
> workingset detection, not just preparation.
> How about:
>
> mm/workingset: prepare the workingset infrastructure for anon LRU

Looks good. I will use it.

> > In the following patch, workingset detection will be applied to
> > anonymous LRU. To prepare it, this patch adds some code to
> > distinguish/handle the both LRUs.
>
> How about:
> To prepare for this, this patch splits workingset event counters for refa=
ult,
> activate and restore into anon and file variants, as well as the refaults
> counter in struct lruvec.

Will do.

> > v6: do not introduce a new nonresident_age for anon LRU since
> > we need to use *unified* nonresident_age to implement workingset
> > detection for anon LRU.
>
> Again, v6 update info shouldn't go to changelog. In this case I think it =
doesn't
> need mentioning at all, at least not in this patch.

Okay. I agree that this should not be included in the changelog. I just wan=
t
to notice someone who checked previous patches about that there is an
important change in this version.

> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
