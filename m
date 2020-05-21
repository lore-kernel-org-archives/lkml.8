Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9506620748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGUqCzpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgEUEvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUEvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:51:24 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:51:24 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 67so2146615ybn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTDSy6rQtPM6ksLHsWDHpGE71vgFWJ3nMNjkQ/CXVsc=;
        b=hGUqCzpGfR+u0MkAe5AX25MsKCkjqfikrQ3WjNa4O7zFIIelSFfn7DX+0N646NurFz
         Fuu23lzgTNOO+3+4bssM3UW6fnzt4GHCJpy4IZBzQ1/Tpu4Z/Gu23YBg7/IhNRxP+vZ8
         MIXWFAKygECI9ygSikqb+mO5sD+/v9C3TqC0mDzWOS8SQNOCjyoyaSzGSHsF/k/8eJyI
         Wa8KfVRNrFbl9+CiLc04tUKYMCixhIeDvs8APaAaEJq3si/TQBBaOgfiIj77C12CPHRK
         QpvgLXmj30cBw8uBNBlCyGRteapNuIiuS+QOBkFL7sEfwpl4svKLaa3lbG/ojwoTdpM2
         ucjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTDSy6rQtPM6ksLHsWDHpGE71vgFWJ3nMNjkQ/CXVsc=;
        b=czkrzWtK1EhTKAzwfpJ6WZWEAouRUYDPjEGzNVUUnjxuM2jxL8Y2YBgI/y8VL7B46e
         850QmmpyLaxinw7bAogiwzWoZjX77TPLgERRyIa7x8ucqbNJnKy3Z1TAVKOKcIYX/agw
         qKfKLZEPeaSC4Ci1vtPIyBaW2uj7lHg7MuPzz1XDcHBU8lNNXd0QFHTCuO0rdltmh+xS
         iCaiG4g544I3YO8ZL9VvQlqM2knZu9bN+4+3+nMmkUtRBVvbpDE5rVkhDX2RNfXpiI13
         nRDchooS7Hp2WNlSsbp6uF4U4ugtK6hAcfOoom80qArBcr/Snnot3yldLEe5wSUbCkox
         uS2A==
X-Gm-Message-State: AOAM5319w0zNFR+DIeLTvOGYQn84fH4BzOVEeRkVZJb/xZ5ovUlzQIIL
        3L8fLtyOImDwklx7nWHq5Mv6B9WaMGxtGxCKssJSGg==
X-Google-Smtp-Source: ABdhPJyTg+h4Mp9qx20ejrQ1XyNdJKAepDavp8xDV1eNDH0UWEvC7YXBqwff1EqnjJEaElBj2JOy2JdxlbhSs8fFir4=
X-Received: by 2002:a25:ab4c:: with SMTP id u70mr11640352ybi.298.1590036683550;
 Wed, 20 May 2020 21:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200520052908.204642-1-walken@google.com> <20200520052908.204642-13-walken@google.com>
 <20200520202242.dec6b520f0bab4a66a510d73@linux-foundation.org>
In-Reply-To: <20200520202242.dec6b520f0bab4a66a510d73@linux-foundation.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 20 May 2020 21:51:11 -0700
Message-ID: <CANN689EDRgw=NDFStgubWZLJxssirt-JY80GbjWcmKi6cU4EbA@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, thanks !

On Wed, May 20, 2020 at 8:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 19 May 2020 22:29:08 -0700 Michel Lespinasse <walken@google.com> wrote:
> > Convert comments that reference mmap_sem to reference mmap_lock instead.
>
> This may not be complete..
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mmap-locking-api-convert-mmap_sem-comments-fix
>
> fix up linux-next leftovers
>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Liam Howlett <Liam.Howlett@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Ying Han <yinghan@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Michel Lespinasse <walken@google.com>
