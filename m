Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE3E207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfInfF5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgEUHvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgEUHvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:51:10 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7535C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:51:10 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i16so2375815ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cTYxMrSpTH1mIGr8IELAXemAW00cOr39cI8SC00UUE=;
        b=jfInfF5Vaq1mZYqYs8FyBhwBLOKmCd4a/4uLJStVBxanYTxpkTlKh1W2dzjaslTv5/
         DgSbzp9xZ2C3OzEP/86Lq1iTi60P4TIhoV8RFGX2m/TSGWTOqaGlJvYbmfiDng56l8HE
         kElvZWD9Dsv7UIAdDOlriuXjPw/p4nlC/MfiFqCDD7VS5AziCXLouPNMPhXdoi1+njSn
         5Kq9USdaxKow8NDx5ctFyf73MicYJNmt5MGFzXZUJQTIRyvOJKklOLdY0WN7XK8zgKVL
         gMiLVjtXjCnYmfQDcEuGzcWZdCyi58MGTCFEtlLXQs4dTFln74NIvD9dkxZxebWXRHrN
         TlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cTYxMrSpTH1mIGr8IELAXemAW00cOr39cI8SC00UUE=;
        b=gtNpaPqG8zCOt03Pf0oduS9niN6PuY1k+05gIzQjjvIRSosLFfJP8NYzR8Lcp2E37k
         U/m5i7p6G3umNYQ3uMJNKNHfLCCeFJj2syQsii4nzeF64tGL4TcqG/pSDqU2CA8OyTcN
         Z8CvBojzxIOzlaLY3xg7UHhDbpaBU2GZMdu6uBcSIJhNrU9q9b4RZNvE7ng1YaU861rm
         m4apeb08c3B5f8bSibfqm+ODtUjuoMyYANqBAB5+SzB6+mJlW4hWOMUzrbLthR38XbiE
         kroaznkiaaD76mho4dGh4pIsV6ZfkY4QThTRq1DXhsbIHGSoRfGhZVB5BKEx0K9IuTHR
         J/Jg==
X-Gm-Message-State: AOAM531nVFqmXAfaqF5A5lExSlmhqAHCvH+zpl1X7M6CSdbICjq8XoeT
        s6Qfg94y9kmR3zcNGmkKzDRQQyaOCXqprDE2QrvhgA==
X-Google-Smtp-Source: ABdhPJyQgfCui8+ZbyhTJRLwncCPT4GDdW7VWSscqDMZqF1XY4ezNuE9uYBObDdaHkFHfxCjWtEIQIWzksQA0BCBWTs=
X-Received: by 2002:a5b:383:: with SMTP id k3mr13411552ybp.332.1590047469660;
 Thu, 21 May 2020 00:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200520052908.204642-1-walken@google.com> <20200520052908.204642-13-walken@google.com>
 <e01060e9-6f00-7fa8-5da0-c9250c951d10@suse.cz>
In-Reply-To: <e01060e9-6f00-7fa8-5da0-c9250c951d10@suse.cz>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 21 May 2020 00:50:56 -0700
Message-ID: <CANN689GXWS9yHTw0aN-tAkd9tyA-vRn0GbJgC+Td=1r13KBZzA@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
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

On Thu, May 21, 2020 at 12:42 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 5/20/20 7:29 AM, Michel Lespinasse wrote:
> > Convert comments that reference mmap_sem to reference mmap_lock instead.
> >
> > Signed-off-by: Michel Lespinasse <walken@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> But:
>
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index a1247d3553da..1bf46e2e0cec 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -224,7 +224,7 @@ static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
> >   * handle an empty nodemask with MPOL_PREFERRED here.
> >   *
> >   * Must be called holding task's alloc_lock to protect task's mems_allowed
> > - * and mempolicy.  May also be called holding the mmap_semaphore for write.
> > + * and mempolicy.  May also be called holding the mmap_lockaphore for write.
> >   */
> >  static int mpol_set_nodemask(struct mempolicy *pol,
> >                    const nodemask_t *nodes, struct nodemask_scratch *nsc)
>
> :)

Haha, good catch !

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
