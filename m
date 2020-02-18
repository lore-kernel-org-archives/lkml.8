Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55193C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26787206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3PJiyBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgBRD72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:59:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38951 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgBRD71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:59:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id t23so13405776lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYNOedp5wMrP0IW+gzyF6blmcFzT2PovuB4hmH3kGKQ=;
        b=V3PJiyBoVL2i5p30BlAXTkxAxZqLFFWaZJilC7w3y7idiZXJubLT3KluMGNkOBuMF7
         AUiAvgjsqm39dlayPng3hQ2uf8nC34jjcmhoxI9PDnEA9mNK4I70k6PIQAnya+3qZlkD
         wbcvyBvYnPOIaGrx7Oj8p+AVjcddTlZV9oazO2n/Lq9LQ0F0flonfVYpn2mmPm6HYILB
         i1+n+gvOvZt+MuPzRU2KtLy+qJVLLHMlmpjMe2cEw39dxhh4ucotU9OtST7/gErOWIk5
         +fAOxw0m3RFFL7xiP4zN2qmsHQiJeOikfekvilXrdEUAd4wNAYhuuR8+NdaNGvoJTH9E
         /Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYNOedp5wMrP0IW+gzyF6blmcFzT2PovuB4hmH3kGKQ=;
        b=T8xtfd9gXVNuY1N8Hj9hCuGOQQuTwy5j1UviVaCQGGC0LiS5433cgVi7bJUgiU3hh0
         KsLq4pGldfX/lekk2RIQG+BokH/7cnClN2yxPjbEqh8xF5yNYxFK2PlQCnVN5dOEyEj+
         UAqi8srq13VEVv/gT+rGznx9bhSU328OX/cs63bT5WKVCMQyYTQDm3B/nuIpq+cKw5nO
         tHgkKbks8TOrtq5qitmrM8V2MnLI0yipE5R5ykZYgyFW/5rs244Qhx9RsBNmTXY66rwQ
         nlKuQtrDXPs4Ut8vMzgS+BVYIrpMJpcy8Hn6ZGcGOu6RNQrDqcHt9vvl7fDOemQ7Xzjf
         GW3Q==
X-Gm-Message-State: APjAAAWKNMEWMRtcIL6t5QqPtBj4Pje+7unItOEfiO627epCuINcWKNv
        7yLnyBawDBW4917wJcVszUQXNNwPEcraBRmkke25cilrjtE=
X-Google-Smtp-Source: APXvYqzVnWobrCVkpHNitkiG+Y6rB+7ON2gu3Rc1nxbC4gW9PquITmuADPvGJ3x/bpNvYzjrje0Gkit9nXSJoo8bD5g=
X-Received: by 2002:ac2:592e:: with SMTP id v14mr9554813lfi.73.1581998364215;
 Mon, 17 Feb 2020 19:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20190620022008.19172-1-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
From:   Bobby Powers <bobbypowers@gmail.com>
Date:   Mon, 17 Feb 2020 19:59:12 -0800
Message-ID: <CAArOQ2Vbpyu=JGfWNgOSQbXe15WzAB6VSah1OV8Cbx99bf0AXA@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] userfaultfd: write protection support
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 7:20 PM Peter Xu <peterx@redhat.com> wrote:
> This series implements initial write protection support for
> userfaultfd.  Currently both shmem and hugetlbfs are not supported
> yet, but only anonymous memory.  This is the 4nd version of it.
>
> The latest code can also be found at:
>
>   https://github.com/xzpeter/linux/tree/uffd-wp-merged

Hi Peter - I ported the branch you had above on top of v5.4.20 (what I
happened to be running locally), and fixed one issue that was causing
crashes for me:
https://github.com/bpowers/linux/commit/61086b5a0fa4aeb494e86d999926551a4323b84f

I wrote a small test program here:
https://github.com/plasma-umass/Mesh/blob/master/src/test/userfaultfd-kernel-copy.cc
and write protection support for userfaultfd (with eventual shmem
support) would be _hugely_ helpful for a userspace memory allocator
I'm working on.

Is there anything I can do to help get this considered for mainline?
We have some time before the 5.7 merge window opens up.

Tested-by: Bobby Powers <bobbypowers@gmail.com>
