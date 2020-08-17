Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6502063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFGxBcVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391134AbgHQScW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391099AbgHQSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:31:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D483C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:31:48 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u24so14523608oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vrg7EhUgrz2VdstxenWZe+fFP5TU9hDojaa4QJfF8Q=;
        b=FFGxBcVrsCK3kZxxpp0xdbyTLkr38HtMmdBLK6Bw4YRVzpqNO82/hFuBoxcvyxUFWL
         6AgYs3ky0EsBljZ7rvG89bUG/fOWnA0vXF8WkH6jEpDZ0Hq+fSTU7ESMK6lggbTIYDKb
         jToXVINrc4na3UGH7Lp+1DgbaGlQDt1w129MV+rhEpPGxFEb7AX1+BxD3a7hO+9XRvxt
         A1P4ettWmugiQ/XRpRmCgvuAAr3nnVmLE6tBBEeapp5DNcnZS5cOA54vCkrD4v5WSVxS
         uU4tJcM2FILVMcFe9rsnraa22lzhbidvk93iA30mVdhW7Lt+Un4BRuG3YvqR/QkSSLi7
         oelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vrg7EhUgrz2VdstxenWZe+fFP5TU9hDojaa4QJfF8Q=;
        b=GJpnqgTUD9Xc9ymXAhyBh/uZcqSu+KQQIwZsmBXb5GkwNbqnft7PcFUyhMORVEsUIc
         7Ry8F3RnL0uLrZylzYWMlib35b/mSMEjaJij/NMNNgdswm04MjgG1w7384ER7g5BpNwz
         CMJwFOol+gshDe4r36b/E1HKeRFZ5CfIbz9n1v1rx4P8oom4QTl3XGEuqoYtjhvxHiyu
         m2pS2q/qy9RpVmEu9knUVnqXCdbcaMGD68KKaYGuzFvNWCOX/OAcxwoyYDP9Bm+JblJE
         Of+AzrGQsdjxs5oYQZWh9PYoh/f3TOv/aVhSi98ADb7fs43/XXVpTGPPbtCGT/CZA0kU
         TCPQ==
X-Gm-Message-State: AOAM530xuEQQ9IUALOEamqV6KnvPKWvGmVtmdetdCkxk6iaYKHN8xOrN
        LLQqFNZCpDC5kcAEQAdi/FbAlVDAEn+UDbzR5gVj9g==
X-Google-Smtp-Source: ABdhPJzRGE0rsOwGqhxO5Txn/GqpQrCcaK3fAH7lCRwMJgEYHd/TDNlGN8e9TKdGBSmDI6Sc9mVjt7HYkQK5W9W0egE=
X-Received: by 2002:aca:d4d5:: with SMTP id l204mr10539438oig.70.1597689107235;
 Mon, 17 Aug 2020 11:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160627.GA1420741@elver.google.com> <CAOJsxLGikg5OsM6v6nHsQbktvWKsy7ccA99OcknLWJpSqH0+pg@mail.gmail.com>
 <20200807171849.GA1467156@elver.google.com> <CAOJsxLEJtXdCNtouqNTFxYtm5j_nnFQHpMfTOsUL2+WrLbR39g@mail.gmail.com>
In-Reply-To: <CAOJsxLEJtXdCNtouqNTFxYtm5j_nnFQHpMfTOsUL2+WrLbR39g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 Aug 2020 20:31:35 +0200
Message-ID: <CANpmjNNhG4VuGq2_kocsTD3CnCv-Y4Kvnz7_VuvZ9Eug+-T=Eg@mail.gmail.com>
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 at 21:06, Pekka Enberg <penberg@gmail.com> wrote:
...
> Yeah, it reproduces with defconfig too, as long as you remember to
> pass "slub_debug=Z"... :-/
>
> The following seems to be the culprit:
>
> commit 3202fa62fb43087387c65bfa9c100feffac74aa6
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Apr 1 21:04:27 2020 -0700
>
>     slub: relocate freelist pointer to middle of object
>
> Reverting this commit and one of it's follow up fixes from Kees from
> v5.8 makes the issue go away for me. Btw, please note that caches with
> size 24 and larger do not trigger this bug, so the issue is that with
> small enough object size, we're stomping on allocator metadata (I
> assume part of the freelist).

Was there a patch to fix this? Checking, just in case I missed it.

Thanks,
-- Marco
