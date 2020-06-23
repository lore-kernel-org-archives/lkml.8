Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97AC20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD8mFtFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgFWN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgFWN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:27:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:27:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so6890566qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s61vTNTKjftgqj7vT6jNSB2p5Hcki29Ard21RMlKgzU=;
        b=iD8mFtFU1qFjRupwAx80BqOYA9F1KCiEQhxThb01dw+DBOXUMGMdITjAh2tGGZm+36
         5XUGnRrrPhfe/T9H8d7QAZTvR2R3oHEJBwwsG76ztKtxdnNwPmD46OF8++qIY7d8ydK5
         kfGSpEai9qK8yrcHYo5wBTjZzwIIRzJa7+05Owlu1HfUnAo0twmze88442E+HWnPWzKk
         TyVn9nlOoEYPdSfUjXuWDzr9ImovltFN249dWeQmm6x8zOQV/pRp0i/EwuJ16qdgpZs7
         mqvSDRHN2AUMd0k36F5KdLl+20Qzd8cEFfWmsJfm3c4/lwMWBWleBzDOr/xsZwGwMcKR
         ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s61vTNTKjftgqj7vT6jNSB2p5Hcki29Ard21RMlKgzU=;
        b=TFT8sj/m4jb3KmFvZqhti4vu8jkAacTaQ8Ip/NJyCl6g8D9uhu59KInXMZmuHevdNl
         /GH/ED81wsGL3q3lSPPYZane7IVoz3J/As/TANCSuzHgrwAyF40H7BFYNaxH+CJGDNqs
         VKF4zMIZDOHiqT5SZPvImTQLk8gbDX4OxdeMt20aMiJNx87Ka12oGAGxR+XS9WOrnI57
         p5rWrYXjOKHZDGbMexumultsfSntzGKGQhg8qvA9CvzE0g+rXzJcR68uNunt5wL5nmNp
         0G/BP/NHJc6Zrn35Uk9jKNWdpU0v4xfRFrY9XBdDkAoZjyG74EJ9wSr9EKb9+s0+d+YP
         Gdrg==
X-Gm-Message-State: AOAM533w2DlZ+mfPDTBbflknxiV3MGk+vYcId6ob84+bPjacKnGvRj3e
        svVsdZaH+nFeRO3XCx1GP20ovfJwT9N00/BGlG4=
X-Google-Smtp-Source: ABdhPJyVwvx3y3npYRO8WzJm1SM6Zh35J6NDRRuD2id8EtSl4Wbrg6fg7kdX3Z6FTA4imU/2jxgSjJebmNgxXLSNrQc=
X-Received: by 2002:a37:748:: with SMTP id 69mr20534534qkh.281.1592918831275;
 Tue, 23 Jun 2020 06:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592905854-60833-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1592905854-60833-1-git-send-email-guoren@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 23 Jun 2020 21:26:33 +0800
Message-ID: <CAEbi=3daXn-HKj2Rt+tot_JmvrNBFsUFWxeKfp=6ycjWuDtdRQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
To:     Guo Ren <guoren@kernel.org>
Cc:     vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
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

<guoren@kernel.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8823=E6=97=A5 =E9=80=B1=
=E4=BA=8C =E4=B8=8B=E5=8D=885:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> For linux-5.8-rc1, enable ftrace of riscv will cause boot panic:
>
> [    2.388980] Run /sbin/init as init process
> [    2.529938] init[39]: unhandled signal 4 code 0x1 at 0x0000003ff449e00=
0
> [    2.531078] CPU: 0 PID: 39 Comm: init Not tainted 5.8.0-rc1-dirty #13
> [    2.532719] epc: 0000003ff449e000 ra : 0000003ff449e954 sp : 0000003ff=
fedb900
> [    2.534005]  gp : 00000000000e8528 tp : 0000003ff449d800 t0 : 00000000=
0000001e
> [    2.534965]  t1 : 000000000000000a t2 : 0000003fffedb89e s0 : 0000003f=
ffedb920
> [    2.536279]  s1 : 0000003fffedb940 a0 : 0000003ff43d4b2c a1 : 00000000=
00000000
> [    2.537334]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : ffffffff=
fbad8000
> [    2.538466]  a5 : 0000003ff449e93a a6 : 0000000000000000 a7 : 00000000=
00000000
> [    2.539511]  s2 : 0000000000000000 s3 : 0000003ff448412c s4 : 00000000=
00000010
> [    2.541260]  s5 : 0000000000000016 s6 : 00000000000d0a30 s7 : 0000003f=
ffedba70
> [    2.542152]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000003f=
ffedb960
> [    2.543335]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000003f=
ffedb8a0
> [    2.544471]  t5 : 0000000000000000 t6 : 0000000000000000
> [    2.545730] status: 0000000000004020 badaddr: 00000000464c457f cause: =
0000000000000002
> [    2.549867] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000004
> [    2.551267] CPU: 0 PID: 1 Comm: init Not tainted 5.8.0-rc1-dirty #13
> [    2.552061] Call Trace:
> [    2.552626] [<ffffffe00020374a>] walk_stackframe+0x0/0xc4
> [    2.553486] [<ffffffe0002039f4>] show_stack+0x40/0x4c
> [    2.553995] [<ffffffe00054a6ae>] dump_stack+0x7a/0x98
> [    2.554615] [<ffffffe00020b9b8>] panic+0x114/0x2f4
> [    2.555395] [<ffffffe00020ebd6>] do_exit+0x89c/0x8c2
> [    2.555949] [<ffffffe00020f930>] do_group_exit+0x3a/0x90
> [    2.556715] [<ffffffe000219e08>] get_signal+0xe2/0x6e6
> [    2.557388] [<ffffffe000202d72>] do_notify_resume+0x6a/0x37a
> [    2.558089] [<ffffffe000201c16>] ret_from_exception+0x0/0xc
>
> "ra:0x3ff449e954" is the return address of "call _mcount" in the
> prologue of __vdso_gettimeofday(). Without proper relocate, pc jmp
> to 0x0000003ff449e000 (vdso map base) with a illegal instruction
> trap.
>
> The solution comes from arch/arm64/kernel/vdso/Makefile:
>
> CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
>
>  - CC_FLAGS_SCS is ShadowCallStack feature in Clang and only
>    implemented for arm64, no use for riscv.
>
> The bug comes from the following commit:
>
> ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the t=
ime-related functions")
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Vincent Chen <vincent.chen@sifive.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 38ba55b..3079935 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -27,6 +27,9 @@ obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
>  obj-y +=3D vdso.o vdso-syms.o
>  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
>
> +# Disable -pg to prevent insert call site
> +CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) -Os
> +
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE :=3D n
>

Thank you, Guo.
I encounter the same bug in v5.8-rc2.
This patch works.

Tested-by: Greentime Hu <greentime.hu@sifive.com>
