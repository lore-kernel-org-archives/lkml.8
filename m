Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120612065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="l4ouuUm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGZM5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgGZM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 08:57:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD645C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 05:57:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t142so5779673wmt.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cj1AA+QajmRenSwYh/8g5RjvZ+1Kfi4azWkbk5rVJMY=;
        b=l4ouuUm+RZKjkDPNsYC7yAU3y2YJaYqK7fRoN7KnpfYrRUJXIdaNeqJraLDSLj+Hsq
         DoCjcYHNOPx4wQ8IoFKBY8oXq+gP6wlJ5S/+4ZJRUZe7F+op3/uY4m7z1/B2VnkOgD5m
         t2uIGFEk+6v+lJhjcexw3MSjbYwv9XzgPyuSk2nG7+0gRoCIhPcpMUQxBQ0CXJeMW7Bq
         Pj3YcVraJh5zWRzVM0CLCI1eEwZtk2hlU89S/EKMlfBzmwOSdLrkBcQe9JB7QgVZ03Q+
         zeks5A6Odx9k1ILsGYWcElYbzhHbp57Sf/ChsiYlNzHYRcSM26Z/AA8OZ33WJhBEDIgd
         p68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj1AA+QajmRenSwYh/8g5RjvZ+1Kfi4azWkbk5rVJMY=;
        b=LpqwlB1ty8EWHY8BIX4RxdLDfhmXeWPr8R3axdftd0wIBlP1HEKadVdz5iA8mTIQNg
         JR79f6BoJFmOMtjDGzfIaj7Drv6PBHufrHfs556wkTCKFRMVleuuMJAClTHGbe+HJKHQ
         588sA9Jcc2OW8pETMwjZy8/oHMYoRP/WQqVp9pUtIl4EBnomRC7EAhh41OijXesL0uVe
         ZVtwYOLzyBUtgxiJv+Lc4WbjLeuZcbc38avUlNgUtVrfZGWksOfJEw9q0mJ8VqcInsiZ
         Gl9a/DFddsX7OTYMt4mQjZ0+gKT+FV2qmLWs7GiXU44KhSk01hWvVO5pZodD6Qarb0CA
         eAJg==
X-Gm-Message-State: AOAM530oqgKfQLEYrdhsXWut9U92l2uF+ukb5VenCrwhHeYyuW3ibI4W
        w2fQ1BhJtvOT0dAq6BKrfAsA9mk7SGQ0QLoyuJ7Szg==
X-Google-Smtp-Source: ABdhPJwiFhCYXoqV5R1BrUk4cFAFcu/0v8ywSpRptTToyE31Qt/lRbVUr0NbxhMSfFzTA3SQmpsU/BUW05YZkVeyxhw=
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr17178624wmb.134.1595768248343;
 Sun, 26 Jul 2020 05:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200724085441.1514-1-jiangyifei@huawei.com> <20200724085441.1514-3-jiangyifei@huawei.com>
In-Reply-To: <20200724085441.1514-3-jiangyifei@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Jul 2020 18:27:16 +0530
Message-ID: <CAAhSdy3q3tNUqSxnFy2tdmXOLJZjt4rMAZirZh88-0BXT7-X1g@mail.gmail.com>
Subject: Re: [RFC 2/2] RISC-V: KVM: read\write kernel mmio device support
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
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Mingwang Li <limingwang@huawei.com>
> ---
>  arch/riscv/kvm/vcpu_exit.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index e97ba96cb0ae..448f11179fa8 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -191,6 +191,8 @@ static int virtual_inst_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  static int emulate_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                         unsigned long fault_addr, unsigned long htinst)
>  {
> +       int ret;
> +       u8 data_buf[8];
>         unsigned long insn;
>         int shift = 0, len = 0;
>         struct kvm_cpu_trap utrap = { 0 };
> @@ -272,19 +274,32 @@ static int emulate_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
>         vcpu->arch.mmio_decode.len = len;
>         vcpu->arch.mmio_decode.return_handled = 0;
>
> -       /* Exit to userspace for MMIO emulation */
> -       vcpu->stat.mmio_exit_user++;
> -       run->exit_reason = KVM_EXIT_MMIO;
> +       ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, fault_addr, len,
> +                                                 data_buf);
> +

Move "ret = kvm_io_bus_read()" just before "if (!ret)".

>         run->mmio.is_write = false;
>         run->mmio.phys_addr = fault_addr;
>         run->mmio.len = len;
>
> +       if (!ret) {
> +               /* We handled the access successfully in the kernel. */
> +               memcpy(run->mmio.data, data_buf, len);
> +               vcpu->stat.mmio_exit_kernel++;
> +               kvm_riscv_vcpu_mmio_return(vcpu, run);
> +               return 1;
> +       }
> +
> +       /* Exit to userspace for MMIO emulation */
> +       vcpu->stat.mmio_exit_user++;
> +       run->exit_reason = KVM_EXIT_MMIO;
> +
>         return 0;
>  }
>
>  static int emulate_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                          unsigned long fault_addr, unsigned long htinst)
>  {
> +       int ret;
>         u8 data8;
>         u16 data16;
>         u32 data32;
> @@ -378,13 +393,24 @@ static int emulate_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                 return -ENOTSUPP;
>         };
>
> -       /* Exit to userspace for MMIO emulation */
> -       vcpu->stat.mmio_exit_user++;
> -       run->exit_reason = KVM_EXIT_MMIO;
> +       ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, fault_addr, len,
> +                                                  run->mmio.data);
> +

Same as above.

Move "ret = kvm_io_bus_write()" just before "if (!ret) {"

>         run->mmio.is_write = true;
>         run->mmio.phys_addr = fault_addr;
>         run->mmio.len = len;
>
> +       if (!ret) {
> +               /* We handled the access successfully in the kernel. */
> +               vcpu->stat.mmio_exit_kernel++;
> +               kvm_riscv_vcpu_mmio_return(vcpu, run);
> +               return 1;
> +       }
> +
> +       /* Exit to userspace for MMIO emulation */
> +       vcpu->stat.mmio_exit_user++;
> +       run->exit_reason = KVM_EXIT_MMIO;
> +
>         return 0;
>  }
>
> --
> 2.19.1
>
>

Regards,
Anup
