Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0725EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D907F20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591203606;
	bh=L2wig0/G6QL9FZ06YyPXDRQAycqobzl2rEvtPf0jOTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bCSkwYdTaAvMk1ZTDuAdvKz7PCJS5v0iTCpj6V5HeA2ulfyvDYKmewASRvMxbjUEQ
	 BXgXyhp9rkBUjhB19+cFZdKKMh4HWcZhavxLqYSZAAq0ZLSx7u8Hz4JGgbU0IyL0Ic
	 CUPS+ofA1AnBF7zfo7IcQZ13FRbbJ16/p9n8T6UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFCRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFCRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:00:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFEC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:00:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so1783445lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APVAZ6BopJEJQVKxT8HV10LaM8dvMHhexq6dbc0PE90=;
        b=Eig+FTwLcNcSvtBuWzcBuSSILGcKWy5mB84khF/UDAFWj/4A6nXrIKyt4WVzf7CLzs
         /xg2DLTm/6zP/bW0Y6ygl82J+uKf0YswcwbGfTXMDaQnc+Ed2HWw38uRZ3lfrjQJFVJZ
         qtHKQkjRYABmpfzrrSiq1hKDvO6NpsmL+cKMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APVAZ6BopJEJQVKxT8HV10LaM8dvMHhexq6dbc0PE90=;
        b=PDFXOpCS7zg0Bm5RvoibchQReflbS4yNKBqYy2QJlZJVve7kZem5uTBRZhPzJcLmZS
         AsaMBV3HKoGUjDTgzXpZVdfN04uw58/UVopMkWMHIExAXRVkWFT9V2ox1u4V947sBSje
         OoLjoVz+P1hrdvDOgd7hACXzkoxiqeWAxWHceACWI/ONiiBDoQupTql618iXstWWnZT1
         k55A1v4OuiKVje1/gZPPIoSlNz+4lBRvrC2lGDzJOZjMLcZ+wjRlrd1U2XRd9I7V9VkF
         fqZduhevJDaSSG/xETppRmRmZbUGf5X1Ujj6lHAG++TMbLwzSZUN4DLqSw/7MT3Fz/gd
         2fTA==
X-Gm-Message-State: AOAM530nhKCI03cIVm5OqqAG9gky2N5XtQp2N5DUP2ED8ybq0nzCrp+I
        MKklKnoD5iYJShzF3Sv7HXb5WIN3jHY=
X-Google-Smtp-Source: ABdhPJyLopBP+dGzbDT8cigTtZbA79r7c1hnkaoZAjvKLt+S2adC1Gjz8/O5TlGprFhsxeL6XqMBfQ==
X-Received: by 2002:a19:c714:: with SMTP id x20mr251594lff.100.1591203600762;
        Wed, 03 Jun 2020 10:00:00 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s12sm616097ljo.70.2020.06.03.09.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 09:59:59 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c21so1779396lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 09:59:59 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr248686lfc.142.1591203599026;
 Wed, 03 Jun 2020 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200602084257.134555-1-mst@redhat.com> <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk> <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
 <20200602162931-mutt-send-email-mst@kernel.org> <CAHk-=wgYu+qk15_NpUZXwbetEU5eiWppJ=Z_A6dCSCWKxCfDfw@mail.gmail.com>
 <20200603014944-mutt-send-email-mst@kernel.org> <CAHk-=wi3=QuD30fRq8fYYTj9WmkgeZ0VR_Sh3DQHU+nmwj-jMg@mail.gmail.com>
In-Reply-To: <CAHk-=wi3=QuD30fRq8fYYTj9WmkgeZ0VR_Sh3DQHU+nmwj-jMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 09:59:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjA6S1LEOLoL5X0+YVBJPy2tnTYbf-JqvqdjXezy8=wEA@mail.gmail.com>
Message-ID: <CAHk-=wjA6S1LEOLoL5X0+YVBJPy2tnTYbf-JqvqdjXezy8=wEA@mail.gmail.com>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Just a re-send without html and a few fixes for mobile editing,
since that email got eaten by the mailing list Gods ]

On Tue, Jun 2, 2020, 23:02 Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Right and we do that, but that still sets the segment according to the
> current thread's flags, right?

But that shouldn't matter.

Sure, the limit might be for a 64-bit task, but it's not like anybody
really cares for the access. The "good address but I should limit user
space mappings to 32-bit" only matters for creating new mappings, not
for normal accesses to user space.

In fact, your very quotes show this effect:

> #define USER_DS         MAKE_MM_SEG(TASK_SIZE_MAX)

Look, to above is what set_fs(USER_DS) will use: always the max address.

Because access_ok() doesn't care. It just checks that it's any user
address at all, and the "is this mapped" is then encoded in the
existing page tables and vma lists.

So no, the current threads flags shouldn't matter for
usrr_access_begin() and unsafe_get/put_user() at all.

Where do you see them mattering?

In contrast, some things then do take the "I'm a 32-bit app" into
account, and they may use TASK_SIZE for limit checking, but on the
whole they should be very very rare. Things like "mmap()" etc, but
that's irrelevant for this discussion. But that's why you then have:

> #define TASK_SIZE               (test_thread_flag(TIF_ADDR32) ? \
>                                         IA32_PAGE_OFFSET : TASK_SIZE_MAX)

Which actually makes that choice.

(Admittedly that's a horrible horrible hack, and we should long since
have stopped doing that hiding inside the #define, but nobody has had
the energy to make it explicit in the mmap paths, I think)

> so if this is run from a kernel thread on a 64 bit kernel, we get
> TASK_SIZE_MAX even if we got the pointer from a 32 bit userspace
> address.

But that's what *normal* access_ok() does too. TASK_SIZE_MAX is fine.
All it needs to check is that it isn't a kernel address.

> Maybe kthread_use_mm should also get the fs, not just mm.
> Then we can just use access_ok directly before the access.

I'm entirely missing why you think we should care about the fs side.

Again, an access shouldn't care, either at access_ok() time, at
user_access_begin() time, or at actual user access itself. We've got
everything set up in the page tables and the vma information.

Can you point to what I'm missing in this discussion?

          Linus
