Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC268C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A343920672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586194437;
	bh=a9Q9bY5sL351gXQoXo/qYHaOKfrzykIuOUjJovyYvC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=knCG8Waf3Oz/cBjaPpw0CUzcHGG22s1WJbBpW6oVOHmkhcA/fJAlGZ2xQIStLOdCI
	 PgVWHV+M8fNtZCNnD5GwyhOoRT4D4hwOKoYDX9B/kEnaFJ3Ni99iXTpZiP/m5jdEST
	 pP78sLBTzCWG5kzypI0xwF6R+msyTgVWRfZHeMfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgDFRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:33:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33367 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgDFRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:33:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so189841lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crJk+8BSj7iZamojeVRuNeQnx02e+aby3GgDMVtCX+M=;
        b=HaLctUUehIorhjsFq2+glIghQf2BJmPdCNRSdW6INhtT+CNtKPXSUUdlbD3pPrqHdo
         wDYu2EbJxV6gfWowAwmLB4BPQOe4BovD3e0D+cJzgLkc9/NAEZMZJ7fAcUfbzHhYkKJa
         iUPkBc9zIba7IkGAJ4Fs2BcVc+k+RQ3ovwnxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crJk+8BSj7iZamojeVRuNeQnx02e+aby3GgDMVtCX+M=;
        b=GRvAErOzJJphWODiqVHPtzSadwO0/5kuVXHny1ts1elSUbMjRWwW6r5G5kKx1q4jf3
         T1Lr54Z64RcyGDoL2iGA1sXmmC3ujqfQAsFF7wMkAvuMWwjXo0X0MttiiOeTn4wcP5Ff
         UiRc5ijU5qt/jPmAM2/htZ48fjCIXCY3OpoEF3k67BbNBdGY/yjf1wBPzEm/DB1i+vaH
         Ny+IEEhXkn1vMl/3r9E9Ngp2mC9nkMIG8o0o3lH+UgGwKEo0Ukjj5kuMiIPzGArAJbKj
         j4uOYAaCi5oEWyWRHmY2TLENWtbqocvqNm0tyO4hPhcKaGoU4IBlKtEOkA2FobymAGre
         h4Rw==
X-Gm-Message-State: AGi0Pub/OvU0Oj3iNuMWfuQlE0Ib3kfvta0F5aIzA6zXFQj4w8hCGLMY
        /+E82WyauAlom+z2q60ILKj8f/UcbwY=
X-Google-Smtp-Source: APiQypJK0+DEjtpFZA92Hu7W0fVSkZ7U2h84BsO50SEpIkKoN5kQ0iXOUlfOIPzB0fc1CNg1OqYbTQ==
X-Received: by 2002:a19:c64b:: with SMTP id w72mr13817427lff.82.1586194433675;
        Mon, 06 Apr 2020 10:33:53 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id l13sm10349613ljc.84.2020.04.06.10.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:33:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b1so607975ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:33:52 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr190977ljc.209.1586194431768;
 Mon, 06 Apr 2020 10:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
 <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
 <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com> <7eb36a794df38c885689085618a8a4ff9df3dd2c.camel@perches.com>
In-Reply-To: <7eb36a794df38c885689085618a8a4ff9df3dd2c.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:33:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=zTfrjXbFp+yhMpjH5jyx=t5fcDVmYN6KpE9Tjxb9YA@mail.gmail.com>
Message-ID: <CAHk-=wj=zTfrjXbFp+yhMpjH5jyx=t5fcDVmYN6KpE9Tjxb9YA@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:22 AM Joe Perches <joe@perches.com> wrote:
>
> API function naming symmetry is good.

BS.

Naming should be symmetric if _use_ is symmetric.

But if the use is completely different, then the naming should be
completely different too.

A symmetric naming is only helpful if it implies symmetries in use.
Otherwise it's actively misleading.

In "kzalloc()", the z is meaningful and an important part of what the
caller wants.

In "kzfree()", the z is actively detrimental, because maybe in the
future we really _might_ want to use that "memfill(0xdeadbeef)" or
something. The "zero" part of the interface isn't even _relevant_.

See? There is no API symmetry. There is only a small and immaterial
implementation detail.

We don't put an "l" into the kfree/kmalloc names because they
internally use a percpu list to manage the allocations, do we? That's
a "symmetry" too. But it's an irrelevant implementation detail that
makes no sense to the caller.

           Linus
