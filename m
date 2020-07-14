Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5C7217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgbqGoc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGNPMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:12:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:12:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b185so15896984qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPY0nKFKw8Xh+fQpn89J/uEUcRoylDvAgOjS6f+f+YA=;
        b=QgbqGoc3EpeCC0EJeM1hRblC8I4e2KKabqrfFBqfPiCekpfex6JB6ojBptjaeR5lYx
         7qcv0OgfQlF4wY8ZCtpvruDgEY4d4zNsTz4WEzqkqXG2HWP1505zVWJimhu2Cp23HF3c
         7+1jWAUXqLrnbBNGiZT7ZQ6UzQNf3Dyiuxx2AMkf533qpm9IQJFd+M01+dA6XnJlLc3v
         P5WkGOuGmeRlLoI41BFWPrTLZcvgquh0fNAyvC0Gyv0xyTnmqBYB/sGWt98KPAQ4TPyL
         jF3UxOaUkgf6BKCI0tktLfbln5SINT+SNL9fgV05p4d+E/kX6Ljccd0MHzn9v/T6pUxU
         II5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPY0nKFKw8Xh+fQpn89J/uEUcRoylDvAgOjS6f+f+YA=;
        b=CpkZ+cbIfEcjsB6JkNO/ecLTT3X7KeSYw/cHJfOz3wDOZklgRldpZA0YkI2dVIgfNY
         1Rj6fHKIUyzbVuzwi7id5fML8fEa0FdnlZGvzq5j3MIRTKtQfQJ8hBRlHJZvbEwext4x
         oNxgkv8xH1HQa77TVoo7HNvjQQguh4Pyp/UM+C6xjoa6mJICYG289ut0rFnTBx6I3VDE
         cXQL2x8IC6MzHYaFhSxAjvqaB/JZ8oVWHtqyR7ZGu+KCt15pHw2LXoophTBs3ILOfXcH
         82Ajmb9KPydkrdVIsQldu+GPgIuM71fdqLtXCXAPf5jvtpVHZzRIvyV0Wr1b5/j7FHRN
         zFnA==
X-Gm-Message-State: AOAM532cOXBVX0nnX3dlVPDvlP2kJ+pSIRMDkJF8AlJFQN+aiZvhR+yU
        FOdz1D/dB3tXOgT4R+/wpetm701rl2lwnq4pi6+icxEDrV8=
X-Google-Smtp-Source: ABdhPJzp5y71Cl5iC+1fgXXPFCvds9tatsYOKuM+mUZJNt5qRokpYb5gzBe8SFxB8DRBH0l7+0ZV2wEUCJJ8kaNUyfQ=
X-Received: by 2002:a37:4289:: with SMTP id p131mr4968739qka.28.1594739551071;
 Tue, 14 Jul 2020 08:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200626223625.199813-1-peterx@redhat.com> <mhng-9a62674e-ca04-4e59-a03a-5e4924ef83ca@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-9a62674e-ca04-4e59-a03a-5e4924ef83ca@palmerdabbelt-glaptop1>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Tue, 14 Jul 2020 18:12:14 +0300
Message-ID: <CAOJsxLHOMCtoty49+8u9+5EA2H76nE5-MAbyPSzP4gvYAfG+2A@mail.gmail.com>
Subject: Re: [PATCH 17/26] mm/riscv: Use general page fault accounting
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Peter Xu <peterx@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Sat, Jul 11, 2020 at 10:43 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> This still slightly changes the accounting numbers, but I don't think it does
> so in a way that's meaningful enough to care about.  SIGBUS is the only one
> that might happen frequently enough to notice, I doubt anyone cares about
> whether faults are accounted for during OOM.

What do you mean?

AFAICT, this patch _fixes_ the accounting to be correct on page fault
restarts. I sent a patch to fix this up some time ago, but of course
this generic solutions is better:

http://lists.infradead.org/pipermail/linux-riscv/2020-June/000775.html

- Pekka
