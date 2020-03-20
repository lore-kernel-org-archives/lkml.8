Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1759C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE320767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fovlzP2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCTTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:32:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42274 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCTTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:32:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id 13so7742905oiy.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtK/7/gXu1ovNCUySDq9BYUWoCn1Zjd42Y2kES4LIpM=;
        b=fovlzP2kOwipRtJHpoxJ4jgC/JCVK0QLiorzypspFTH9aJXj7PP4ZRdxMDg411kk0y
         a8vWAbRH6LU0oot2ZyauWnBxhQiTxn6JzAGRgfLDcW6ARrVgOYN+0MqnvLvIXoOh5E1X
         GxdCs7wFLTW24dfgVy0QKYr771PI+xbNkbyJMpUuq6nSdp28lOu1DHxUbJloKhRqili7
         pQp1KmfqpwhFPm+wVRq1/uWbhrxaCX9LUutEIkZKtwhJM4hs3GR9FWuPDmqkh040SWxW
         kIvraYUVo1kk9GLHhQLGaiQWCPK1Wpmw2Z5Ph4v/kSzQ3pTB1OFW7jglZSrPZURI2Eod
         umWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtK/7/gXu1ovNCUySDq9BYUWoCn1Zjd42Y2kES4LIpM=;
        b=OTxO+797+n/+jrpPbGLKvXReVKK20V9UDuehbde3zvwpbqKvABMdsVo6pj+8P42WM/
         9ev1GGyrAVI7szC4USRmPEANSgUZSGcblQcC2i6o943LE3hKHVbiCvx2SOz50O99Wl2y
         f8kY6wuXOzkJ8NnQRumD8l+nQU6sUpBJRzkM6jfu/xXFmDhSdvjoYPH939yxjy5eTwZU
         n5e9R+W9EgZmAAvIZcOXGKjyjkpE9Klm1OY28NPUwuDvu/NftiS8j2zJMNoePGHMTBlZ
         aW5JhUhGewWQBWwQNmqyUXa2/kvrbQOMMsQM2JW5V/ngAV6wiM6My9A2bzIWu2L2MX0I
         07eA==
X-Gm-Message-State: ANhLgQ2zyy2ruFu1tCYBRnSN0dVrXVDS9ZZyaFXBnybeqduDeNsxHEEv
        CFUoyWln2LriBc0AXF1YvpZpUxD22Mm8psIP0SgqvA==
X-Google-Smtp-Source: ADFU+vtATW7OF0jdQrbPsEIZUB6+NQzlm/MoxyVX81FQyBfsxlRimzKyzb8W88GR0NPdrdcTifvl4fObC6qNPQQvkIc=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr2660083oib.8.1584732739064;
 Fri, 20 Mar 2020 12:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200313223920.124230-1-almasrymina@google.com>
 <CAHS8izMcLx93DJtr0kyDz_qm_bNV-EOzKnPGrpQoopBHyJg9=g@mail.gmail.com> <87zhcin6gr.fsf@redhat.com>
In-Reply-To: <87zhcin6gr.fsf@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 20 Mar 2020 12:32:07 -0700
Message-ID: <CAHS8izNGHOMwxAXP3KhJ5H6fb4BT2P6F6GgREbtiosZHRuoZNQ@mail.gmail.com>
Subject: Re: [PATCH -next] hugetlb_cgroup: fix illegal access to memory
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun/Mike you want to also give this a quick look?

On Sat, Mar 14, 2020 at 11:21 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Fri, Mar 13, 2020 at 3:39 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> This appears to be a mistake in commit faced7e0806cf ("mm: hugetlb
> >> controller for cgroups v2"). Essentially that commit does
> >> a hugetlb_cgroup_from_counter assuming that page_counter_try_charge has
> >> initialized counter, but if page_counter_try_charge has failed then it
> >> seems it does not initialize counter, so
> >> hugetlb_cgroup_from_counter(counter) ends up pointing to random memory,
> >> causing kasan to complain.
> >>
> >> Solution, simply use h_cg, instead of
> >> hugetlb_cgroup_from_counter(counter), since that is a reference to the
> >> hugetlb_cgroup anyway. After this change kasan ceases to complain.
> >>
> >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >> Reported-by: syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com
> >> Fixes: commit faced7e0806cf ("mm: hugetlb controller for cgroups v2")
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: mike.kravetz@oracle.com
> >> Cc: rientjes@google.com
> >>
> >> ---
> >>  mm/hugetlb_cgroup.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> >> index 7994eb8a2a0b4..aabf65d4d91ba 100644
> >> --- a/mm/hugetlb_cgroup.c
> >> +++ b/mm/hugetlb_cgroup.c
> >> @@ -259,8 +259,7 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> >>                     __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
> >>                     nr_pages, &counter)) {
> >>                 ret = -ENOMEM;
> >> -               hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
> >> -                             HUGETLB_MAX);
> >> +               hugetlb_event(h_cg, idx, HUGETLB_MAX);
> >>                 css_put(&h_cg->css);
> >>                 goto done;
> >>         }
> >> --
> >> 2.25.1.481.gfbce0eb801-goog
>
> Acked-by: Giuseppe Scrivano <gscrivan@redhat.com>
>
> Thanks,
> Giuseppe
>
