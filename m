Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A96D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dk7LaBzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407595AbgFYWsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407587AbgFYWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:48:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:48:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l6so1016557pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RUInkwppGEY2OD1Zn1NZcICY8BU7HziGnuCYCO6xNi0=;
        b=Dk7LaBzkZouRRNfHAOBhsxXZqT/quWHc+saz9T8BMocYoA4hfvFN+SB+9Xy+JzS+h8
         hz9ef4aVKlxpaXUNngDXfGEAiGBAc896SmB+7T+Uj66MXzK+x1nQnhImxmfSWkvccrKt
         SLE0SknkV8zpDteERUsmk4xI738WCtjEltMVkIvnGY0I8Yg3QXJSD9k9LiGNWfkKjChF
         iWwE50F/dCuD8pHFusibRuyWuvi4N2iYU/knBwJMFjJfZle2KNQIsn+BWoJRGFPepDX3
         WhNKx1SK3O5mfJpnw9I0zDww8F1Md3xYZLoKqy63Af1U0mwUdZ3hmHt7kitvLij5icwP
         mbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RUInkwppGEY2OD1Zn1NZcICY8BU7HziGnuCYCO6xNi0=;
        b=qtHKEEqECnEsecCPDOSHMp7QUAd2e5m9h3y8u+2/V34L74kcEpB73SKK2Bggjb4cp+
         fJeqJwoTKzvXSZwouxeY7ZYypXDRDMDJEFA5/LitmWy38oF0aLAi3Ti2mZAT3oW2Yq09
         iz1BDawyW6IxgeELeBAXsXQh65UnJT3h0u13XzZCHQM+ctbHhCQBq22KjgJU9+oEw46s
         VtDnw1V+I7WziOuPraezmMmWH5cTzYLVFaZnpD7f3nyccvo2B1/3rDZNliIrvNuCIINv
         RkTRYtKWy8K15wzh3N3n3ZbCeGe2MA4j1wzfTk9jWqVu5RdHYwV3lWkeQCojD7lsNDXc
         1g8w==
X-Gm-Message-State: AOAM53388umrnMkjNfud9lOS+9jKZaoNyOJDwU1AhQaT/W1SNbRwfpJw
        ox8xj1BVm2vxth5CPoa/WkWZoQ==
X-Google-Smtp-Source: ABdhPJxxAaJZG05Y+ZHLJYNtwRZoWhDrbFDYa5i5HzUiieCkN7a6GU6Sczv8+78ybu3YEuJgnbOllg==
X-Received: by 2002:a17:90a:1996:: with SMTP id 22mr228055pji.171.1593125300117;
        Thu, 25 Jun 2020 15:48:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y26sm23563581pff.26.2020.06.25.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 15:48:16 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:48:16 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jun 2020 15:39:37 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
In-Reply-To: <1592905854-60833-1-git-send-email-guoren@kernel.org>
CC:     vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        Atish Patra <Atish.Patra@wdc.com>, alankao@andestech.com,
        green.hu@gmail.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-14238943-d2f5-4dd2-9f23-90203fc1786b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 02:50:54 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> For linux-5.8-rc1, enable ftrace of riscv will cause boot panic:
>
> [    2.388980] Run /sbin/init as init process
> [    2.529938] init[39]: unhandled signal 4 code 0x1 at 0x0000003ff449e000
> [    2.531078] CPU: 0 PID: 39 Comm: init Not tainted 5.8.0-rc1-dirty #13
> [    2.532719] epc: 0000003ff449e000 ra : 0000003ff449e954 sp : 0000003fffedb900
> [    2.534005]  gp : 00000000000e8528 tp : 0000003ff449d800 t0 : 000000000000001e
> [    2.534965]  t1 : 000000000000000a t2 : 0000003fffedb89e s0 : 0000003fffedb920
> [    2.536279]  s1 : 0000003fffedb940 a0 : 0000003ff43d4b2c a1 : 0000000000000000
> [    2.537334]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : fffffffffbad8000
> [    2.538466]  a5 : 0000003ff449e93a a6 : 0000000000000000 a7 : 0000000000000000
> [    2.539511]  s2 : 0000000000000000 s3 : 0000003ff448412c s4 : 0000000000000010
> [    2.541260]  s5 : 0000000000000016 s6 : 00000000000d0a30 s7 : 0000003fffedba70
> [    2.542152]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000003fffedb960
> [    2.543335]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000003fffedb8a0
> [    2.544471]  t5 : 0000000000000000 t6 : 0000000000000000
> [    2.545730] status: 0000000000004020 badaddr: 00000000464c457f cause: 0000000000000002
> [    2.549867] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
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
> CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
>
>  - CC_FLAGS_SCS is ShadowCallStack feature in Clang and only
>    implemented for arm64, no use for riscv.
>
> The bug comes from the following commit:
>
> ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
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
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 38ba55b..3079935 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -27,6 +27,9 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  obj-y += vdso.o vdso-syms.o
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>
> +# Disable -pg to prevent insert call site
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> +
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n

Thanks, this is on fixes (with a slightly modified commit message to fix some
checkpatch issues).
