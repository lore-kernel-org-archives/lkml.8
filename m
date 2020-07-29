Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4590F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAXXkxLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgG2Ioo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgG2Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:44:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49448C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:44:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so18733443ilh.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDpsIzFQs4UostU3d175HM40L3ctsRPQboCEBf+fEY8=;
        b=vAXXkxLlLmo3Mg95KzzQSAigRBzjV4MgGii1xUhDlEMWoxREn8MvV3c+iQaa8F9Lyw
         H5dESD6EsGSQgaRQYd1PxIjahmNGz+jUufXsS6QXFFL4MSOx4g6UYfRWMGI4DE9SrTFu
         rwBeYo3gA7HBkYwZvhBlBeVrHokWBM6Oin/4lTOrDXgwpMh4jAWjEImgj0QlXMRg5jRS
         1cZ17U6nQU+HO5EBvzQmhME+Y+wMHFenzKaGSNCufKfqIiMuAjoMZ/p81M45NDta+ff8
         KG9M9bvv+b7VTtxaE4NhJh/li3ViMAxDNeHQQv83gTtuqYl4EsBzwGJVSnDOv7w+P4Aw
         EefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDpsIzFQs4UostU3d175HM40L3ctsRPQboCEBf+fEY8=;
        b=AuRxCticuPi/8O9AmBfk6EXCs+ioIYyc+qQ9IVeERPNP31T8T3m+lZmS1Eua9SjVmT
         f1i71YZ2YDu8qgcgOQU/5jhfvXlfh3hP3FVHe1MDTk/2WRkcN3w8mRuO+l7OsomTceLK
         4uhKypEgZsiJ3BZ+9i1PI/k3z90WsJ7aQvuZPFk0pLwbpvYXRJ/JKM8/wQIKnv5cWSJs
         Ei/RV3fU3CERfFV7dvmNnBOGoSAmIlETLmRC7cSmfSk4UK1x0BRyiCPoDwtjon5Zv7Nk
         AylzMjkl0346f3s7cjbwg4YhUvVaDgvaYktZ2wtqC2KZ6mSzVhkSPZYmjaNzAMQ26nuC
         AoQA==
X-Gm-Message-State: AOAM531U736X2eHyHtOS4gLccycdX53gP+ZO2dtCIBIPNZrIBWhnLKzs
        rc/2PogRJ7eNleszNdEGEsAHxr+V1ieAt7jvyMVn6nh7ilI=
X-Google-Smtp-Source: ABdhPJzOKF+Wcdg+vf2wuYy/Or6CmJeQjHWY6lDTpzf/zM7Su1gGI5jPg2YDYfx7SNgTcxxKeGgLLP3ns6YlvkBqCR0=
X-Received: by 2002:a92:1b9d:: with SMTP id f29mr980299ill.241.1596012282435;
 Wed, 29 Jul 2020 01:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGvU0H=AAPt0wSTh1dyb-aTnG9zeUY6U2uBkmi6K9Bvpuc9YAA@mail.gmail.com>
 <9d9a48e0-844d-8ba4-b839-92cb1af622ee@fb.com>
In-Reply-To: <9d9a48e0-844d-8ba4-b839-92cb1af622ee@fb.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Wed, 29 Jul 2020 09:44:05 +0100
Message-ID: <CAGvU0HmUnMq=7W=GhW+Mut9henBf5yDDgG7S2RfVFny7VdoUJQ@mail.gmail.com>
Subject: Re: BTF_KIND_FWD enums
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 29 Jul 2020 at 08:09, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/28/20 1:56 PM, Giuliano Procida wrote:
> > Hi.
> >
> > Re: https://github.com/torvalds/linux/commit/9d5f9f701b1891466fb3dbb1806ad97716f95cc3
> >
> > Both GCC and LLVM support forward-declared (a.k.a. incomplete) enums
> > as a language extension -
> > https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html.
> >
> > (C++11 has a different notion of incomplete enum type - opaque enum
> > declaration - storage size is known but enumerators are not)
> >
> > Forward-declared enums feature in various places in kernel code and
> > allow the usual things to be done (passing around pointers to such).
> > I'm curious as to if and how they are they are handled by BTF and
> > whether a further change to btf_type is needed:
> >
> > 1. Use BTF_KIND_FWD, with another spare bit to allow up to 4 kinds of
> > forward-declaration; or
> > 2. use BTF_KIND_ENUM, kind_flag 0 and vlen 0 (as empty enums are
> > currently illegal C); or
>
> #2 above is the current way.
> -bash-4.4$ cat t.c
> enum H;
> enum H * func(enum H *arg) { return arg; }
> -bash-4.4$ clang -target bpf -S -g -O2 t.c
>
> -bash-4.4$
>
> The generated BTF enum type:
>
>          .long   1                               # BTF_KIND_ENUM(id = 2)
>          .long   100663296                       # 0x6000000
>          .long   0
>
> So vlen = 0 here indicates it is a forward declaration.
>

Thanks, that's all clear. There is a small risk that C will follow C++
and allow zero enumerators in the future.

>
> > 3. use BTF_KIND_ENUM, kind_flag 1 and vlen 0.
> >
> > If I had a working pahole -J, I'd test this myself. :-)
> >
> > $ cat /tmp/en.c
> > enum H;
> > enum H * fun(enum H * x) { return x; }
> > $ clang -Wall -Wextra -ggdb -c /tmp/en.c
> > $ build/pahole -J /tmp/en.o
> > Segmentation fault
> > $ build/pahole -J /dev/null
> > btf_elf__new: cannot get elf header.
> > ctf__new: cannot get elf header.
> > Segmentation fault
>
> -bash-4.4$ cat t.c
> enum H;
> enum H * func(enum H *arg) { return arg; }
> -bash-4.4$ ~/work/pahole/build/pahole --version
> v1.17
> -bash-4.4$ clang -Wall -Wextra -ggdb -c t.c
>
> -bash-4.4$ ~/work/pahole/build/pahole -JV t.o
> File t.o:
> [1] PTR (anon) type_id=2
> [2] ENUM H size=4 vlen=0
> [3] INT (anon) size=4 bit_offset=0 nr_bits=32 encoding=(none)
> [4] FUNC_PROTO (anon) return=1 args=(1 arg)
> [5] FUNC func type_id=4
>
> pahole also generates vlen=0 ENUM type to indicate it is a
> forward declaration.
>
> Maybe your pahole is too old?

I tried both master and v1.17. Perhaps my libdw (Debian 0.176-1.1) is
incompatible or some other library is too old.

Regards,
Giuliano.

> >
> > My interest here is that I helped add support for incomplete enums to
> > libabigail which we're using to monitor kernel ABIs.
> >
> > Regards,
> > Giuliano.
> >
> > (resend due to email address typo)
> >
