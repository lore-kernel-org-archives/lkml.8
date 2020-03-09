Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3658C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A2A20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qamw/UdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIEtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 00:49:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40151 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgCIEtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:49:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id p2so8511978wrw.7;
        Sun, 08 Mar 2020 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xI1EE8uoH3BiMUeYAvkpbtUnHedvpDujiVrHPh8bOzY=;
        b=Qamw/UdXj4dZwwOaui4AglCQkL2sA83e5UKXOSOtO6MTKgklIM5WaejaMvaUTYm3YA
         ZEts/A0gALcdJQD9pwmOfH8vCccm8UxGs2evP48fjre3WrM06CpOaRyvgqlqzeP5kJt4
         rfotCbnXAXDBjSwb6UPimWECBYODWbv9vRD8xaggL9GDxSI5gAftoNmZsHb9bA8ps4NV
         5EKK4/pBTJwzPyL38McbpIMdiqJiE/OLZfKBIK8XSJSVYedrLIrKaDn4/bXS8dhTZjHZ
         n6mluqK2/EPIyVWeMfW3tSBPd30AHbDnjK5TQqGejei2Xm27BaCPjin71XFWin0+U6LW
         xZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xI1EE8uoH3BiMUeYAvkpbtUnHedvpDujiVrHPh8bOzY=;
        b=nRqOCursKYlpep8zlZolXM7dCumGv2p2NRLp7EtkRUeZa/vnkvy6Do6wcCzbUCEeMX
         b9bJTvez3UZSwhKQ7vta6S/sWsji8TYdo+/UFGZx/CcwLiCmdu9ToMn0q/OI5OrsMBxe
         cdKzVFwIIXqy5yFktQfGcnyfxlW8u48OiRnNvLr8p7awcb8hqko2ADIapAZ8RTF+VO27
         B/c1vVYaLrr/KwjRryAtpRLSjsBrgB26ApWM6W8jU+DyM3q0j3gKJdSOZZHf+YvW9fC5
         SwiJDkM8FbKZ6VWOyFl4qmYZfIOs4lEBk+aRlxQ/DglADsC8QfyLDPOk0PVH1mrCqw/1
         00Qg==
X-Gm-Message-State: ANhLgQ01BLnlzPUluM0fCJ2w7cwNfP2zwAQksdH06AuLOW6/YucUdLcs
        rZspJOdPOJgJ3RBwpqC9fO17n8cvcLTGu8ITCg4=
X-Google-Smtp-Source: ADFU+vsIzNDy7d/4P5U1gR4NjNyvgGKnpVC2ocXy5OjVTTgRdNoYLdPBN3Xv9gef45BSHewBm3OoaR/ShxZbDhkSaDg=
X-Received: by 2002:adf:ecca:: with SMTP id s10mr19357056wro.255.1583729340347;
 Sun, 08 Mar 2020 21:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-3-chenzhou10@huawei.com> <CAJ2QiJ+SQ1orriXJWyhKDcDL9s4Vh5+HQHhWFOKPVmijGpMGvw@mail.gmail.com>
 <0c00f14a-15ca-44db-7f82-00f15ddd3c88@huawei.com>
In-Reply-To: <0c00f14a-15ca-44db-7f82-00f15ddd3c88@huawei.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Mon, 9 Mar 2020 10:18:22 +0530
Message-ID: <CAJ2QiJL5Zj3Z=jrLVVn_n3vwNnTVtUZZMSkEaiVNLTA-ZmOe-Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, dyoung@redhat.com,
        Bhupesh Sharma <bhsharma@redhat.com>, xiexiuqi@huawei.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        horms@verge.net.au,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Sat, Mar 7, 2020 at 4:36 PM Chen Zhou <chenzhou10@huawei.com> wrote:
>
>
>
> On 2020/3/5 18:13, Prabhakar Kushwaha wrote:
> > On Mon, Dec 23, 2019 at 8:57 PM Chen Zhou <chenzhou10@huawei.com> wrote:
> >>
> >> Crashkernel=X tries to reserve memory for the crash dump kernel under
> >> 4G. If crashkernel=X,low is specified simultaneously, reserve spcified
> >> size low memory for crash kdump kernel devices firstly and then reserve
> >> memory above 4G.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/arm64/kernel/setup.c |  8 +++++++-
> >>  arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
> >>  2 files changed, 36 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >> index 56f6645..04d1c87 100644
> >> --- a/arch/arm64/kernel/setup.c
> >> +++ b/arch/arm64/kernel/setup.c
> >> @@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
> >>                     kernel_data.end <= res->end)
> >>                         request_resource(res, &kernel_data);
> >>  #ifdef CONFIG_KEXEC_CORE
> >> -               /* Userspace will find "Crash kernel" region in /proc/iomem. */
> >> +               /*
> >> +                * Userspace will find "Crash kernel" region in /proc/iomem.
> >> +                * Note: the low region is renamed as Crash kernel (low).
> >> +                */
> >> +               if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> >> +                               crashk_low_res.end <= res->end)
> >> +                       request_resource(res, &crashk_low_res);
> >>                 if (crashk_res.end && crashk_res.start >= res->start &&
> >>                     crashk_res.end <= res->end)
> >>                         request_resource(res, &crashk_res);
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index b65dffd..0d7afd5 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -80,6 +80,7 @@ static void __init reserve_crashkernel(void)
> >>  {
> >>         unsigned long long crash_base, crash_size;
> >>         int ret;
> >> +       phys_addr_t crash_max = arm64_dma32_phys_limit;
> >>
> >>         ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >>                                 &crash_size, &crash_base);
> >> @@ -87,12 +88,38 @@ static void __init reserve_crashkernel(void)
> >>         if (ret || !crash_size)
> >>                 return;
> >>
> >> +       ret = reserve_crashkernel_low();
> >> +       if (!ret && crashk_low_res.end) {
> >> +               /*
> >> +                * If crashkernel=X,low specified, there may be two regions,
> >> +                * we need to make some changes as follows:
> >> +                *
> >> +                * 1. rename the low region as "Crash kernel (low)"
> >> +                * In order to distinct from the high region and make no effect
> >> +                * to the use of existing kexec-tools, rename the low region as
> >> +                * "Crash kernel (low)".
> >> +                *
> >> +                * 2. change the upper bound for crash memory
> >> +                * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
> >> +                *
> >> +                * 3. mark the low region as "nomap"
> >> +                * The low region is intended to be used for crash dump kernel
> >> +                * devices, just mark the low region as "nomap" simply.
> >> +                */
> >> +               const char *rename = "Crash kernel (low)";
> >> +
> >> +               crashk_low_res.name = rename;
> >> +               crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
> >> +               memblock_mark_nomap(crashk_low_res.start,
> >> +                                   resource_size(&crashk_low_res));
> >> +       }
> >> +
> >>         crash_size = PAGE_ALIGN(crash_size);
> >>
> >>         if (crash_base == 0) {
> >>                 /* Current arm64 boot protocol requires 2MB alignment */
> >> -               crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> >> -                               crash_size, SZ_2M);
> >> +               crash_base = memblock_find_in_range(0, crash_max, crash_size,
> >> +                               SZ_2M);
> >>                 if (crash_base == 0) {
> >>                         pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>                                 crash_size);
> >> --
> >
> > I tested this patch series on ARM64-ThunderX2 with no issue with
> > bootargs crashkenel=X@Y crashkernel=250M,low
> >
> > $ dmesg | grep crash
> > [    0.000000] crashkernel reserved: 0x0000000b81200000 -
> > 0x0000000c81200000 (4096 MB)
> > [    0.000000] Kernel command line:
> > BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
> > root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro
> > crashkernel=4G@0xb81200000 crashkernel=250M,low nowatchdog earlycon
> > [   29.310209]     crashkernel=250M,low
> >
> > $  kexec -p -i /boot/vmlinuz-`uname -r`
> > --initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
> > $ echo 1 > /proc/sys/kernel/sysrq ; echo c > /proc/sysrq-trigger
> >
> > But when i tried with crashkernel=4G crashkernel=250M,low as bootargs.
> > Kernel is not able to allocate memory.
> > [    0.000000] cannot allocate crashkernel (size:0x100000000)
> > [    0.000000] Kernel command line:
> > BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
> > root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro crashkernel=4G
> > crashkernel=250M,low nowatchdog
> > [   29.332081]     crashkernel=250M,low
> >
> > does crashkernel=X@Y mandatory to get allocated beyond 4G?
> > am I missing something?
>
> I can't reproduce the problem in my environment, can you test with other size,
> such as "crashkernel=1G crashkernel=250M,low", see if there is the same issue.
>
I tried 1G also. Same error, please find the logs

$ dmesg | grep crash
[    0.000000] cannot allocate crashkernel (size:0x40000000)
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro nowatchdog earlycon
crashkernel=1G crashkernel=250M,low
[   29.326916]     crashkernel=250M,low


> Besides, crashkernel=X@Y isn't mandatory to get allocated beyond 4G,

this was my understanding also.

> can you show the whole file /proc/iomem.
>

$ cat /proc/iomem
00000000-00000000 : PCI ECAM
00000000-00000000 : PCI ECAM
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:0f
    00000000-00000000 : PCI Bus 0000:10
      00000000-00000000 : 0000:10:00.0
      00000000-00000000 : 0000:10:00.0
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
    00000000-00000000 : 0000:01:00.1
  00000000-00000000 : PCI Bus 0000:05
    00000000-00000000 : 0000:05:00.0
    00000000-00000000 : 0000:05:00.1
  00000000-00000000 : PCI Bus 0000:09
    00000000-00000000 : 0000:09:00.0
    00000000-00000000 : 0000:09:00.1
  00000000-00000000 : 0000:00:10.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:10.1
    00000000-00000000 : ahci
00000000-00000000 : PCI Bus 0000:80
  00000000-00000000 : PCI Bus 0000:83
    00000000-00000000 : 0000:83:00.0
    00000000-00000000 : 0000:83:00.0
      00000000-00000000 : nvme
  00000000-00000000 : PCI Bus 0000:89
    00000000-00000000 : 0000:89:00.0
      00000000-00000000 : e1000e
    00000000-00000000 : 0000:89:00.0
    00000000-00000000 : 0000:89:00.0
      00000000-00000000 : e1000e
    00000000-00000000 : 0000:89:00.0
      00000000-00000000 : e1000e
  00000000-00000000 : PCI Bus 0000:8d
    00000000-00000000 : 0000:8d:00.0
    00000000-00000000 : 0000:8d:00.0
      00000000-00000000 : mpt3sas
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : reserved
  00000000-00000000 : Kernel data
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
00000000-00000000 : CAV901C:00
00000000-00000000 : CAV901D:00
  00000000-00000000 : CAV901C:00
00000000-00000000 : CAV901E:00
  00000000-00000000 : CAV901C:00
00000000-00000000 : CAV901F:00
  00000000-00000000 : CAV901C:00
00000000-00000000 : CAV9006:00
  00000000-00000000 : CAV9006:00
00000000-00000000 : ARMH0011:00
  00000000-00000000 : ARMH0011:00
00000000-00000000 : arm-smmu-v3.0.auto
  00000000-00000000 : arm-smmu-v3.0.auto
00000000-00000000 : arm-smmu-v3.1.auto
  00000000-00000000 : arm-smmu-v3.1.auto
00000000-00000000 : arm-smmu-v3.2.auto
  00000000-00000000 : arm-smmu-v3.2.auto
00000000-00000000 : CAV901C:01
00000000-00000000 : CAV901D:01
  00000000-00000000 : CAV901C:01
00000000-00000000 : CAV901E:01
  00000000-00000000 : CAV901C:01
00000000-00000000 : CAV901F:01
  00000000-00000000 : CAV901C:01
00000000-00000000 : CAV9007:06
  00000000-00000000 : CAV9007:06
00000000-00000000 : arm-smmu-v3.3.auto
  00000000-00000000 : arm-smmu-v3.3.auto
00000000-00000000 : arm-smmu-v3.4.auto
  00000000-00000000 : arm-smmu-v3.4.auto
00000000-00000000 : arm-smmu-v3.5.auto
  00000000-00000000 : arm-smmu-v3.5.auto
00000000-00000000 : System RAM
00000000-00000000 : System RAM
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
00000000-00000000 : System RAM
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
  00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
    00000000-00000000 : 0000:01:00.1
    00000000-00000000 : 0000:01:00.0
    00000000-00000000 : 0000:01:00.1
    00000000-00000000 : 0000:01:00.0
    00000000-00000000 : 0000:01:00.1
  00000000-00000000 : PCI Bus 0000:05
    00000000-00000000 : 0000:05:00.0
      00000000-00000000 : bnx2x
    00000000-00000000 : 0000:05:00.1
      00000000-00000000 : bnx2x
    00000000-00000000 : 0000:05:00.0
      00000000-00000000 : bnx2x
    00000000-00000000 : 0000:05:00.0
      00000000-00000000 : bnx2x
    00000000-00000000 : 0000:05:00.1
      00000000-00000000 : bnx2x
    00000000-00000000 : 0000:05:00.1
      00000000-00000000 : bnx2x
  00000000-00000000 : PCI Bus 0000:09
    00000000-00000000 : 0000:09:00.0
      00000000-00000000 : i40e
    00000000-00000000 : 0000:09:00.1
      00000000-00000000 : i40e
    00000000-00000000 : 0000:09:00.0
    00000000-00000000 : 0000:09:00.1
    00000000-00000000 : 0000:09:00.0
      00000000-00000000 : i40e
    00000000-00000000 : 0000:09:00.1
      00000000-00000000 : i40e
    00000000-00000000 : 0000:09:00.0
    00000000-00000000 : 0000:09:00.1
  00000000-00000000 : 0000:00:0f.0
    00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:0f.0
  00000000-00000000 : 0000:00:0f.1
    00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:0f.1
  00000000-00000000 : 0000:00:10.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:10.1
    00000000-00000000 : ahci
00000000-00000000 : PCI Bus 0000:80

--pk
