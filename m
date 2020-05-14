Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C89C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E260F207BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589424226;
	bh=UwFK1JSh04uU+EKtoD0SWRBNbvLzPgcTZDGhixl8HcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S+oSSkZWQEQkWONFmopcnVbNZXObJd9EGY2Jahda3I6tu1BFD7uDLnFW/iQPCrUJG
	 4QXysX/hrKdnoEb/G+clFmQIVLaHKstqJ4kgYk5VY7m8AemrtvhDZehmOzGtTJd+Sf
	 XTEEbETylwFaionqPAIyuNBdwt9fcOoJb3EvIoEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgENCnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgENCnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:43:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:43:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so1843350ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3In83ZNtvhCqrpK0vVjzsKNvprMyvL+zJ9ohua4z10=;
        b=RJxI7nc5/+qicT+av7MVnCPyCWQNYqEmo+1I8aEDjYrcgsKm1JO+ximEumc2BGCHG6
         IRKjgEiRjwQuoza3oL4WOrhIpbRc8zh7pT5r3iUQzrEjc7+dcHsaKetaMFqukCgIbr+Y
         1swtCFlefWtGVUfsLBR/jTXuJr1SgZ0x45QhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3In83ZNtvhCqrpK0vVjzsKNvprMyvL+zJ9ohua4z10=;
        b=WazOw1lSKPioK2lPoQAY4LVzSHNd+Dhg6+UAp4hbSXrpBjgqg/40eNfLXCLZ+KawnT
         JUwquuGhvvviuHPZcTCLWKrVMw3OXVlAc+J1j6PmxrNE7C8HHGa/xhhs06gdPOf6hzd0
         V5Aa3NKwHDw+IWv+W6CivHom59Xy7rA9ljTSGAREQ3++pBHVTobK+aYg7TvWWnOlt89c
         b2xh8tJTeFgolUFL/gNSQOnX8E7fC3THWhyFNSIleG0wxIYU2qahsiVQFUxrB+kGc8qr
         KeQtBZllOcDkE1UMFXF9eKVcKg6kjwaBS9/frphl7b7do43sXiQLqTuZltT5f8lNzQv4
         6jaw==
X-Gm-Message-State: AOAM531P6xxqXEFm4d3UCiG3IiB6F9073nPg2GmqIVTQx1K3Uig7nDgL
        NsROlV4or+wHWCrGuvEN2U3ngQCtzpc=
X-Google-Smtp-Source: ABdhPJzaOENhdDJCrE1kvuOJHW8TqOb55NqDnPw+NTDyIhSrdrP6veWL7AQRgNTkIOi/V1oFZbRImQ==
X-Received: by 2002:a2e:5847:: with SMTP id x7mr1201812ljd.61.1589424222614;
        Wed, 13 May 2020 19:43:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b25sm605236ljp.105.2020.05.13.19.43.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 19:43:40 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r17so1257801lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:43:40 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr1567307lfk.192.1589424220085;
 Wed, 13 May 2020 19:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org> <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
 <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
In-Reply-To: <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 19:43:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP8ysEZnNFi_+E1ZEFGpcbAN8kbYHrCnC93TX6XX+jEQ@mail.gmail.com>
Message-ID: <CAHk-=wjP8ysEZnNFi_+E1ZEFGpcbAN8kbYHrCnC93TX6XX+jEQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 6:00 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > But we should likely at least disallow it entirely on platforms where
> > we really can't - or pick one hardcoded choice. On sparc, you really
> > _have_ to specify one or the other.
>
> OK. BTW, is there any way to detect the kernel/user space overlap on
> memory layout statically? If there, I can do it. (I don't like
> "if (CONFIG_X86)" thing....)
> Or, maybe we need CONFIG_ARCH_OVERLAP_ADDRESS_SPACE?

I think it would be better to have a CONFIG variable that
architectures can just 'select' to show that they are ok with separate
kernel and user addresses.

Because I don't think we have any way to say that right now as-is. You
can probably come up with hacky ways to approximate it, ie something
like

    if (TASK_SIZE_MAX > PAGE_OFFSET)
        .... they overlap ..

which would almost work, but..

                 Linus
