Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ECB22574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prGW8xYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGNRDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:03:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x9so14820132ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb+jD9n5+9xpnE7B/LBnTZz9Tl2kSY4iRvV+XR2VR9s=;
        b=prGW8xYMA3U04VmXt/eqhzdeGjMwKu65HwSHkGIj+wEvYFI235boc9nAFR8Kh5+BuD
         DE1tiGT753DF0+h+x/TZAbpQWdNj/JsItTtkZOEQLfulddZvDFim4Q/lnE8y16sid+Jn
         WlxBeY4Zd9l8m+Y1C51TEax1lLSIYWaeaKyMsnlVREGJYiA8PyaRZhCfb9c2baSYx8qc
         zW80kyN4umJ2slIK3oS/0YpFZRTZsQbvPubPlBFr7M/y9JmHyRteURxm1L72f3Itqrni
         ynYs2IaL5y8qGnHhneu9oDsNiYvfBVu37d56DibxNAm4pUEKTR8eiGH2IB4ht6hzO9tY
         Ws4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb+jD9n5+9xpnE7B/LBnTZz9Tl2kSY4iRvV+XR2VR9s=;
        b=toBNjHB9wjpKo0ehBkrOggZfV3lr6OHaJZhxwi1c6ixoJvWZK2dsM0CXavdra24Z0n
         NJ+gXj4svz6EXvf2y1SMUEeUIPr8qDucw+uPN8lXXdr1YmmfD2SK2ooxZjp6TNWc4iLm
         U1z3lLVHZRol9G+e2xQ3eiMvuIgvJfDeH34h3nvrzBjO1V2Ge1AvVkJ6/rmSEWEzZdMU
         co4FHXzLpYGiVhWuqD279LVQ94je5/QBtVwwoO2JdHUTnGmKqkDZIBs1iMaCXEPxcpja
         14ic2qlWldYo+mkfmV0iGZcNQJNgZFkKumirW8AufCVCXIaZo6xFExr49fd0AVvOHog2
         CUqQ==
X-Gm-Message-State: AOAM5306OhsZLW9eymjopSVkSZhCRl6gTFtMMDDGirZP9v8hgQPMNKWe
        +AyFHhZdXhxFhC5HrhLpzGibNs7FnGkPrxkDCuWQXWI=
X-Google-Smtp-Source: ABdhPJyGa8ZTsGJ1rTjvuFyI+vq7yVyouhUYqqdgxcAfBDqGIXiA5MxfNCvwwWxAkPqoeXkX07nGAV5m91nAOyDVsQ0=
X-Received: by 2002:a05:6e02:e43:: with SMTP id l3mr5478271ilk.11.1594746179266;
 Tue, 14 Jul 2020 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200616142315.375918-1-brgerst@gmail.com> <20200714064004.GA32655@lst.de>
In-Reply-To: <20200714064004.GA32655@lst.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 14 Jul 2020 13:02:48 -0400
Message-ID: <CAMzpN2gg4H5qnU8Dk=bCaEm2WdRF-synfpf_yUaK8L6vyuo=zQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] X32 syscall cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 16, 2020 at 10:23:13AM -0400, Brian Gerst wrote:
> > Christoph Hellwig uncovered an issue with how we currently handle X32
> > syscalls.  Currently, we can only use COMPAT_SYS_DEFINEx() for X32
> > specific syscalls.  These changes remove that restriction and allow
> > native syscalls.
>
> Did this go anywhere?

This approach wasn't well received, so I'd just go with this as the
simplest solution:
https://lore.kernel.org/lkml/CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com/

--
Brian Gerst
