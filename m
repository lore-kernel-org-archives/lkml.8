Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F3220691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nitingupta.dev header.i=@nitingupta.dev header.b="VIHY8xLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgFIShp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgFISho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:37:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F6C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:37:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so13097938lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwHRiAPDtrkwECsv6SA7fU7H4zLVJKTcGFNk2QXOnhU=;
        b=VIHY8xLiHmbfAk+929GtvjqxvUF90uuWGK5L3c+gPpqDFRUpDiapReEG17Y3LutSww
         3V4dWOmewogkwd+Eh2mmUpKoH16NlRQle+kI7Ko4/1uBuemv435R5GU4c4mZfT3By+vr
         SVqe2G5aySIYKw5hxgQiZjXAPzP+T8vokiag6aXGMR6sDZe5pPUDOq6HgWNca8MC52A7
         s5P1ye0S5PDBu7AxhHFPbfcEVraz8m2ymqGLFoxZrFnyou69s91LmCHH95LIuM1OqCgh
         uMYv3citOqdRrf9huGay2dU3OYM+dmat6IejYUUbBgED5NkrInRwRjh2cXUyRAkBVYvk
         BSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwHRiAPDtrkwECsv6SA7fU7H4zLVJKTcGFNk2QXOnhU=;
        b=JUiGDnv6uWRcE5kSs78lxqGwN9oxkZ7O2GmA2uz96SEr3d8iai7LyudZb04P9nXJIk
         lYnjfpthiJyHYPNXZV+SrS5uhU0lDPJkQ551+MWmEmJd373zDxeDmw0CMflbs/bfSoxi
         jAabUU+BWnUD/rLsnjL+K3jpCeoKlBpdxNJAHFcHIvNZM3bKI1gXiT4O0ck9Zy6NjndY
         gMFVkfmi/sQ4UAWoObESnJfR1oVmjKlM+c6zBffr/j1efqcIEsph/O99YzPupfmsO4v3
         aaZsgl1mJ4sm6VloxKP5Bb+StmqbDZyKMzlStMuwmb5ncXordP347U/2HbAsdi3aEQX8
         /g/A==
X-Gm-Message-State: AOAM530bfUM+kTYWqk0tINxI4eOW4mObKZXxiDjGXlhNeU2GjxflBuO1
        eFfWioWSZoyxtTPiky6MkSzP2bxVR6vScM6Poywfvg==
X-Google-Smtp-Source: ABdhPJxuVElaiZy/wi7zPSnZaETNDw3REFYZMvBDEZDwQF9KjdWC3LmrzfRnNv5y4/4dmn7H2To75+SN/JnbU9vOoOw=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr16495368lfc.142.1591727862693;
 Tue, 09 Jun 2020 11:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200601194822.30252-1-nigupta@nvidia.com>
In-Reply-To: <20200601194822.30252-1-nigupta@nvidia.com>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Date:   Tue, 9 Jun 2020 11:37:31 -0700
Message-ID: <CAB6CXpAGTWGNboAXEkqC2wZsHmvbhFf_5enguXJ7QssRpr=c9A@mail.gmail.com>
Subject: Re: [PATCH v6] mm: Proactive compaction
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:48 PM Nitin Gupta <nigupta@nvidia.com> wrote:
>
> For some applications, we need to allocate almost all memory as
> hugepages. However, on a running system, higher-order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages, but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) show that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.
>

> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

(+CC Khalid)

Can this be pipelined for upstream inclusion now? Sorry, I'm a bit
rusty on upstream flow these days.

Thanks,
Nitin
