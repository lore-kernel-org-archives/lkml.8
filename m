Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D6320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Do7bcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbgFXVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388770AbgFXVCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:02:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05346C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:02:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so3861504eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q65HneRMVLhdg5SVAjawRKs3e4Na9FxPWBLgo8PD4DM=;
        b=C0Do7bcUEx1h891atQwx7sZfQK/co/oG5+keMt+dphDsjEoV7ElA4VRaEUwwl2WyPx
         jHFcXosSdWbwdjNXrPQxg54FGXbeidn6T6UwSBKPV2zT/kEGYOLm5PlqKumfRtYP19XB
         0J/jcMXrC4Bvk7fpoY5iO0GjQIkfjaxC6VxlizzfQF+Y9EcaBcxNMfroMIR9v5Ekv71/
         lqrH5fypCSpjQRp6EM5ptJLlTafD3hlK1WfBrk2cGJTLj00RpS7NPn+q2RVmbQCAq1y4
         jAV+g8VmpC+rw49LdR13HpfUq3/5A0BanSQd8KUpiKvr3x+RuDFX8cl8khwrrvvTC7SR
         MVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q65HneRMVLhdg5SVAjawRKs3e4Na9FxPWBLgo8PD4DM=;
        b=F08eJaDhleu8g/TZZJ8oX/ZDSIsiitDzbiZuEgFx95cpU0PUiXhpwWqY5NHleKDKue
         vvMEp6Tjs41Ksp4BqCqQd0xt7oWxWHzUIObH4AbKCBvrjIUdWVmzqxgsTWEZJPGbq4Fh
         iD0rCEpCU7Ej5frK9ugYzASA9Su6O6Pn8wO/WPaSHaY2Evx3JHkYh9jy1AdAT3lduly2
         e9gStrmmNlYI62K1NmBpFqpMBSZeeixABDTFnvkNB4ArcSJl/UyGdQ59e8UR5zyKE7nh
         lHQF+LtINxfaGMzR4SfbXMymMnJi93wgPzpNdFBmnbtB69GlFMePyGvl54GddeJpJpvX
         dI7A==
X-Gm-Message-State: AOAM532h+1nBj3XOPDHtZW7b6lXidCou7TN4K9VvGBIRuj7u3ZtOhH02
        JlTyW6gitW0O+XI95yTEioErjJ6lXSEB//XKGR8=
X-Google-Smtp-Source: ABdhPJxMbkTVZFeqafVKJn8HY0wcCBMIsoXT8hVjSV2RB0oGms2P5ENEgkeFqhXyUNeyiMWdtYbU3LLL5pFCTAlnd2s=
X-Received: by 2002:a17:906:7751:: with SMTP id o17mr28009624ejn.111.1593032539710;
 Wed, 24 Jun 2020 14:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200624192116.GO6578@ziepe.ca> <CAHbLzkoy2kz7yirch7t9ruzJjNTyCCZHJFZst7OEz_DdmQyaaA@mail.gmail.com>
In-Reply-To: <CAHbLzkoy2kz7yirch7t9ruzJjNTyCCZHJFZst7OEz_DdmQyaaA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 Jun 2020 14:02:07 -0700
Message-ID: <CAHbLzkomoxKE73SgZvRD0cLELBtx71jx+g07zZ5YMajUPPcRLw@mail.gmail.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 1:23 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Jun 24, 2020 at 12:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> > > A general rule of thumb is that shrinkers should be fast and effective.
> > > They are called from direct reclaim at the most incovenient of times when
> > > the caller is waiting for a page. If we attempt to reclaim a page being
> > > pinned for active dma [pin_user_pages()], we will incur far greater
> > > latency than a normal anonymous page mapped multiple times. Worse the
> > > page may be in use indefinitely by the HW and unable to be reclaimed
> > > in a timely manner.
> >
> > A pinned page can't be migrated, discarded or swapped by definition -
> > it would cause data corruption.
> >
> > So, how do things even get here and/or work today at all? I think the
> > explanation is missing something important.
>
> The __remove_mapping() will try to freeze page count if the count is
> expected otherwise just not discard the page. I'm not quite sure why
> the check is done that late, my wild guess is to check the refcount at
> the last minute so there might be a chance the pin gets released right
> before it.
>
> But I noticed a bug in __remove_ampping() for THP since THP's dma
> pinned count is recorded in the tail page's hpage_pinned_refcount
> instead of refcount. So, the refcount freeze might be successful for
> pinned THP.  Chris's patch could solve this issue too, but I'm not

This bug is not valid. I just realized try_grab_page() would increase
both refcount and hpage_pinned_refcount.

> sure if it is worth backing earlier once dma pinned page is met. If it
> is worth, the follow-up question is why not just skip such page in
> scan phase?
>
> >
> > Jason
> >
