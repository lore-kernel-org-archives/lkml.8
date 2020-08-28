Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7220C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gpMTcbpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1E5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 00:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgH1E5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:57:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD25C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:57:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q93so42362pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EeBnzl55KhlznFGrhdw4wiCgK95KqATQ83rC/nkZT0=;
        b=gpMTcbpl4/LN0p/Roic31wTiMY2eUFarLAXop4+im+qllDOfxyjQyOgske9U78MIsz
         7b5/Z9Plh7i+IUCnuJs3xxHlcQ5Mqmkq3odbq4FQfOGUkYxgzO+G6y48tw4mvJ349sNr
         W1EATwnMZoXRC94aHfKUHgdFR+18slX19mje7G+6R4yAatxZU4/P4GliSt1ZDO0Vuv0q
         t4STmH5dVvVnJE8cmQIQWZYAYKIfvr62Ihc9poxPhPOWcTv2CqIB6kvuDZLU0fDUG2PO
         2noPdsy2ydKpMra9XUm0/A65slQOjYRltyLJCq/uwtJEuf/z+WrpVYDINuTrI+qnNMx0
         EIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EeBnzl55KhlznFGrhdw4wiCgK95KqATQ83rC/nkZT0=;
        b=CN2wNaIV9DmtMzMJYq/zvNkrwywkUQrA4t9X+vPns12M1EXL4XavMg08zNAwowDC4v
         vUzZutzplQvlXAPk6s0eeVSmI/z754k8ZU6dshYJRDZY2Njp9zvqNSLfKioC3dkRepz9
         hilhEx3URd2woLctqW4M2ktc7WKH0Way89cD2Mglxv3KNsnY1begyfVyjNGwNsq8AiP0
         GMtCjxTv3SPFPTnQsPjb1gdo37DTrCAIzvGm/5xUZW7JM1T/3ZianTzN0VX1s7y5qmOD
         hQlEoaaVtOqjH/odolti8iMJPJ3vDD9vYY0zVGeZxQNBYKlDHRfx5uP3TWreSDox/ATj
         Z5VA==
X-Gm-Message-State: AOAM5300RJGBrBUrCjujyvJ7OoJeD8DhHD1BkasP+CGLQHAoKVVeekjr
        jvPQPu+Hpik687z4KGyJvww/1gskIeuGZicn3bGkKA==
X-Google-Smtp-Source: ABdhPJxLo7vrQLUhTi7CAJ1QiiyZWein+ivOd8qafBnWQxI56Vc3pCvlOZ2oTlRXck0fsNFr8fIGigFt8sJIz/vk4+Y=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr84381pjb.101.1598590637116;
 Thu, 27 Aug 2020 21:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200724085441.1514-1-jiangyifei@huawei.com>
In-Reply-To: <20200724085441.1514-1-jiangyifei@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Aug 2020 10:27:04 +0530
Message-ID: <CAAhSdy2qtr4EpYjFM=REigrC7DK_Fo26P-SGhVC6n21FewtFvw@mail.gmail.com>
Subject: Re: [RFC 0/2] Add risc-v vhost-net support
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

On Fri, Jul 24, 2020 at 2:25 PM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Hi,
>
> These two patches enable support for vhost-net on RISC-V architecture. They are developed
> based on the Linux source in this repo: https://github.com/avpatel/linux,
> the branch is riscv_kvm_v13.
>
> The accompanying QEMU is from the repo: https://github.com/alistair23/qemu, the branch is
> hyp-ext-v0.6.next. In order for the QEMU to work with KVM, the patch found here is necessary:
> https://patchwork.kernel.org/cover/11435965/
>
> Several steps to use this:
>
> 1. create virbr0 on riscv64 emulation
> $ brctl addbr virbr0
> $ brctl stp virbr0 on
> $ ifconfig virbr0 up
> $ ifconfig virbr0 <virbr0_ip> netmask <virbr0_netmask>
>
> 2. boot riscv64 guestOS on riscv64 emulation
> $ ./qemu-system-riscv64 -M virt,accel=kvm -m 1024M -cpu host -nographic \
>         -name guest=riscv-guest \
>         -smp 2 \
>         -kernel ./Image \
>         -drive file=./guest.img,format=raw,id=hd0 \
>         -device virtio-blk,drive=hd0 \
>         -netdev type=tap,vhost=on,script=./ifup.sh,downscript=./ifdown.sh,id=net0 \
>         -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"
>
> $ cat ifup.sh
> #!/bin/sh
> brctl addif virbr0 $1
> ifconfig $1 up
>
> $ cat ifdown.sh
> #!/bin/sh
> ifconfig $1 down
> brctl delif virbr0 $1
>
> This brenchmark is vhost-net compare with virtio:
>
> $ ./netperf -H <virbr0_ip> -l 100 -t TCP_STREAM
>
> vhost-net:
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
>
> 131072  16384  16384    100.07    457.55
>
> virtio:
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
>
> 131072  16384  16384    100.07    227.02
>
>
> The next step is to support irqfd on RISC-V architecture.
>
> Yifei Jiang (2):
>   RISC-V: KVM: enable ioeventfd capability and compile for risc-v
>   RISC-V: KVM: read\write kernel mmio device support
>
>  arch/riscv/kvm/Kconfig     |  2 ++
>  arch/riscv/kvm/Makefile    |  2 +-
>  arch/riscv/kvm/vcpu_exit.c | 38 ++++++++++++++++++++++++++++++++------
>  arch/riscv/kvm/vm.c        |  1 +
>  4 files changed, 36 insertions(+), 7 deletions(-)
>
> --
> 2.19.1
>
>

I will be squashing these patches into PATCH7 of v14 KVM RISC-V series.

I will also add your Signed-off-by to PATCH7 of v14 KVM RISC-V to
acknowledge your efforts.

Thanks,
Anup
