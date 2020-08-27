Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD8C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC220757
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwDD//o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgH0Xy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Xy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:54:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE2C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:54:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so7836800qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tPhhvVGwKSAuel8jNNMpBV2hW2oRk0ci2Ch7jocIK7o=;
        b=QwDD//o7ub1e8O2Borzvx0WyXnIdXAuWfDG1wLF+F+5FTCHlBOlmcet+/rXszmjfFc
         2XYG0oOODYXZRxVC8OGmK/cFJ0+sMN4Ng8Ge1N+b8hk+YOFN2RDg8xF4UZJiieuqiAt/
         A4wHbV7iC5GIVEVdBt3yH57efZWhYLoo1Rs6kdoBFnpQpoHy/JBTekdjVU/RFMlk3Fxq
         0UocONyTMlnNXh84kD3aQZ/+iwlSCUyjazJQbrVPMGel4OAuMud3ca5ypb+ZFyCuKKLU
         PsNx+hpyVFXPdlbhb+ODNv3ebvmETIpjtmLJos5+HrGX3Q+xzbZAQ9y5X/Hc05ieRo0+
         W6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPhhvVGwKSAuel8jNNMpBV2hW2oRk0ci2Ch7jocIK7o=;
        b=fVqsrQx5rbrE5HjcFHwbeRTOdjnAoRWg59zPs2EUTpfQG0vbze0jnggqhzcEtaGTcd
         AS8HLVAizlHjO++Fl/CUGsJgsZ4FF0Ro+S1n4FKQiyMq1XmYbkhpoXqv150ZXifk3znW
         ftGeUBr8mFinI13fPm3u2opEdrE1dQoOeGvBhgXhST90ukaCAjPUsyjlQFx902tb6c70
         pH8H+yST0FAY/VOYFT34gKyB+cKiuyMxNI2fLz8/4SmPlF164rg5eJDl3pnXxMhi7YFE
         yDiv2hOMPeFUQ7ps0kvhe7im67hdUcblsX8r8DS+AHSN+pi1rCIxrD1qf18nzyimpNYM
         Xh4g==
X-Gm-Message-State: AOAM532PoQOoDAMDW6lIG/sRCVxEm6eQYpANy/RB2L6zqhd1Fmf87D6r
        dVyzbm7Udq4sVW/f84/DEx+GG0eHkTScXyn3zfk=
X-Google-Smtp-Source: ABdhPJw/XngZSnCgwjpPwdGCdAsF1zFP1OuZnj/kBJ14DG7/Ch/KvdZinGXKodKEO5+FW20SlBbu7ZOdAgSYnLGQaD4=
X-Received: by 2002:a37:d8d:: with SMTP id 135mr4611687qkn.59.1598572495641;
 Thu, 27 Aug 2020 16:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz> <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
 <20200827133523.GC3090@techsingularity.net>
In-Reply-To: <20200827133523.GC3090@techsingularity.net>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 28 Aug 2020 08:54:44 +0900
Message-ID: <CAAmzW4PTgbVzf1dkvnzpHpYYTbLyeNM=OzywUBvkFw9rUhtR4w@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 8=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:35, =
Mel Gorman <mgorman@techsingularity.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Wed, Aug 26, 2020 at 02:12:44PM +0900, Joonsoo Kim wrote:
> > > > And, it requires to break current code
> > > > layering that order-0 page is always handled by the pcplist. I'd pr=
efer
> > > > to avoid it so this patch uses different way to skip CMA page alloc=
ation
> > > > from the pcplist.
> > >
> > > Well it would be much simpler and won't affect most of allocations. B=
etter than
> > > flushing pcplists IMHO.
> >
> > Hmm...Still, I'd prefer my approach.
>
> I prefer the pcp bypass approach. It's simpler and it does not incur a
> pcp drain/refill penalty.
>
> > There are two reasons. First,
> > layering problem
> > mentioned above. In rmqueue(), there is a code for MIGRATE_HIGHATOMIC.
> > As the name shows, it's for high order atomic allocation. But, after
> > skipping pcplist
> > allocation as you suggested, we could get there with order 0 request.
>
> I guess your concern is that under some circumstances that a request that
> passes a watermark check could fail due to a highatomic reserve and to
> an extent this is true. However, in that case the system is already low
> on memory depending on the allocation context, the pcp lists may get
> flushed anyway.

My concern is that non-highorder (order-0) allocation could pollute/use the
MIGRATE_HIGHATOMIC pageblock. It's reserved for highorder atomic
allocation so it's not good if an order-0 request could get there. It would
cause more fragmentation on that pageblock.

> > We can also
> > change this code, but, I'd hope to maintain current layering. Second,
> > a performance
> > reason. After the flag for nocma is up, a burst of nocma allocation
> > could come. After
> > flushing the pcplist one times, we can use the free page on the
> > pcplist as usual until
> > the context is changed.
>
> It's not guaranteed because CMA pages could be freed between the nocma sa=
ve
> and restore triggering further drains due to a reschedule.  Similarly,
> a CMA allocation in parallel could refill with CMA pages on the per-cpu
> list. While both cases are unlikely, it's more unpredictable than a
> straight-forward pcp bypass.

Agreed that it's unpredictable than the pcp bypass. But, as you said,
those cases
would be rare.

> I don't really see it as a layering violation of the API because all
> order-0 pages go through the PCP lists. The fact that order-0 is serviced
> from the pcp list is an internal implementation detail, the API doesn't
> care.

What I mean is an internal implementation layering violation. We could make
a rule even in internal implementation to make code simpler and maintainabl=
e.
I guess that order-0 is serviced from the pcp list is one of those.

Anyway, although I prefer my approach, I'm okay with using pcp bypass.

Thanks.
