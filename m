Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584AC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C872067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBXCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:21:33 -0500
Received: from foss.arm.com ([217.140.110.172]:56128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:21:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4954D1FB;
        Sun, 23 Feb 2020 18:21:32 -0800 (PST)
Received: from [10.162.16.95] (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05F473F6CF;
        Sun, 23 Feb 2020 18:21:30 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/vma: Replace all remaining open encodings with
 is_vm_hugetlb_page()
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
 <202002190954.rWlsTEwn%lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7e76e88c-e828-654b-bf2a-4573f388e7cc@arm.com>
Date:   Mon, 24 Feb 2020 07:51:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <202002190954.rWlsTEwn%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/19/2020 06:44 AM, kbuild test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on mmotm/master]
> [also build test ERROR on tip/perf/core m68k/for-next powerpc/next tip/sched/core char-misc/char-misc-testing linux/master linus/master tip/x86/mm asm-generic/master v5.6-rc2 next-20200218]
> [cannot apply to kvm-ppc/kvm-ppc-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-vma-Use-available-wrappers-when-possible/20200219-065223
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: nds32-allnoconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/nds32/include/asm/tlb.h:7,
>                     from arch/nds32/mm/init.c:18:
>    include/asm-generic/tlb.h: In function 'tlb_update_vma_flags':
>>> include/asm-generic/tlb.h:382:18: error: implicit declaration of function 'is_vm_hugetlb_page' [-Werror=implicit-function-declaration]
>      382 |  tlb->vma_huge = is_vm_hugetlb_page(vma);
>          |                  ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Though I am unable to reproduce this build failure [1], it seems like
explicitly adding <linux/hugetlb.h> or <linux/hugetlb_inline.h> header
will be sufficient.

[1] nds32 build failure (error while loading shared libraries)

/usr/lib/x86_64-linux-gnu/libfl.so.2: invalid ELF header
