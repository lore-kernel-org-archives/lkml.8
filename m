Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B36207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aVOjgIgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIBOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:32:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39EAC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:32:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so5140155edo.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bItmxO/box4xkUA8NKzf+RG/lZQ2k+Z9iLxIKAdl3rg=;
        b=aVOjgIghf/LEOqFr9f4cUaGIB9aNDSyALYlLsC+VQPNplfPqFtVW5Qz+ox/xFwMdpG
         jB7beowphCRkU5QDzWrb1EIupdF/v2r4RrLTeTNLFjTKFbZT7NXvgjlyT110in7Hx4dz
         8GpNde4P1H361ikv41rISWFetQY8pv60aCfHVotYKc+9S1z/8/DbWq6/tv6WzUJv8SKX
         DCirYhdgoK+EpYuOQ8MlWhfwnFl74/BPW+p0nPJCl193hT7+N0RKmg2ztMkUn5l5Z0Bb
         UWhbiXJwo5yKScy0+CLjd2d6INwPCv6lmQoNSeG44B0Q2AYK8pFHtFdXOrkgqZyeW7eD
         VTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bItmxO/box4xkUA8NKzf+RG/lZQ2k+Z9iLxIKAdl3rg=;
        b=iS6WuH0FSb+mp7WEIf44wQ9NQAXtjQ88E2rf384OmQH3QxXIsuQE+ObkptmPFGxDpz
         I8DxLwXLNzXSPTkOGK3gaGzNvRAzt+Bih67jnQNzVztR0ImD8aFILcMIpjA+fOpuPXu6
         +d3i0Q8m8A2E6UNh419GWVdtmWmTYVQuKf6Kqv4vFlGqThyV3wh/vQ0NtZlOYuDPBsSr
         foyZAbZ3PCEO1yGkedgA0HXfUwbz5vd5zeUVDCsj0d9XbgdfZFJdptKvV6qzCDshl7OC
         uehkXZw62f2OiD34OsSCP3OdIRDd5MEvdIK1UNBOsLPOCRu8tuNHdvFMaBxUrD3auvLi
         RYvg==
X-Gm-Message-State: AOAM531tjlJXYnwn0osShMVxbIXyMPIj3hzI/SKFTC4YnEoOjotXgN9W
        sniVXP3rGewAcEGXy/RMZTk4gD+A8p8Y0cMd5sgZew==
X-Google-Smtp-Source: ABdhPJz7LBVE9G0FklzTLP3uMK+8ho+lPEAer2aH2x2P88+WwHOIvwpcKHpNBVp5M80nq++1xfgz3t4mbQjP3lzHp+s=
X-Received: by 2002:aa7:de91:: with SMTP id j17mr345344edv.85.1599057144195;
 Wed, 02 Sep 2020 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140116.GI4617@dhcp22.suse.cz> <20200902141057.GK4617@dhcp22.suse.cz>
In-Reply-To: <20200902141057.GK4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 10:31:48 -0400
Message-ID: <CA+CK2bChfLLDikSzaD0kCkchxiRd0fzpyDEEpbzEh_7MEqhNgw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The fix is to try to drain per-cpu lists again after
> > > check_pages_isolated_cb() fails.
>
> Still trying to wrap my head around this but I think this is not a
> proper fix. It should be the page isolation to make sure no races are
> possible with the page freeing path.
>

As Bharata B Rao found in another thread, the problem was introduced
by this change:
c52e75935f8d: mm: remove extra drain pages on pcp list

So, the drain used to be tried every time with lru_add_drain_all();
Which, I think is excessive, as we start a thread per cpu to try to
drain and catch a rare race condition. With the proposed change we
drain again only when we find such a condition. Fixing it in
start_isolate_page_range means that we must somehow synchronize it
with the release_pages() which adds costs to runtime code, instead of
to hot-remove code.

Pasha
