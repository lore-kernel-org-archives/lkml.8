Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC8C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F31A2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJmkZLnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBDWNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:13:54 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46642 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbgBDWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:13:53 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so11338vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xv45OFjwFXofwH8/xu3BaSo5k0sz448Vtu4g6hjFri8=;
        b=dJmkZLnBv+66hPhwQXMbEtLD92PjwoXKqRbsnMFHDA+M/KuGpmv9873RKAAoQcLuB5
         j1X8EZakA99WtxjZBAbPfbng+wJR/YyDgKEYD5Na6D/Kb663gSgeCjB2BelOc7gOm9Fs
         +skDRKs4GNUfBwUDA9+/vGOtfClfqhNwn7w9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xv45OFjwFXofwH8/xu3BaSo5k0sz448Vtu4g6hjFri8=;
        b=EiAyCsdcDb55DMRYGYY/LEg/SQDyeDQZQ5U7XT3HL+Rq+eo85opcvTEJ7L/uBBx6x5
         3pLmMeiRkz/FmmufcDKTHTScqWvxR53J1jONE5GQ9IqYjQge0JXnJf3R4qFXrxfnp10g
         KDHf+xkgR00zgbRJhqV2J+8mRXdQmoTqzLfcLsFkLMdM8M6Wqw1qPEeBtWpICOaiebDi
         MQWyLCLEm18pEMCNi1Y9JCNxb1d6eL2w7ROz09OteFZcXi6Kx0A1eiObndAwo0k6nMig
         bUXYaDOVLLUaOsTZp9Gvv997O/kyNwj7SbUlPZABOBkzlB8ljKjyCMpHFqxizK44mL1L
         kzog==
X-Gm-Message-State: APjAAAVin1GJ6/zX4goIvYH3KQXIBI8c2eJvdaXlmSBh/KwWzCfAzxgh
        XX1GpGrYaO41d/o68K9VctkNLZmjSaQ=
X-Google-Smtp-Source: APXvYqxHenjuwTLifSfjXZnMbPjK8/pYAQR1BPwWWOURBJMhn3lBeZHkrst1oworbmZ8r6ygjtSlsw==
X-Received: by 2002:a67:e3b3:: with SMTP id j19mr20007649vsm.41.1580854432224;
        Tue, 04 Feb 2020 14:13:52 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id r193sm7726308vkd.12.2020.02.04.14.13.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:13:52 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id r18so42758vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:13:51 -0800 (PST)
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr19825660vsq.169.1580854431077;
 Tue, 04 Feb 2020 14:13:51 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
In-Reply-To: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 14:13:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
Message-ID: <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
Subject: Re: [sparc64] unable to build kernel after bbfceba15f8 / "kdb: Get
 rid of confusing diag msg from "rd" if current task has no regs"
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 1:14 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Hello!
>
> After (bisected) bbfceba15f8d1260c328a254efc2b3f2deae4904 got
> mainline, i'm unable to build kernel with the following messages:
>
> ~/linux-2.6$ make -j olddefconfig; make kernel/debug/kdb/
> scripts/kconfig/conf  --olddefconfig Kconfig
> #
> # No change to .config
> #
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CC      kernel/debug/kdb/kdb_main.o
> kernel/debug/kdb/kdb_main.c: In function =E2=80=98kdb_rd=E2=80=99:
> kernel/debug/kdb/kdb_main.c:1857:11: error: =E2=80=98dbg_reg_def=E2=80=99=
 undeclared
> (first use in this function); did you mean =E2=80=98dbg_reg_def_t=E2=80=
=99?
>  1857 |   rsize =3D dbg_reg_def[i].size * 2;
>       |           ^~~~~~~~~~~
>       |           dbg_reg_def_t
> kernel/debug/kdb/kdb_main.c:1857:11: note: each undeclared identifier
> is reported only once for each function it appears in
> kernel/debug/kdb/kdb_main.c:1868:12: error: implicit declaration of
> function =E2=80=98dbg_get_reg=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>  1868 |    rname =3D dbg_get_reg(i, &reg8, kdb_current_regs);
>       |            ^~~~~~~~~~~
> kernel/debug/kdb/kdb_main.c:1868:10: warning: assignment to =E2=80=98char=
 *=E2=80=99
> from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> [-Wint-conversion]
>  1868 |    rname =3D dbg_get_reg(i, &reg8, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1874:10: warning: assignment to =E2=80=98char=
 *=E2=80=99
> from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> [-Wint-conversion]
>  1874 |    rname =3D dbg_get_reg(i, &reg16, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1880:10: warning: assignment to =E2=80=98char=
 *=E2=80=99
> from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> [-Wint-conversion]
>  1880 |    rname =3D dbg_get_reg(i, &reg32, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1886:10: warning: assignment to =E2=80=98char=
 *=E2=80=99
> from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> [-Wint-conversion]
>  1886 |    rname =3D dbg_get_reg(i, &reg64, kdb_current_regs);
>       |          ^
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:266: kernel/debug/kdb/kdb_main.o] Er=
ror 1
> make[2]: *** [scripts/Makefile.build:503: kernel/debug/kdb] Error 2
> make[1]: *** [scripts/Makefile.build:503: kernel/debug] Error 2
> make: *** [Makefile:1681: kernel] Error 2
>
>
> reversing bbfceba15f8d with current git master branch - makes kernel
> compilable again.
>
> kernel config attached

Argh.  Sorry about this.  :(  I'm not setup with a sparc compiler, but
I've simulated your results on arm64 by just commenting out the
definition of "DBG_MAX_REG_NUM" in "arch/arm64/include/asm/kgdb.h".
Hopefully:

https://lore.kernel.org/r/20200204141219.1.Ief3f3a7edbbd76165901b14813e9038=
1c290786d@changeid

...will fix you?

-Doug
