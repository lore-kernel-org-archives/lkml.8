Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC64C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5A2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597738711;
	bh=U4epaaykPL5fPcTaFEy5MI2492sDRoxjcdYC/9qc3OM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H+SdDvLFoLoJePoeD3CrMs9JeEebg8rO7ZuhqAHkxL9s+8pSR5g+4JVfLZcDKm48P
	 54eSW3nt9Gh9VycRh3gMNnYnyUYdTFPjTNTxc6shjGRR0z6AT1+v0OyTKeR392x9bd
	 CR1qqYXdB2HNJFrkAE4Hf58QvFlTvianT4i+56fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHRISa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgHRIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:18:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11ADC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v15so9746380lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ldPLk00zDl2npSmv8Uf+w008g6jg8ITcXg6uW8fPbI=;
        b=eqS+9xjC9jrTPy363gkpZ79QjRN6vwbFjXLWnrbmOtoQbECfwf8F3MmNNWLOcGXLsj
         lD8wFsXw7H0WFpfmvhD3Y/1WbazKHmesFqPISyLz0ng3WqcJkAoAFslskN26G18JkPL9
         MBhIc9KTitsEhfzTiiEcYUBJYgyu4pB9nemZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ldPLk00zDl2npSmv8Uf+w008g6jg8ITcXg6uW8fPbI=;
        b=M78nD/P+yE7ZygCW6F35PKM09Y/FaImSPSGV99QR34Atx2KLKqcgYdEQVm2K52iOvb
         VQVjE2Xl9cQxhh1B2L+IPgaQdAFjZh1C+jifS5acc2muzkCCLNJo4We51KKBK8493VrB
         TCQj9+9t5eVyNsXzzCARzX7By3tkopsFQzmJTKBT0SUu2T80YTJ2SUKqUHsvB1yB8dNX
         Nq+jdaUJ1niBbeVuWgHjJN2/7fr+6X9U7sl/0ER+Ddc1c5fD9LxloQ/pXEY31wKBvVYo
         HzjIhZTD+MGSyKDpmHGT86ONwh/GmcNKJc3Jv3VW0wM1TiJa4cIOy0rOoNDaHv6uN0A5
         f3SQ==
X-Gm-Message-State: AOAM533npK3DWsOn27NNn1ESpmwyIg0rOVRXVEZ0U/OkaWc5aDUSeWDN
        VRKlr+cTwYhuPEjcTUXtYFtkaMlVOLumxw==
X-Google-Smtp-Source: ABdhPJyL/mRgfBQB8Xyp843k3OiLg/vBr/X5Hm/bdjU2eYhdH4unC06EOCZSIqZHHa0VoqyfrBjnsA==
X-Received: by 2002:ac2:530e:: with SMTP id c14mr9167328lfh.127.1597738699973;
        Tue, 18 Aug 2020 01:18:19 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d14sm6270037lfj.30.2020.08.18.01.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y2so11451476ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr9791504ljf.285.1597738698039;
 Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-5-jannh@google.com>
In-Reply-To: <20200818061239.29091-5-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 01:18:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
Message-ID: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:13 PM Jann Horn <jannh@google.com> wrote:
>
>         /*
>          * If this looks like the beginning of a DSO or executable mapping,
> +        * we'll check for an ELF header. If we find one, we'll dump the first
> +        * page to aid in determining what was mapped here.
> +        * However, we shouldn't sleep on userspace reads while holding the
> +        * mmap_lock, so we just return a placeholder for now that will be fixed
> +        * up later in vma_dump_size_fixup().

I still don't like this.

And I still don't think it's necessary.

The whole - and only - point of "check if it's an ELF header" is that
we don't want to dump data that could just be found by looking at the
original binary.

But by the time we get to this point, we already know that

 (a) it's a private mapping with file backing, and it's the first page
of the file

 (b) it has never been written to and it's mapped for reading

and the choice at this point is "don't dump at all", or "dump just the
first page".

And honestly, that whole "check if it has the ELF header" signature
was always just a heuristic. Nothing should depend on it anyway.

We already skip dumping file data under a lot of other circumstances
(and perhaps equally importantly, we already decided to dump it all
under other circumstances).

I think this DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER hackery is worse than
just changing the heuristic.

So instead, just say "ok, if the file was executable, let's dump the
first page".

The test might be as simple as jjust checking

       if (file_inode(vma->vm_file)->i_mode & 0111)

and you'd be done. That's likely a _better_ heuristic than the "let's
go look at the random first word in memory".

Your patches look otherwise fine, but I really really despise that
DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER, and I don't think it's even
necessary.

             Linus
