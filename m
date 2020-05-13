Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF09C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09978206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589399357;
	bh=GYbsmH5lfKgxq6blawT++E5MS+pgYLhbHB3ft/FdgTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0nBxMmPcWtxmveAQKcxhEJbU4c//MCKpGiRuy7ZSG2pOC43HL4WlTiPP9naK3OoHF
	 6MPrBdNcJyeEpTnfkqrNPUGMjWFJhqJJLFV9Qu547jJFCHrZjfp0CJv2yVufwi1ci+
	 +7QkNH4x1cZB54rhVnJiNODf/H2hjOE4Z0TZZawU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbgEMTtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390696AbgEMTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:49:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE64C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:49:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 8so573067lfp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO5CZycJoj3SG3fGwN+WTopK/LhbyP0lsfj2E+DRkX4=;
        b=PhubPRzpkCdl9mVPHrG9Oo8C+WwrKBHaeYw/BPL1ZhM7m32uY9vOkxzag4IPR45vmN
         nCyuee+AoItBB8/CS6j7/cO2lxt0a4Fuet7ze1acDgZYlgBMc3l9Izqr8rAmG81U3hf8
         E+jYDPSfclqu+31+e+LKbjbSmiBTvos3Qrvk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO5CZycJoj3SG3fGwN+WTopK/LhbyP0lsfj2E+DRkX4=;
        b=H2GjkOoxZ4dxjDNCiorKuoLJzjDYHj1vLXLDHI9vts0lY4ZJ3I8wKA61VxfAfH/Lqd
         OIWAwlqvB8YPJVRYjrSnmHfImD+W+XXXKoiDnBIymSCPBUm0AqvJrDfZfTBPuwA99NAZ
         ARQL8CIGYFinRpKbM9bVE2nzpDVj4krKeD3GIwL3e5xgHlpe4HAnP8IpavnsslCHIOyQ
         7pMwdJWuVzRBj56reBHNBPrHEvhl02cQWLL5BDNuxD6kuZDZkt8RvOyIFi/SvhQVdHgG
         xHuIic2Nor5HkMKD+TF2z6Dy0hCn1lNUAB/zjwMMWsk38eC5aAn0vte+tVKIrkN8o6pA
         BWNg==
X-Gm-Message-State: AOAM5313kvHxq91UwOfXRQo9eHOgNYartiM+zBuqNnjsqwtWNY9zky7P
        DQMhkRSqFKEWXkTWAhozlyPYyjRshuE=
X-Google-Smtp-Source: ABdhPJwC7LSIy6tuvuAYhod1sWIibAXIE1hV7tLzS/s4qCIwpeusXFYhQ6Jz9yahGTDHZc0MSNxxjw==
X-Received: by 2002:a19:700b:: with SMTP id h11mr741234lfc.62.1589399352383;
        Wed, 13 May 2020 12:49:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k1sm333744lfc.40.2020.05.13.12.49.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:49:11 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id a9so548520lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:49:10 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr739476lfo.142.1589399350490;
 Wed, 13 May 2020 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-15-hch@lst.de>
 <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com> <20200513194003.GA31028@lst.de>
In-Reply-To: <20200513194003.GA31028@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:48:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
Message-ID: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
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

On Wed, May 13, 2020 at 12:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> We do export something like it, currently it is called
> probe_kernel_address, and the last patch renames it to
> get_kernel_nofault.  However it is implemented as a wrapper
> around probe_kernel_address / copy_from_kernel_nofault and thus
> not quite as efficient and without the magic goto semantics.

Looking at the current users of "probe_kernel_read()", it looks like
it's almost mostly things that just want a single byte or word.

It's not 100% that: we definitely do several things that want the
"copy" semantics vs the "get" semantics: on the x86 side we have
CALL_INSN_SIZE and MAX_INSN_SIZE, and the ldttss_desc.

But the bulk of them do seem to be a single value.

I don't know if performance really matters here, but to me the whole
"most users seem to want to read a single value" is what makes me
think that maybe that should be the primary model, rather than have
the copy model be the primary one and then we implement the single
value case (badly) with a copy.

It probably doesn't matter that much. I certainly wouldn't hold this
series up over it - it can be a future thing.

         Linus
