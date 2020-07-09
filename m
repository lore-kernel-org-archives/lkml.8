Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AAE206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixRBRPBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgGID0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGID0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:26:39 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EEC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 20:26:38 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h17so383278qvr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SqfR0yyd/akPVv8fPW8XhDfR8IeowNBbxqDF+5ncZTQ=;
        b=ixRBRPBaHHksvrmGxXr5jpB4f/EWHMghO4zMqkhWithmAAzyOsYKfBgbl4Hy0IHHaa
         fYBa6gwzHiLUVlxVqQzDF7wGS51vPzJxceYsKkOhA5pnSHxmvH5ePJt2IUUSQaVPNPVn
         u61YPKMxNO0yD5Srjbl1GnULDf6ziFj2HlhalTxsTWsepBryXnJ9CUS8Q49z2/uzHh8f
         UfJ0Fk5ZjRSh9yBGqgPG3ocrb4hozkCDjraOcqsULLHo8UniAk4QXL4JGlZj6AF9mps3
         Q5Ut5Jc8nka4I5RMA6uSHFLeD8Ye4GHAy4eMb2FP6kL6Je8XXGOIW21gKid1EFertY7q
         DlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SqfR0yyd/akPVv8fPW8XhDfR8IeowNBbxqDF+5ncZTQ=;
        b=BlQaZpyXhki2cDu8wexfkBzMZ10QUldH9bUxZAMVCDmOLtUoPynPvLOTI2hguLgjUC
         aDzv7hYHBvJJ+k6YSu2b7j6Pd5oEwzBAI6Dh9F2nvuj7Nk1v871XIpDyO7Ao3IKBqkay
         ki0uXJNp350Wf6PCm94V3iLtg0h8wSYBhsOf4vZ/6z8GK0PjaGgQSr6n91fdCSRUDRV4
         +Y/QLRqmKMpOGL5uLC/OWG4piDzH3g0ZzcD+c2JTKRLMu/LuC2ZrNzU0rOHbDechBsq4
         ZnEgWoUVDEtqA2tXaUsEGcF4HwhSxs5hADqFXznpRpoBfFNlXhpNnRgc62zNQ5pK9mqL
         hw8Q==
X-Gm-Message-State: AOAM531m55V4YebYyBIjI1Se7diC/qKn3R9FjfRYBRxSlml8vzzoGkF/
        ljLp6v0ueHihKp7PXJ/3OdUCjsBBfWi0WE1/9Mc=
X-Google-Smtp-Source: ABdhPJw2ZKl7RX7AQLafTxj7lp5YLbaZmJNNPzsnPCWA97cPgrkgCH2aCd+qAFEovniiV0ktv6/eYdDCHp0mpgGCNPc=
X-Received: by 2002:ad4:4732:: with SMTP id l18mr58016937qvz.208.1594265198224;
 Wed, 08 Jul 2020 20:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707114019.GI5913@dhcp22.suse.cz> <20200708071916.GD16543@js1304-desktop>
 <20200708074820.GE7271@dhcp22.suse.cz>
In-Reply-To: <20200708074820.GE7271@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Jul 2020 12:26:30 +0900
Message-ID: <CAAmzW4PdjSa0qO3EJwCEBTrLyCpCXKSZbV1b-ptPORDKqO4AvA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 8=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 4:48, Mi=
chal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 08-07-20 16:19:17, Joonsoo Kim wrote:
> > On Tue, Jul 07, 2020 at 01:40:19PM +0200, Michal Hocko wrote:
> [...]
> > Subject: [PATCH] mm/migrate: clear __GFP_RECLAIM for THP allocation for
> >  migration
> >
> > In migration target allocation functions, THP allocations uses differen=
t
> > gfp_mask, especially, in regard to the reclaim gfp_mask. There is no
> > reason to use different reclaim gfp_mask for each cases and it is
> > an obstacle to make a common function in order to clean-up migration
> > target allocation functions. This patch fixes this situation by using
> > common reclaim gfp_mask for THP allocation.
>
> I would find the following more understandable, feel free to reuse parts
> that you like:
> "
> new_page_nodemask is a migration callback and it tries to use a common
> gfp flags for the target page allocation whether it is a base page or a
> THP. The later only adds GFP_TRANSHUGE to the given mask. This results
> in the allocation being slightly more aggressive than necessary because
> the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
> allocations usually exclude this flag to reduce over eager background
> reclaim during a high THP allocation load which has been seen during
> large mmaps initialization. There is no indication that this is a
> problem for migration as well but theoretically the same might happen
> when migrating large mappings to a different node. Make the migration
> callback consistent with regular THP allocations.
> "

Looks good!
I will use this description.

Thanks.
