Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C215EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856E92063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iQ8P0o5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbgDAQwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:52:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43749 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgDAQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:52:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id bd14so691283edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxAHZMB3P7yemdxIkt4vzJJqSZh7+SRQmJTgBhu3ZC4=;
        b=iQ8P0o5Lcw3JW6EArdliAxxbSUsS53/a5RuXf6cPfLAgAB3HtdBre2hHs9UVqpeY+8
         Ls7Xo6o2CkvGoZeX9P9GymfYDZu/XQiV6feOl9/iKR5+dP5RI68em61mqQEaO07tO/xF
         DhjBHgnb+eSXwn3bqvdtEKt1WCdXQlX9StQDkAQqSGPR4/Rq9pE40qYhwj69RYWYOuqH
         hhYojVv/EPXQ6dX6rSacTwnYRnjGQS7st1sPiuh4/tRAcaxGhVUud9sxV7gI1yF/t8Zq
         KyOb9hR8h5nrjs+7+gSJbmX88/nfQfHhvZzKSkhKyZP6n5/8OPw4N5VUT1hvGt+k4JRM
         NaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxAHZMB3P7yemdxIkt4vzJJqSZh7+SRQmJTgBhu3ZC4=;
        b=Cz4P/z4K/CYHooDzPjBvTkU72sewP4e+64IZwkxNs63wiTIJQvl00RKmbYG97/47PI
         PW+GQTIzJQyFQKiOzKSMFYh1EjIE79PlJDGyLSs7TR3UEWaMaDm9v0SqsnYEjGU0wCHh
         eDRNFGgEyzQDkfsQDg0iUmRZ8Ep0f4bi3TuoPQyRfWmFx7YBjEKSSYPSq6VkpINAhf7c
         FxaopszutBaoycCo1DbMNA1JifYbLorX6zP9YlB44LL3eorwVKB8UpM1CfQnJs7PjGos
         N0bpIJE8+4nVNCauyfiLznwSVULnCOjUXiLXmG1sqaJFtmWRRMKKWTY+nz2TDimuhkLK
         NExA==
X-Gm-Message-State: ANhLgQ3arCI1Kaf46vdInQVSqT3C1vxO5bRF7kgd4iCCct+WooMCSuMX
        FC5mbU8hZRkOkPZJuFgJRsVmCVis5bsGZtxVyEXVqA==
X-Google-Smtp-Source: ADFU+vuVpMe/hjYycPBUcJTSJrMd3zMxZKNcPfopDiEvgMF/laDQbj3sNMjztAxqNc/bUeFitH6ag3fui6K9vZtu0Zc=
X-Received: by 2002:a17:906:65ca:: with SMTP id z10mr20461333ejn.368.1585759927596;
 Wed, 01 Apr 2020 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz> <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz> <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz> <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
 <20200401162655.GX22681@dhcp22.suse.cz> <CA+CK2bCGpG6kBjkGd-QP06kNtwezj8mW13Jdvbxs6ExzRaJSpQ@mail.gmail.com>
 <20200401164654.GY22681@dhcp22.suse.cz>
In-Reply-To: <20200401164654.GY22681@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 12:51:56 -0400
Message-ID: <CA+CK2bCKxok9Ho2NJd0kWR=YCi+eQqyfv6fg1Je3Lmov9PqzwQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I do not remember seeing any real failures, this was a theoretical
> > window. So, we could potentially simply remove these locks until we
> > see a real boot failure in some interrupt thread. The allocation has
> > to be rather large as well.
>
> Yes please! We are really great at over complicating and over
> engineering stuff based on theoretical issues and build on top of that
> and make the code even more complex because nobody dares to re-evaluate
> and so on.

I will submit a patch (or revert) whichever is cleaner.

Pasha
