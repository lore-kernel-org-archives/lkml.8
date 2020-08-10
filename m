Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB82206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGpBsWq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHJXjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgHJXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:39:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7930FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:39:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so11484216ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/34YJbMeuxWiZIVphuGmT7O/HjPJjpnAOf2BK75EVc=;
        b=DGpBsWq243vsUYKMEHEDWzu7OHyMBIK8OO8Z0buizN5PDvd0+2TMQbVGGSBkofbQn6
         dmPWNOZLkQVI78dLEEUF/VoLSgmSLwfI/KExoe/IAjD0yB09Qhni5tkTNZ2P6iZ+yvj7
         A74k/ruNuFdoO83D2rCDyGeGDxmjrUI4jm9RPof2grq5Ax5VhwAc4EtVe9TipUuYBEdV
         urui9crtYhOFpD7HlXvAPzggE3XHNqSM0+jQbqTWme/Ro819+/tfymwCIRFPXpcEGW5h
         LjQ41GLIioCpVBMlfaOVNWSankPi4FUfGrZMgge6E71PaMwhIe3BRTvypNVpIU5rpdUX
         tukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/34YJbMeuxWiZIVphuGmT7O/HjPJjpnAOf2BK75EVc=;
        b=qWxKx1SUAHvBIN0y6Cb+nSW4D8KXXwP+/MU6o4WJBRBA0awI65ly56/bIiWgRFNGzC
         MWemvtI4Dw4KHgWLuzRMzyvV800gpit3uYOWgtc6S9ENHgKLidRcQ8KAyA2VNf5O2ViB
         k7IQrirwYvywMbyY/xM+KNhp99ObV8vUE06zvwFJpeyxRn5uZBpmxxxYOxpTnzCcXEMc
         jebTFM0Lh4pt4/W5Efx2DRiFQJHvW4quoGQmQ9m9xhCLXIESMtJj/m5Cr9c22gkOtgek
         R/SD9/CJbZjhDhyFrweYlLcBn2d+9rEieKGswwl0fL+YBJ/xj76EF943KFyhsLWuXR91
         HrKg==
X-Gm-Message-State: AOAM530MziLa/LsPy6fZgSzSDg2Yy+rWKgV5FiP8IXPa6yUd9OSfPUho
        +Ms4p46LPYuCU5P4uP7kHqmscIsM4VF9Tm8E2/itEA==
X-Google-Smtp-Source: ABdhPJxfAch9eYuc+NxjABHWfnfS36mTYJMIpeGvT82zKgxW/uWxIqTqOjffHoFeWSQhc8vTBiat+LOEd7zDkn3pa1c=
X-Received: by 2002:a2e:b058:: with SMTP id d24mr1737055ljl.265.1597102753674;
 Mon, 10 Aug 2020 16:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com> <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1> <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
 <20200810215734.GB132381@xz-x1> <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
In-Reply-To: <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Aug 2020 01:38:47 +0200
Message-ID: <CAG48ez1R_F-Oxz++sQ0dGTqZKHCyKazVEKZTTAutQbSuohXXnw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 1:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 10, 2020 at 2:57 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Yeah, that's why I totally agree we need to do enforced COW even for a read gup
> > as long as the page can be further referenced (GET|PIN).  However frankly
> > speaking I didn't follow the rest on what's wrong with "Userfaultfd-wp should
> > not care about this because it's not a write operation" that I mentiond.  Is
> > that the major part of the objection?
>
> You didn't _explain_ why it's ok.
>
> You said "it's only reading".
>
> And I told you why "only reading" is not an argument against COW.

The way I understand Peter, he doesn't want to avoid doing COW; he
wants to decouple userfaultfd-WP's fault handling from COW, so that
userfaultfd-wp notifies only when a previously-write-protected page is
actually written to. In other words, he wants the COW to basically
happen as it happens now, but it should only create a readonly PTE;
and if someone later triggers a real write fault, the fault handling
path would run again, and this time userfaultfd-wp would be notified
before that readonly PTE is turned into a writable one.

The FOLL flag would only be generated by the GUP path, not passed in
by any callers. It would cause the PTEs generated by breaking COW to
be read-only (I think this part is missing from the patch?), and it
would cause userfaultfd-WP to not synchronously block the fault.

I hope I summarized Peter's idea correctly?
