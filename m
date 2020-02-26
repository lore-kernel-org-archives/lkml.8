Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C8C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B869421556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBZH5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:57:13 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52037 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBZH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:57:13 -0500
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 65F62200002;
        Wed, 26 Feb 2020 07:56:54 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.6-rc4
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <5226d756-e348-29d1-258d-0ab4b63c0677@ghiti.fr>
Date:   Wed, 26 Feb 2020 08:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 2/25/20 6:37 PM, Palmer Dabbelt wrote:
> The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:
> 
>    Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linux-5.6-rc4
> 
> for you to fetch changes up to 8458ca147c204e7db124e8baa8fede219006e80d:
> 
>    riscv: adjust the indent (2020-02-24 13:12:53 -0800)
> 
> ----------------------------------------------------------------
> RISC-V Fixes for 5.6-rc4
> 
> This tag contains a handful of RISC-V related fixes that I've collected and
> would like to target for 5.6-rc4:
> 
> * A fix to set up the PMPs on boot, which allows the kernel to access memory on
>    systems that don't set up permissive PMPs before getting to Linux.  This only
>    effects machine-mode kernels, which currently means only NOMMU kernels.
> * A fix to avoid enabling supervisor-mode interrupts when running in
>    machine-mode, also only for NOMMU kernels.
> * A pair of fixes to our KASAN support to avoid corrupting memory.
> * A gitignore fix.
> 
> This boots on QEMU's virt board for me.
> 
> ----------------------------------------------------------------
> Anup Patel (1):
>        RISC-V: Don't enable all interrupts in trap_init()
> 
> Damien Le Moal (1):
>        riscv: Fix gitignore
> 
> Greentime Hu (1):
>        riscv: set pmp configuration if kernel is running in M-mode
> 
> Zong Li (2):
>        riscv: allocate a complete page size for each page table
>        riscv: adjust the indent
> 
>   arch/riscv/boot/.gitignore   |  2 ++
>   arch/riscv/include/asm/csr.h | 12 ++++++++++
>   arch/riscv/kernel/head.S     |  6 +++++
>   arch/riscv/kernel/traps.c    |  4 ++--
>   arch/riscv/mm/kasan_init.c   | 53 ++++++++++++++++++++++++++------------------
>   5 files changed, 53 insertions(+), 24 deletions(-)
> 

What about this patch https://patchwork.kernel.org/patch/11395273/ from 
Vincent that fixes module loading problems described here:

https://lore.kernel.org/linux-riscv/d868acf5-7242-93dc-0051-f97e64dc4387@ghiti.fr/T/

Do you consider it for 5.6 ?

Thanks,

Alex
