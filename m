Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25334C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 04:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CB62072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 04:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHETV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:19:21 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:43142 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgDHETV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:21 -0400
X-Greylist: delayed 1593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 00:19:20 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 0383pJxK088647
        for <linux-kernel@vger.kernel.org>; Wed, 8 Apr 2020 11:51:19 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0383nq2K088232;
        Wed, 8 Apr 2020 11:49:52 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 8 Apr 2020
 11:51:17 +0800
Date:   Wed, 8 Apr 2020 11:51:18 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Eric Lin <tesheng@andestech.com>, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>, <zong.li@sifive.com>,
        <alex@ghiti.fr>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, <atish.patra@wdc.com>,
        <yash.shah@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
Message-ID: <20200408035118.GA1451@andestech.com>
References: <20200331093241.3728-1-tesheng@andestech.com>
 <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0383nq2K088232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:31:37AM +0200, Arnd Bergmann wrote:
> On Tue, Mar 31, 2020 at 11:34 AM Eric Lin <tesheng@andestech.com> wrote:
> >
> > With Highmem support, the kernel can map more than 1GB physical memory.
> >
> > This patchset implements Highmem for RV32, referencing to mostly nds32
> > and others like arm and mips, and it has been tested on Andes A25MP platform.
> 
> I would much prefer to not see highmem added to new architectures at all
> if possible, see https://lwn.net/Articles/813201/ for some background.
> 

Understood.

> For the arm32 architecture, we are thinking about implementing a
> VMPLIT_4G_4G option to replace highmem in the long run. The most
> likely way this would turn out at the moment looks like:
> 

Thanks for sharing the status from ARM32.  Is there any available branch
already?  It would be good to have a reference implementation.

> - have a 256MB region for vmalloc space at the top of the 4GB address
>   space, containing vmlinux, module, mmio mappings and vmalloc
>   allocations
> 
> - have 3.75GB starting at address zero for either user space or the
>   linear map.
> 
> - reserve one address space ID for kernel mappings to avoid tlb flushes
>   during normal context switches
> 
> - On any kernel entry, switch the page table to the one with the linear
>   mapping, and back to the user page table before returning to user space
>

After some survey I found previous disccusion
(https://lkml.org/lkml/2019/4/24/2110). The 5.2-based patch ended up not
being merged.  But at least we will have something to start if we want to.

Also interestingly, there was a PR for privileged spec that separates
addressing modes (https://github.com/riscv/riscv-isa-manual/pull/128) as
Sdas extension, but there was no progress afterwards.

Not very related to this thread, but there were some discussion about
ASID design in RISC-V (https://github.com/riscv/riscv-isa-manual/issues/348).
It is now in ratified 1.11 privileged spec.

> - add a generic copy_from_user/copy_to_user implementation based
>   on get_user_pages() in asm-generic/uaccess.h, using memcpy()
>   to copy from/to the page in the linear map.
> 
> - possible have architectures override get_user/put_user to use a
>   cheaper access based on a page table switch to read individual
>   words if that is cheaper than get_user_pages().
> 
> There was an implementation of this for x86 a long time ago, but
> it never got merged, mainly because there were no ASIDs on x86
> at the time and the TLB flushing during context switch were really
> expensive. As far as I can tell, all of the modern embedded cores
> do have ASIDs, and unlike x86, most do not support more than 4GB
> of physical RAM, so this scheme can work to replace highmem
> in most of the remaining cases, and provide additional benefits
> (larger user address range, higher separate of kernel/user addresses)
> at a relatively small performance cost.
> 
>        Arnd
> 

It seems to me that VMSPLIT_4G_4G is quite different from other VMSPLITs,
because it requires much more changes.

Thanks for showing the stance of kernel community against HIGHMEM support.
The cited discussion thread is comprehensive and clear.  Despite that RV32
users cannot get upstream support for their large memory, mechnisms like
VMSPLIT_4G_4G seems to be a promising way to go.  That being said, to
support the theoretical 16G physical memory, eventually kmap* will still
be needed.

Alan
