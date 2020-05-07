Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C24C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0076D208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="usOpsGc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEGBfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbgEGBfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:35:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD52C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 18:35:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id 19so16852ioz.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSQgeUzDc0Ws4bUG9eu4KJ9IiMZF0azB+bvY4wjW68Q=;
        b=usOpsGc2ooVJ9JUs6gxetJRbdtbLNuADqFfE5M9fvDF6oIA0h5x3iVA+4ngzBW9V6v
         nlIelZ/Mblmt+6SpqJ0cIZR8SJ/fwPVdI1BWynIATxF++YRYsTrPklVXrH7PyRGCRh+i
         SaDBiHImXZq0HpP+gMdsjxqmfkGP1sscwuedM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSQgeUzDc0Ws4bUG9eu4KJ9IiMZF0azB+bvY4wjW68Q=;
        b=BtOh3ynRcy8N8W4n2ydxmt85uGifKH+dm9fWlCiKO9gT/8ED8dnIQ+T+28oJo5DLJq
         Q/B/bdDynJbWLDpenX8SpO0hFPkw9zdWrHiNaI8vcLBqdifnkhVKAJVvCZ7r3maeHh3i
         pn/Ci5wCcNt0L3qHPabPBsPdDpSU2Nfk7kAQ63R2DwelcwbKAu3adGwoJb93YICXKXbv
         syXhbeKH6KZ0/Z8VxlM+z6qmTQGRNMrrf8Yl8BjmJQM8ktbXNNTtPLqYmmbaObrcm2H1
         iq5NFY0f+UcyMmKBH0OQrc/xYSHY3r3Xi/gO1qRa7J2TPLJRWMh1MW+ZBUYRlu2uair4
         fxyg==
X-Gm-Message-State: AGi0PubHG2JjVX6H4osMC0DL2yviuxb1JTIHff0YE1tY6KHCEMfryqSt
        wLcSa9KcfePGuScnbGfJ7UE4djf/DMsNVfVoIwt32Q==
X-Google-Smtp-Source: APiQypJm6BQfKoiRqEjddc6PWtsPlFYtuVAqgoS8S0MrVf7FZnlKR4QKeTS+VWu2+k315cqqwmUA1wA4/G2Z1Pv1oeQ=
X-Received: by 2002:a6b:bc85:: with SMTP id m127mr11138943iof.89.1588815322685;
 Wed, 06 May 2020 18:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com> <CAEXW_YS_rAxHuj_Jr+0xWQSUyiOX3WKnJNevh2ReE=O+Xsp6SA@mail.gmail.com>
 <CADyq12wW-j9vi0oxXB_+sjSyP=FgaNWkRM2Yo9YqkEwGnOb0bA@mail.gmail.com>
In-Reply-To: <CADyq12wW-j9vi0oxXB_+sjSyP=FgaNWkRM2Yo9YqkEwGnOb0bA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 6 May 2020 21:35:10 -0400
Message-ID: <CAEXW_YT34g6aypdia0AsXGQ1MxGtD9=DF=mpAwKWaLM6JuSpcQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 9:11 PM Brian Geffon <bgeffon@google.com> wrote:
>
> > > -       mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
> > > +       mremap_userfaultfd_complete(&uf, addr, ret, old_len);
> >
> > Not super familiar with this code, but thought I'd ask, does ret
> > to be checked for -ENOMEM before calling mremap_userfaultfd_complete?
> > Sorry if I missed something.
>
> No, mremap_userfaultfd_complete will do a check similar to
> offset_in_page() by checking the page mask.
> It does (to & ~PAGE_MASK) to check for a non-aligned "to" value, so we're good.
>
> Additionally, earlier in the process then ctx will be null because we
> will have never called mremap_userfaultfd_prep,
> and mremap_userfaultfd_complete will check if there is a context
> before proceeding.

Makes sense.

thanks,

 - Joel
