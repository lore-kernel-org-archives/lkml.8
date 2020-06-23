Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC087C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46F020738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YChY4/EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393322AbgFWVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392204AbgFWVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:15:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE485C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:15:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cy7so10932270edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/a2gbmPrfzKZgrMWGCChbggZ0/wE/cGco+2jd4C/7s=;
        b=YChY4/EGiQ5VTXFGUFGFmq3+lZnyPUCsCYVoDiosA6DmZ4LDu0KSLqZ8lh/myZbPG1
         Gcy2pOZ/uWcYHHp6GhVeMbcosWZWUewRybYgMfBIkB/nWCe4rqWkfISZMYNBwApkMY8K
         tVjYu7C+mO0AaAHthTof7bCmo+UHSpAoBcJxJIw2q4pFbLWrbOhRtT98Gx7Ou+67LP1q
         XHFEep7YNSFk92GUEvkuF/2fg1SIoYXSzl8uVTOD9VrJOzsXuGuCyCizZQ7lM4WESxLw
         eAzwxmpMRmQ9J20UgP9yFGiN6NNZzjv03JVJXdtyGO3eoIqDgavitctvTvVzBCBfjcVA
         j9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/a2gbmPrfzKZgrMWGCChbggZ0/wE/cGco+2jd4C/7s=;
        b=obuVToN78MHKqy7C3HPPk5jqYZz3AnnN8l5FJ+YupFSKjeByGwcvoJjl0VAGTtTpn2
         eE5vFnU9r9AjbD2lrOAk+WlKf90qugs9Qf86h0LtLqb1yRR8yydNCcQlszZEL3EZXoCY
         qAeEhgNExgSI9yIhWkETVkjJyFNa8SB9wk6E5E2/ZJ900nd9MP8qV0M1x9eapJ4qTAf1
         JKvHe31yWqZdXEnlhvw16bSESMn8RkvOhCltP1KZCxJwpZoDaJhb2ID13BicveatC4Nk
         4TBwxMRliJOkXh5x7TQk8BoZHT7aV8kOJ5dLtWF27B4/lpgD7mGgG8/VLTOuiIzvdV94
         RUeA==
X-Gm-Message-State: AOAM533UJZHFPoCZ4HyWCVhrQYzIQXB2/9nsNS6oCIsTsW19hPxBDS51
        pjSJ0WxqVzTce7kAiznL4XEG3K31PE4JKsjEEUV/9QOp
X-Google-Smtp-Source: ABdhPJwiRU11aW7hp405eS+bX8JNNrfbrB8kWaMHZ4aLXoHOaSUyXemO4m/lQ99UWFKS/XGsXhj8LJhiJHxYahoYipU=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr9031435edj.93.1592946935407;
 Tue, 23 Jun 2020 14:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125923.22602-1-david@redhat.com> <20200619125923.22602-3-david@redhat.com>
 <CAPcyv4hgHmnKd-isUbSy5PjohjhhCL03Y00x0NO8=JOvexvUtw@mail.gmail.com> <aac8e0db-1bd7-0991-e2e1-58a5580387c0@redhat.com>
In-Reply-To: <aac8e0db-1bd7-0991-e2e1-58a5580387c0@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 14:15:24 -0700
Message-ID: <CAPcyv4j642Hs4N2rHFEuEON1kQMwf-D0hzROPVFhcaWAK6rpdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: document why shuffle_zone() is relevant
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:28 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.20 03:41, Dan Williams wrote:
> > On Fri, Jun 19, 2020 at 6:00 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> It's not completely obvious why we have to shuffle the complete zone, as
> >> some sort of shuffling is already performed when onlining pages via
> >> __free_one_page(), placing MAX_ORDER-1 pages either to the head or the tail
> >> of the freelist. Let's document why we have to shuffle the complete zone
> >> when exposing larger, contiguous physical memory areas to the buddy.
> >>
> >
> > How about?
> >
> > Fixes: e900a918b098 ("mm: shuffle initial free memory to improve
> > memory-side-cache utilization")
> >
> > ...just like Patch1 since that original commit was missing the proper
> > commentary in the code?
>
> Hmm, mixed feelings. I (working for a distributor :) ) prefer fixes tags
> for actual BUGs, as described in
>
> Documentation/process/submitting-patches.rst: "If your patch fixes a bug
> in a specific commit, e.g. you found an issue using ``git bisect``,
> please use the 'Fixes:' tag with the first 12 characters" ...
>
> So unless there are strong feelings, I'll not add a fixes tag (although
> I agree, that it should have been contained in the original commit).

It doesn't need to be "Fixes", but how about at least mentioning the
original commit as a breadcrumb so that some future "git blame"
archaeology effort is streamlined.
