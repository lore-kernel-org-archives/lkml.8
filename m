Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B832074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4Ekwisf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHXNqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:46:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:46:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v16so4261683plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCkJ5WyjWp/vo15sfOy04O9dC6dPdDe+nxNNjru5ZGQ=;
        b=L4Ekwisfob8lARUVm4IHX3FSJQrLhsxH1pNhXY+IU4Jl5JmiwnHFq4kC+ZkoUgOmTF
         oRxm0wToaEKJKO4tLNn6/l/IbT/fPOEy8H5nh0aJGhI8AJPtc3yAZkw3Pklb8nDKpVTZ
         sb+l2wno0t2WM3QWkGJPS2hXaU5ciwx7kBOSduO8r9OP/phqdKZ70GrZuTjvtp43wuvd
         zi2orafnwRsVj9eU9Gzv2Z9QJenI/AXGEIZGjWwxssOBvL6wdxgf1Wd5MugS4Gu4Dq+u
         gNOJJ+kFq8iLGHNcGlIQvv6gEbWiOXgCP/msm39irv9GzYAwCC22QJe/X5ND0WU7nSvx
         +kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCkJ5WyjWp/vo15sfOy04O9dC6dPdDe+nxNNjru5ZGQ=;
        b=LD3AzLc/3EkpUk/j6PTAfpeiU3Zb3GSAA5WJoE3sSBaNenR1LYWpDTKk99PYu1sevQ
         8VmKd76/qfMJP9RJ/iQdD49jKMITi7wprp2053sb2Kr/h6vmHMA9WfqF2YobubED1Mqt
         QEW1ooVz5qNqSW6i7mCm/k3oDKm+CANpinSvfnSFE1O4CVfyopzIFNgXhqSlj6Ra7e28
         7HA+US0gF+oJ2aGa1Zy6PnWQDKQZcXnNWijBl9FKEzpeXoSa440riV9tFy77RTt2Kd8e
         +2CpdJG/1BdLlYrmTcm6hexCH3kFAlUn85UfMtMM11qw5vgyfT/6ne5SmgvyNoALFLL0
         CVFg==
X-Gm-Message-State: AOAM5308iTXM0ljfL5RlYHeQfwCCjqAQBbaKgmdESMIcf+hVnxm/1aUd
        OHXK8nlFSM5hm0Oj7ePlblSwkV/giUjlPPSivZxydg==
X-Google-Smtp-Source: ABdhPJx+5AvTxkSnNbppFehjvnHPzRzC3+yOqtfyATDKvQu5nlD7W4qLlvriyKbSeuNAKL00SFlARsrh8YiIyNzkaco=
X-Received: by 2002:a17:902:6944:: with SMTP id k4mr3098268plt.147.1598276768239;
 Mon, 24 Aug 2020 06:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200824081353.25148-1-walter-zh.wu@mediatek.com> <CANpmjNNf5pr=0hKVo92M9fEnCy7sYbv==6Bv_sVSmn=rZi7JEA@mail.gmail.com>
In-Reply-To: <CANpmjNNf5pr=0hKVo92M9fEnCy7sYbv==6Bv_sVSmn=rZi7JEA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 24 Aug 2020 15:45:56 +0200
Message-ID: <CAAeHK+w3n3f4iA_WmAKAr+mKRxu+0Trfs7mGD=i2SWodfF448A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kasan: add tests for workqueue stack recording
To:     Marco Elver <elver@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 1:49 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 24 Aug 2020 at 10:14, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > Adds a test to verify workqueue stack recording and print it in
> > KASAN report.
> >
> > The KASAN report was as follows(cleaned up slightly):
> >
> >  BUG: KASAN: use-after-free in kasan_workqueue_uaf
> >
> >  Freed by task 54:
> >   kasan_save_stack+0x24/0x50
> >   kasan_set_track+0x24/0x38
> >   kasan_set_free_info+0x20/0x40
> >   __kasan_slab_free+0x10c/0x170
> >   kasan_slab_free+0x10/0x18
> >   kfree+0x98/0x270
> >   kasan_workqueue_work+0xc/0x18
> >
> >  Last potentially related work creation:
> >   kasan_save_stack+0x24/0x50
> >   kasan_record_wq_stack+0xa8/0xb8
> >   insert_work+0x48/0x288
> >   __queue_work+0x3e8/0xc40
> >   queue_work_on+0xf4/0x118
> >   kasan_workqueue_uaf+0xfc/0x190
> >
> > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  lib/test_kasan.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> These will majorly conflict with the KASAN-test KUnit rework, which I
> don't know what the status is. AFAIK, these are not yet in -mm tree.

I've asked Andrew to take those in 5.9, but that didn't happen.
Perhaps we should ping him again after Plumbers.

> I think the KASAN-test KUnit rework has priority, as rebasing that
> work on top of this patch is going to be difficult. So maybe these
> test additions can be declared optional if there are conflicts coming,
> and if that'll be the case you'll have to rebase and resend the test.

Yeah, either waiting for KASAN+Kunit or separating the tests sounds
like plausible approaches.
