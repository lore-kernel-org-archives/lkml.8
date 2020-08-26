Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57872C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE12078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598462114;
	bh=3tiogIcS4nGjoUQ9FUtNefH5ddVGV6tiBQKfkvzB2Ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SLNihJE7MzPvXsPCRB6MT19+dIj1QsvDLmy/UkbgAdy3yuZvJ8jCvMkzhkoK4UwJK
	 wTGwJHQmB1k+42dsyZPm7aLwlwHDlOswvw+0W0J3vnB7pd/8Y65curTLmceab0kiaQ
	 Kkijfrz3VJ50Nap3zPDlZVIKZdfqevaEoBqe7N3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHZRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:15:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E582C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x77so390341lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP9JT9RZ6cg16XibPhu1WP9qLmnAItWF0Fa2z1UMDZI=;
        b=gnE/PuzwUiR5nbYEU0P+4LWH2qyES1j1Z881X6oEA+lavFprJsQaKzOFd9+1tsnfM+
         e9OfyrazJJTWB/GksaUDWytv75fKgS0GnX+tCaBCitTlh8Ksllt4L6s2t89+ILGxAL4S
         TMmZy2nzqRMYH+qmpOU92kllkom8B8DMMf7fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP9JT9RZ6cg16XibPhu1WP9qLmnAItWF0Fa2z1UMDZI=;
        b=DAZrHBYR5hicztMgeDdhGRAHALWnoLNCChx7c4ZutTlPA0II97n8GmbOnKVFuLwcU1
         qLM3JxOFaZLkwKhZmAlaedswtrMogguWOep9DVU8qD+euGmVW7o6pdZ0nCJ4gPFyYgAv
         zfwU7jOb2Qb9wehpFcBiZicPUgcXLHApIH3nlZAxccAxGBFOSOIdmETBJemb2jcZB1qr
         E6ESPPQAPt6TF3OBd98bB75yuoaEjFxyEWZhU9F3o+GXDcchPX8bu2TFRolVun2nAHWm
         JUyStD0eqXBy26oqvBosMp1360hjy0Sn6xjMrtPPA1IbMyOMW9NQLx9bUsr1PZz+RyOS
         OAAQ==
X-Gm-Message-State: AOAM533MBBQxyNs+iszGKgCVr18jD5WYHgJKwLMvCnAsCEYA8+WKs0wv
        4r7G6gOFRJNZw12HmGd5yBrZfHwhfzpaIA==
X-Google-Smtp-Source: ABdhPJyEgrWEi4HrXEowQEF3eDe+7hiPHdHV6B93q8UWv+W7RYW3DoIQNSYpwEAFEOFphOZ1cwIFtw==
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr7975979lfo.116.1598462109015;
        Wed, 26 Aug 2020 10:15:09 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d11sm359467lfq.20.2020.08.26.10.15.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w25so3217739ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr7171003ljh.70.1598462107068;
 Wed, 26 Aug 2020 10:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com> <20200826151448.3404695-5-jannh@google.com>
In-Reply-To: <20200826151448.3404695-5-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 10:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYkiyOKvBG96EaP5BgXeppXVC2rPv56bhBR27C9sbDLA@mail.gmail.com>
Message-ID: <CAHk-=whYkiyOKvBG96EaP5BgXeppXVC2rPv56bhBR27C9sbDLA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
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

On Wed, Aug 26, 2020 at 8:15 AM Jann Horn <jannh@google.com> wrote:
>
> A downside of this approach is that we now need a bigger amount of kernel
> memory per userspace VMA in the normal ELF case, and that we need O(n)
> kernel memory in the FDPIC ELF case at all; but 40 bytes per VMA shouldn't
> be terribly bad.

So this looks much simpler now.

But it also makes it more obvious how that dump-size callback is kind
of pointless. Why does elf_fdpic have different heuristics than
regular elf? And not in meaningful ways - the heuristics look
basically identical, just with different logging and probably random
other differences that  have mostly just grown over time.

So rather than the callback function pointer, I think you should just
copy the ELF version of the dump_size() logic, and get rid of a very
odd and strange callback.

But even in this form, at least this patch doesn't make the code look
_worse_ than it used to, so while I would like to see a further
cleanup I no longer dislike it.

              Linus
