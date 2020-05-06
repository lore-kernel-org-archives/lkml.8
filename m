Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899F7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA68206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588787900;
	bh=0K0aE2bw8O+D2zxuH1nVtjWOjmncOreUUbvjPVB9+3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1lY1TTGs4n1iN0UH66+/ZPCIIRhutuzJ8etlgrYN0Uu6ccHKsHi7lpj2CZvI3ZEST
	 vJCc/s5aa6SkUlGFfGr8snipT5dTrkLAd5NFkd10foG+vE/FjWEbQG0DSwHdp3nbpt
	 9xC9omU/j8mYyXqG2YIlc48VpGabfCyBz8wD3GmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgEFR6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:58:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9975C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:58:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so3322718lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amhqtC0jx3Soa4PMXxAnnhfkbBJzW3RmXIKW7xjvTm8=;
        b=HgJKLXT1DdNyq51LO7Yajpy+kFP02OcEtgqoKUtFS1yGSN45VqntoJwH+X2ojFI5Yz
         VanVze+sYnLUdhLxZWaCjc0lht8OTs/pF6rfb8vQjJNFuC8VJ1vNt8Biip5j85VsAxzZ
         GcH0M+IVfjrqrmfFOzxxtIOPztNPNJHUO70hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amhqtC0jx3Soa4PMXxAnnhfkbBJzW3RmXIKW7xjvTm8=;
        b=RjRxZP8Dvb/vkghjdmMGn27FRZUw/WN+u1cCW5GSizrHz513VXhmlfe7kRNpXyHTym
         +L6izLvcP60ToKrvxz9jVbD9X+DeQtiuwOiffhDrwhzMyevPkqCBVavBhFSGckHOOBfI
         veZKurZRubO3Xwg/g7BZYfg3TcaUhy9J578nbJUTFuq5M1HG7lc1ZslJfEju2Ge+PHxe
         bzv5ZKvQ1HrFBaKTAlpD0pHgXyToF0OAQ7o26JEle4dcH8wGwzLac6/IDD3uj3O8Y4fc
         7TJAY702pZ6FuTkJyPHA1SGg3eo+4WdODsW/sTmrEVZcp12dduh6eJKYPuUy7jLZc/LR
         i0Dw==
X-Gm-Message-State: AGi0Puaw4jqit3VivCCfvHFRjT7XFGhemcORJHouMwwWoBkCVsLyOadK
        LiwE9D88BJ+/xEkjYJc0XOsxCZn0x/o=
X-Google-Smtp-Source: APiQypJvyhLsJWyypDh9mdBd3tQPZnRzVLclLLhxvRDZOxREU1aiEVnxOYKU0I8s1HOEjsjPfeQnRA==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr5759500ljj.90.1588787895632;
        Wed, 06 May 2020 10:58:15 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q27sm2012126lfn.58.2020.05.06.10.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:58:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id a4so2105672lfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:58:14 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr6180281lfh.30.1588787893824;
 Wed, 06 May 2020 10:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de> <20200506062223.30032-9-hch@lst.de>
 <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com> <20200506174747.GA7549@lst.de>
In-Reply-To: <20200506174747.GA7549@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:57:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_tQpDnrODW0U1kd3+BzuGtan4353fu9AfWdrpMcv3Jw@mail.gmail.com>
Message-ID: <CAHk-=wh_tQpDnrODW0U1kd3+BzuGtan4353fu9AfWdrpMcv3Jw@mail.gmail.com>
Subject: Re: [PATCH 08/15] maccess: rename strnlen_unsafe_user to strnlen_user_unsafe
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

On Wed, May 6, 2020 at 10:47 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > The fact that we have "probe_kernel_read()" but then
> > "strncpy_from_user_unsafe()" for the _same_ conceptual difference
> > really tells me how inconsistent the naming for these kinds of "we
> > can't take page faults" is. No?
>
> True.  If we wanted to do _nofaul, what would the basic read/write
> versions be?

I think "copy_to/from_kernel_nofault()" might be the most consistent
model, if we are looking to be kind of consistent with the user access
functions..

Unless we want to make "memcpy" be part of the name, but I think that
we really want to have that 'from/to' part anyway, which forces the
"copy_from/to_xyz" kind of naming.

I dunno. I don't want to be too nit-picky, I just would like us to be
more consistent and have the naming say what's up without having
multiple different versions of the same thing.

We've had this same discussion with the nvdimm case, but there the
issues are somewhat different (faulting is ok on user addresses - you
can sleep - but kernel address faults aren't about the _context_ any
more, they are about the data not being safe to access any more)

Anybody else?

             Linus
