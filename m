Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F14C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31722076A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gwsElXHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGZMsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgGZMsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 08:48:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2FC0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 05:48:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so5202632wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCLczGQIxWKiTkxHU6NiarIhxc9Z+JmjQxED80qEJss=;
        b=gwsElXHX2E2bUDww3ab3IoZnn76R5AZW2fLMad++U/SfNz2BQysjn9tmQWLc68si09
         vjvfu12vgyKudVHKrUiZ5jfldqlKc8Wj28ZbK0upIQvgG5/tXeW3EpZimmGZGW2ExcKJ
         qP553zFfDrJdUvHw8f0LhdqsapqLZD7UtlzRre2tgNZMRe2O+1x8zy1B8/0hCRv1kHxv
         YPkUSzFVgMQNOnLyjSHr+G4o/H9zQ9UtallmpbnPciV2SfNw8hqZ5/VHB4SBaosZh/vD
         01OTENe/iN0DPo/jtmvNS4QD/YrdszGynX1Fb+bIQnmFxhzWGbsV1U1nzbekl4PX/7Qr
         NIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCLczGQIxWKiTkxHU6NiarIhxc9Z+JmjQxED80qEJss=;
        b=r3t6EziME14sbfy9rzSkt5W+tGo6SJIapHdFd0cUXCs2sqt1yTbeX/eseL0MtupJuA
         eFbMt9KvhJGyXLYJoUBPbZPw06DoCLsSL1QODGGG+uyPvRkaFsrIHYSpIC/pj/maIzP+
         ttt8zflZT3Yq/atL3svrXD76Mutdi+KVsZH/YI+/jnWN3Pz15nQo7AgrKVBrlEhX2Col
         vVRiDdsxulo8pf5dRQp5R/7mFJAT1u7zgQqouZ8N5QZw552cve2yaCqz3e1L8axLNz1n
         v4SDEPDUVeDFLtQYI17g5ts8aiRYunca9qY5BtjwP9ROeumJuaiRTxyTuKShPzwCFkCM
         CwGQ==
X-Gm-Message-State: AOAM533rYVNq77EdHYW6kf4Ag8I2tyGIRA87Q/QP7tOV6vd7182qVSky
        6xQqZfldWNX71c7kKLlzkuTV49giCTM3EqTCsRQ5uw==
X-Google-Smtp-Source: ABdhPJwhqkhQturWmZRFMqSZv9GNE6rrK3X7LahzNQkb0Zo4Tkad6SpMIBWX4YYc/OAmqOhmFgHIsVezEkmX8Si7Pes=
X-Received: by 2002:a1c:6689:: with SMTP id a131mr5266820wmc.157.1595767730427;
 Sun, 26 Jul 2020 05:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200724085441.1514-1-jiangyifei@huawei.com> <20200724085441.1514-2-jiangyifei@huawei.com>
In-Reply-To: <20200724085441.1514-2-jiangyifei@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Jul 2020 18:18:38 +0530
Message-ID: <CAAhSdy08NEMR2jjJ-FVixyWMOpQ4+V-P9k2xuyO+Xu5OWKrmFQ@mail.gmail.com>
Subject: Re: [RFC 1/2] RISC-V: KVM: enable ioeventfd capability and compile
 for risc-v
To:     Yifei Jiang <jiangyifei@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "Zhangxiaofeng (F)" <victor.zhangxiaofeng@huawei.com>,
        wu.wubin@huawei.com,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>,
        "dengkai (A)" <dengkai1@huawei.com>, limingwang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change subject to:
"RISC-V: KVM: enable ioeventfd capability"

Also add 1-2 sentences of commit description.

On Fri, Jul 24, 2020 at 2:25 PM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Mingwang Li <limingwang@huawei.com>
> ---
>  arch/riscv/kvm/Kconfig  | 2 ++
>  arch/riscv/kvm/Makefile | 2 +-
>  arch/riscv/kvm/vm.c     | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index 2356dc52ebb3..95d85d893ab6 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -4,6 +4,7 @@
>  #
>
>  source "virt/kvm/Kconfig"
> +source "drivers/vhost/Kconfig"
>
>  menuconfig VIRTUALIZATION
>         bool "Virtualization"
> @@ -26,6 +27,7 @@ config KVM
>         select KVM_MMIO
>         select HAVE_KVM_VCPU_ASYNC_IOCTL
>         select SRCU
> +       select HAVE_KVM_EVENTFD
>         help
>           Support hosting virtualized guest machines.
>
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index b56dc1650d2c..3ad46fe44900 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for RISC-V KVM support
>  #
>
> -common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
> +common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o)
>
>  ccflags-y := -Ivirt/kvm -Iarch/riscv/kvm
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 4f2498198cb5..473299e71f68 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -52,6 +52,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         int r;
>
>         switch (ext) {
> +       case KVM_CAP_IOEVENTFD:
>         case KVM_CAP_DEVICE_CTRL:
>         case KVM_CAP_USER_MEMORY:
>         case KVM_CAP_SYNC_MMU:
> --
> 2.19.1
>
>

Regards,
Anup
