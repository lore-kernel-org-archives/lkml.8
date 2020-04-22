Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0316C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9269F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sy64pUBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDVRbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDVRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:31:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02641C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:31:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so2378235lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH/4JiFaVWzo5ZXlfDSZ+F9xWKfQK8/az3nRBT+3Ob0=;
        b=sy64pUBYeS1VuzngKnQzfqPdwoQ9xR/N3Sz+eeFgQarNRaojQFOFsGacyr3y3vkVyI
         scgMTxXkb4gRjeInhr4AoiaQ9IKFiOOktM5Ygev+YIjwJ9Mg0bxO456FvwhLwmBVMLRK
         YWJNZpAgZ0rSUjnJ5dyQB86w/4zGV4Qo5s9Jl3M0eN499tDFwZJ2boUBSkDqVLkFNwfs
         TY/yBVN42t19Bl6nsw+Q1t+McQDsP/TYTmM2DyppBmJOmkuLDEp+B3KDY1HrMTtQKpjA
         ugfESwMkPOqWW3PK4mKx4D8Z3PvoRRIq1M0yGb1+RvD/WPnPy27gy+n4+Cahdj5uU09N
         PY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH/4JiFaVWzo5ZXlfDSZ+F9xWKfQK8/az3nRBT+3Ob0=;
        b=cJrTOpK4HPQHu4TJZDA2RnoHHDHC9hzC+5bxo4WGdAM+zFeL6AQNq/ByTFQ/r2e8dj
         7FIakWVNM7XRNtQE/YInPabHf4ROqtM1pDNP6smqBrXIrtNPL7nTEfRDD+eRWS5854AY
         YVYKYYl4gRYNsoprRl5GpgLvDxkUIlI10QdZ79BTkYiP/zNsSS00AXP0fKLUV+fbhSDF
         UqrqCu9zG55yd65Z2D7j4nes9+wY7KEqfoJs2WOrp5rZqmkNZNwyqrR2xrLa3kVcei7/
         UVJznbz0AmoOExLHkuqalVyvjyZZmonFBUONigDYvESotrLVstC0bI/8sKp2t/EXAmrI
         /I9g==
X-Gm-Message-State: AGi0PuYY8SdQek9V1TuBRICgm136TccENfEBauQeAkXLByYFov+jvL3R
        5XjBS2lQTqoVtPr+6QJuDshO503NqAogHeKevb2dLw==
X-Google-Smtp-Source: APiQypIBOdCeBOlaD4SwnrUl2Ov2dmhMv62XLptmy1XZzhZrOSgT2Am8PtZwCUE2ZTV53ujuKoxlQ4ySiX01O04rnrU=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr17530208lfr.189.1587576671205;
 Wed, 22 Apr 2020 10:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-4-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 10:30:59 -0700
Message-ID: <CALvZod6433GCgVwV7=h5zoByKj7ANoox9FyB6m1_k63KJJnyMQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] mm: memcontrol: drop @compound parameter from memcg
 charging API
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The memcg charging API carries a boolean @compound parameter that
> tells whether the page we're dealing with is a hugepage.
> mem_cgroup_commit_charge() has another boolean @lrucare that indicates
> whether the page needs LRU locking or not while charging. The majority
> of callsites know those parameters at compile time, which results in a
> lot of naked "false, false" argument lists. This makes for cryptic
> code and is a breeding ground for subtle mistakes.
>
> Thankfully, the huge page state can be inferred from the page itself
> and doesn't need to be passed along. This is safe because charging
> completes before the page is published and somebody may split it.
>
> Simplify the callsites by removing @compound, and let memcg infer the
> state by using hpage_nr_pages() unconditionally. That function does
> PageTransHuge() to identify huge pages, which also helpfully asserts
> that nobody passes in tail pages by accident.
>
> The following patches will introduce a new charging API, best not to
> carry over unnecessary weight.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
