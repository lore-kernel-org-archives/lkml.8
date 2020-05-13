Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D3F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589414404;
	bh=4WYyMaGWG9a9nFYDIlkg8Bpp7B8l0nT3fSfWhGSXUN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A6UG4/g9e3Juv0LGePzSJjUsyXRJ+hnOQ5DAmvI2xpGsHqXQIepKw5NxlrubIxAVo
	 c6imBOqrLI4Q/422A2tEMoFpPW9j3VO0nfyV3xFePNTu6WPK07RPUW3XFO7A4tGkvJ
	 ZUjDNo0cF7oXWC/rLo9yMChzl3UF1PUjJd0Bbd1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbgENAAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732861AbgENAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:00:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D5AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:00:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so1048178lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fasYih196bvKUHb0YCxHna3fp2u2qNy7HWnYHVsQ+sQ=;
        b=fD3hyHvKHx/67q1VTFKCR74zDcE6394aAhGXhl0a0C48TMMb4AnhPQvs7IdErH6CX2
         um+ec95QL1F0EfXLmER3SmoJ0T+gygc4SnxysABRELnzBjVWudgYOLaUmLBf8bjna0/G
         B5XXX5vTTIkGXj8ZYK86YltWbiai+htzLW22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fasYih196bvKUHb0YCxHna3fp2u2qNy7HWnYHVsQ+sQ=;
        b=ELoPvN5GAW/MDWu5WAUMxBmHPeDIfM488+Zedp3Ohsk3SO35uVH9PrnmnRXP0MKidK
         MNxSKIVNsIquddo0PNV0pGMhuKeMMYC8FVYPy63nGHh71Uu/Phoz1xk4zuhS1s2KCBTI
         xYBawDz5XhuRzg8up/erbPWCDDp32PCRRyVXkLb+pG2wSxx8Knvy2t18RqAdHJ5KXQVe
         WiRiCjuiOQ/dmH+Qz2Xs7qVpnGRHGRsa7Zra6uxBTF8KXLTfv5sC+j+g8o/PYBbsYBay
         PoXVqNrOHc0Nz8EMc+chraosDPVNn3TtPYi1F5lqgvElVaXf3Gb6sBmq9PFDxuGGc89u
         hmiA==
X-Gm-Message-State: AOAM533mauqHCP/3Ns936FA+rQQ6L2F4q94CF827Se8ZnXDhbw1nSQ3x
        scUHB64txblBafBhz5BtSJB8StTlSVA=
X-Google-Smtp-Source: ABdhPJzRR0QZoJLKFPK9f4tKXBKScX7lcQDCgbug4GCKcqyoVmvzNxTdVqSNPI+laQoRaVj1Rq1kOQ==
X-Received: by 2002:ac2:4a8d:: with SMTP id l13mr1249662lfp.213.1589414398518;
        Wed, 13 May 2020 16:59:58 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 66sm85914lfk.54.2020.05.13.16.59.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:59:57 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u6so1516485ljl.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:59:56 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr857486ljp.209.1589414396039;
 Wed, 13 May 2020 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org>
In-Reply-To: <20200514082054.f817721ce196f134e6820644@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:59:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
Message-ID: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
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

On Wed, May 13, 2020 at 4:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>
> For trace_kprobe.c current order (kernel -> user fallback) is preferred
> because it has another function dedicated for user memory.

Well, then it should just use the "strict" kernel-only one for the
non-user memory.

But yes, if there are legacy interfaces, then we might want to say
"these continue to work for the legacy case on platforms where we can
tell which kind of pointer it is from the bit pattern".

But we should likely at least disallow it entirely on platforms where
we really can't - or pick one hardcoded choice. On sparc, you really
_have_ to specify one or the other.

                  Linus
