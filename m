Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E84B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igUkvz8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFJDpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:45:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CCC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:45:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so700734qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QeqT5hbbPCXDLDKC00+0EjzExFkKZPk0Jl5kbDiCosU=;
        b=igUkvz8X8Uk89MLtNxKGshq/2w56i97N+2FRmWU6ob9cC6gD0Q/A8wPlt9Y6QLTzNk
         28pA7cT1NJjK0IpOTFQQt3PiUEsA0pixyRls3VBotHazk9h3LOJrDqCA/0KddxTj9T1Q
         UWdd6tC1gRSP9nG/0zWcrFwCbYONkEEWlM2WdFGjgOF61FrgtYH3JwHf8wzT+4kUTwny
         gCWJPuySZuxs0sBvOGhyAxh4XQqphUKgDMwoo6TtNfzRyxlX8cgtxylZsij2nNxC+fCn
         26lmomuLRzY+E7/scdizf46PPHFXRST1MvGVqeSHzrxyn9bJPhSy6Fi0jGaDlk4UfRAs
         wXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QeqT5hbbPCXDLDKC00+0EjzExFkKZPk0Jl5kbDiCosU=;
        b=M1r7BBdbybzjPScWYyiN5ENldyn1qLADjzZuqkJXCQjAY0ZYm/+JPqVTeYSTZUoCjq
         //r4OOZX/xjfK/82/pdrYXqDrFyOJJVDRXVqh7G7EjiXOwlXf4xsBizXjzozZxirauZU
         8ymwqZVp4mizkkAeWVmeJtCalpw1NcaO6sM8KNzAV7CVeDE2eg4C6J9YsO319g+Wrozd
         uDuxzYpiWOi4VNbmsiwMfhgR5TMWeCGlLo5X5aTcrjFEOzKTOHvlpxHIyWmQSnJSQ6Bw
         6F9AzhfCaDhrsefxSHXfEh4kE1L7N8IuzWVEJTkecA3H2FfBKVWyDLzYB4S0zhn4iBKi
         OZ3Q==
X-Gm-Message-State: AOAM532j3rSnym2RqsmgkeHR20nmYiDqM+9/gaeti1nZg6gSPl0krhwI
        0AI92jBZSmAbflU9SUI2pgcFBxBCuddEDy6dbdE=
X-Google-Smtp-Source: ABdhPJzirNidMueStSJeirH2upP0n06cxqOB1zXIc9rmTkuY7tDhPywuzEjRmRFOPsED1gTHAsALDFn9gNRYv3F/Gj0=
X-Received: by 2002:ac8:70da:: with SMTP id g26mr1097273qtp.333.1591760717196;
 Tue, 09 Jun 2020 20:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-9-git-send-email-iamjoonsoo.kim@lge.com> <20200609140418.GJ22623@dhcp22.suse.cz>
In-Reply-To: <20200609140418.GJ22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 12:45:03 +0900
Message-ID: <CAAmzW4NxY_wW165DPhyH+4iSKba+bDUc0H+9qN4VHxmPJKq_VA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] mm/migrate: change the interface of the
 migration target alloc/free functions
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

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:04, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:59, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > To prepare unifying duplicated functions in following patches, this pat=
ch
> > changes the interface of the migration target alloc/free functions.
> > Functions now use struct alloc_control as an argument.
>
> It also pulls private argument into alloc_control and keeps it that way.
> Wouldn't it be better to use explicit types and names in a union? Each
> allocation callback has to understant the meaning anyway. I would
> consider the resulting code cleaner that way. What do you think?

Your suggestion sounds reasonable. Thanks.

My plan is that, as Vlastimil suggested, I will keep the private argument i=
n
migration callback and use the appropriate private argument by the
allocation caller. There will be no private field on alloc_control.

Thanks.
