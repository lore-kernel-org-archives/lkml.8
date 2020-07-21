Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628ECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4492920709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgGUXNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:13:46 -0400
Received: from kernel.crashing.org ([76.164.61.194]:41692 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:13:45 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06LNCxrb017185
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Jul 2020 18:13:05 -0500
Message-ID: <6fbea8347bdb8434d91cf3ec2b95b134bd66cfe3.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>, alex@ghiti.fr
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Date:   Wed, 22 Jul 2020 09:12:58 +1000
In-Reply-To: <mhng-08bff01a-ca15-4bbc-8454-2ca3e823fef8@palmerdabbelt-glaptop1>
References: <mhng-08bff01a-ca15-4bbc-8454-2ca3e823fef8@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 12:05 -0700, Palmer Dabbelt wrote:
> 
> * We waste vmalloc space on 32-bit systems, where there isn't a lot of it.
> * On 64-bit systems the VA space around the kernel is precious because it's the
>   only place we can place text (modules, BPF, whatever). 

Why ? Branch distance limits ? You can't use trampolines ?

>  If we start putting
>   the kernel in the vmalloc space then we either have to pre-allocate a bunch
>   of space around it (essentially making it a fixed mapping anyway) or it
>   becomes likely that we won't be able to find space for modules as they're
>   loaded into running systems.

I dislike the kernel being in the vmalloc space (see my other email)
but I don't understand the specific issue with modules.

> * Relying on a relocatable kernel for sv48 support introduces a fairly large
>   performance hit.

Out of curiosity why would relocatable kernels introduce a significant
hit ? Where about do you see the overhead coming from ?

> Roughly, my proposal would be to:
> 
> * Leave the 32-bit memory map alone.  On 32-bit systems we can load modules
>   anywhere and we only have one VA width, so we're not really solving any
>   problems with these changes.
> * Staticly allocate a 2GiB portion of the VA space for all our text, as its own
>   region.  We'd link/relocate the kernel here instead of around PAGE_OFFSET,
>   which would decouple the kernel from the physical memory layout of the system.
>   This would have the side effect of sorting out a bunch of bootloader headaches
>   that we currently have.
> * Sort out how to maintain a linear map as the canonical hole moves around
>   between the VA widths without adding a bunch of overhead to the virt2phys and
>   friends.  This is probably going to be the trickiest part, but I think if we
>   just change the page table code to essentially lie about VAs when an sv39
>   system runs an sv48+sv39 kernel we could make it work -- there'd be some
>   logical complexity involved, but it would remain fast.
> 
> This doesn't solve the problem of virtually relocatable kernels, but it does
> let us decouple that from the sv48 stuff.  It also lets us stop relying on a
> fixed physical address the kernel is loaded into, which is another thing I
> don't like.
> 
> I know this may be a more complicated approach, but there aren't any sv48
> systems around right now so I just don't see the rush to support them,
> particularly when there's a cost to what already exists (for those who haven't
> been watching, so far all the sv48 patch sets have imposed a significant
> performance penalty on all systems).

