Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F3214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw5+tmp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgA3Ww0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:52:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35503 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3WwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:52:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so4788879otd.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSsZcaTfXOTFMqkKy3ZnZWZbmKJX0x/xuamjtfc8mfk=;
        b=Xw5+tmp+ErELACNDrM55VJgVQo5HyMVRPz03mHg0bvUr1o3WLBt2ztpTwqWNQ4C0cz
         wpoBqQ73TseKUZ8LDU9ET88Pi5YITbV03hAd07uV++wHLHZXPZGx4VKWxGVexrtMY6Yz
         72uHZ7V4nOvxWxQGxD5tABvYW95KNOzueJQ34cQIwX8QbpwuSVeby9/H0+Jq2KuXH59V
         o5aDsxn/mdcpXjXG0Crki9njtDgVbCcKHaFxxDG456PtfNHslwX+4+KOyHiAHZiPpjs6
         sbj1cQrJvOPRU9kmKgkGMdkR4NpB4AAaGF8xwA6EMAY5B9cnggQJj2OJ8ijfZjCFPx2/
         z0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSsZcaTfXOTFMqkKy3ZnZWZbmKJX0x/xuamjtfc8mfk=;
        b=MAz0L6zgQ2bOUDpP8+m9oGFLS0uWIQbY+r8sQe16AaoXq+cy/XXGlaXZALgzrRycIE
         5oQnOyLSawU3dNGXniV19k5IS/FRBUi0EUHSdcbX59o4kn6pVjw/3qbmwM0zW+7yPPR9
         Hbz2zw4PSYk9WoxElt2fGSLOHVafvv8NRoJ1A3idA/7hEFuby6bhgUPEoByA+AENgKJ8
         rSgAnUaNf+uqfPvsPkATP0Ny97/ZuDJDCHeQ04JYHdXnYQU/zIlJqhGTHz76tYq5iXBk
         GPZMPhC30mvT2MXdnhaDDFWm3WMHf9cDr3eefhHyxxsf6XCFUllNH1JfnLUc7EFgSCwe
         PmHA==
X-Gm-Message-State: APjAAAVcwE//ylkX9AlJY3Vn1+xp5AL9fzHvLUsZuRjMnM+wKQilyPkm
        UxNBAPEN/aq9UrTzKM0gMmLWBLWD2j6OashfCd4=
X-Google-Smtp-Source: APXvYqzXCCLiZwpASK2AHyFBUFB9uZN8F9l7IZ/XQxgSwk9nTjL6WYsOgvdFWnodSKcVaoUZ3cKLGDFGwHqEBfi4Xdc=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr5653105otr.244.1580424744732;
 Thu, 30 Jan 2020 14:52:24 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz> <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org> <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org> <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org> <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org> <20200128113953.GA24244@dhcp22.suse.cz>
 <CAM_iQpVjiui0xb7wTfF2HOME=cuk7M2SCBa7O_RVebk04qMs4w@mail.gmail.com>
In-Reply-To: <CAM_iQpVjiui0xb7wTfF2HOME=cuk7M2SCBa7O_RVebk04qMs4w@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 30 Jan 2020 14:52:13 -0800
Message-ID: <CAM_iQpX2P_NWeR_FTZOcL96Gd0TwDLZY1=X_AeUpYuX=pPE-ew@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:44 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Jan 28, 2020 at 3:39 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 28-01-20 02:48:57, Matthew Wilcox wrote:
> > > Doesn't the stack trace above indicate that we're doing migration as
> > > the result of an allocation in add_to_page_cache_lru()?
> >
> > Which stack trace do you refer to? Because the one above doesn't show
> > much more beyond mem_cgroup_iter and likewise others in this email
> > thread. I do not really remember any stack with lock_page on the trace.
>
> I think the page is locked in add_to_page_cache_lru() by
> __SetPageLocked(), as the stack trace shows __add_to_page_cache_locked().
> It is not yet unlocked, as it is still looping inside try_charge().
>
> I will write a script to see if I can find the longest time spent in reclaim
> as you suggested.

After digging the changelog, I believe the following commit could fix
the problem:

commit f9c645621a28e37813a1de96d9cbd89cde94a1e4
Author: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date:   Mon Sep 23 15:37:08 2019 -0700

    memcg, oom: don't require __GFP_FS when invoking memcg OOM killer

which is not yet in our 4.19 branch yet. We will sync with 4.19 stable soon.

Thanks.
