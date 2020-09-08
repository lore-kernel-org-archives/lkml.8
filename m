Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAD6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A4921532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL/xrscW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIHEma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgIHEm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81ACC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f2so14247413qkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uq+qFUrJ5V3Owi968MrkvbmJ4ZL9M9F0MoSjvYJeOkg=;
        b=PL/xrscWG5Ye5/vZMkh5964OctYckdksblwZvxTmONwsMvw5r9zAABOWZjw5krdC4V
         T9M5QrFRLV7/3cFVTcAeHG+SrheEdLZ7fYLnrkXiIUuTQgGX85hTO9PQJnZmc3XlKdwP
         +OkykUcfSAuoweLyzc0FP4dw9QtnL9h/qxbWeJE0SMn2rCxIsAUhQpdfywSFBQZJMMEk
         0IMLE/cDxdx0kSjr0LvAPPhEKeIcE4MtOL6WN8bQosHvJyGf3AvxnF/q7GQQmadfMyVP
         U3zASd20RBOVFt7Yo5YXIKU1/Kct83KCB4RVKg6S26c1ErXs+TO/gmD1LguXREUfrD2r
         Cklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq+qFUrJ5V3Owi968MrkvbmJ4ZL9M9F0MoSjvYJeOkg=;
        b=CatTJ4a6FlrkE9PPMh1sn16dyzu7rrPXaX+HVJkLrzLjHxjrRcnYr8JqgYsF+5Rpb0
         +r1J5FE7BrbnfK7Y+afAlJcSK0OgGvm+MHKWHLHOBS+5LvdvrnI/tpbDZIB7qQ0bjTp+
         BuuYzcBxJkDIs/GDApl+NM3g1q6txNZ94reX7rsX+QmRMLGApRga+eYyeOPiuLOUKdi0
         VQT/qwQv19F4Wjyciolwo+GXqXHkY98N+ocEVhgUYOZASSGnrY83I3b6eX1iKu1N0X44
         OGeyVjt6e8SPOdcoU1ssDf/xoWZfGj6jxrb25evstMhboAsoGs6XIFFWZfuGz5ojkFZl
         C2ag==
X-Gm-Message-State: AOAM530zeNCqutnesR+Sst2737nQrIGyZD9L/3ybAbSd0sg93rggTgv5
        ZJBwkFKezUUc9nEzq31h/pc=
X-Google-Smtp-Source: ABdhPJxoLHP8cE9Wtg/pmuQCyZU9lVcGRDNMrVExxFnAv5xtLkKMhAyZ9scje9ePMVT8z6yNyZAPVw==
X-Received: by 2002:a37:9c55:: with SMTP id f82mr15084616qke.123.1599540140881;
        Mon, 07 Sep 2020 21:42:20 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id q35sm13514397qtd.75.2020.09.07.21.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:20 -0700 (PDT)
Date:   Mon, 7 Sep 2020 21:42:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
Message-ID: <20200908044218.GB1422621@ubuntu-n2-xlarge-x86>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200907161230.GA2149325@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907161230.GA2149325@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:12:30PM -0400, Arvind Sankar wrote:
> On Wed, Sep 02, 2020 at 03:59:04PM -0700, Nick Desaulniers wrote:
> > Adds a compile time #error to compiler-clang.h setting the effective
> > minimum supported version to clang 10.0.1. A separate patch has already
> > been picked up into the Documentation/ tree also confirming the version.
> > 
> 
> Is 10.0.1 actually required or could it just check major version? I have
> 10.0.0 currently and at least x86 seems to be building fine.
> 
> Thanks.

There was a decent amount of effort put in to testing LLVM 10.0.1 and
making sure that it could handle the kernel. I know of a few backend
errors that were fixed and backported to 10.0.1:

https://github.com/ClangBuiltLinux/linux/issues/944
https://github.com/ClangBuiltLinux/linux/issues/954

Plus there was this rather nasty ld.lld crash in 10.0.0 that just
x86_64_defconfig triggers with mainline:

https://github.com/ClangBuiltLinux/linux/issues/962

I do not have any strong opinions around checking just major version but
I would prefer that we stick with 10.0.1 because it has been tested
against several kernel configs unlike 10.0.0. However, I know that Kees
mentioned that Ubuntu 20.04 shipped clang 10.0.0 and there is no 10.0.1
available yet. Presumably it is coming down the pipeline from Debian
since 10.0.1 appears to be in testing? I suppose if 10.0.0 is shipped in
multiple places without an easy upgrade path to 10.0.1, we should
consider softening up this version check, at least for the time being. I
just worry about duplicate reports.

Cheers,
Nathan
