Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ED920659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589398603;
	bh=D+MMl1eEjVQMrzdkAuYYyV6dZOU0ShG86I8tDOXGHvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Quyxb2IjXCrtFDAwkgbH80wySohKLpaoPY5bMXtSntB8WQt8ONI1TerRmF2QXmntO
	 om1LP8sS2ieJ/AKZnhPv1YVL9u9AN3ljeWjudiXz6Vos6g1SMLe2NeCTCzwFtV5hnu
	 +5nANTZzRubgX1oOluLTyaF4390o8/vO9kBshkkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390720AbgEMTgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390708AbgEMTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:36:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AEC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:36:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d22so504767lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxiMveoP0RhCR8vjDCp/HmQWj731R3On/oP1uZF2PQE=;
        b=eyGhYtEXi8PPzZXswj9fBVzAZ7MKdPyfDFJANIY5Qa8lnG4B6PQlkLIvCnEsRuAYDd
         cijbLp3K6GqvurO+mnvtFYs9Cit1WsfsH6w5mAvZOtdvpGdoJxKX+co3FEMrxzMFBuxb
         6U4kH5ee2J4uHKUOq+K6Hnjpw8SSIL615vIlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxiMveoP0RhCR8vjDCp/HmQWj731R3On/oP1uZF2PQE=;
        b=LIpvtid85Vytx/OQswN5oOep1Rvm6IxnTYzHlbLHH2odRwalmATmvdvghGJcL2xdzJ
         X8Lx6Y8uePrtu3xPDZuu3sw1ZniTFHK/9d+UwFpKQVAsNuvgvWu/Qdz6zZYA/qyFbVVv
         ZSXQ12+An2bKxLb9c4E9CywOqQcfcjTS2G/Xk+BefctrP+88nTQoSdQMZAxkym4cMity
         MqAuhhC8iDDpoBhJirnhIzKWHLXMSz2HH0cQp0HYfs9ct/73arbStSdztpMeWu19gVH3
         hVgSO7Boc+dlWxkDpib7XizhMUjJPhyqQoCvOhlR/H7xDJa9SF2if4nA/w+74lwiQbth
         556Q==
X-Gm-Message-State: AOAM533xC54AVzwewDxNVNsdSJdU/xAUkSOAamuZZNSPyCGQKUJE8+CM
        5BO/3zhLMg6TAyCN/IpcJg4WWDgmB/Q=
X-Google-Smtp-Source: ABdhPJwciVzJzIjdOVNf4UZ1FKYYdFpuK1YuLnjrtiro+ZjTQQNfkLFmzZwJcvm1HKJ/06IpLtcnkA==
X-Received: by 2002:a19:ae10:: with SMTP id f16mr651865lfc.74.1589398596513;
        Wed, 13 May 2020 12:36:36 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g10sm296472lfc.95.2020.05.13.12.36.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:36:35 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id l19so864569lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:36:34 -0700 (PDT)
X-Received: by 2002:a2e:9641:: with SMTP id z1mr394092ljh.201.1589398594575;
 Wed, 13 May 2020 12:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-15-hch@lst.de>
In-Reply-To: <20200513160038.2482415-15-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:36:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
Message-ID: <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +               arch_kernel_read(dst, src, type, err_label);            \

I'm wondering if

 (a) we shouldn't expose this as an interface in general

 (b) it wouldn't be named differently..

The reason for (a) is that several users of the
"copy_from_kernel_nofault()" interfaces just seem to want a single
access from kernel mode.

The reason for (b) is that if we do expose this as a normal interface,
it shouldn't be called "arch_kernel_read", and it should have the same
semantics as "get_user_unsafe()".

IOW, maybe we should simply do exactly that: have a
"get_kernel_nofault()" thing that looks exactly like
unsafe_get_user().

On x86, it would basically be identical to unsafe_get_user().

And on architectures that only have the copy function, you'd just have
a fallback something like this:

  #define get_kernel_nofault(dst, src, err_label) do {  \
        typeof (*src) __gkn_result;                     \
        if (probe_kernel_read(&__gkn_result, src) < 0)  \
                goto err_label;                         \
        (dst) = __gkn_result;                           \
  } while (0)

and now the people who want to read a single kernel word can just do

        get_kernel_nofault(n, untrusted_pointer, error);

and they're done.

And some day - when we get reliably "asm goto" wiith outputs - that
"get_kernel_fault()" will literally be a single instruction asm with
the proper exception handler marker, the way "put_user_unsafe()"
already works (and the way "put_kernel_nofault()" would already work
if it does the above).

             Linus
