Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED2D2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WVLsE6GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbgFXB1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgFXB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:27:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF622C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:27:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so351872pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5WqxirMnj7b1Z9cfj2+T6ttey+7IO6/UmXnBcAnlL5o=;
        b=WVLsE6GKyBKghjtlRRoqw+jK/TkSzt8Y8R9lLFgI6U17GJv2Jvt3eaK4wnyXiYkWGe
         0Q6xvjT2TTBQmCmpzfKIdWZyrA44Rsvtn4AEzq9q2mBI/8/lZ67M1xVML+5ZTrZ1fmcY
         wH91F75UMO6Rzq9wkwYCenEUF3tWyu/dgat633p8XzrFPm8nuv14uQ8sIwOPg+YsdWjl
         6fze+c9CqheqViv+bIGiXHVV/CKxC/q7Jd3UTEiVoXfCn1xkK6q+ULskWtoj0BzLLbD4
         uhFIYPejKK1BB/uahHDwsSDmuEt2YYO9fDJkURJsuxbjWUCqR9T5TGfpO08bN5IbfThA
         bmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5WqxirMnj7b1Z9cfj2+T6ttey+7IO6/UmXnBcAnlL5o=;
        b=AaEX8ojpvcG1TptukMMs9TTuZf1wFcO7n4A73upMo5Zsa7LQVyK6dq02ISdAfGoi2y
         1++vo4gYKfit20rMpkHbgb1SIxK700QSEgpqVya6R2rQX9wIp8Tr4YNqng/V4OkRvdSS
         MSLydr3d2xsg9IhrBihntQAWPQfCHZi8Ts1H1OXo2hLkxgs0I6CvlVhtkHmIRjScAx2L
         iZxwwGsgZp6VgWDs3L3VVpeS/9CniSVw2jk/NSDBfCSk6AqBbHtnMcmJte9X60wZOru1
         S6osYRABfIR2g+sIOjZCWQTrHZGz9atRujLNBUV0TEicb6V1d9t7xlEI9BKZ6XwuCmH0
         DoDg==
X-Gm-Message-State: AOAM5328Hvxirkww0dtHmpFrfAubvkYXxDtZ9M2IuZXmvR5oyKZeBRRg
        /fEp+z+zMppR0cJr3REA9koVpyEzMWjZrHDN+28B1u80GmBroQ==
X-Google-Smtp-Source: ABdhPJzeq5txjKMUQAVr9+e0vQTIzzj8xHpGdSgvkgQr8uapF37yQ1dDH+5b3uyCoSICkGIBBLsUTaPuMFymKS4CHCM=
X-Received: by 2002:a17:90a:acf:: with SMTP id r15mr27081700pje.171.1592962027133;
 Tue, 23 Jun 2020 18:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <1592905854-60833-1-git-send-email-guoren@kernel.org> <CAEbi=3daXn-HKj2Rt+tot_JmvrNBFsUFWxeKfp=6ycjWuDtdRQ@mail.gmail.com>
In-Reply-To: <CAEbi=3daXn-HKj2Rt+tot_JmvrNBFsUFWxeKfp=6ycjWuDtdRQ@mail.gmail.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 24 Jun 2020 09:26:56 +0800
Message-ID: <CABvJ_xjYHiNS6OygtvGnStn-++XRKP3CxcTOr-MtA8sN8WmdVA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alan Kao <alankao@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 9:27 PM Greentime Hu <green.hu@gmail.com> wrote:
>
> <guoren@kernel.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8823=E6=97=A5 =E9=80=
=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:52=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > For linux-5.8-rc1, enable ftrace of riscv will cause boot panic:
> >
> > [    2.388980] Run /sbin/init as init process
> > [    2.529938] init[39]: unhandled signal 4 code 0x1 at 0x0000003ff449e=
000
> > [    2.531078] CPU: 0 PID: 39 Comm: init Not tainted 5.8.0-rc1-dirty #1=
3
> > [    2.532719] epc: 0000003ff449e000 ra : 0000003ff449e954 sp : 0000003=
fffedb900
> > [    2.534005]  gp : 00000000000e8528 tp : 0000003ff449d800 t0 : 000000=
000000001e
> > [    2.534965]  t1 : 000000000000000a t2 : 0000003fffedb89e s0 : 000000=
3fffedb920
> > [    2.536279]  s1 : 0000003fffedb940 a0 : 0000003ff43d4b2c a1 : 000000=
0000000000
> > [    2.537334]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : ffffff=
fffbad8000
> > [    2.538466]  a5 : 0000003ff449e93a a6 : 0000000000000000 a7 : 000000=
0000000000
> > [    2.539511]  s2 : 0000000000000000 s3 : 0000003ff448412c s4 : 000000=
0000000010
> > [    2.541260]  s5 : 0000000000000016 s6 : 00000000000d0a30 s7 : 000000=
3fffedba70
> > [    2.542152]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000000=
3fffedb960
> > [    2.543335]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 000000=
3fffedb8a0
> > [    2.544471]  t5 : 0000000000000000 t6 : 0000000000000000
> > [    2.545730] status: 0000000000004020 badaddr: 00000000464c457f cause=
: 0000000000000002
> > [    2.549867] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000004
> > [    2.551267] CPU: 0 PID: 1 Comm: init Not tainted 5.8.0-rc1-dirty #13
> > [    2.552061] Call Trace:
> > [    2.552626] [<ffffffe00020374a>] walk_stackframe+0x0/0xc4
> > [    2.553486] [<ffffffe0002039f4>] show_stack+0x40/0x4c
> > [    2.553995] [<ffffffe00054a6ae>] dump_stack+0x7a/0x98
> > [    2.554615] [<ffffffe00020b9b8>] panic+0x114/0x2f4
> > [    2.555395] [<ffffffe00020ebd6>] do_exit+0x89c/0x8c2
> > [    2.555949] [<ffffffe00020f930>] do_group_exit+0x3a/0x90
> > [    2.556715] [<ffffffe000219e08>] get_signal+0xe2/0x6e6
> > [    2.557388] [<ffffffe000202d72>] do_notify_resume+0x6a/0x37a
> > [    2.558089] [<ffffffe000201c16>] ret_from_exception+0x0/0xc
> >
> > "ra:0x3ff449e954" is the return address of "call _mcount" in the
> > prologue of __vdso_gettimeofday(). Without proper relocate, pc jmp
> > to 0x0000003ff449e000 (vdso map base) with a illegal instruction
> > trap.
> >
> > The solution comes from arch/arm64/kernel/vdso/Makefile:
> >
> > CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS=
)
> >
> >  - CC_FLAGS_SCS is ShadowCallStack feature in Clang and only
> >    implemented for arm64, no use for riscv.
> >
> > The bug comes from the following commit:
> >
> > ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the=
 time-related functions")
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Vincent Chen <vincent.chen@sifive.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Alan Kao <alankao@andestech.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > ---
> >  arch/riscv/kernel/vdso/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/M=
akefile
> > index 38ba55b..3079935 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -27,6 +27,9 @@ obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
> >  obj-y +=3D vdso.o vdso-syms.o
> >  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
> >
> > +# Disable -pg to prevent insert call site
> > +CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) -Os
> > +
> >  # Disable gcov profiling for VDSO code
> >  GCOV_PROFILE :=3D n
> >
>
> Thank you, Guo.
> I encounter the same bug in v5.8-rc2.
> This patch works.
>
> Tested-by: Greentime Hu <greentime.hu@sifive.com>

Sorry for any inconvenience caused by my mistake and thank you for
resolving this bug.
It looks good to me.
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
