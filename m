Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C35420870
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593713198;
	bh=m5mL1I5gGiyy1V3W9dGZshSIapbY55COo+rlsJGPBvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fus4/ibnDt6yJwFmPUnIsAAgwPexbfTIdVoq19rfPDjtNFuAu30zuxBOxyMht5ToM
	 PgISxK+9aUxFNz2RDrGEPkqc55x8UYzWODxru09AIB8L6+Bm95Nzgd/3blrMmcmmZK
	 5DEh6MWexaTnVBuY6ifKnRXmjwZnHAtMSXRHHwNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGBSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGBSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:06:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:06:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so33376395ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXeahw42GKg9juA4uBvpVeENM2KNGrSYvX0lCAxHaNg=;
        b=SAc0P6TZQfW4FQsf2+lBD6w+OSrGuXoO/P2PmSMr9aJV7th8BuILaQ/KWCoOqTwRky
         Z+eIAa2Z4MCcV67tYB3E39MCwT1aVIIJBvvu6hNQ/ndKZHjjvkLbORwFnofChsGG7dJ/
         +O1yGNrkWF0L9ihdnRiytVkIkOBqnPy0jQXsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXeahw42GKg9juA4uBvpVeENM2KNGrSYvX0lCAxHaNg=;
        b=GtELQoJn4HsNYPcdfb+nV3QBXxkLLxYpUzoMpj5gizUZgTNzf8QSBoHvVjCR0zR18i
         GQJZvnLy9KYn5ELG9hdH2mrnTsgKRApw0IIJnYw/aaWDAqO2qG6FGa+AsIN6v0kItcxl
         JKnfmE3rbQ1kmbGmJGzjeZ/9H+qVxyuMEvjAUfbD8v8mTbKmpEEPCVejEOe9khTncWu7
         k9FUW+CLRZpUMT9fO/mlLixpQZtYWwNq5VpvZnO0gtAXxLq5dQTJ148Sim4uESieT1iW
         Aw01yXg1YmOtqrUaHoSAm1cJUW9Zt1c71sbDXk/JW2uaFAIUPsJ1qr5J3SEPEtXn4mns
         u0ag==
X-Gm-Message-State: AOAM531sZVKaYAoxexBlI8gYlfJQt5TQOjOcj38dJfENpGUxBPZ4s8/6
        oLjOotCkVis2/6XUuO1rvtLNzwO0CSw=
X-Google-Smtp-Source: ABdhPJwGK9Dl4lsePL2boVq2ZImMJ36uBo6auueAei9iYv2LepNFmmp1jAIxIlbsG03qq3sHgsimEQ==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr16590742ljk.382.1593713194229;
        Thu, 02 Jul 2020 11:06:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l5sm4023452lfp.9.2020.07.02.11.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:06:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id f5so17508180ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:06:33 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr11620388lji.371.1593713192759;
 Thu, 02 Jul 2020 11:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-3-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 11:06:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
Message-ID: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> shouldn't trigger any filesystem I/O for the actual request or for
> readahead.  This allows to do tentative reads out of the page cache as
> some filesystems allow, and to take the appropriate locks and retry the
> reads only if the requested pages are not cached.

This looks sane to me, except for this part:
>                 if (!PageUptodate(page)) {
> -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
>                                 put_page(page);
>                                 goto would_block;
>                         }

This path doesn't actually initiate reads at all - it waits for
existing reads to finish.

So I think it should only check for IOCB_NOWAIT.

Of course, if you want to avoid both new reads to be submitted _and_
avoid waiting for existing pending reads, you should just set both
flags, and you get the semantics you want. So for your case, this may
not make any difference.

But if the issue is a deadlock where the code can block for IO, but
not call back down to the filesystem for new IO (because it holds a
lock that the filesystem might need) then this patch as-is is wrong,
because it disallows even that case.

              Linus
